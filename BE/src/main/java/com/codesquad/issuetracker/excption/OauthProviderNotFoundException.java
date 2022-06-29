package com.codesquad.issuetracker.excption;

public class OauthProviderNotFoundException extends BusinessException {

    public OauthProviderNotFoundException(String message) {
        super(message);
    }
}
