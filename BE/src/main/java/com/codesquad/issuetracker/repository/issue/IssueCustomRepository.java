package com.codesquad.issuetracker.repository.issue;

import com.codesquad.issuetracker.domain.Issue;

import java.util.List;
import java.util.Optional;

public interface IssueCustomRepository {

    Optional<Issue> findByIdWithAuthorAndMilestone(Long issueId);
    void updateBulkStates(List<Long> issueIds, boolean isOpened);
}
