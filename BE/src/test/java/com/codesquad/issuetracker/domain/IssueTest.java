package com.codesquad.issuetracker.domain;

import com.codesquad.issuetracker.excption.InvalidIssueAssigneeAddException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class IssueTest {

    private final Member memberA = new Member("memberA", "1234!", "사용자1");
    private final Member memberB = new Member("memberB", "1234!", "사용자2");
    private Issue issue;
    private Set<IssueAssignee> issueAssignees;

    @BeforeEach
    void init() {
        issue = Issue.create("냠냠", "본문", memberA, null);
        issueAssignees = issue.getAssignees();
    }

    @Test
    @DisplayName("동등한 issueAssignee를 같은 issue에 삽입하면 먼저 삽입된 issueAssignee만 삽입된다.")
    public void addEqualAssigneeTest() {
        IssueAssignee issueAssigneeA = new IssueAssignee(memberA, issue);
        IssueAssignee issueAssigneeB = new IssueAssignee(issueAssigneeA.getMember(), issueAssigneeA.getIssue());

        issue.addIssueAssignee(issueAssigneeA);
        issue.addIssueAssignee(issueAssigneeB);
        IssueAssignee findIssueAssignee = issueAssignees.stream().findFirst().get();

        assertThat(issue.getAssignees().size()).isEqualTo(1);
        assertThat(issueAssigneeA).isNotSameAs(issueAssigneeB);
        assertThat(findIssueAssignee).isSameAs(issueAssigneeA);
    }

    @Test
    @DisplayName("동등하지 않은 issueAssignee를 같은 issue에 삽입하면 모두 다 삽입된다.")
    public void addNotEqualAssigneeTest() {
        IssueAssignee issueAssigneeA = new IssueAssignee(memberA, issue);
        IssueAssignee issueAssigneeB = new IssueAssignee(memberB, issue);

        issue.addIssueAssignee(issueAssigneeA);
        issue.addIssueAssignee(issueAssigneeB);

        assertThat(issue.getAssignees().size()).isEqualTo(2);
        assertThat(issueAssignees).containsExactlyInAnyOrder(issueAssigneeA, issueAssigneeB);
    }

    @Test
    @DisplayName("다른 이슈에 할당된 IssueAssignee를 issue에 할당하면 InvalidIssueAssigneeAddException이 발생한다.")
    public void invalidIssueAssigneeAddTest() {
        Issue otherIssue = Issue.create("Other Issue", "content", memberA, null);
        IssueAssignee otherIssueAssignee = new IssueAssignee(memberB, otherIssue);

        assertThatThrownBy(() -> issue.addIssueAssignee(otherIssueAssignee))
                .isInstanceOf(InvalidIssueAssigneeAddException.class);
    }

}
