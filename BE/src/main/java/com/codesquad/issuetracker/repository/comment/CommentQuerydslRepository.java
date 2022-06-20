package com.codesquad.issuetracker.repository.comment;

import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;

public class CommentQuerydslRepository implements CommentCustomRepository {

    private final JPAQueryFactory queryFactory;

    public CommentQuerydslRepository(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }
}
