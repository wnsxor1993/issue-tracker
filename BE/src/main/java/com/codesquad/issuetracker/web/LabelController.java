package com.codesquad.issuetracker.web;

import com.codesquad.issuetracker.domain.Label;
import com.codesquad.issuetracker.service.label.LabelCommandService;
import com.codesquad.issuetracker.service.label.LabelQueryService;
import com.codesquad.issuetracker.web.dto.label.LabelCreateRequest;
import com.codesquad.issuetracker.web.dto.label.LabelCreateResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
public class LabelController {

    private final LabelQueryService labelQueryService;
    private final LabelCommandService labelCommandService;

    @PostMapping("/issue-tracker/api/labels")
    public LabelCreateResponse createLabel(@RequestBody LabelCreateRequest labelCreateRequest) {
        Label label = labelCreateRequest.toEntity();
        Long labelId = labelCommandService.enrollLabel(label);

        log.info("create Label = {}", label);

        return new LabelCreateResponse(labelId);
    }
}
