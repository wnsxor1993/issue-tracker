package com.codesquad.issuetracker.domain;

import com.codesquad.issuetracker.excption.InvalidIssueAssigneeAddException;
import com.codesquad.issuetracker.excption.InvalidIssueLabelAddException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class IssueTest {

    private final Member memberA = new Member("memberA", "1234!", "사용자1");
    private final Member memberB = new Member("memberB", "1234!", "사용자2");
    private final Label labelA = new Label("labelA", "widwdniw", LabelColor.create("FFFFFF"));
    private final Label labelB = new Label("labelB", "widwdniw", LabelColor.create("AAAAAA"));
    private Issue issue;
    private Set<IssueAssignee> issueAssignees;
    private Set<IssueLabel> issueLabels;


    @BeforeEach
    void init() {
        issue = Issue.create("냠냠", "본문", memberA, null);
        issueAssignees = issue.getAssignees();
        issueLabels = issue.getIssueLabels();
    }

    @Test
    @DisplayName("동등한 issueAssignee를 같은 issue에 삽입하면 먼저 삽입된 issueAssignee만 삽입된다.")
    public void addEqualAssigneeTest() {
        IssueAssignee issueAssigneeA = new IssueAssignee(memberA, issue);
        IssueAssignee issueAssigneeB = new IssueAssignee(issueAssigneeA.getMember(), issueAssigneeA.getIssue());

        issue.addIssueAssignee(issueAssigneeA);
        issue.addIssueAssignee(issueAssigneeB);
        IssueAssignee findIssueAssignee = issueAssignees.stream().findFirst().get();

        assertThat(issueAssignees.size()).isEqualTo(1);
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

        assertThat(issueAssignees.size()).isEqualTo(2);
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

    @Test
    @DisplayName("동등한 issueLabel를 같은 issue에 삽입하면 먼저 삽입된 issueLabel만 삽입된다.")
    public void addEqualIssueLabelTest() {
        IssueLabel issueLabelA = new IssueLabel(labelA, issue);
        IssueLabel issueLabelB = new IssueLabel(issueLabelA.getLabel(), issueLabelA.getIssue());

        issue.addIssueLabel(issueLabelA);
        issue.addIssueLabel(issueLabelB);
        IssueLabel findIssueLabel = issueLabels.stream().findFirst().get();

        assertThat(issueLabels.size()).isEqualTo(1);
        assertThat(issueLabelA).isNotSameAs(issueLabelB);
        assertThat(findIssueLabel).isSameAs(issueLabelA);
    }

    @Test
    @DisplayName("동등하지 않은 issueLabel를 같은 issue에 삽입하면 모두 다 삽입된다.")
    public void addNotEqualIssueLabelTest() {
        IssueLabel issueLabelA = new IssueLabel(labelA, issue);
        IssueLabel issueLabelB = new IssueLabel(labelB, issue);

        issue.addIssueLabel(issueLabelA);
        issue.addIssueLabel(issueLabelB);

        assertThat(issueLabels.size()).isEqualTo(2);
        assertThat(issueLabels).containsExactlyInAnyOrder(issueLabelA, issueLabelB);
    }

    @Test
    @DisplayName("다른 이슈에 할당된 IssueLabel를 issue에 할당하면 InvalidIssueLabelAddException이 발생한다.")
    public void invalidIssueLabelAddTest() {
        Issue otherIssue = Issue.create("Other Issue", "content", memberA, null);
        IssueLabel otherIssueLabel = new IssueLabel(labelA, otherIssue);

        assertThatThrownBy(() -> issue.addIssueLabel(otherIssueLabel))
                .isInstanceOf(InvalidIssueLabelAddException.class);
    }


}
