package com.codesquad.issuetracker.web.dto.issue;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class IssueListResponse {

    private List<IssueListElement> issues;

    public IssueListResponse(List<IssueListElement> issues) {
        this.issues = issues;
    }

}
