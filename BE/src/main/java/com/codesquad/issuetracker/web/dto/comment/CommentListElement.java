package com.codesquad.issuetracker.web.dto.comment;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class CommentListElement {

    private final Long commentId;
    private final Long commentAuthorId;
    private final String commentAuthorName;
    private final String commentContent;
    private final LocalDateTime commentCreatedTime;
    private final LocalDateTime commentLastModifiedTime;

    @QueryProjection
    public CommentListElement(Long commentId, Long commentAuthorId, String commentAuthorName, String commentContent, LocalDateTime commentCreatedTime, LocalDateTime commentLastModifiedTime) {
        this.commentId = commentId;
        this.commentAuthorId = commentAuthorId;
        this.commentAuthorName = commentAuthorName;
        this.commentContent = commentContent;
        this.commentCreatedTime = commentCreatedTime;
        this.commentLastModifiedTime = commentLastModifiedTime;
    }
}
