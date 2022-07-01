package com.codesquad.issuetracker.web.dto.issue;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Getter
public class IssueListElement {

    private final Long issueId;
    private final String title;
    private final String content;
    private final Long milestoneId;
    private final String milestoneName;
    private final List<IssueLabelDto> labels = new ArrayList<>();

    @QueryProjection
    public IssueListElement(Long issueId, String title, String content, Long milestoneId, String milestoneName) {
        this.issueId = issueId;
        this.title = title;
        this.content = content;
        this.milestoneId = milestoneId;
        this.milestoneName = milestoneName;
    }

    public void initLabels(List<IssueLabelDto> issueLabels) {
        this.labels.addAll(issueLabels);
    }
}
