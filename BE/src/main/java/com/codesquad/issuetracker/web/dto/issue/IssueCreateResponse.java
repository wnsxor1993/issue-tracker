package com.codesquad.issuetracker.web.dto.issue;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class IssueCreateResponse {

    private Long issueId;

    public IssueCreateResponse(Long issueId) {
        this.issueId = issueId;
    }
}
