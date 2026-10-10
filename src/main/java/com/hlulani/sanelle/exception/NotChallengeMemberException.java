package com.hlulani.sanelle.exception;

public class NotChallengeMemberException extends ApiException {
    public NotChallengeMemberException() {
        super(Kind.FORBIDDEN, ErrorCode.NOT_CHALLENGE_MEMBER, "Only members can see this challenge's members");
    }
}
