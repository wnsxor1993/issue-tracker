package com.codesquad.issuetracker.service.issue;

import com.codesquad.issuetracker.domain.Issue;
import com.codesquad.issuetracker.excption.IssueNotFoundException;
import com.codesquad.issuetracker.repository.issue.IssueRepository;
import com.codesquad.issuetracker.web.dto.issue.IssueDetailResponse;
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

    public List<Issue> findIssues(List<Long> issueIds) {
        return issueRepository.findAllById(issueIds);
    }

    public boolean checkIssueExistence(Long issueId) {
        return issueRepository.existsById(issueId);
    }

    public IssueDetailResponse findDetailIssue(Long issueId) {
        return issueRepository.findIssueDetail(issueId)
                .orElseThrow(()-> new IssueNotFoundException("일치하는 식별자의 이슈를 찾을 수 없습니다."));
    }
}
