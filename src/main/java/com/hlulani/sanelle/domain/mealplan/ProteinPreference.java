package com.hlulani.sanelle.domain.mealplan;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Optional;
import java.util.Set;

/** How someone eats. Each choice knows which meals it allows and how to say so truthfully. */
public enum ProteinPreference {
    ANY(EnumSet.allOf(DietClass.class), null),
    /** Older plans may still send MEATY; the app no longer offers it. */
    MEATY(EnumSet.of(DietClass.MEAT, DietClass.FISH), "Includes meat or fish, as you chose"),
    PESCATARIAN(EnumSet.of(DietClass.FISH, DietClass.VEGETARIAN, DietClass.VEGAN), "No meat, as you chose"),
    VEGETARIAN(EnumSet.of(DietClass.VEGETARIAN, DietClass.VEGAN), "Vegetarian, as you chose"),
    VEGAN(EnumSet.of(DietClass.VEGAN), "Vegan, as you chose");

    private final Set<DietClass> allowed;
    private final String reason;

    ProteinPreference(Set<DietClass> allowed, String reason) {
        this.allowed = allowed;
        this.reason = reason;
    }

    /** Missing or unrecognised values mean no preference, so nothing is filtered out by mistake. */
    public static ProteinPreference from(String value) {
        if (value == null) return ANY;
        try {
            return valueOf(value.trim().toUpperCase(Locale.ROOT));
        } catch (IllegalArgumentException e) {
            return ANY;
        }
    }

    public boolean allows(DietClass dietClass) {
        return allowed.contains(dietClass);
    }

    /** The "why this meal" line for this choice; empty when there's nothing to say. */
    public Optional<String> reason() {
        return Optional.ofNullable(reason);
    }
}
