package com.hlulani.sanelle.domain.allergen;

import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.valueobject.Ingredient;

import java.util.*;
import java.util.regex.Pattern;

/**
 * A person's allergies and dislikes, kept separate:
 *  - allergies are strict: a meal is left out if any ingredient contains or may
 *    contain the allergen, or if the meal has no ingredient list to check.
 *  - dislikes leave out meals that name the food; "may contain" doesn't apply.
 * Dietary patterns (vegan etc.) are handled separately by the plan service.
 */
public record FoodRestrictions(Set<Allergen> allergies, List<String> dislikes) {

    public FoodRestrictions {
        allergies = allergies == null ? Set.of() : Set.copyOf(allergies);
        dislikes = dislikes == null ? List.of()
                : dislikes.stream().filter(Objects::nonNull).map(String::trim).filter(s -> !s.isEmpty())
                        .map(s -> s.toLowerCase(Locale.ROOT)).distinct().toList();
    }

    public static FoodRestrictions none() {
        return new FoodRestrictions(Set.of(), List.of());
    }

    /**
     * Parses allergen codes from a request. Unknown codes are rejected rather than
     * ignored, so a typo can never silently switch an exclusion off.
     */
    public static FoodRestrictions parse(List<String> allergyCodes, List<String> dislikes) {
        Set<Allergen> parsed = EnumSet.noneOf(Allergen.class);
        if (allergyCodes != null) {
            for (String code : allergyCodes) {
                try {
                    parsed.add(Allergen.valueOf(code.trim().toUpperCase(Locale.ROOT)));
                } catch (IllegalArgumentException | NullPointerException e) {
                    throw new UnknownAllergenException(code);
                }
            }
        }
        return new FoodRestrictions(parsed, dislikes);
    }

    public boolean allows(Meal meal) {
        Collection<Ingredient> ingredients = meal.getIngredients();
        if (!allergies.isEmpty() && (ingredients == null || ingredients.isEmpty())) {
            return false; // nothing to check against, so it can't be offered to someone with allergies
        }
        for (Ingredient i : ingredients) {
            for (Allergen a : allergies) {
                if (a.in(i.getName()) != Allergen.Presence.NONE) return false;
            }
            for (String d : dislikes) {
                if (mentions(i.getName(), d)) return false;
            }
        }
        return true;
    }

    /** Whole-word match that tolerates simple plurals ("mushroom" matches "mushrooms"). */
    static boolean mentions(String ingredientName, String food) {
        if (ingredientName == null) return false;
        String stem = food.endsWith("es") ? food.substring(0, food.length() - 2)
                : food.endsWith("s") ? food.substring(0, food.length() - 1) : food;
        Pattern p = Pattern.compile("\\b" + Pattern.quote(stem) + "(s|es)?\\b");
        return p.matcher(ingredientName.toLowerCase(Locale.ROOT)).find();
    }
}
