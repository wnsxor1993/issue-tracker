package com.codesquad.issuetracker.repository.issue;

import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;

public class IssueQuerydslRepository implements IssueCustomRepository {

    private final JPAQueryFactory queryFactory;

    public IssueQuerydslRepository(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }

}