package com.codesquad.issuetracker.web.dto.label;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class LabelCreateResponse {

    private Long labelId;

    public LabelCreateResponse(Long labelId) {
        this.labelId = labelId;
    }
}
