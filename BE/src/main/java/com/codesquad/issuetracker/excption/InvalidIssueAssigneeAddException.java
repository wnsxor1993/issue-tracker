package com.codesquad.issuetracker.excption;

/**
 * 이슈에 IssueAssignee를 할당할 때 다른 Issue에 할당된 IssueAssignee를 추가할 때 발생하는 예외
 */
public class InvalidIssueAssigneeAddException extends BusinessException {

    public InvalidIssueAssigneeAddException(String message) {
        super(message);
    }
}
