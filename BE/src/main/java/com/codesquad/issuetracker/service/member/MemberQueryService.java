package com.codesquad.issuetracker.service.member;

import com.codesquad.issuetracker.domain.Member;
import com.codesquad.issuetracker.excption.MemberNotFoundException;
import com.codesquad.issuetracker.repository.member.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Slf4j
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class MemberQueryService {

    private final MemberRepository memberRepository;

    public Member findMemberById(Long memberId) {
        return memberRepository.findById(memberId)
                .orElseThrow(() -> new MemberNotFoundException("일치하는 식별자의 회원이 존재하지 않습니다."));
    }

    public List<Member> findAllById(List<Long> memberIds) {
        return memberRepository.findAllById(memberIds);
    }
}
