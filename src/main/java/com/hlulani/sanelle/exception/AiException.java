package com.hlulani.sanelle.exception;

/** AI drafting is switched off, busy, or returned something unusable. The app falls back to its own rules. */
public class AiException extends ApiException {

    private AiException(Kind kind, ErrorCode code, String message) {
        super(kind, code, message);
    }

    public static AiException unavailable() {
        return new AiException(Kind.UNAVAILABLE, ErrorCode.AI_UNAVAILABLE, "AI drafting isn't switched on.");
    }

    public static AiException rateLimited() {
        return new AiException(Kind.TOO_MANY_REQUESTS, ErrorCode.AI_RATE_LIMITED,
                "That's a lot of drafts in a short time. Try again in a little while.");
    }

    public static AiException failed() {
        return new AiException(Kind.UNAVAILABLE, ErrorCode.AI_FAILED,
                "The AI draft couldn't be made just now. Sanelle's own suggestions are still shown.");
    }
}
