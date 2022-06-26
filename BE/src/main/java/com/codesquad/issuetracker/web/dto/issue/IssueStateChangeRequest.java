package com.codesquad.issuetracker.web.dto.issue;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class IssueStateChangeRequest {

    private boolean isOpened;

    public boolean getIsOpened() {
        return isOpened;
    }
}
