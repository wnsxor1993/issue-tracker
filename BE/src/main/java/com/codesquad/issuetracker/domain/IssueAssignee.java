package com.codesquad.issuetracker.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

import static javax.persistence.FetchType.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
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

    private IssueAssignee(Member member, Issue issue) {
        this.member = member;
        this.issue = issue;
    }

    /**
     * 이슈에 회원을 할당하기 위해 사용하는 편의 메서드
     * Issue에 종속적임. 생성 시 Issue에서만 생성하도록 하고 package-private로 함
     */
    static void assignMemberToIssue(Member member, Issue issue) {
        IssueAssignee issueAssignee = new IssueAssignee(member, issue);
        issue.getAssignees().add(issueAssignee);
    }

}
