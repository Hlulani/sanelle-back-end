package com.hlulani.sanelle.repository;

import com.hlulani.sanelle.domain.entity.CustomChallenge;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface CustomChallengeRepository extends JpaRepository<CustomChallenge, UUID> {
    Optional<CustomChallenge> findByInviteCode(String inviteCode);
    boolean existsByInviteCode(String inviteCode);

    List<CustomChallenge> findByCreatedByUserId(UUID userId);

    // Challenges the user created OR has joined (via challenge_participants,
    // matching on challenge_id = custom_challenges.id::text).
    // Native SQL: Spring Data's HQL grammar doesn't support the POSIX regex operator (~)
    // used to guard against non-UUID challenge_id values (the built-in challenges' string ids).
    @Query(value = """
        SELECT c.* FROM custom_challenges c
        WHERE c.created_by_user_id = :userId
           OR c.id IN (
               SELECT cp.challenge_id::uuid FROM challenge_participants cp
               WHERE cp.user_id = :userId
                 AND cp.challenge_id ~ '^[0-9a-fA-F-]{36}$'
           )
        ORDER BY c.created_at DESC
        """, nativeQuery = true)
    List<CustomChallenge> findMineOrJoined(@Param("userId") UUID userId);
}
