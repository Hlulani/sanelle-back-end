package com.hlulani.sanelle.domain.entity;

import jakarta.persistence.*;
import java.time.Instant;
import java.util.UUID;
import jakarta.persistence.PrePersist;


@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(nullable = false, updatable = false)
    private UUID id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false, unique = true)
    private String username;

    // Inside User.java
    @Column(name = "password", nullable = false) // Changed from password_hash to password
    private String passwordHash;

    @Column(nullable = false)
    private Instant createdAt;

    @Column(name = "display_name", length = 80)
    private String displayName;

    /** When the address was confirmed from an emailed link; null until then. */
    @Column(name = "email_verified_at")
    private Instant emailVerifiedAt;

    @Column(name = "terms_accepted_at")
    private Instant termsAcceptedAt;

    protected User() {
        // JPA
    }

    public User(String email, String username, String passwordHash) {
        this.email = email;
        this.username = username;
        this.passwordHash = passwordHash;
    }

    /** A new sign-up: named, terms accepted now, address not yet confirmed. */
    public User(String email, String username, String passwordHash, String displayName, Instant termsAcceptedAt) {
        this(email, username, passwordHash);
        this.displayName = displayName;
        this.termsAcceptedAt = termsAcceptedAt;
    }


    public UUID getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getUsername() {
        return username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public String getDisplayName() {
        return displayName;
    }

    /** What to call the person: the name they gave, or their username for accounts that never gave one. */
    public String getName() {
        return displayName != null && !displayName.isBlank() ? displayName : username;
    }

    public Instant getEmailVerifiedAt() {
        return emailVerifiedAt;
    }

    public boolean isEmailVerified() {
        return emailVerifiedAt != null;
    }

    public Instant getTermsAcceptedAt() {
        return termsAcceptedAt;
    }

    /** Records the first confirmation; later ones keep the original time. */
    public void markEmailVerified(Instant now) {
        if (emailVerifiedAt == null) {
            emailVerifiedAt = now;
        }
    }

    public void changePasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    @PrePersist
    void onCreate() {
        if (createdAt == null) {
            createdAt = Instant.now();
        }
    }

}
