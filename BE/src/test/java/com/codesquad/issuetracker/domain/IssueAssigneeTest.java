package com.codesquad.issuetracker.domain;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class IssueAssigneeTest {

    private final Member memberA = new Member("memberA", "membera1111", "사용자1", "https://i.picsum.photos/id/805/600/600.jpg?hmac=HHttHmXVsB7dhFuTQT7UCSMXMHNUGnTqZG0KnNvVyjY");
    private final Member memberB = new Member("memberB", "memberb2222", "사용자2", "https://images.unsplash.com/photo-1656346079355-47b7dc576812?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY1NjU1NzY0Mw&ixlib=rb-1.2.1&q=80&w=1080");
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

    @Test
    @DisplayName("hasDiffrentIssue 메서드 호출 시, 자신의 이슈와 다른 이슈면 true를 반환한다.")
    public void hasDifferentIssueTest_True() {
        IssueAssignee issueAssignee = new IssueAssignee(memberA, issue);

        Issue otherIssue = Issue.create("Other Issue", "content", memberA, null);

        boolean result = issueAssignee.hasDifferentIssue(otherIssue);
        assertThat(result).isTrue();
    }

    @Test
    @DisplayName("hasDiffrentIssue 메서드 호출 시, 자신의 이슈와 동등한 이슈면 false를 반환한다.")
    public void hasDifferentIssueTest_False() {
        IssueAssignee issueAssignee = new IssueAssignee(memberA, issue);
        boolean result = issueAssignee.hasDifferentIssue(issue);

        assertThat(result).isFalse();
    }

}