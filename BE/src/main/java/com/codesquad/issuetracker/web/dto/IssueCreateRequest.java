package com.codesquad.issuetracker.web.dto;

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
    private List<Long> labelIds = new ArrayList<>();
    private List<Long> assigneeIds = new ArrayList<>();
}
