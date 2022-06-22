package com.codesquad.issuetracker.repository.milestone;

import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;

public class MilestoneQuerydslRepository implements MilestoneCustomRepository {

    private final JPAQueryFactory queryFactory;

    public MilestoneQuerydslRepository(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }
}
