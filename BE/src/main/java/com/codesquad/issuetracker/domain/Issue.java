package com.codesquad.issuetracker.domain;

import com.codesquad.issuetracker.excption.InvalidIssueAssigneeAddException;
import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
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

    /**
     * 지정 Label들로 현재 이슈를 교체(포함되지 않은 라벨들 제거)
     */
    public void changeIssueLabels(List<Label> changeLabels) {
        removeIssueLabelsNotIn(changeLabels);
        removeDuplicateLabelFrom(changeLabels);

        List<IssueLabel> newLabels = createNewIssueLabels(changeLabels);
        issueLabels.addAll(newLabels);
    }

    /**
     * 리스트에 없는 라벨을 제거
     */
    private void removeIssueLabelsNotIn(List<Label> changeLabels) {
        this.issueLabels.removeIf(
                issueLabel -> !issueLabel.isLabelBelongTo(changeLabels)
        );
    }

    /**
     * 리스트에 존재하는 라벨이 이미 존재하면 changeLabels에서 제거
     */
    private void removeDuplicateLabelFrom(List<Label> changeLabels) {
        List<Label> beforeLabels = issueLabels.stream()
                .map(IssueLabel::getLabel)
                .collect(Collectors.toList());
        changeLabels.removeIf(beforeLabels::contains);
    }

    /**
     * 기존에 추가되지 않은 라벨들로 이슈라벨을 생성
     */
    private List<IssueLabel> createNewIssueLabels(List<Label> changeLabels) {
        return changeLabels.stream()
                .map(newLabel -> new IssueLabel(this, newLabel))
                .collect(Collectors.toList());
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
