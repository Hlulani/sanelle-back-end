package com.hlulani.sanelle.mail;

/** Sends the emails an account needs. {@code link} is ready to click; {@code name} is how to greet the person. */
public interface AccountMailer {

    void sendVerification(String email, String name, String link);

    void sendPasswordReset(String email, String name, String link);
}
