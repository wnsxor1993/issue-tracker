package com.codesquad.issuetracker.repository.comment;

import com.codesquad.issuetracker.web.dto.comment.CommentListElement;

import java.util.List;

public interface CommentCustomRepository {

    List<CommentListElement> findCommentDtosByIssueId(Long issueId);

}
