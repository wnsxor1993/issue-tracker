package com.codesquad.issuetracker.domain;

import com.codesquad.issuetracker.excption.InvalidIssueAssigneeAddException;
import com.codesquad.issuetracker.excption.InvalidIssueLabelAddException;
import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
    private final Set<IssueAssignee> assignees = new HashSet<>();

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
     * 이슈의 상태를 변경
     */
    public void changeIssueState(boolean isOpened) {
        this.isOpened = isOpened;
    }

    public void addIssueAssignee(IssueAssignee issueAssignee) {
        validateIssueAssignee(issueAssignee);
        assignees.add(issueAssignee);
    }

    private void validateIssueAssignee(IssueAssignee issueAssignee) {
        if (issueAssignee.hasDifferentIssue(this)) {
            throw new InvalidIssueAssigneeAddException("다른 이슈에 할당된 IssueAssignee를 추가할 수 없습니다.");
        }
    }

    public void addIssueAssignees(List<IssueAssignee> assignees) {
        assignees.forEach(this::addIssueAssignee);
    }

    /**
     * 리스트에 없는 이슈 할당자들을 기존의 할당자에서 제거
     */
    public void removeAssigneesNotIn(List<IssueAssignee> otherAssignees) {
        this.assignees.removeIf(
                assignee -> !otherAssignees.contains(assignee)
        );
    }

    public void addIssueLabel(IssueLabel issueLabel) {
        validateIssueLabel(issueLabel);
        issueLabels.add(issueLabel);
    }

    private void validateIssueLabel(IssueLabel issueLabel) {
        if (issueLabel.hasDifferentIssue(this)) {
            throw new InvalidIssueLabelAddException("다른 이슈에 할당된 IssueLabel를 추가할 수 없습니다.");
        }
    }

    public void addIssueLabels(List<IssueLabel> issueLabels) {
        issueLabels.forEach(this::addIssueLabel);
    }

    /**
     * 리스트에 없는 라벨들을 기존의 issueLabels에서 제거
     */
    public void removeIssueLabelsNotIn(List<IssueLabel> otherIssueLabels) {
        this.issueLabels.removeIf(
                issueLabel -> !issueLabels.contains(issueLabel)
        );
    }

    /**
     * 제목 변경
     */
    public void changeTitle(String title) {
        this.title = title;
    }

    /**
     * 본문 변경
     */
    public void changeContent(String content) {
        this.content = content;
    }

    /**
     * 마일스톤 변경
     */
    public void changeMilestone(Milestone updateMilestone) {
        this.milestone = milestone;
    }
}
