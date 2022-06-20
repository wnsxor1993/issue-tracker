package com.codesquad.issuetracker.excption;

public class MilestoneNotFoundException extends BusinessException {

    public MilestoneNotFoundException(String message) {
        super(message);
    }
}
