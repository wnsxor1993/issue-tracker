package com.codesquad.issuetracker.web.dto.comment;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class CommentListElement {

    private Long commentId;
    private Long commentAuthorId;
    private String commentAuthorName;
    private String commentContent;
    private LocalDateTime commentCreatedTime;
    private LocalDateTime commentLastModifiedTime;

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
