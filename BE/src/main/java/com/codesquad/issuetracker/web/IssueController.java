package com.codesquad.issuetracker.web;

import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.service.issue.IssueCommandService;
import com.codesquad.issuetracker.service.issue.IssueQueryService;
import com.codesquad.issuetracker.web.dto.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
public class IssueController {

    private final IssueQueryService issueQueryService;
    private final IssueCommandService issueCommandService;

    private static final Long SAMPLE_MEMBER_ID = 1L;

    /**
     * 이슈 생성
     */
    @PostMapping("/issue-tracker/api/issues")
    public IssueCreateResponse create(@RequestBody IssueCreateRequest createRequest) {
        log.info("Issue Create Request = {}", createRequest);
        Long authorId = SAMPLE_MEMBER_ID;

        Long createdIssueId = issueCommandService.createIssue(
                authorId,
                createRequest.getAssigneeIds(),
                createRequest.getMilestoneId(),
                createRequest.getLabelIds(),
                createRequest.getTitle(),
                createRequest.getContent());
        
        log.info("Created Issue Id = {}", createdIssueId);
        return new IssueCreateResponse(createdIssueId);
    }

    /**
     * 이슈 검색
     */
    @GetMapping("/issue-tracker/api/issues")
    public IssueListResponse issueList(@ModelAttribute IssueListRequest listRequest) {
        log.info("Issue List Request = {}", listRequest);
        return null;
    }

    /**
     * 이슈 수정(제목, 본문, 레이블, 마일스톤)
     */
    @PutMapping("/issue-tracker/api/issues")
    public IssueUpdateResponse update(@RequestBody IssueUpdateRequest updateRequest) {
        log.info("Issue Create Request = {}", updateRequest);
        return null;
    }

    /**
     * 이슈 상세 조회
     */
    @GetMapping("/issue-tracker/api/issues/{issueId}")
    public IssueDetailResponse issueDetail(@PathVariable Long issueId) {
        log.info("Issue Detail Request - issueId = {}", issueId);
        return null;
    }

    /**
     * 이슈 상태변경(open, close)
     */
    @PatchMapping("/issue-tracker/api/issues/{issueId}")
    public IssueStateChangeResponse stateChange(@PathVariable Long issueId, @RequestBody IssueStateChangeRequest stateChangeRequest) {
        log.info("Issue StateChange Request = {}", stateChangeRequest);
        issueCommandService.changeState(issueId, stateChangeRequest.getIsOpened());
        Issue issue = issueQueryService.findIssue(issueId);

        return IssueStateChangeResponse.create(issue);
    }

    /**
     * 이슈 삭제
     */
    @DeleteMapping("/issue-tracker/api/issues/{issueId}")
    public IssueDeleteResponse delete(@PathVariable Long issueId) {
        log.info("Issue Delete Request - issueId = {}", issueId);
        return null;
    }

    /**
     * 이슈 다중 상태 변경
     */
    @PatchMapping("/issue-tracker/api/issues")
    public MultipleIssueStateChangeResponse multipleStateChange(@RequestBody MultipleIssueStateChangeRequest multipleStateCahngeRequest) {
        log.info("Multiple Issue StateChange Request = {}", multipleStateCahngeRequest);
        issueCommandService.changeStates(multipleStateCahngeRequest.getIssueIds(), multipleStateCahngeRequest.getIsOpened());
        List<Issue> issues = issueQueryService.findIssues(multipleStateCahngeRequest.getIssueIds());

        return MultipleIssueStateChangeResponse.create(issues);
    }

}

