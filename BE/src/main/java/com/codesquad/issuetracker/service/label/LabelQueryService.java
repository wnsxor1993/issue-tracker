package com.codesquad.issuetracker.service.label;

import com.codesquad.issuetracker.domain.Label;
import com.codesquad.issuetracker.repository.label.LabelRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Slf4j
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class LabelQueryService {

    private final LabelRepository labelRepository;

    public List<Label> findAllById(List<Long> labelIds) {
        return labelRepository.findAllById(labelIds);
    }
}
