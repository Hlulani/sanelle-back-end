package com.hlulani.sanelle.controller;

import com.hlulani.sanelle.api.dto.request.CreateCustomChallengeRequest;
import com.hlulani.sanelle.api.dto.request.JoinByCodeRequest;
import com.hlulani.sanelle.api.dto.response.ChallengeMemberResponse;
import com.hlulani.sanelle.api.dto.response.CustomChallengeResponse;
import com.hlulani.sanelle.security.AuthenticatedUser;
import com.hlulani.sanelle.service.CustomChallengeService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/custom-challenges")
public class CustomChallengeController {

    private final CustomChallengeService service;

    public CustomChallengeController(CustomChallengeService service) {
        this.service = service;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public CustomChallengeResponse create(@Valid @RequestBody CreateCustomChallengeRequest req,
                                          @AuthenticationPrincipal AuthenticatedUser user) {
        return service.create(user.getUserId(), req.name(), req.description(), req.type(), req.targetCount(), req.durationDays());
    }

    @PostMapping("/join")
    public CustomChallengeResponse join(@Valid @RequestBody JoinByCodeRequest req,
                                        @AuthenticationPrincipal AuthenticatedUser user) {
        return service.joinByCode(user.getUserId(), req.inviteCode());
    }

    @GetMapping("/mine")
    public List<CustomChallengeResponse> mine(@AuthenticationPrincipal AuthenticatedUser user) {
        return service.mineOrJoined(user.getUserId());
    }

    @GetMapping("/{id}/members")
    public List<ChallengeMemberResponse> members(@PathVariable UUID id, @AuthenticationPrincipal AuthenticatedUser user) {
        return service.members(user.getUserId(), id);
    }
}
