package com.codesquad.issuetracker.web.dto;

import com.codesquad.issuetracker.domain.Label;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class LabelDto {

    private Long labelId;
    private String labelName;
    private String labelColor;

    @Builder(access = AccessLevel.PRIVATE)
    private LabelDto(Long labelId, String labelName, String labelColor) {
        this.labelId = labelId;
        this.labelName = labelName;
        this.labelColor = labelColor;
    }

    public static LabelDto create(Label label) {
        return LabelDto.builder()
                .labelId(label.getId())
                .labelName(label.getName())
                .labelColor(label.getLabelColor().getColorCode())
                .build();
    }
}
