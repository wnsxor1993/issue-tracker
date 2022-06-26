package com.codesquad.issuetracker.domain;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

class IssueLabelTest {

    private final Label labelA = new Label("labelA", "widwdniw", LabelColor.create("FFFFFF"));
    private final Label labelB = new Label("labelB", "widwdniw", LabelColor.create("AAAAAA"));
    private final Member author = new Member("test", "1234", "github");

    private Issue issue;

    @BeforeEach
    void init() {
        this.issue = Issue.create("냠냠", "본문", author, null);
    }

    @Test
    @DisplayName("따로 생성된 IssueLabel들은 주솟값이 다르다.")
    public void notSameTest() {
        IssueLabel issueLabelA = new IssueLabel(labelA, issue);
        IssueLabel issueLabelB = new IssueLabel(labelA, issue);

        assertThat(issueLabelA).isNotSameAs(issueLabelB);
    }

    @Test
    @DisplayName("label, issue가 동등한 IssueLabel은 동등하다.")
    public void equalsTest() {
        IssueLabel issueLabelA = new IssueLabel(labelA, issue);
        IssueLabel issueLabelB = new IssueLabel(labelA, issue);

        assertThat(issueLabelA).isEqualTo(issueLabelB);
    }

    @Test
    @DisplayName("label 또는 issue가 동등하지 않은 IssueLabel은 동등하지 않다.")
    public void notEqualsTest() throws Exception {
        IssueLabel issueLabelA = new IssueLabel(labelA, issue);
        IssueLabel issueLabelB = new IssueLabel(labelB, issue);

        assertThat(issueLabelA).isNotEqualTo(issueLabelB);
    }

    @Test
    @DisplayName("hasDiffrentIssue 메서드 호출 시, 자신의 이슈와 다른 이슈면 true를 반환한다.")
    public void hasDifferentIssueTest_True() {
        IssueLabel issueLabel = new IssueLabel(labelA, issue);

        Issue otherIssue = Issue.create("Other Issue", "content", author, null);

        boolean result = issueLabel.hasDifferentIssue(otherIssue);
        assertThat(result).isTrue();
    }

    @Test
    @DisplayName("hasDiffrentIssue 메서드 호출 시, 자신의 이슈와 동등한 이슈면 false를 반환한다.")
    public void hasDifferentIssueTest_False() {
        IssueLabel issueLabel = new IssueLabel(labelA, issue);

        boolean result = issueLabel.hasDifferentIssue(issue);
        assertThat(result).isFalse();
    }
}
