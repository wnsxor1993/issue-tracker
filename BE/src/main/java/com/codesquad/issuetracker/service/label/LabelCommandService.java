package com.codesquad.issuetracker.service.label;

import com.codesquad.issuetracker.domain.Label;
import com.codesquad.issuetracker.repository.label.LabelRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class LabelCommandService {

    private final LabelRepository labelRepository;

    public Long enrollLabel(Label label) {
        labelRepository.save(label);
        return label.getId();
    }
}
