package com.codesquad.issuetracker.web.dto;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

@Getter
@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MultipleIssueStateChangeRequest {

    private List<Long> issueIds = new ArrayList<>();
    private boolean isOpened;
}
