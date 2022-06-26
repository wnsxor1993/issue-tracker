package com.codesquad.issuetracker.web.dto.issue;

public class IssueDeleteResponse {

    private final boolean isDeleted;

    public IssueDeleteResponse(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public boolean getIsDeleted() {
        return isDeleted;
    }
}
