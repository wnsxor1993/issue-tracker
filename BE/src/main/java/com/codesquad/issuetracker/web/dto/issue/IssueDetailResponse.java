package com.codesquad.issuetracker.web.dto.issue;

import com.codesquad.issuetracker.web.dto.comment.CommentListElement;
import com.codesquad.issuetracker.web.dto.label.LabelDto;
import com.querydsl.core.annotations.QueryProjection;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class IssueDetailResponse {

    private Long issueId;
    private Long authorId;
    private String authorName;
    private String title;
    private String content;
    private final List<IssueAssigneeDto> assignees = new ArrayList<>();
    private Long milestoneId;
    private String milestoneName;
    private boolean isOpened;
    private LocalDateTime createdAt;
    private LocalDateTime lastModifiedAt;
    private final List<LabelDto> labels = new ArrayList<>();
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

    public List<LabelDto> getLabels() {
        return labels;
    }

    public List<CommentListElement> getComments() {
        return comments;
    }
}
