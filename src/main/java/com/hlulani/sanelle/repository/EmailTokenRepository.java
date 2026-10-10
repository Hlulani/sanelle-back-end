package com.hlulani.sanelle.repository;

import com.hlulani.sanelle.domain.entity.EmailToken;
import com.hlulani.sanelle.domain.entity.EmailTokenPurpose;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

public interface EmailTokenRepository extends JpaRepository<EmailToken, UUID> {

    Optional<EmailToken> findByTokenHash(String tokenHash);

    /** Retires every link of this kind the account still holds, so only the newest one works. */
    @Modifying(flushAutomatically = true, clearAutomatically = true)
    @Query("UPDATE EmailToken t SET t.usedAt = :now "
            + "WHERE t.userId = :userId AND t.purpose = :purpose AND t.usedAt IS NULL")
    int retireUnused(@Param("userId") UUID userId, @Param("purpose") EmailTokenPurpose purpose,
                     @Param("now") Instant now);
}
