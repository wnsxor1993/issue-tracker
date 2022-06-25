package com.codesquad.issuetracker.excption;

public class IssueNotFoundException extends BusinessException {

    public IssueNotFoundException(String message) {
        super(message);
    }
}
