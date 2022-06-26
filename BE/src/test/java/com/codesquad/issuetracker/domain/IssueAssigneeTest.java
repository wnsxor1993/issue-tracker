package com.codesquad.issuetracker.domain;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class IssueAssigneeTest {

    private final Member memberA = new Member("memberA", "1234!", "사용자1");
    private final Member memberB = new Member("memberB", "1234!", "사용자2");
    private Issue issue;

    @BeforeEach
    void init() {
        this.issue = Issue.create("냠냠", "본문", memberA, null);
    }

    @Test
    @DisplayName("따로 생성된 IssueAssingee들은 주솟값이 다르다.")
    public void notSameTest() {
        IssueAssignee issueAssignee1 = new IssueAssignee(memberA, issue);
        IssueAssignee issueAssignee2 = new IssueAssignee(memberA, issue);

        assertThat(issueAssignee1).isNotSameAs(issueAssignee2);
    }

    @Test
    @DisplayName("member, issue가 동등한 IssueAssignee는 동등하다.")
    public void equalsTest() {
        IssueAssignee issueAssignee1 = new IssueAssignee(memberA, issue);
        IssueAssignee issueAssignee2 = new IssueAssignee(memberA, issue);

        assertThat(issueAssignee1).isEqualTo(issueAssignee2);
    }

    @Test
    @DisplayName("member 또는 issue가 동등하지 않은 IssueAssignee는 동등하지 않다.")
    public void notEqualsTest() throws Exception {
        IssueAssignee issueAssignee1 = new IssueAssignee(memberA, issue);
        IssueAssignee issueAssignee2 = new IssueAssignee(memberB, issue);

        assertThat(issueAssignee1).isNotEqualTo(issueAssignee2);
    }

}