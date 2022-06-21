package com.codesquad.issuetracker.domain;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import static com.codesquad.issuetracker.domain.IssueAssignee.assignMemberToIssue;
import static com.codesquad.issuetracker.domain.IssueLabel.putLabelToIssue;
import static javax.persistence.FetchType.LAZY;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@ToString(of = {"id", "title", "content", "isOpened", "createdAt", "lastModifiedAt"})
public class Issue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "issue_id")
    private Long id;

    private LocalDateTime createdAt;

    private LocalDateTime lastModifiedAt;

    @ManyToOne(fetch = LAZY)
    private Member author;

    @OneToMany(mappedBy = "issue", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<IssueAssignee> assignees = new ArrayList<>();

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "milestone_id")
    private Milestone milestone;

    @OneToMany(mappedBy = "issue", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<IssueLabel> issueLabels = new ArrayList<>();

    @OneToMany(mappedBy = "issue", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Comment> comments = new ArrayList<>();

    private String title;
    private String content;

    private boolean isOpened;

    @Builder(access = AccessLevel.PRIVATE)
    private Issue(LocalDateTime createdAt, LocalDateTime lastModifiedAt, Member author, Milestone milestone,String title, String content, boolean isOpened) {
        this.createdAt = createdAt;
        this.lastModifiedAt = lastModifiedAt;
        this.author = author;
        this.milestone = milestone;
        this.title = title;
        this.content = content;
        this.isOpened = isOpened;
    }

    public static Issue create(Member author, List<Member> assigneeMembers, Milestone milestone, List<Label> labels, String title, String content) {
        LocalDateTime createdTime = LocalDateTime.now();
        Issue issue = Issue.builder()
                .author(author)
                .milestone(milestone)
                .title(title)
                .content(content)
                .createdAt(createdTime)
                .lastModifiedAt(createdTime)
                .isOpened(true)
                .build();
        initAssignees(assigneeMembers, issue);
        initIssueLabels(labels, issue);
        return issue;
    }

    private static void initAssignees(List<Member> assigneeMembers, Issue issue) {
        assigneeMembers.forEach(member -> assignMemberToIssue(member, issue));
    }

    private static void initIssueLabels(List<Label> labels, Issue issue) {
        labels.forEach(label -> putLabelToIssue(label, issue));
    }

}
