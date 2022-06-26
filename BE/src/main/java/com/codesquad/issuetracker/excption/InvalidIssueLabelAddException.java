package com.codesquad.issuetracker.excption;

/**
 * 이슈에 IssueLabel를 할당할 때 다른 Issue에 할당된 IssueLabel를 추가할 때 발생하는 예외
 */
public class InvalidIssueLabelAddException extends BusinessException {

    public InvalidIssueLabelAddException(String message) {
        super(message);
    }
}
