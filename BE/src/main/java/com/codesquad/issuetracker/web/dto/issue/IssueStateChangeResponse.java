package com.codesquad.issuetracker.web.dto.issue;

import com.codesquad.issuetracker.domain.Issue;

public class IssueStateChangeResponse {

    private Long issueId;
    private boolean isOpened;

    public static IssueStateChangeResponse create(Issue issue) {
        return new IssueStateChangeResponse(issue.getId(), issue.isOpened());
    }

    private IssueStateChangeResponse(Long issueId, boolean isOpened) {
        this.issueId = issueId;
        this.isOpened = isOpened;
    }

    public Long getIssueId() {
        return issueId;
    }

    public boolean getIsOpened() {
        return isOpened;
    }
}
