package com.hlulani.sanelle.repository.spec;

import com.hlulani.sanelle.domain.entity.Meal;
import org.springframework.data.jpa.domain.Specification;

public class MealPlanSpecifications {

    private MealPlanSpecifications() {}

    public static Specification<Meal> withMinimumScores(Integer minAntiInflammatory, Integer minIronSupport, Integer minFiber) {
        return (root, query, cb) -> {
            var predicates = cb.conjunction();

            if (minAntiInflammatory != null) {
                predicates = cb.and(predicates, cb.greaterThanOrEqualTo(root.get("antiInflammatoryScore"), minAntiInflammatory));
            }

            if (minIronSupport != null) {
                predicates = cb.and(predicates, cb.greaterThanOrEqualTo(root.get("ironSupport"), minIronSupport));
            }

            if (minFiber != null) {
                predicates = cb.and(predicates, cb.greaterThanOrEqualTo(root.get("fiberScore"), minFiber));
            }

            return predicates;
        };
    }
}
