package com.codesquad.issuetracker.web;

import com.codesquad.issuetracker.service.label.LabelCommandService;
import com.codesquad.issuetracker.service.label.LabelQueryService;
import com.codesquad.issuetracker.web.dto.label.LabelCreateRequest;
import com.codesquad.issuetracker.web.dto.label.LabelCreateResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
public class LabelController {

    private final LabelQueryService labelQueryService;
    private final LabelCommandService labelCommandService;

    @PostMapping("/issue-tracker/api/labels")
    @ResponseStatus(HttpStatus.CREATED)
    public LabelCreateResponse createLabel(@RequestBody LabelCreateRequest labelCreateRequest) {
        Long labelId = labelCommandService.createLabel(labelCreateRequest);
        log.info("create Label = {}", labelId);
        return new LabelCreateResponse(labelId);
    }
}
