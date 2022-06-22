package com.codesquad.issuetracker.repository.milestone;

import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;

public class MilestoneRepositoryImpl implements MilestoneCustomRepository {

    private final JPAQueryFactory queryFactory;

    public MilestoneRepositoryImpl(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }
}
