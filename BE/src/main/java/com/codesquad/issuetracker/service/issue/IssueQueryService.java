package com.codesquad.issuetracker.service.issue;

import com.codesquad.issuetracker.domain.Comment;
import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.domain.IssueAssignee;
import com.codesquad.issuetracker.domain.IssueLabel;
import com.codesquad.issuetracker.excption.IssueNotFoundException;
import com.codesquad.issuetracker.repository.issue.IssueRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class IssueQueryService {

    private final IssueRepository issueRepository;

    public Issue findIssue(Long issueId) {
        return issueRepository.findById(issueId)
                .orElseThrow(() -> new IssueNotFoundException("일치하는 식별자의 이슈를 찾을 수 없습니다."));
    }

    public List<Issue> findIssues(List<Long> issueIds) {
        return issueRepository.findAllById(issueIds);
    }

    public boolean checkIssueExistence(Long issueId) {
        return issueRepository.existsById(issueId);
    }

    public Issue findDetailIssue(Long issueId) {
        Issue detailIssue = issueRepository.findByIdWithAuthorAndMilestone(issueId)
                .orElseThrow(() -> new IssueNotFoundException("일치하는 식별자의 이슈를 찾을 수 없습니다."));


        List<IssueLabel> issueLabels = detailIssue.getIssueLabels();
        for (IssueLabel issueLabel : issueLabels) {
            issueLabel.getLabel();
        }

        List<IssueAssignee> assignees = detailIssue.getAssignees();
        for (IssueAssignee assignee : assignees) {
            assignee.getMember();
        }

        List<Comment> comments = detailIssue.getComments();
        for (Comment comment : comments) {
            comment.getAuthor();
        }

        return detailIssue;
    }
}
