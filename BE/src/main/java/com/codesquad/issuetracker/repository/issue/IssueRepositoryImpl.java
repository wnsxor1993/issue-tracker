package com.codesquad.issuetracker.repository.issue;

import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.domain.QMember;
import com.codesquad.issuetracker.web.dto.issue.IssueDetailResponse;
import com.codesquad.issuetracker.web.dto.issue.QIssueDetailResponse;
import com.codesquad.issuetracker.web.dto.issue.QIssueDetailResponse_CommentListElement;
import com.codesquad.issuetracker.web.dto.issue.QIssueDetailResponse_IssueAssigneeDto;
import com.codesquad.issuetracker.web.dto.label.LabelDto;
import com.codesquad.issuetracker.web.dto.label.QLabelDto;
import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

import static com.codesquad.issuetracker.domain.QComment.comment;
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

        IssueDetailResponse issueDetailResponse = getIssueDetailResponse(issueId);

        if (issueDetailResponse == null) {
            return Optional.empty();
        }

        List<IssueDetailResponse.IssueAssigneeDto> assigneeDtos = findIssueAssigneeDtos(issueId);
        List<LabelDto> labelDtos = findLabelDtos(issueId);
        List<IssueDetailResponse.CommentListElement> commentDtos = findCommentDtos(issueId);

        issueDetailResponse.getAssignees().addAll(assigneeDtos);
        issueDetailResponse.getLabels().addAll(labelDtos);
        issueDetailResponse.getComments().addAll(commentDtos);

        return Optional.of(issueDetailResponse);
    }

    private List<IssueDetailResponse.CommentListElement> findCommentDtos(Long issueId) {
        QMember author = new QMember("author");

        return queryFactory
                .select(
                        new QIssueDetailResponse_CommentListElement(
                                comment.id, author.id, author.name,
                                comment.content, comment.createdAt, comment.lastModifiedAt))
                .from(comment)
                .join(comment.author, author)
                .where(comment.issue.id.eq(issueId))
                .fetch();
    }

    private List<LabelDto> findLabelDtos(Long issueId) {
        return queryFactory.select(new QLabelDto(label.id, label.name, label.labelColor))
                .from(issueLabel)
                .join(issueLabel.label, label)
                .where(issueLabel.issue.id.eq(issueId))
                .fetch();
    }



    private List<IssueDetailResponse.IssueAssigneeDto> findIssueAssigneeDtos(Long issueId) {
        return queryFactory
                .select(new QIssueDetailResponse_IssueAssigneeDto(member.id, member.name))
                .from(issueAssignee)
                .join(issueAssignee.member, member)
                .where(issueAssignee.issue.id.eq(issueId))
                .fetch();
    }

    private IssueDetailResponse getIssueDetailResponse(Long issueId) {
        QMember author = new QMember("author");

        return queryFactory
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
    }
}
