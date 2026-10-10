package com.hlulani.sanelle.exception;

/** The password was right, but the address hasn't been confirmed from the emailed link yet. */
public class EmailNotVerifiedException extends ApiException {
    public EmailNotVerifiedException() {
        super(Kind.FORBIDDEN, ErrorCode.EMAIL_NOT_VERIFIED, "Confirm your email address before signing in");
    }
}
