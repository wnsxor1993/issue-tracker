package com.codesquad.issuetracker.web.dto.issue;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.List;

@Getter
@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class IssueCreateRequest {

    @NotBlank
    private String title;
    private String content;
    private Long milestoneId;
    private final List<Long> labelIds = new ArrayList<>();
    private final List<Long> assigneeIds = new ArrayList<>();
}
