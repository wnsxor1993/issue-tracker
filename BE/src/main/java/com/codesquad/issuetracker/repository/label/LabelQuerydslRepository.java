package com.codesquad.issuetracker.repository.label;

import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;

public class LabelQuerydslRepository implements LabelCustomRepository {

    private final JPAQueryFactory queryFactory;

    public LabelQuerydslRepository(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }
}
