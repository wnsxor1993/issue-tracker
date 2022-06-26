package com.codesquad.issuetracker.web.dto.issue;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;

@Getter
public class IssueAssigneeDto {

    private final Long assigneeId;
    private final String assigneeName;

    @QueryProjection
    public IssueAssigneeDto(Long assigneeId, String assigneeName) {
        this.assigneeId = assigneeId;
        this.assigneeName = assigneeName;
    }
}
