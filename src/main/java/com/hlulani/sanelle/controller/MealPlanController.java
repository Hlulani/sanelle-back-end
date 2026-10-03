package com.hlulani.sanelle.controller;

import com.hlulani.sanelle.service.MealPlanService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/meal-plans")
public class MealPlanController {

    private final MealPlanService mealPlanService;

    public MealPlanController(MealPlanService mealPlanService) {
        this.mealPlanService = mealPlanService;
    }

    @PostMapping("/generate")
    public MealPlanService.MealPlanResponse generate(
            @RequestBody MealPlanService.GenerateMealPlanRequest req
    ) {
        return mealPlanService.generate(req);
    }
}

