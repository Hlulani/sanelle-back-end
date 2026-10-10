package com.hlulani.sanelle.exception;

/** A name, email, password or terms answer that breaks the account rules; the code says which. */
public class InvalidAccountDetailsException extends ApiException {
    public InvalidAccountDetailsException(ErrorCode code, String message) {
        super(Kind.BAD_REQUEST, code, message);
    }
}
