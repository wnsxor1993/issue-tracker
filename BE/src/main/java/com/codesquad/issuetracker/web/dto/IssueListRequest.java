package com.codesquad.issuetracker.web.dto;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class IssueListRequest {

    private boolean isOpened;

    public IssueListRequest(boolean isOpened) {
        this.isOpened = isOpened;
    }
}
