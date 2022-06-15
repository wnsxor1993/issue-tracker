package com.codesquad.issuetracker.excption;

public class InvalidColorCodeException extends BusinessException {

    public InvalidColorCodeException(String message) {
        super(message);
    }
}
