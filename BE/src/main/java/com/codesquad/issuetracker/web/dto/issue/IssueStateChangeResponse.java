package com.codesquad.issuetracker.web.dto.issue;

public class IssueStateChangeResponse {

    private Long issueId;
    private boolean isOpened;

    public IssueStateChangeResponse(Long issueId, boolean isOpened) {
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
