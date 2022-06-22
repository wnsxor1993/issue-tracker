package com.codesquad.issuetracker.excption;

public class MemberNotFoundException extends BusinessException {

    public MemberNotFoundException(String message) {
        super(message);
    }
}
