package com.hlulani.sanelle.domain.mealplan;

import com.hlulani.sanelle.domain.entity.MealType;

import java.util.List;

/** The meal schedule someone chose. A preference, not a health recommendation. */
public enum FastingStyle {
    NO_FASTING_3_MEALS(List.of(MealType.BREAKFAST, MealType.LUNCH, MealType.DINNER)),
    FASTING_16_8(List.of(MealType.LUNCH, MealType.DINNER)),
    FASTING_18_6(List.of(MealType.LUNCH, MealType.DINNER));

    private final List<MealType> mealTypes;

    FastingStyle(List<MealType> mealTypes) {
        this.mealTypes = mealTypes;
    }

    public List<MealType> mealTypes() {
        return mealTypes;
    }

    /** Anything unrecognised plans three meals a day. */
    public static FastingStyle from(String value) {
        for (FastingStyle s : values()) {
            if (s.name().equals(value)) return s;
        }
        return NO_FASTING_3_MEALS;
    }
}
