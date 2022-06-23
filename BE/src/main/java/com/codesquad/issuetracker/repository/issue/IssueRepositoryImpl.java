package com.codesquad.issuetracker.repository.issue;

import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.domain.QMember;
import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;

import java.util.List;
import java.util.Optional;

import static com.codesquad.issuetracker.domain.QIssue.*;
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
}
