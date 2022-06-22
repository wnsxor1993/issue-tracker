package com.codesquad.issuetracker.web.dto;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class IssueDeleteResponse {

    private boolean deleted;

    public IssueDeleteResponse(boolean deleted) {
        this.deleted = deleted;
    }
}
