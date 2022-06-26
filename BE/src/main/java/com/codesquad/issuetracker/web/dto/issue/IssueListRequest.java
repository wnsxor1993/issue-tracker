package com.codesquad.issuetracker.web.dto.issue;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class IssueListRequest {

    private final boolean isOpened;

    public IssueListRequest(boolean isOpened) {
        this.isOpened = isOpened;
    }
}
