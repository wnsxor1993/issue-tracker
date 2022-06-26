package com.codesquad.issuetracker.service.comment;

import com.codesquad.issuetracker.repository.comment.CommentRepository;
import com.codesquad.issuetracker.web.dto.comment.CommentListElement;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class CommentQueryService {

    private final CommentRepository commentRepository;

    public List<CommentListElement> findCommentDtosByIssueId(Long issueId) {
        return commentRepository.findCommentDtosByIssueId(issueId);
    }
}
