package com.codesquad.issuetracker.repository.issue;

import com.codesquad.issuetracker.domain.Issue;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IssueRepository extends JpaRepository<Issue, Long>, IssueCustomRepository {

}
