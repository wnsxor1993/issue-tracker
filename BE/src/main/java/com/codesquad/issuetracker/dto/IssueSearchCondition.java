package com.codesquad.issuetracker.dto;


import lombok.Builder;
import lombok.Getter;

@Getter
public class IssueSearchCondition {

    private Boolean isOpened;
    private Long authorId;
    private Long commentAuthorId;

    @Builder
    public IssueSearchCondition(Boolean isOpened, Long authorId, Long commentAuthorId) {
        this.isOpened = isOpened;
        this.authorId = authorId;
        this.commentAuthorId = commentAuthorId;
    }
}
