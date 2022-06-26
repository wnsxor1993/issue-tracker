package com.codesquad.issuetracker.web.dto.issue;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
public class IssueUpdateResponse {

    private final Long issueId;

    public IssueUpdateResponse(Long issueId) {
        this.issueId = issueId;
    }
}
