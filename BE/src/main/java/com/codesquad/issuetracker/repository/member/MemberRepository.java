package com.codesquad.issuetracker.repository.member;

import com.codesquad.issuetracker.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, Long>, MemberCustomRepository {

}
