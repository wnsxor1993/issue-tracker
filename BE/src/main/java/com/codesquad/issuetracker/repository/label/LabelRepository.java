package com.codesquad.issuetracker.repository.label;

import com.codesquad.issuetracker.domain.Label;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LabelRepository extends JpaRepository<Label, Long>, LabelCustomRepository {

}
