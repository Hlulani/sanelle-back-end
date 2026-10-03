package com.hlulani.sanelle.service.impl;

import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import com.hlulani.sanelle.repository.MealRepository;
import com.hlulani.sanelle.service.MealPlanService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.*;

@Service
@Transactional(readOnly = true)
public class MealPlanServiceImpl implements MealPlanService {

    enum ProteinClass { MEATY, VEGETARIAN, VEGAN }

    private static final Set<String> MEAT_KEYWORDS = Set.of(
            "chicken", "beef", "turkey", "pork", "ham", "bacon", "sausage", "lamb", "duck",
            "salmon", "tuna", "shrimp", "cod", "halibut", "mackerel", "sardine", "trout",
            "anchovy", "crab", "lobster"
    );

    private static final Set<String> DAIRY_EGG_HONEY_KEYWORDS = Set.of(
            "egg", "milk", "cheese", "feta", "mozzarella", "parmesan", "yogurt", "yoghurt",
            "cream", "ghee", "whey", "honey", "burrata", "brie", "cheddar", "ricotta",
            "halloumi", "paneer", "kefir", "mascarpone", "labneh", "skyr", "quark",
            "gouda", "camembert", "casein", "mayonnaise", "mayo"
    );

    // "butter" alone is dairy, but nut/seed butters (peanut butter, almond butter, tahini) are plant-based
    private static final Set<String> PLANT_BASED_BUTTER_KEYWORDS = Set.of(
            "peanut butter", "almond butter", "cashew butter", "hazelnut butter",
            "walnut butter", "sunflower seed butter", "tahini"
    );

    private final MealRepository mealRepository;
    private final Random random = new Random();

    public MealPlanServiceImpl(MealRepository mealRepository) {
        this.mealRepository = mealRepository;
    }

    @Override
    public MealPlanResponse generate(GenerateMealPlanRequest req) {
        int days = switch (req.duration() == null ? "" : req.duration()) {
            case "DAYS_14" -> 14;
            case "DAYS_30" -> 30;
            default -> 7;
        };

        List<MealType> typesPerDay = switch (req.fastingStyle() == null ? "" : req.fastingStyle()) {
            case "FASTING_16_8", "FASTING_18_6" -> List.of(MealType.LUNCH, MealType.DINNER);
            default -> List.of(MealType.BREAKFAST, MealType.LUNCH, MealType.DINNER);
        };

        Integer maxPrep = req.maxPrepMinutes() != null && req.maxPrepMinutes() > 0 ? req.maxPrepMinutes() : null;

        // Only meals that meet every preference. No fallback to meals that don't:
        // a slot stays empty rather than showing something the person ruled out.
        List<Meal> eligible = mealRepository.findAll().stream()
                .filter(m -> matchesProteinPreference(m, req.proteinPreference()))
                .filter(m -> maxPrep == null || (m.getPrepTimeMinutes() != null && m.getPrepTimeMinutes() <= maxPrep))
                .toList();
        Map<MealType, List<Meal>> byType = groupByType(eligible);

        Map<MealType, Deque<Meal>> queues = new EnumMap<>(MealType.class);
        Set<String> unfilled = new LinkedHashSet<>();
        List<DayPlan> daysPlan = new ArrayList<>();
        LocalDate start = LocalDate.now();

        for (int i = 0; i < days; i++) {
            List<PlannedMeal> plannedMeals = new ArrayList<>();
            for (MealType t : typesPerDay) {
                Meal picked = nextFor(t, byType, queues);
                if (picked == null) {
                    unfilled.add(t.name());
                    continue;
                }
                plannedMeals.add(new PlannedMeal(
                        t,
                        picked.getId(),
                        picked.getName(),
                        picked.getImageUrl(),
                        picked.getTags().stream().sorted().toList(),
                        picked.getPrepTimeMinutes(),
                        reasonsFor(picked, req.proteinPreference(), maxPrep)
                ));
            }
            daysPlan.add(new DayPlan(start.plusDays(i), plannedMeals));
        }

        return new MealPlanResponse(days, daysPlan, List.copyOf(unfilled));
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

    /** Only the person's own criteria. No health claims. */
    List<String> reasonsFor(Meal meal, String proteinPreference, Integer maxPrep) {
        List<String> reasons = new ArrayList<>();
        switch (proteinPreference == null ? "ANY" : proteinPreference) {
            case "VEGAN" -> reasons.add("Vegan, as you chose");
            case "VEGETARIAN" -> reasons.add("Vegetarian, as you chose");
            case "MEATY" -> reasons.add("Includes meat or fish, as you chose");
            default -> { }
        }
        if (maxPrep != null && meal.getPrepTimeMinutes() != null) {
            reasons.add("Ready in " + meal.getPrepTimeMinutes() + " min (your limit is " + maxPrep + ")");
        } else if (meal.getPrepTimeMinutes() != null) {
            reasons.add("Ready in " + meal.getPrepTimeMinutes() + " min");
        }
        return reasons;
    }

    private Map<MealType, List<Meal>> groupByType(List<Meal> meals) {
        Map<MealType, List<Meal>> byType = new EnumMap<>(MealType.class);
        for (MealType t : MealType.values()) byType.put(t, new ArrayList<>());
        for (Meal m : meals) byType.get(m.getMealType()).add(m);
        return byType;
    }

    boolean matchesProteinPreference(Meal meal, String proteinPreference) {
        if (proteinPreference == null) {
            return true;
        }
        ProteinClass proteinClass = classifyProtein(meal);
        return switch (proteinPreference) {
            case "MEATY" -> proteinClass == ProteinClass.MEATY;
            case "VEGETARIAN" -> proteinClass != ProteinClass.MEATY;
            case "VEGAN" -> proteinClass == ProteinClass.VEGAN;
            default -> true; // "ANY" or unrecognized value: no filtering
        };
    }

    ProteinClass classifyProtein(Meal meal) {
        boolean meaty = meal.getIngredients().stream()
                .anyMatch(i -> containsAnyKeyword(i.getName(), MEAT_KEYWORDS));
        if (meaty) {
            return ProteinClass.MEATY;
        }

        boolean taggedVegan = meal.getTags().stream().anyMatch("vegan"::equalsIgnoreCase);
        boolean noDairyEggHoney = meal.getIngredients().stream()
                .noneMatch(i -> isDairyEggOrHoney(i.getName()));

        return (taggedVegan || noDairyEggHoney) ? ProteinClass.VEGAN : ProteinClass.VEGETARIAN;
    }

    private static boolean isDairyEggOrHoney(String ingredientName) {
        String lower = ingredientName.toLowerCase(Locale.ROOT);
        if (lower.contains("butter") && PLANT_BASED_BUTTER_KEYWORDS.stream().noneMatch(lower::contains)) {
            return true;
        }
        return containsAnyKeyword(ingredientName, DAIRY_EGG_HONEY_KEYWORDS);
    }

    private static boolean containsAnyKeyword(String ingredientName, Set<String> keywords) {
        String lower = ingredientName.toLowerCase(Locale.ROOT);
        for (String keyword : keywords) {
            if (lower.contains(keyword)) {
                return true;
            }
        }
        return false;
    }
}
