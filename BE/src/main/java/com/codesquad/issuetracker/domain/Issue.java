package com.codesquad.issuetracker.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

import static javax.persistence.FetchType.LAZY;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Issue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "issue_id")
    private Long id;

    @ManyToOne(fetch = LAZY)
    private Member author;

    @OneToMany(mappedBy = "issue", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<IssueAssignee> assignees = new HashSet<>();

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "milestone_id")
    private Milestone milestone;

    private String title;
    private String content;

    private boolean isOpened;

    public Issue(Member author, Set<IssueAssignee> assignees, Milestone milestone, String title, String content, boolean isOpened) {
        this.author = author;
        this.assignees = assignees;
        this.milestone = milestone;
        this.title = title;
        this.content = content;
        this.isOpened = isOpened;
    }
}
