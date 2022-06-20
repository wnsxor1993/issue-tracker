package com.codesquad.issuetracker.repository.milestone;

import com.codesquad.issuetracker.domain.Milestone;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MilestoneRepository extends JpaRepository<Milestone, Long>, MilestoneCustomRepository {

}
