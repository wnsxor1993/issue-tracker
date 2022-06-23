package com.codesquad.issuetracker.domain;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static javax.persistence.FetchType.LAZY;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@ToString(of = {"id", "title", "content", "isOpened", "createdAt", "lastModifiedAt"})
public class Issue extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "issue_id")
    private Long id;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "author_id")
    private Member author;

    @OneToMany(mappedBy = "issue", cascade = CascadeType.ALL, orphanRemoval = true)
    private final List<IssueAssignee> assignees = new ArrayList<>();

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "milestone_id")
    private Milestone milestone;

    @OneToMany(mappedBy = "issue", cascade = CascadeType.ALL, orphanRemoval = true)
    private final List<IssueLabel> issueLabels = new ArrayList<>();

    @OneToMany(mappedBy = "issue", cascade = CascadeType.ALL, orphanRemoval = true)
    private final List<Comment> comments = new ArrayList<>();

    private String title;
    private String content;

    private boolean isOpened;

    @Builder(access = AccessLevel.PRIVATE)
    private Issue(Member author, Milestone milestone, String title, String content, boolean isOpened) {
        this.author = author;
        this.milestone = milestone;
        this.title = title;
        this.content = content;
        this.isOpened = isOpened;
    }

    public static Issue create(String title, String content, Member author, Milestone milestone) {
        return Issue.builder()
                .author(author)
                .milestone(milestone)
                .title(title)
                .content(content)
                .isOpened(true)
                .build();
    }

    /**
     * 지정 member들로 현재 이슈의 할당자 교체(포함되지 않은 회원들 제거)
     */
    public void changeIssueAssignees(List<Member> changeMembers) {
        removeAssigneesNotIn(changeMembers);
        removeDuplicateMemberFrom(changeMembers);

        List<IssueAssignee> newAssignees = createNewAssignees(changeMembers);
        assignees.addAll(newAssignees);
    }

    /**
     * 이슈의 상태를 변경
     */
    public void changeIssueState(boolean isOpened) {
        this.isOpened = isOpened;
    }

    /**
     * 리스트에 없는 회원을 기존의 할당자에서 제거
     */
    private void removeAssigneesNotIn(List<Member> changeMembers) {
        this.assignees.removeIf(
                assignee -> !assignee.isMemberBelongTo(changeMembers)
        );
    }

    /**
     * 기존에 추가되지 않은 회원들을 할당
     */
    private List<IssueAssignee> createNewAssignees(List<Member> changeMembers) {
        return changeMembers.stream()
                .map(newMember -> new IssueAssignee(newMember, this))
                .collect(Collectors.toList());
    }

    /**
     * 리스트에 존재하는 할당자가 이미 존재하면 changeMembers에서 제거
     */
    private void removeDuplicateMemberFrom(List<Member> changeMembers) {
        List<Member> beforeMembers = assignees.stream()
                .map(IssueAssignee::getMember)
                .collect(Collectors.toList());
        changeMembers.removeIf(beforeMembers::contains);
    }

}
