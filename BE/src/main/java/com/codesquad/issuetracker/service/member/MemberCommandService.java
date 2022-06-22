package com.codesquad.issuetracker.service.member;

import com.codesquad.issuetracker.domain.Member;
import com.codesquad.issuetracker.repository.member.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class MemberCommandService {

    private final MemberRepository memberRepository;

    /**
     * OAuth, JWT 기능이 구현되기 전까지는 임시로, 어플리케이션 실행 직후 샘플회원을 생성하도록 한다.
     */
    @PostConstruct
    public void initMember() {
        Member sampleMember = new Member("testMember", "1234!", "테스트 유저");
        memberRepository.save(sampleMember);
    }
}
