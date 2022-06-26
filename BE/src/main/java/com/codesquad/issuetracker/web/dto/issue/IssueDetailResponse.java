package com.codesquad.issuetracker.web.dto.issue;

import com.codesquad.issuetracker.web.dto.comment.CommentListElement;
import com.querydsl.core.annotations.QueryProjection;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class IssueDetailResponse {

    private final Long issueId;
    private final Long authorId;
    private final String authorName;
    private final String title;
    private final String content;
    private final List<IssueAssigneeDto> assignees = new ArrayList<>();
    private final Long milestoneId;
    private final String milestoneName;
    private final boolean isOpened;
    private final LocalDateTime createdAt;
    private final LocalDateTime lastModifiedAt;
    private final List<IssueLabelDto> labels = new ArrayList<>();
    private final List<CommentListElement> comments = new ArrayList<>();

    @QueryProjection
    public IssueDetailResponse(
            Long issueId, Long authorId, String authorName,
            String title, String content, Long milestoneId, String milestoneName,
            boolean isOpened, LocalDateTime createdAt, LocalDateTime lastModifiedAt) {
        this.issueId = issueId;
        this.authorId = authorId;
        this.authorName = authorName;
        this.title = title;
        this.content = content;
        this.milestoneId = milestoneId;
        this.milestoneName = milestoneName;
        this.isOpened = isOpened;
        this.createdAt = createdAt;
        this.lastModifiedAt = lastModifiedAt;
    }

    public Long getIssueId() {
        return issueId;
    }

    public Long getAuthorId() {
        return authorId;
    }

    public String getAuthorName() {
        return authorName;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public List<IssueAssigneeDto> getAssignees() {
        return assignees;
    }

    public Long getMilestoneId() {
        return milestoneId;
    }

    public String getMilestoneName() {
        return milestoneName;
    }

    public boolean getIsOpened() {
        return isOpened;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getLastModifiedAt() {
        return lastModifiedAt;
    }

    public List<IssueLabelDto> getLabels() {
        return labels;
    }

    public List<CommentListElement> getComments() {
        return comments;
    }
}
