package com.codesquad.issuetracker.domain;

import com.codesquad.issuetracker.excption.InvalidIssueAssigneeAddException;
import com.codesquad.issuetracker.excption.InvalidIssueLabelAddException;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.Set;

import static org.assertj.core.api.Assertions.*;

@Slf4j
class IssueTest {

    Member memberA = new Member("memberA", "1234!", "사용자1");
    Member memberB = new Member("memberB", "1234!", "사용자2");
    Label labelA = new Label("labelA", "widwdniw", LabelColor.create("FFFFFF"));
    Label labelB = new Label("labelB", "widwdniw", LabelColor.create("AAAAAA"));

    Issue issue = issue = Issue.create("냠냠", "본문", memberA, null);

    Set<IssueAssignee> issueAssignees = issue.getAssignees();
    Set<IssueLabel> issueLabels = issue.getIssueLabels();


    @BeforeEach
    void init() {
        issueAssignees.clear();
        issueLabels.clear();
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

    @Nested
    @DisplayName("removeAssigneesNotIn 메서드는")
    class removeAssigneesNotIn_메서드는 {

        @Nested
        @DisplayName("기존 이슈 Assignee가 인자에 포함되지 않았을 때")
        class 기존_이슈_Assignee_가_인자에_포함_안_될_때 {

            IssueAssignee beforeAssignee = new IssueAssignee(memberA, issue);
            IssueAssignee otherAssignee = new IssueAssignee(memberB, issue);
            List<IssueAssignee> otherIssueAssignees = List.of(otherAssignee);

            @Test
            @DisplayName("해당 IssueAssignee를 제거한다.")
            public void deleteAssignee() {
                issue.addIssueAssignee(beforeAssignee);

                //when
                issue.removeAssigneesNotIn(otherIssueAssignees);

                assertThat(issueAssignees.size()).isEqualTo(0);
                assertThat(issueAssignees).doesNotContain(beforeAssignee);
            }
        }

        @Nested
        @DisplayName("기존 이슈 Assignee가 인자에 포함될 때")
        class 기존_이슈_Assignee_가_인자에_포함_될_때 {

            IssueAssignee beforeAssignee = new IssueAssignee(memberA, issue);
            IssueAssignee otherAssignee = new IssueAssignee(memberA, issue);
            List<IssueAssignee> otherIssueAssignees = List.of(otherAssignee);

            @Test
            @DisplayName("해당 IssueAssignee를 제거하지 않는다.")
            public void doesNotDeleteAssignee() {
                // given
                issue.addIssueAssignee(beforeAssignee);

                // when
                issue.removeAssigneesNotIn(otherIssueAssignees);

                // then
                assertThat(issueAssignees.size()).isEqualTo(1);
                assertThat(issueAssignees).containsExactly(beforeAssignee);
            }
        }
    }

    @Nested
    @DisplayName("removeLabelsNotIn 메서드는")
    class removeLablesNotIn_메서드는 {

        @Nested
        @DisplayName("기존 이슈 Labels가 인자에 포함되지 않았을 때")
        class 기존_이슈_Labels_가_인자에_포함_안_될_때 {

            IssueLabel beforeIssueLabel = new IssueLabel(labelA, issue);
            IssueLabel otherIssueLabel = new IssueLabel(labelB, issue);
            List<IssueLabel> otherIssueLabels = List.of(otherIssueLabel);

            @Test
            @DisplayName("해당 IssueLabel를 제거한다.")
            public void deleteIssueLabel() {
                issue.addIssueLabel(beforeIssueLabel);

                //when
                issue.removeIssueLabelsNotIn(otherIssueLabels);

                assertThat(issueLabels.size()).isEqualTo(0);
                assertThat(issueLabels).doesNotContain(beforeIssueLabel);
            }
        }

        @Nested
        @DisplayName("기존 이슈 Labels가 인자에 포함될 때")
        class 기존_이슈_Labels_가_인자에_포함_될_때 {
            IssueLabel beforeIssueLabel = new IssueLabel(labelA, issue);
            IssueLabel otherIssueLabel = new IssueLabel(labelA, issue);
            List<IssueLabel> otherIssueLabels = List.of(otherIssueLabel);

            @Test
            @DisplayName("해당 IssueLabel를 제거하지 않는다.")
            public void doesNotDeleteIssueLabel() {
                issue.addIssueLabel(beforeIssueLabel);

                //when
                issue.removeIssueLabelsNotIn(otherIssueLabels);

                assertThat(issueLabels.size()).isEqualTo(1);
                assertThat(issueLabels).containsExactly(beforeIssueLabel);
            }
        }
    }
}
