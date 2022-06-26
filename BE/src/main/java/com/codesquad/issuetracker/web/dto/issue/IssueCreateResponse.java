package com.codesquad.issuetracker.web.dto.issue;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
public class IssueCreateResponse {

    private final Long issueId;

    public IssueCreateResponse(Long issueId) {
        this.issueId = issueId;
    }
}
