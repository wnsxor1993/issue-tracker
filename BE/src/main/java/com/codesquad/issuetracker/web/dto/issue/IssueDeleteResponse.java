package com.codesquad.issuetracker.web.dto.issue;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class IssueDeleteResponse {

    private boolean isDeleted;

    public IssueDeleteResponse(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public boolean getIsDeleted() {
        return isDeleted;
    }
}
