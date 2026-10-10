package com.hlulani.sanelle.exception;

public class ChallengeNotFoundException extends ApiException {
    public ChallengeNotFoundException(String identifier) {
        super(Kind.NOT_FOUND, ErrorCode.CHALLENGE_NOT_FOUND, "Challenge not found: " + identifier);
    }
}
