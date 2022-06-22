package com.codesquad.issuetracker.web.dto;

import com.codesquad.issuetracker.domain.Comment;
import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.domain.IssueAssignee;
import com.codesquad.issuetracker.domain.IssueLabel;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class IssueDetailResponse {

    private Long issueId;
    private Long authorId;
    private String authorName;
    private String title;
    private String content;
    private List<IssueAssigneeDto> assignees = new ArrayList<>();
    private Long milestoneId;
    private String milestoneName;
    private boolean isOpened;
    private LocalDateTime createdAt;
    private LocalDateTime lastModifiedAt;
    private List<LabelDto> labels = new ArrayList<>();
    private List<CommentListElement> comments = new ArrayList<>();

    @Builder(access = AccessLevel.PRIVATE)
    private IssueDetailResponse(Long issueId, Long authorId, String authorName, String title, String content, List<IssueAssigneeDto> assignees, Long milestoneId, String milestoneName, boolean isOpened, LocalDateTime createdAt, LocalDateTime lastModifiedAt, List<LabelDto> labels, List<CommentListElement> comments) {
        this.issueId = issueId;
        this.authorId = authorId;
        this.authorName = authorName;
        this.title = title;
        this.content = content;
        this.assignees = assignees;
        this.milestoneId = milestoneId;
        this.milestoneName = milestoneName;
        this.isOpened = isOpened;
        this.createdAt = createdAt;
        this.lastModifiedAt = lastModifiedAt;
        this.labels = labels;
        this.comments = comments;
    }

    public static IssueDetailResponse create(Issue issue) {
        return IssueDetailResponse.builder()
                .issueId(issue.getId())
                .authorId(issue.getAuthor().getId())
                .authorName(issue.getAuthor().getName())
                .title(issue.getTitle())
                .content(issue.getContent())
                .assignees(initAssignees(issue))
                .milestoneId(issue.getMilestone().getId())
                .milestoneName(issue.getMilestone().getTitle())
                .isOpened(issue.isOpened())
                .createdAt(issue.getCreatedAt())
                .lastModifiedAt(issue.getLastModifiedAt())
                .labels(initLabels(issue))
                .comments(initComments(issue))
                .build();
    }

    private static List<IssueAssigneeDto> initAssignees(Issue issue) {
        return issue.getAssignees().stream()
                .map(IssueAssigneeDto::create)
                .collect(Collectors.toList());
    }

    private static List<LabelDto> initLabels(Issue issue) {
        return issue.getIssueLabels().stream()
                .map(IssueLabel::getLabel)
                .map(LabelDto::create)
                .collect(Collectors.toList());
    }

    private static List<CommentListElement> initComments(Issue issue) {
        return issue.getComments().stream()
                .map(CommentListElement::create)
                .collect(Collectors.toList());
    }

    @Getter
    private static class IssueAssigneeDto {

        private Long assigneeId;
        private String assigneeName;

        private IssueAssigneeDto(Long assigneeId, String assigneeName) {
            this.assigneeId = assigneeId;
            this.assigneeName = assigneeName;
        }

        public static IssueAssigneeDto create(IssueAssignee issueAssignee) {
            return new IssueAssigneeDto(issueAssignee.getId(), issueAssignee.getMember().getName());
        }
    }

    @Getter
    private static class CommentListElement {

        private Long commentId;
        private Long commentAuthorId;
        private String commentAuthorName;
        private String commentContent;
        private LocalDateTime commentCreatedTime;
        private LocalDateTime commentLastModifiedTime;

        @Builder(access = AccessLevel.PRIVATE)
        private CommentListElement(Long commentId, Long commentAuthorId, String commentAuthorName, String commentContent, LocalDateTime commentCreatedTime, LocalDateTime commentLastModifiedTime) {
            this.commentId = commentId;
            this.commentAuthorId = commentAuthorId;
            this.commentAuthorName = commentAuthorName;
            this.commentContent = commentContent;
            this.commentCreatedTime = commentCreatedTime;
            this.commentLastModifiedTime = commentLastModifiedTime;
        }

        public static CommentListElement create(Comment comment) {
            return CommentListElement.builder()
                    .commentId(comment.getId())
                    .commentAuthorId(comment.getAuthor().getId())
                    .commentAuthorName(comment.getAuthor().getName())
                    .commentContent(comment.getContent())
                    .commentCreatedTime(comment.getCreatedAt())
                    .commentLastModifiedTime(comment.getLastModifiedAt())
                    .build();
        }
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
