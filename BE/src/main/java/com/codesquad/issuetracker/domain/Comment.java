package com.codesquad.issuetracker.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

import static javax.persistence.FetchType.LAZY;


@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comment_id")
    private Long id;

    private String content;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "author_id")
    private Member author;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "issue_id")
    private Issue issue;

    public Comment(String content, Member author, Issue issue) {
        this.content = content;
        this.author = author;
        this.issue = issue;
    }

}
