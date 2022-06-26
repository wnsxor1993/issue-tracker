package com.codesquad.issuetracker.domain;

import lombok.AccessLevel;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@EqualsAndHashCode(of = {"issue", "label"})
public class IssueLabel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "issue_label_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "issue_id")
    private Issue issue;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "label_id")
    private Label label;

    public IssueLabel(Label label, Issue issue) {
        this.label = label;
        this.issue = issue;
    }

    public static List<IssueLabel> createIssueLabels(Issue issue, List<Label> labels) {
        return labels.stream()
                .map(label -> new IssueLabel(label, issue))
                .collect(Collectors.toList());
    }

    public boolean hasDifferentIssue(Issue otherIssue) {
        return !(issue.equals(otherIssue));
    }
}
