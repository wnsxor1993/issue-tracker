package com.codesquad.issuetracker.service.issue;

import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.excption.IssueNotFoundException;
import com.codesquad.issuetracker.repository.issue.IssueRepository;
import com.codesquad.issuetracker.service.comment.CommentQueryService;
import com.codesquad.issuetracker.web.dto.comment.CommentListElement;
import com.codesquad.issuetracker.web.dto.issue.IssueAssigneeDto;
import com.codesquad.issuetracker.web.dto.issue.IssueDetailResponse;
import com.codesquad.issuetracker.web.dto.issue.IssueLabelDto;
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

    private final CommentQueryService commentQueryService;

    public Issue findIssueById(Long issueId) {
        return issueRepository.findById(issueId)
                .orElseThrow(() -> new IssueNotFoundException("일치하는 식별자의 이슈가 존재하지 않습니다."));
    }

    public List<Issue> findIssues(List<Long> issueIds) {
        return issueRepository.findAllById(issueIds);
    }

    public IssueDetailResponse findIssueDetail(Long issueId) {

        IssueDetailResponse issueDetailResponse = issueRepository.findIssueDetail(issueId)
                .orElseThrow(() -> new IssueNotFoundException("일치하는 식별자의 이슈가 존재하지 않습니다."));

        List<IssueAssigneeDto> assigneeDtos = issueRepository.findIssueAssigneeDtosByIssueId(issueId);
        List<IssueLabelDto> issueLabelDtos = issueRepository.findIssueLabelDtosByIssueId(issueId);
        List<CommentListElement> commentDtos = commentQueryService.findCommentDtosByIssueId(issueId);

        issueDetailResponse.getAssignees().addAll(assigneeDtos);
        issueDetailResponse.getLabels().addAll(issueLabelDtos);
        issueDetailResponse.getComments().addAll(commentDtos);

        return issueDetailResponse;
    }
}
