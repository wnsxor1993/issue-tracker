package com.codesquad.issuetracker.repository.label;

import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;

public class LabelRepositoryImpl implements LabelCustomRepository {

    private final JPAQueryFactory queryFactory;

    public LabelRepositoryImpl(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }
}
