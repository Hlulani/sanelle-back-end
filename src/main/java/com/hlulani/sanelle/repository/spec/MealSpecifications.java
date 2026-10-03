package com.hlulani.sanelle.repository.spec;

import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import org.springframework.data.jpa.domain.Specification;
import jakarta.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;

public class MealSpecifications {

    public static Specification<Meal> withFilters(String name, MealType type) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (name != null && !name.isEmpty()) {
                predicates.add(cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%"));
            }

            if (type != null) {
                predicates.add(cb.equal(root.get("mealType"), type));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }}