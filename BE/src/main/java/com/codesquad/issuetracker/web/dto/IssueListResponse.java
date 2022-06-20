package com.codesquad.issuetracker.web.dto;

import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.domain.IssueLabel;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class IssueListResponse {

    private List<IssueListElement> issues;

    @Getter
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    private static class IssueListElement {

        private Long issueId;
        private String title;
        private String content;
        private Long milestoneId;
        private String milestoneName;
        private List<LabelDto> labels = new ArrayList<>();

        @Builder(access = AccessLevel.PRIVATE)
        private IssueListElement(Long issueId, String title, String content, Long milestoneId, String milestoneName, List<LabelDto> labels) {
            this.issueId = issueId;
            this.title = title;
            this.content = content;
            this.milestoneId = milestoneId;
            this.milestoneName = milestoneName;
            this.labels = labels;
        }

        public static IssueListElement create(Issue issue) {
            return IssueListElement.builder()
                    .issueId(issue.getId())
                    .title(issue.getTitle())
                    .content(issue.getContent())
                    .milestoneId(initMilestoneId(issue))
                    .milestoneName(initMilestoneName(issue))
                    .labels(initLabels(issue))
                    .build();

        }

        private static Long initMilestoneId(Issue issue) {
            return issue.getMilestone() == null ? null : issue.getMilestone().getId();
        }

        private static String initMilestoneName(Issue issue) {
            return issue.getMilestone() == null ? null : issue.getMilestone().getTitle();
        }

        private static List<LabelDto> initLabels(Issue issue) {
            return issue.getIssueLabels().stream()
                    .map(IssueLabel::getLabel)
                    .map(LabelDto::create)
                    .collect(Collectors.toList());
        }
    }

}
