package com.codesquad.issuetracker.web.dto.issue;

import com.codesquad.issuetracker.domain.LabelColor;
import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;

@Getter
public class IssueLabelDto {

    private Long labelId;
    private String labelName;
    private String labelColor;

    @QueryProjection
    public IssueLabelDto(Long labelId, String labelName, LabelColor labelColor) {
        this.labelId = labelId;
        this.labelName = labelName;
        this.labelColor = labelColor.getColorCode();
    }
}
