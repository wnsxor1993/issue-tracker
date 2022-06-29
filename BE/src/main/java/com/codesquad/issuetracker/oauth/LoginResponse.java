package com.codesquad.issuetracker.oauth;

import lombok.Getter;

@Getter
public class LoginResponse {

    private boolean loginSuccess;

    public LoginResponse(boolean loginSuccess) {
        this.loginSuccess = loginSuccess;
    }
}
