package com.hlulani.sanelle.service.impl;

import com.hlulani.sanelle.api.dto.request.CreateMealRequest;
import com.hlulani.sanelle.api.dto.response.MealResponse;
import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import com.hlulani.sanelle.exception.NotFoundException;
import com.hlulani.sanelle.mapper.MealMapper;
import com.hlulani.sanelle.repository.MealRepository;
import com.hlulani.sanelle.repository.spec.MealSpecifications;
import com.hlulani.sanelle.service.MealService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class MealServiceImpl implements MealService {

    private final MealRepository mealRepository;

    public MealServiceImpl(MealRepository mealRepository) {
        this.mealRepository = mealRepository;
    }

    @Override
    public MealResponse create(CreateMealRequest request) {
        Meal meal = MealMapper.toEntity(request);
        Meal saved = mealRepository.save(meal);
        return MealMapper.toResponse(saved);
    }

    @Override
    @Transactional(readOnly = true)
    public List<MealResponse> findAll() {
        return mealRepository.findAll()
                .stream()
                .map(MealMapper::toResponse)
                .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public  MealResponse findById(UUID id) {
        Meal meal = mealRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Meal not found: " + id));
        return MealMapper.toResponse(meal);
    }

    @Override
    public MealResponse createWithImage(CreateMealRequest request, MultipartFile image) {
        Meal meal = MealMapper.toEntity(request);

        if (image != null && !image.isEmpty()) {
            String fileName = UUID.randomUUID() + "_" + image.getOriginalFilename();
            Path uploadPath = Paths.get("uploads");

            try {
                if (!Files.exists(uploadPath)) Files.createDirectories(uploadPath);
                Files.copy(image.getInputStream(), uploadPath.resolve(fileName));
                meal.setImageUrl("/uploads/" + fileName); // Store the path
            } catch (IOException e) {
                throw new RuntimeException("Could not save image", e);
            }
        }

        return MealMapper.toResponse(mealRepository.save(meal));
    }


    @Override
    @Transactional(readOnly = true)
    public List<MealResponse> searchMeals(String name, MealType type) {
        // Pass only the 3 parameters to the specification
        return mealRepository.findAll(MealSpecifications.withFilters(name, type))
                .stream()
                .map(MealMapper::toResponse)
                .toList();
    }
}
