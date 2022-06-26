package com.codesquad.issuetracker.repository.issue;

import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.web.dto.issue.IssueAssigneeDto;
import com.codesquad.issuetracker.web.dto.issue.IssueDetailResponse;
import com.codesquad.issuetracker.web.dto.issue.IssueLabelDto;

import java.util.List;
import java.util.Optional;

public interface IssueCustomRepository {

    Optional<Issue> findByIdWithAuthorAndMilestone(Long issueId);
    void updateBulkStates(List<Long> issueIds, boolean isOpened);
    Optional<IssueDetailResponse> findIssueDetail(Long issueId);
    List<IssueLabelDto> findIssueLabelDtosByIssueId(Long issueId);
    List<IssueAssigneeDto> findIssueAssigneeDtosByIssueId(Long issueId);
}
