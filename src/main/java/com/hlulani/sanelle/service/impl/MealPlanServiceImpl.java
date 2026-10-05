package com.hlulani.sanelle.service.impl;

import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import com.hlulani.sanelle.domain.mealplan.FastingStyle;
import com.hlulani.sanelle.domain.mealplan.MealCriteria;
import com.hlulani.sanelle.domain.mealplan.PlanDuration;
import com.hlulani.sanelle.repository.MealRepository;
import com.hlulani.sanelle.service.MealPlanService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.*;

@Service
@Transactional(readOnly = true)
public class MealPlanServiceImpl implements MealPlanService {

    private final MealRepository mealRepository;
    private final Random random = new Random();

    public MealPlanServiceImpl(MealRepository mealRepository) {
        this.mealRepository = mealRepository;
    }

    @Override
    public MealPlanResponse generate(GenerateMealPlanRequest req) {
        int days = PlanDuration.from(req.duration()).days();
        List<MealType> typesPerDay = FastingStyle.from(req.fastingStyle()).mealTypes();
        MealCriteria criteria = MealCriteria.of(req.proteinPreference(), req.maxPrepMinutes(), req.allergies(), req.dislikes());

        // Only meals that meet every preference. No fallback to meals that don't:
        // a slot stays empty rather than showing something the person ruled out.
        Map<MealType, List<Meal>> byType = groupByType(eligibleMeals(criteria));
        Map<MealType, Deque<Meal>> queues = new EnumMap<>(MealType.class);
        Set<String> unfilled = new LinkedHashSet<>();
        List<DayPlan> daysPlan = new ArrayList<>();
        LocalDate start = LocalDate.now();

        for (int i = 0; i < days; i++) {
            List<PlannedMeal> plannedMeals = new ArrayList<>();
            for (MealType type : typesPerDay) {
                Meal picked = nextFor(type, byType, queues);
                if (picked == null) {
                    unfilled.add(type.name());
                } else {
                    plannedMeals.add(toPlanned(picked, type, criteria));
                }
            }
            daysPlan.add(new DayPlan(start.plusDays(i), plannedMeals));
        }

        return new MealPlanResponse(days, daysPlan, List.copyOf(unfilled));
    }

    @Override
    public List<PlannedMeal> swapOptions(SwapOptionsRequest req) {
        MealCriteria criteria = MealCriteria.of(req.proteinPreference(), req.maxPrepMinutes(), req.allergies(), req.dislikes());
        return eligibleMeals(criteria).stream()
                .filter(m -> req.mealType() == null || m.getMealType() == req.mealType())
                .filter(m -> !m.getId().equals(req.currentMealId()))
                .sorted(Comparator.comparing(Meal::getName))
                .map(m -> toPlanned(m, m.getMealType(), criteria))
                .toList();
    }

    /** The one place every rule is applied, for plans and swaps alike. */
    private List<Meal> eligibleMeals(MealCriteria criteria) {
        return mealRepository.findAll().stream().filter(criteria::allows).toList();
    }

    private static PlannedMeal toPlanned(Meal meal, MealType slot, MealCriteria criteria) {
        return new PlannedMeal(slot, meal.getId(), meal.getName(), meal.getImageUrl(),
                meal.getTags().stream().sorted().toList(), meal.getPrepTimeMinutes(), criteria.reasonsFor(meal));
    }

    /**
     * Variety: each recipe of a type is used once, in a shuffled order, before any
     * recipe repeats.
     */
    private Meal nextFor(MealType type, Map<MealType, List<Meal>> byType, Map<MealType, Deque<Meal>> queues) {
        List<Meal> pool = byType.getOrDefault(type, List.of());
        if (pool.isEmpty()) return null;
        Deque<Meal> queue = queues.computeIfAbsent(type, k -> new ArrayDeque<>());
        if (queue.isEmpty()) {
            List<Meal> shuffled = new ArrayList<>(pool);
            Collections.shuffle(shuffled, random);
            queue.addAll(shuffled);
        }
        return queue.poll();
    }

    private static Map<MealType, List<Meal>> groupByType(List<Meal> meals) {
        Map<MealType, List<Meal>> byType = new EnumMap<>(MealType.class);
        for (MealType t : MealType.values()) byType.put(t, new ArrayList<>());
        for (Meal m : meals) byType.get(m.getMealType()).add(m);
        return byType;
    }
}
