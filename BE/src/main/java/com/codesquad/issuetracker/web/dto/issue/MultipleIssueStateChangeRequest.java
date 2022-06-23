package com.codesquad.issuetracker.web.dto.issue;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MultipleIssueStateChangeRequest {

    private List<Long> issueIds = new ArrayList<>();
    private boolean isOpened;

    public List<Long> getIssueIds() {
        return issueIds;
    }

    public boolean getIsOpened() {
        return isOpened;
    }
}
