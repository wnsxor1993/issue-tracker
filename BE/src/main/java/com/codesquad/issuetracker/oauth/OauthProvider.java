package com.codesquad.issuetracker.oauth;

import lombok.Builder;
import lombok.Getter;

@Getter
public class OauthProvider {

    private final String clientId;
    private final String clientSecret;
    private final String redirectUrl;
    private final String loginUrl;
    private final String tokenUrl;
    private final String userInfoUrl;

    public OauthProvider(OauthProperties.User user, OauthProperties.Provider provider) {
        this(user.getClientId(), user.getClientSecret(), user.getRedirectUrl(), user.getLoginUrl(), provider.getTokenUrl(), provider.getUserUrl());
    }

    @Builder
    public OauthProvider(String clientId, String clientSecret, String redirectUrl, String loginUrl, String tokenUrl, String userInfoUrl) {
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.redirectUrl = redirectUrl;
        this.loginUrl = loginUrl;
        this.tokenUrl = tokenUrl;
        this.userInfoUrl = userInfoUrl;
    }
}
