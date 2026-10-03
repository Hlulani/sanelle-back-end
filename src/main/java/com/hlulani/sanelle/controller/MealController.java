package com.hlulani.sanelle.controller;

import com.hlulani.sanelle.api.dto.request.CreateMealRequest;
import com.hlulani.sanelle.api.dto.response.MealResponse;
import com.hlulani.sanelle.domain.entity.MealType;
import com.hlulani.sanelle.service.MealService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/meals")
public class MealController {

    private final MealService mealService;

    public MealController(MealService mealService) {
        this.mealService = mealService;
    }


    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @ResponseStatus(HttpStatus.CREATED)
    public MealResponse create(
            @RequestPart("meal") @Valid CreateMealRequest request,
            @RequestPart(value = "image", required = false) MultipartFile image
    ) {
        return mealService.createWithImage(request, image);
    }


    @GetMapping("/{id}")
    public MealResponse getById(@PathVariable UUID id) {
        return mealService.findById(id);
    }

    @GetMapping
    public List<MealResponse> list() {
        return mealService.findAll();
    }

    @GetMapping("/search")
    public List<MealResponse> search(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) MealType type
    ) {
        return mealService.searchMeals(name, type);
    }
}
