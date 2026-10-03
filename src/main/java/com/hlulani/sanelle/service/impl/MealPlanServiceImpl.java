package com.hlulani.sanelle.service.impl;

import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import com.hlulani.sanelle.repository.MealRepository;
import com.hlulani.sanelle.repository.spec.MealPlanSpecifications;
import com.hlulani.sanelle.service.MealPlanService;
import org.springframework.data.jpa.domain.Specification;
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
            "cream", "ghee", "whey", "honey"
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
        int days = switch (req.duration()) {
            case "DAYS_7" -> 7;
            case "DAYS_14" -> 14;
            case "DAYS_30" -> 30;
            default -> 7;
        };

        Integer minAnti = req.fibroidFocus() ? 4 : null;
        Integer minIron = req.ironSupport() ? 4 : null;
        Integer minFiber = req.fiberFocus() ? 4 : null;

        // 1) Load ALL meals (fallback pool)
        List<Meal> allMeals = mealRepository.findAll();

        // 2) Load score-FILTERED meals (preferred pool, DB-level)
        Specification<Meal> spec = MealPlanSpecifications.withMinimumScores(minAnti, minIron, minFiber);
        List<Meal> scoreFilteredMeals = mealRepository.findAll(spec);

        // 3) Narrow further by protein preference (keyword-derived, done in Java since it's not a DB column)
        List<Meal> filteredMeals = scoreFilteredMeals.stream()
                .filter(m -> matchesProteinPreference(m, req.proteinPreference()))
                .toList();

        // If filters are too strict for EVERYTHING, fallback to all
        if (filteredMeals.isEmpty()) {
            filteredMeals = allMeals;
        }

        // Build maps by type
        Map<MealType, List<Meal>> allByType = groupByType(allMeals);
        Map<MealType, List<Meal>> filteredByType = groupByType(filteredMeals);

        List<MealType> typesPerDay = switch (req.fastingStyle()) {
            case "NO_FASTING_3_MEALS" -> List.of(MealType.BREAKFAST, MealType.LUNCH, MealType.DINNER);
            case "FASTING_16_8", "FASTING_18_6" -> List.of(MealType.LUNCH, MealType.DINNER);
            default -> List.of(MealType.BREAKFAST, MealType.LUNCH, MealType.DINNER);
        };

        List<DayPlan> daysPlan = new ArrayList<>();
        LocalDate start = LocalDate.now();

        for (int i = 0; i < days; i++) {
            LocalDate date = start.plusDays(i);

            List<PlannedMeal> plannedMeals = new ArrayList<>();
            for (MealType t : typesPerDay) {

                // ✅ Prefer filtered pool, but fallback to all meals of that type
                List<Meal> preferred = filteredByType.getOrDefault(t, List.of());
                List<Meal> fallback = allByType.getOrDefault(t, List.of());

                Meal picked = pickRandom(!preferred.isEmpty() ? preferred : fallback);

                if (picked != null) {
                    plannedMeals.add(new PlannedMeal(
                            t,
                            picked.getId(),
                            picked.getName(),
                            picked.getImageUrl(),
                            picked.getTags().stream().sorted().toList(),
                            picked.getAntiInflammatoryScore(),
                            picked.getIronSupport(),
                            picked.getFiberScore()
                    ));
                }
            }

            daysPlan.add(new DayPlan(date, plannedMeals));
        }

        return new MealPlanResponse(days, daysPlan);
    }

    private Map<MealType, List<Meal>> groupByType(List<Meal> meals) {
        Map<MealType, List<Meal>> byType = new EnumMap<>(MealType.class);
        for (MealType t : MealType.values()) byType.put(t, new ArrayList<>());
        for (Meal m : meals) byType.get(m.getMealType()).add(m);
        return byType;
    }


    private Meal pickRandom(List<Meal> list) {
        if (list == null || list.isEmpty()) return null;
        return list.get(random.nextInt(list.size()));
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
