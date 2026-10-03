package com.hlulani.sanelle.domain.entity;

import jakarta.persistence.*;

import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "challenge_participants")
public class ChallengeParticipant {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "challenge_id", nullable = false, length = 64)
    private String challengeId;

    @Column(name = "joined_at", nullable = false)
    private OffsetDateTime joinedAt;

    protected ChallengeParticipant() {
        // JPA
    }

    public ChallengeParticipant(UUID userId, String challengeId) {
        this.userId = userId;
        this.challengeId = challengeId;
        this.joinedAt = OffsetDateTime.now();
    }

    public UUID getId() {
        return id;
    }

    public UUID getUserId() {
        return userId;
    }

    public String getChallengeId() {
        return challengeId;
    }

    public OffsetDateTime getJoinedAt() {
        return joinedAt;
    }

    public void refreshJoinedAt() {
        this.joinedAt = OffsetDateTime.now();
    }
}
