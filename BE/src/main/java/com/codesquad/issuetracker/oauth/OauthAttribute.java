package com.codesquad.issuetracker.oauth;

import com.codesquad.issuetracker.excption.OauthProviderNotFoundException;

import java.util.Arrays;
import java.util.Map;

public enum OauthAttribute {

    GITHUB("github") {
        @Override
        public MemberProfileDto of(Map<String, Object> attributes) {
            return MemberProfileDto.builder()
                    .resourceServerId(String.valueOf(attributes.get("id")))
                    .resourceServerLoginId((String) attributes.get("login"))
                    .name((String) attributes.get("name"))
                    .imageUrl((String) attributes.get("avatar_url"))
                    .build();
        }
    };

    private final String providerName;

    OauthAttribute(String providerName) {
        this.providerName = providerName;
    }

    public static MemberProfileDto extract(String providerName, Map<String, Object> attributes) {
        return Arrays.stream(values())
                .filter(provider -> providerName.equals(provider.providerName))
                .findFirst()
                .orElseThrow(() -> new OauthProviderNotFoundException(
                        "요청에 대응하는 OauthProvider가 존재하지 않습니다."))
                .of(attributes);
    }

    public abstract MemberProfileDto of(Map<String, Object> attributes);
}
