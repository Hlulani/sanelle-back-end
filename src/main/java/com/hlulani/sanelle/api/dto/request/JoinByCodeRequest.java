package com.hlulani.sanelle.api.dto.request;

import jakarta.validation.constraints.NotBlank;

public record JoinByCodeRequest(@NotBlank String inviteCode) {}
