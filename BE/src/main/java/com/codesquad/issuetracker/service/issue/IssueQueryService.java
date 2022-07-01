package com.codesquad.issuetracker.service.issue;

import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.dto.IssueSearchCondition;
import com.codesquad.issuetracker.excption.IssueNotFoundException;
import com.codesquad.issuetracker.repository.issue.IssueRepository;
import com.codesquad.issuetracker.service.comment.CommentQueryService;
import com.codesquad.issuetracker.web.dto.comment.CommentListElement;
import com.codesquad.issuetracker.web.dto.issue.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class IssueQueryService {

    private final IssueRepository issueRepository;

    private final CommentQueryService commentQueryService;

    public Issue findIssueById(Long issueId) {
        return issueRepository.findById(issueId)
                .orElseThrow(() -> new IssueNotFoundException("일치하는 식별자의 이슈가 존재하지 않습니다."));
    }

    public List<Issue> findIssues(List<Long> issueIds) {
        return issueRepository.findAllById(issueIds);
    }

    public IssueDetailResponse findIssueDetail(Long issueId) {

        IssueDetailResponse issueDetailResponse = issueRepository.findIssueDetail(issueId)
                .orElseThrow(() -> new IssueNotFoundException("일치하는 식별자의 이슈가 존재하지 않습니다."));

        List<IssueAssigneeDto> assigneeDtos = issueRepository.findIssueAssigneeDtosByIssueId(issueId);
        List<IssueLabelDto> issueLabelDtos = issueRepository.findIssueLabelDtosByIssueId(issueId);
        List<CommentListElement> commentDtos = commentQueryService.findCommentDtosByIssueId(issueId);

        issueDetailResponse.getAssignees().addAll(assigneeDtos);
        issueDetailResponse.getLabels().addAll(issueLabelDtos);
        issueDetailResponse.getComments().addAll(commentDtos);

        return issueDetailResponse;
    }

    public Issue findByIdWithAuthorAndMilestone(Long issueId) {
        return issueRepository.findByIdWithAuthorAndMilestone(issueId)
                .orElseThrow(() -> new IssueNotFoundException("일치하는 식별자의 이슈를 찾을 수 없습니다."));
    }

    public IssueListResponse searchIssueList(IssueSearchCondition issueSearchCondition) {
        List<IssueListElement> issueListElements = issueRepository.searchIssueList(issueSearchCondition);

        //TODO : 가져온 issue들 id List 추출

        //TODO : in절 쿼리로 issue들에 해당하는 LabelList를 Map<Long, List<IssueLabel>> 꼴로 가져오기

        //TODO : 맵핑에 맞춰서 각 이슈들에게 List<IssueLabal> 주입

        /**
         * 왜 이런 식으로 가져아야할까?
         *  - 한번에 issue들을 땡겨올 때
         *  - 1:다에 해당하는 이슈라벨들도 땡겨오면 행의 개수가 늘어나고 페이징을 할 수 없게 된다.
         *  - 따라서 다:일에 해당하는 것들까지 한번 가져오고(행의 갯수 안 늘어남) 제 각각에 대해서 일대다를 다시 조회해서 맵핑해야한다.
         *  - 물론 이는 N+1 쿼리가 발생하므로 batch_fetch_size를 조절해서 갖고와야함.
         *
         */

        return new IssueListResponse(issueListElements);
    }
}
