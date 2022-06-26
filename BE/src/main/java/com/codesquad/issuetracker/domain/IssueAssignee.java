package com.codesquad.issuetracker.domain;

import lombok.AccessLevel;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

import java.util.List;
import java.util.stream.Collectors;

import static javax.persistence.FetchType.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@EqualsAndHashCode(of = {"member", "issue"})
public class IssueAssignee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "issue_assignee_id")
    private Long id;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "issue_id")
    private Issue issue;

    public IssueAssignee(Member member, Issue issue) {
        this.member = member;
        this.issue = issue;
    }

    public static List<IssueAssignee> createIssueAssignees(Issue issue, List<Member> members) {
        return members.stream()
                .map(member -> new IssueAssignee(member, issue))
                .collect(Collectors.toList());
    }

    public boolean hasDifferentIssue(Issue otherIssue) {
        return !(issue.equals(otherIssue));
    }
}
