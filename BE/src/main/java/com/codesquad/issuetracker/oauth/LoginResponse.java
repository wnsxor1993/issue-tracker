package com.codesquad.issuetracker.oauth;

import lombok.Getter;

@Getter
public class LoginResponse {

    private final String jwtAccessToken;
    private final String jwtRefreshToken;

    public LoginResponse(String jwtAccessToken, String jwtRefreshToken) {
        this.jwtAccessToken = jwtAccessToken;
        this.jwtRefreshToken = jwtRefreshToken;
    }
}
