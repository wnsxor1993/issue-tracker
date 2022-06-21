package com.codesquad.issuetracker.service.issue;

import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.domain.Label;
import com.codesquad.issuetracker.domain.Member;
import com.codesquad.issuetracker.domain.Milestone;
import com.codesquad.issuetracker.excption.IssueNotFoundException;
import com.codesquad.issuetracker.excption.MemberNotFoundException;
import com.codesquad.issuetracker.excption.MilestoneNotFoundException;
import com.codesquad.issuetracker.repository.issue.IssueRepository;
import com.codesquad.issuetracker.repository.label.LabelRepository;
import com.codesquad.issuetracker.repository.member.MemberRepository;
import com.codesquad.issuetracker.repository.milestone.MilestoneRepository;
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
    private final MemberRepository memberRepository;
    private final MilestoneRepository milestoneRepository;
    private final LabelRepository labelRepository;

    /**
     * 이슈 생성
     */
    public Long createIssue(Long authorId, List<Long> assigneeIds, Long milestondId, List<Long> labelIds, String title, String content) {
        Member author = findMember(authorId);
        List<Member> assigneeMembers = memberRepository.findAllById(assigneeIds);
        Milestone milestone = findMilestone(milestondId);
        List<Label> labels = labelRepository.findAllById(labelIds);

        Issue issue = Issue.create(author, assigneeMembers, milestone, labels, title, content);
        issueRepository.save(issue);

        log.info("created Issue = {}", issue);

        return issue.getId();
    }

    private Milestone findMilestone(Long milestoneId) {
        return (milestoneId == null)
                ? null
                : milestoneRepository.findById(milestoneId)
                        .orElseThrow(() -> new MilestoneNotFoundException("일치하는 식별자의 마일스톤이 존재하지 않습니다."));
    }

    private Member findMember(Long memberId) {
        return memberRepository.findById(memberId)
                .orElseThrow(() -> new MemberNotFoundException("일치하는 식별자의 회원이 존재하지 않습니다."));
    }

    public void changeState(Long issueId, boolean isOpened) {
        Issue issue = findIssue(issueId);
        issue.changeIssueState(isOpened);
    }

    private Issue findIssue(Long issueId) {
        return issueRepository.findById(issueId)
                .orElseThrow(() -> new IssueNotFoundException("일치하는 식별자의 이슈가 존재하지 않습니다."));
    }

    public void changeStates(List<Long> issueIds, boolean isOpened) {
        List<Issue> issues = issueRepository.findAllById(issueIds);

        issues.stream()
                .forEach(issue -> issue.changeIssueState(isOpened));
    }

}
