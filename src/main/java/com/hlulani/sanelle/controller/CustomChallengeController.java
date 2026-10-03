package com.hlulani.sanelle.controller;

import com.hlulani.sanelle.api.dto.request.CreateCustomChallengeRequest;
import com.hlulani.sanelle.api.dto.request.JoinByCodeRequest;
import com.hlulani.sanelle.api.dto.response.ChallengeMemberResponse;
import com.hlulani.sanelle.api.dto.response.CustomChallengeResponse;
import com.hlulani.sanelle.domain.entity.CustomChallenge;
import com.hlulani.sanelle.domain.entity.User;
import com.hlulani.sanelle.exception.ChallengeNotFoundException;
import com.hlulani.sanelle.repository.CustomChallengeRepository;
import com.hlulani.sanelle.repository.UserRepository;
import com.hlulani.sanelle.service.CustomChallengeService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/custom-challenges")
public class CustomChallengeController {

    private final CustomChallengeService service;
    private final CustomChallengeRepository customChallengeRepository;
    private final UserRepository userRepository;

    public CustomChallengeController(CustomChallengeService service,
                                      CustomChallengeRepository customChallengeRepository,
                                      UserRepository userRepository) {
        this.service = service;
        this.customChallengeRepository = customChallengeRepository;
        this.userRepository = userRepository;
    }

    @PostMapping
    public ResponseEntity<CustomChallengeResponse> create(@Valid @RequestBody CreateCustomChallengeRequest req,
                                                            @AuthenticationPrincipal UserDetails principal) {
        UUID userId = resolveUserId(principal);
        CustomChallenge challenge = service.create(userId, req.name(), req.description(), req.type(), req.targetCount(), req.durationDays());
        return ResponseEntity.status(201).body(toResponse(challenge, userId));
    }

    @PostMapping("/join")
    public ResponseEntity<CustomChallengeResponse> join(@Valid @RequestBody JoinByCodeRequest req,
                                                          @AuthenticationPrincipal UserDetails principal) {
        UUID userId = resolveUserId(principal);
        CustomChallenge challenge = service.joinByCode(userId, req.inviteCode());
        return ResponseEntity.ok(toResponse(challenge, userId));
    }

    @GetMapping("/mine")
    public ResponseEntity<List<CustomChallengeResponse>> mine(@AuthenticationPrincipal UserDetails principal) {
        UUID userId = resolveUserId(principal);
        List<CustomChallengeResponse> body = service.mineOrJoined(userId).stream()
                .map(c -> toResponse(c, userId))
                .toList();
        return ResponseEntity.ok(body);
    }

    @GetMapping("/{id}/members")
    public ResponseEntity<List<ChallengeMemberResponse>> members(@PathVariable UUID id,
                                                                   @AuthenticationPrincipal UserDetails principal) {
        UUID userId = resolveUserId(principal);
        CustomChallenge challenge = customChallengeRepository.findById(id).orElseThrow(() -> new ChallengeNotFoundException(id.toString()));
        if (!service.isMember(userId, challenge)) {
            return ResponseEntity.status(403).build();
        }
        List<ChallengeMemberResponse> body = service.getMembers(challenge).stream()
                .map(m -> new ChallengeMemberResponse(m.userId(), m.username(), m.joinedAt()))
                .toList();
        return ResponseEntity.ok(body);
    }

    private CustomChallengeResponse toResponse(CustomChallenge challenge, UUID requestingUserId) {
        String creatorUsername = userRepository.findById(challenge.getCreatedByUserId())
                .map(User::getUsername)
                .orElse(null);
        return new CustomChallengeResponse(
                challenge.getId(),
                challenge.getName(),
                challenge.getDescription(),
                challenge.getType(),
                challenge.getTargetCount(),
                challenge.getDurationDays(),
                challenge.getInviteCode(),
                challenge.getCreatedByUserId(),
                creatorUsername,
                challenge.getCreatedAt(),
                challenge.getCreatedByUserId().equals(requestingUserId)
        );
    }

    private UUID resolveUserId(UserDetails principal) {
        User user = userRepository.findByEmail(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("Authenticated but user missing in DB"));
        return user.getId();
    }
}
