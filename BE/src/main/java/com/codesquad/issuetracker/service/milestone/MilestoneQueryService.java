package com.codesquad.issuetracker.service.milestone;

import com.codesquad.issuetracker.domain.Milestone;
import com.codesquad.issuetracker.excption.MilestoneNotFoundException;
import com.codesquad.issuetracker.repository.milestone.MilestoneRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class MilestoneQueryService {

    private final MilestoneRepository milestoneRepository;

    public Milestone findMilestoneById(Long milestoneId) {
        return (milestoneId == null)
                ? null
                : milestoneRepository.findById(milestoneId)
                .orElseThrow(() -> new MilestoneNotFoundException("일치하는 식별자의 마일스톤이 존재하지 않습니다."));
    }
}
