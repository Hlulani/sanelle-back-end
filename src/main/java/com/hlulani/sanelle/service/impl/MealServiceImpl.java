package com.hlulani.sanelle.service.impl;

import com.hlulani.sanelle.api.dto.request.CreateMealRequest;
import com.hlulani.sanelle.api.dto.response.MealResponse;
import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import com.hlulani.sanelle.exception.MealNotFoundException;
import com.hlulani.sanelle.mapper.MealMapper;
import com.hlulani.sanelle.repository.MealRepository;
import com.hlulani.sanelle.repository.spec.MealSpecifications;
import com.hlulani.sanelle.service.ImageStorage;
import com.hlulani.sanelle.service.MealService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class MealServiceImpl implements MealService {

    private final MealRepository mealRepository;
    private final ImageStorage imageStorage;

    public MealServiceImpl(MealRepository mealRepository, ImageStorage imageStorage) {
        this.mealRepository = mealRepository;
        this.imageStorage = imageStorage;
    }

    @Override
    @Transactional(readOnly = true)
    public List<MealResponse> findAll() {
        return toResponses(mealRepository.findAll());
    }

    @Override
    @Transactional(readOnly = true)
    public MealResponse findById(UUID id) {
        return mealRepository.findById(id)
                .map(MealMapper::toResponse)
                .orElseThrow(() -> new MealNotFoundException(id));
    }

    @Override
    public MealResponse createWithImage(CreateMealRequest request, MultipartFile image) {
        Meal meal = MealMapper.toEntity(request);
        if (image != null && !image.isEmpty()) {
            meal.setImageUrl(imageStorage.save(image));
        }
        return MealMapper.toResponse(mealRepository.save(meal));
    }

    @Override
    @Transactional(readOnly = true)
    public List<MealResponse> searchMeals(String name, MealType type) {
        return toResponses(mealRepository.findAll(MealSpecifications.withFilters(name, type)));
    }

    private static List<MealResponse> toResponses(List<Meal> meals) {
        return meals.stream().map(MealMapper::toResponse).toList();
    }
}
