package com.codesquad.issuetracker.web.dto.label;

import com.codesquad.issuetracker.domain.Label;
import com.codesquad.issuetracker.domain.LabelColor;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;

@Getter
@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class LabelCreateRequest {

    @NotBlank
    private String name;
    private String description;
    private String colorCode;

    public Label toEntity() {
        LabelColor labelColor = LabelColor.create(colorCode);
        return new Label(name, description, labelColor);
    }
}
