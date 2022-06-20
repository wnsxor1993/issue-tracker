package com.codesquad.issuetracker.web.dto;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class IssueUpdateResponse {

    private Long issueId;

    public IssueUpdateResponse(Long issueId) {
        this.issueId = issueId;
    }
}
