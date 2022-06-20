package com.codesquad.issuetracker.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
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

    private IssueLabel(Issue issue, Label label) {
        this.issue = issue;
        this.label = label;
    }

    /**
     * 이슈에 라벨을 할당하기 위해 사용하는 편의 메서드
     * Issue에 종속적임. 생성 시 Issue에서만 생성하도록 하고 package-private로 함
     */
    static void putLabelToIssue(Label label, Issue issue) {
        IssueLabel issueLabel = new IssueLabel(issue, label);
        issue.getIssueLabels().add(issueLabel);
    }

}
