package com.hlulani.sanelle.api.dto.response;

import com.hlulani.sanelle.domain.entity.User;

import java.util.UUID;

public record UserResponse(UUID id, String email, String username) {
    public static UserResponse from(User user) {
        return new UserResponse(user.getId(), user.getEmail(), user.getUsername());
    }
}
