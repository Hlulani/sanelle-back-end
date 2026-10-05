package com.hlulani.sanelle.exception;

public class NotChallengeMemberException extends ApiException {
    public NotChallengeMemberException() {
        super(Kind.FORBIDDEN, "Only members can see this challenge's members");
    }
}
