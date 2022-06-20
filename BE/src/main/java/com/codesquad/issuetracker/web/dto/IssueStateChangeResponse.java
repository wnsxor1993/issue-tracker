package com.codesquad.issuetracker.web.dto;

import com.codesquad.issuetracker.domain.Issue;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class IssueStateChangeResponse {

    private Long issueId;
    private boolean isOpened;

    @Builder(access = AccessLevel.PRIVATE)
    private IssueStateChangeResponse(Long issueId, boolean isOpened) {
        this.issueId = issueId;
        this.isOpened = isOpened;
    }

    public static IssueStateChangeResponse create(Issue issue) {
        return IssueStateChangeResponse.builder()
                .issueId(issue.getId())
                .isOpened(issue.isOpened())
                .build();
    }
}
