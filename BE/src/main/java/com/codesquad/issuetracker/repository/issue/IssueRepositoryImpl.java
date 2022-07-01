package com.codesquad.issuetracker.repository.issue;

import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.domain.QMember;
import com.codesquad.issuetracker.dto.IssueSearchCondition;
import com.codesquad.issuetracker.web.dto.issue.*;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

import static com.codesquad.issuetracker.domain.QIssue.issue;
import static com.codesquad.issuetracker.domain.QIssueAssignee.issueAssignee;
import static com.codesquad.issuetracker.domain.QIssueLabel.issueLabel;
import static com.codesquad.issuetracker.domain.QLabel.label;
import static com.codesquad.issuetracker.domain.QMember.member;
import static com.codesquad.issuetracker.domain.QMilestone.milestone;


public class IssueRepositoryImpl implements IssueCustomRepository {

    private final JPAQueryFactory queryFactory;

    public IssueRepositoryImpl(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }

    @Override
    public Optional<Issue> findByIdWithAuthorAndMilestone(Long issueId) {
        QMember author = new QMember("author");

        Issue findIssue = queryFactory.select(issue)
                .from(issue)
                .join(issue.author, author).fetchJoin()
                .leftJoin(issue.milestone, milestone).fetchJoin()
                .where(issue.id.eq(issueId))
                .fetchOne();

        return Optional.ofNullable(findIssue);
    }

    @Override
    public void updateBulkStates(List<Long> issueIds, boolean isOpened) {
        queryFactory.update(issue)
                .set(issue.isOpened, isOpened)
                .where(issue.id.in(issueIds))
                .execute();
    }

    @Override
    public Optional<IssueDetailResponse> findIssueDetail(Long issueId) {
        QMember author = new QMember("author");

        IssueDetailResponse issueDetailResponse = queryFactory
                .select(
                        new QIssueDetailResponse(
                                issue.id, author.id, author.name, issue.title,
                                issue.content, milestone.id, milestone.title, issue.isOpened,
                                issue.createdAt, issue.lastModifiedAt
                        ))
                .from(issue)
                .join(issue.author, author)
                .leftJoin(issue.milestone, milestone)
                .where(issue.id.eq(issueId))
                .fetchOne();

        return Optional.ofNullable(issueDetailResponse);
    }

    @Override
    public List<IssueLabelDto> findIssueLabelDtosByIssueId(Long issueId) {
        return queryFactory.select(new QIssueLabelDto(label.id, label.name, label.labelColor))
                .from(issueLabel)
                .join(issueLabel.label, label)
                .where(issueLabel.issue.id.eq(issueId))
                .fetch();
    }

    @Override
    public List<IssueAssigneeDto> findIssueAssigneeDtosByIssueId(Long issueId) {
        return queryFactory
                .select(new QIssueAssigneeDto(member.id, member.name))
                .from(issueAssignee)
                .join(issueAssignee.member, member)
                .where(issueAssignee.issue.id.eq(issueId))
                .fetch();
    }

    @Override
    public List<IssueListElement> searchIssueList(IssueSearchCondition issueSearchCondition) {
        QMember author = new QMember("author");
        return queryFactory
                .select(new QIssueListElement(
                        issue.id, issue.title, issue.content, milestone.id, milestone.title))
                .from(issue)
                .join(issue.author, author)
                .join(issue.milestone, milestone)
                .where(isOpenedEq(issueSearchCondition.getIsOpened()))
                .fetch();
    }

    private BooleanExpression isOpenedEq(Boolean isOpenedCondition) {
        return (isOpenedCondition == null)
                ? null
                : issue.isOpened.eq(isOpenedCondition);
    }
}
