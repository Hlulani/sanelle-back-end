package com.hlulani.sanelle.domain.entity;

import jakarta.persistence.*;

import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "custom_challenges")
public class CustomChallenge {

    @Id
    private UUID id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(length = 280)
    private String description;

    @Column(nullable = false, length = 32)
    private String type; // "meals-in-period" | "days-in-period" | "streak" — validated at the DTO layer, not enforced by the DB

    @Column(name = "target_count", nullable = false)
    private int targetCount;

    @Column(name = "duration_days", nullable = false)
    private int durationDays;

    @Column(name = "invite_code", nullable = false, unique = true, length = 16)
    private String inviteCode;

    @Column(name = "created_by_user_id", nullable = false)
    private UUID createdByUserId;

    @Column(name = "created_at", nullable = false)
    private OffsetDateTime createdAt;

    protected CustomChallenge() {}

    public CustomChallenge(String name, String description, String type, int targetCount,
                            int durationDays, String inviteCode, UUID createdByUserId) {
        this.id = UUID.randomUUID();
        this.name = name;
        this.description = description;
        this.type = type;
        this.targetCount = targetCount;
        this.durationDays = durationDays;
        this.inviteCode = inviteCode;
        this.createdByUserId = createdByUserId;
        this.createdAt = OffsetDateTime.now();
    }

    public UUID getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public String getType() {
        return type;
    }

    public int getTargetCount() {
        return targetCount;
    }

    public int getDurationDays() {
        return durationDays;
    }

    public String getInviteCode() {
        return inviteCode;
    }

    public UUID getCreatedByUserId() {
        return createdByUserId;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    /** Custom challenges share the participants table with built-in ones, keyed by this id. */
    public String participationKey() {
        return id.toString();
    }

    public boolean isCreatedBy(UUID userId) {
        return createdByUserId.equals(userId);
    }
}
