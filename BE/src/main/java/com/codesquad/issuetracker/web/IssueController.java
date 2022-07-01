package com.codesquad.issuetracker.web;

import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.dto.IssueSearchCondition;
import com.codesquad.issuetracker.service.issue.IssueCommandService;
import com.codesquad.issuetracker.service.issue.IssueQueryService;
import com.codesquad.issuetracker.web.dto.issue.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
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
    @ResponseStatus(HttpStatus.CREATED)
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

        IssueSearchCondition issueSearchCondition = listRequest.toSearchCondition(listRequest);
        return issueQueryService.searchIssueList(issueSearchCondition);
    }

    /**
     * 이슈 수정(제목, 본문, 레이블, 마일스톤)
     */
    @PutMapping("/issue-tracker/api/issues/{issueId}")
    public IssueUpdateResponse update(@PathVariable Long issueId, @RequestBody IssueUpdateRequest updateRequest) {
        log.info("Issue update Request = {}", updateRequest);
        issueCommandService.updateIssue(issueId, updateRequest);
        return new IssueUpdateResponse(issueId);
    }

    /**
     * 이슈 상세 조회
     */
    @GetMapping("/issue-tracker/api/issues/{issueId}")
    public IssueDetailResponse issueDetail(@PathVariable Long issueId) {
        log.info("Issue Detail Request - issueId = {}", issueId);
        return issueQueryService.findIssueDetail(issueId);
    }

    /**
     * 이슈 상태변경(open, close)
     */
    @PatchMapping("/issue-tracker/api/issues/{issueId}")
    public IssueStateChangeResponse stateChange(@PathVariable Long issueId, @RequestBody IssueStateChangeRequest stateChangeRequest) {
        log.info("Issue StateChange Request = {}", stateChangeRequest);

        issueCommandService.changeState(issueId, stateChangeRequest.getIsOpened());

        Issue afterIssue = issueQueryService.findIssueById(issueId);
        return IssueStateChangeResponse.create(afterIssue);
    }

    /**
     * 이슈 삭제
     */
    @DeleteMapping("/issue-tracker/api/issues/{issueId}")
    @ResponseStatus(HttpStatus.OK)
    public IssueDeleteResponse delete(@PathVariable @NotNull Long issueId) {
        log.info("Issue Delete Request - issueId = {}", issueId);
        boolean isDeleted = issueCommandService.deleteIssue(issueId);
        return new IssueDeleteResponse(isDeleted);
    }

    /**
     * 이슈 다중 상태 변경
     */
    @PatchMapping("/issue-tracker/api/issues")
    public MultipleIssueStateChangeResponse multipleStateChange(@RequestBody MultipleIssueStateChangeRequest multipleStateCahngeRequest) {
        log.info("Multiple Issue StateChange Request = {}", multipleStateCahngeRequest);
        issueCommandService.changeStates(multipleStateCahngeRequest.getIssueIds(), multipleStateCahngeRequest.getIsOpened());

        List<Issue> afterIssues = issueQueryService.findIssues(multipleStateCahngeRequest.getIssueIds());
        return MultipleIssueStateChangeResponse.create(afterIssues);
    }

}
