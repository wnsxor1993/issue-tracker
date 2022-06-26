package com.codesquad.issuetracker.web.dto.label;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
public class LabelCreateResponse {

    private final Long labelId;

    public LabelCreateResponse(Long labelId) {
        this.labelId = labelId;
    }
}
