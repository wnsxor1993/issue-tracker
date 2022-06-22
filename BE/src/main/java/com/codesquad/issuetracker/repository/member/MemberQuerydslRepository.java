package com.codesquad.issuetracker.repository.member;

import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;

public class MemberQuerydslRepository implements MemberCustomRepository {

    private final JPAQueryFactory queryFactory;

    public MemberQuerydslRepository(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }
}
