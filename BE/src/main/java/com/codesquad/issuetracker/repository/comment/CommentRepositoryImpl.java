package com.codesquad.issuetracker.repository.comment;

import com.codesquad.issuetracker.domain.QMember;
import com.codesquad.issuetracker.web.dto.comment.CommentListElement;
import com.codesquad.issuetracker.web.dto.comment.QCommentListElement;
import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;
import java.util.List;

import static com.codesquad.issuetracker.domain.QComment.comment;

public class CommentRepositoryImpl implements CommentCustomRepository {

    private final JPAQueryFactory queryFactory;

    public CommentRepositoryImpl(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }

    @Override
    public List<CommentListElement> findCommentDtosByIssueId(Long issueId) {
        QMember author = new QMember("author");
        return queryFactory
                .select(
                        new QCommentListElement(
                                comment.id, author.id, author.name,
                                comment.content, comment.createdAt, comment.lastModifiedAt))
                .from(comment)
                .join(comment.author, author)
                .where(comment.issue.id.eq(issueId))
                .fetch();
    }
}
