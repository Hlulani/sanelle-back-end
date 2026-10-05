package com.hlulani.sanelle.service;

import com.hlulani.sanelle.api.dto.request.CreateMealRequest;
import com.hlulani.sanelle.api.dto.response.MealResponse;
import com.hlulani.sanelle.domain.entity.MealType;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

public interface MealService {
    MealResponse createWithImage(CreateMealRequest request, MultipartFile image);

    List<MealResponse> findAll();
    MealResponse findById(UUID id);

    List<MealResponse> searchMeals(String name, MealType type);
}
