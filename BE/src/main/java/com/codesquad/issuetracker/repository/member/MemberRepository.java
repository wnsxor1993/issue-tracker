package com.codesquad.issuetracker.repository.member;

import com.codesquad.issuetracker.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long>, MemberCustomRepository {

    Optional<Member> findMemberByResourceServerId(String resourceServerId);

}
