    package com.codesquad.issuetracker.oauth;

import com.codesquad.issuetracker.domain.Member;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class MemberProfileDto {

    private final String resourceServerId;
    private final String resourceServerLoginId;
    private final String name;
    private final String imageUrl;

    @Builder
    public MemberProfileDto(String resourceServerId, String resourceServerLoginId, String name, String imageUrl) {
        this.resourceServerId = resourceServerId;
        this.resourceServerLoginId = resourceServerLoginId;
        this.name = name;
        this.imageUrl = imageUrl;
    }

    public Member toEntity() {
        return Member.builder()
                .resourceServerId(resourceServerId)
                .resourceServerLoginId(resourceServerLoginId)
                .name(name)
                .imageUrl(imageUrl)
                .build();
    }
}
