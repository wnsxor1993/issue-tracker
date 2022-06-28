package com.codesquad.issuetracker.service.member;

import com.codesquad.issuetracker.domain.Member;
import com.codesquad.issuetracker.oauth.MemberProfileDto;
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

    private final MemberQueryService memberQueryService;

    /**
     * OAuth, JWT 기능이 구현되기 전까지는 임시로, 어플리케이션 실행 직후 샘플회원을 생성하도록 한다.
     */
    @PostConstruct
    public void initMember() {
        Member sampleMember = new Member("tttt", "testMember", "테스트 유저", "https://avatars.githubusercontent.com/u/88282356?v=4)");
        saveMember(sampleMember);
    }

    public Long saveOrUpdate(MemberProfileDto memberProfileDto) {
        String resourceServerId = memberProfileDto.getResourceServerId();

        Member member = memberQueryService.findMemberByResourceServerIdNullAble(resourceServerId);

        if (member == null) {
            member = memberProfileDto.toEntity();
            saveMember(member);
            return member.getId();
        }
        updateMember(member, memberProfileDto);
        return member.getId();
    }

    public void saveMember(Member member) {
        memberRepository.save(member);
        log.info("save Member = {}", member);
    }

    private void updateMember(Member member, MemberProfileDto memberProfileDto) {
        member.updateMember(
                memberProfileDto.getResourceServerId(),
                memberProfileDto.getResourceServerLoginId(),
                memberProfileDto.getName(),
                memberProfileDto.getImageUrl()
        );
        log.info("updated Member = {}", member);
    }

}
