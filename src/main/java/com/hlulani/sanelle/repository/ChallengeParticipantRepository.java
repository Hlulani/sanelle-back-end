package com.hlulani.sanelle.repository;

import com.hlulani.sanelle.domain.entity.ChallengeParticipant;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ChallengeParticipantRepository extends JpaRepository<ChallengeParticipant, UUID> {

    Optional<ChallengeParticipant> findByUserIdAndChallengeId(UUID userId, String challengeId);

    void deleteByUserIdAndChallengeId(UUID userId, String challengeId);

    long countByChallengeId(String challengeId);

    List<ChallengeParticipant> findByChallengeId(String challengeId);

    void deleteByChallengeId(String challengeId);
}
