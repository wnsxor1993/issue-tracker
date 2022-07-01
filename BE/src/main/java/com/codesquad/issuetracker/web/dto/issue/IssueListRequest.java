package com.codesquad.issuetracker.web.dto.issue;

import com.codesquad.issuetracker.dto.IssueSearchCondition;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@RequiredArgsConstructor
@ToString(of = {"isOpened", "authorId", "commentAuthorId"})
public class IssueListRequest {

    private final Boolean isOpened;
    private final Long authorId;
    private final Long commentAuthorId;

    public IssueSearchCondition toSearchCondition(IssueListRequest listRequest) {
        return IssueSearchCondition.builder()
                .isOpened(isOpened)
                .authorId(authorId)
                .commentAuthorId(commentAuthorId)
                .build();
    }

    public Boolean getIsOpened() {
        return isOpened;
    }

    public Long getAuthorId() {
        return authorId;
    }

    public Long getCommentAuthorId() {
        return commentAuthorId;
    }
}

