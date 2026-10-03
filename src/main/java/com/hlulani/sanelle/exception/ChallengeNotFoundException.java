package com.hlulani.sanelle.exception;

public class ChallengeNotFoundException extends RuntimeException {
    public ChallengeNotFoundException(String identifier) {
        super("Challenge not found: " + identifier);
    }
}
