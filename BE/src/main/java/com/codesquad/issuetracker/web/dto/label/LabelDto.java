package com.codesquad.issuetracker.web.dto.label;

import com.codesquad.issuetracker.domain.LabelColor;
import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;

@Getter
public class LabelDto {

    private Long labelId;
    private String labelName;
    private String labelColor;

    @QueryProjection
    public LabelDto(Long labelId, String labelName, LabelColor labelColor) {
        this.labelId = labelId;
        this.labelName = labelName;
        this.labelColor = labelColor.getColorCode();
    }
}
