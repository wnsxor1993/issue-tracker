package com.codesquad.issuetracker.web.dto.issue;

import com.codesquad.issuetracker.domain.Issue;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MultipleIssueStateChangeResponse {

    private List<IssueStateChangeResponse> patchedIssues = new ArrayList<>();

    public static MultipleIssueStateChangeResponse create(List<Issue> issues) {
        List<IssueStateChangeResponse> patchedIssues = issues.stream()
                .map(IssueStateChangeResponse::create)
                .collect(Collectors.toList());

        return new MultipleIssueStateChangeResponse(patchedIssues);
    }

    private MultipleIssueStateChangeResponse(List<IssueStateChangeResponse> patchedIssues) {
        this.patchedIssues = patchedIssues;
    }

}
