package com.codesquad.issuetracker.service.issue;

import com.codesquad.issuetracker.domain.*;
import com.codesquad.issuetracker.excption.IssueNotFoundException;
import com.codesquad.issuetracker.repository.issue.IssueRepository;
import com.codesquad.issuetracker.service.label.LabelQueryService;
import com.codesquad.issuetracker.service.member.MemberQueryService;
import com.codesquad.issuetracker.service.milestone.MilestoneQueryService;
import com.codesquad.issuetracker.web.dto.issue.IssueUpdateRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class IssueCommandService {

    private final IssueRepository issueRepository;

    private final IssueQueryService issueQueryService;
    private final MemberQueryService memberQueryService;
    private final MilestoneQueryService milestoneQueryService;
    private final LabelQueryService labelQueryService;

    /**
     * 이슈 생성
     */
    public Long createIssue(Long authorId, List<Long> assigneeIds, Long milestondId, List<Long> labelIds, String title, String content) {
        Member author = memberQueryService.findMemberById(authorId);
        List<Member> assigneeMembers = memberQueryService.findAllById(assigneeIds);
        Milestone milestone = milestoneQueryService.findMilestoneById(milestondId);
        List<Label> labels = labelQueryService.findAllById(labelIds);

        Issue issue = Issue.create(title, content, author, milestone);

        List<IssueAssignee> assignees = IssueAssignee.createIssueAssignees(issue, assigneeMembers);
        List<IssueLabel> issueLabels = IssueLabel.createIssueLabels(issue, labels);

        issue.addIssueAssignees(assignees);
        issue.addIssueLabels(issueLabels);

        issueRepository.save(issue);

        log.info("created Issue = {}", issue);

        return issue.getId();
    }

    public void changeState(Long issueId, boolean isOpened) {
        Issue issue = issueQueryService.findIssueById(issueId);
        issue.changeIssueState(isOpened);
    }

    public void changeStates(List<Long> issueIds, boolean isOpened) {
        issueRepository.updateBulkStates(issueIds, isOpened);
    }

    public boolean deleteIssue(Long issueId) {
        Issue issue = issueQueryService.findIssueById(issueId);
        issueRepository.delete(issue);
        return true;
    }

    /**
     * 이슈 수정
     */
    public void updateIssue(Long issueId, IssueUpdateRequest updateRequest) {
        Issue issue = issueQueryService.findByIdWithAuthorAndMilestone(issueId);
        Milestone updateMilestone = milestoneQueryService.findMilestoneById(updateRequest.getMilestoneId());
        List<Label> labels = labelQueryService.findAllById(updateRequest.getLabelIds());
        List<Member> assigneeMembers = memberQueryService.findAllById(updateRequest.getAssigneeIds());

        issue.changeTitle(updateRequest.getTitle());
        issue.changeContent(updateRequest.getContent());
        issue.changeMilestone(updateMilestone);

        List<IssueAssignee> issueAssignees = IssueAssignee.createIssueAssignees(issue, assigneeMembers);
        issue.removeAssigneesNotIn(issueAssignees);
        issue.addIssueAssignees(issueAssignees);

        List<IssueLabel> issueLabels = IssueLabel.createIssueLabels(issue, labels);
        issue.removeIssueLabelsNotIn(issueLabels);
        issue.addIssueLabels(issueLabels);
    }
}
