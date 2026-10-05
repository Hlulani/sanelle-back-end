package com.hlulani.sanelle.domain.food;

import java.util.List;
import java.util.Locale;
import java.util.regex.Pattern;

/**
 * A list of food words matched as whole words, case-insensitively, so "egg" matches
 * "boiled egg" but not "eggplant" or "veggies". The one word matcher behind allergens
 * and diets, so both read an ingredient name the same way.
 */
public final class Terms {

    private final List<Pattern> patterns;

    private Terms(List<String> words) {
        this.patterns = words.stream()
                .map(w -> Pattern.compile("\\b" + Pattern.quote(w.toLowerCase(Locale.ROOT)) + "\\b"))
                .toList();
    }

    public static Terms of(List<String> words) {
        return new Terms(words);
    }

    public static Terms of(String... words) {
        return new Terms(List.of(words));
    }

    public boolean foundIn(String text) {
        if (text == null) return false;
        String lower = text.toLowerCase(Locale.ROOT);
        return patterns.stream().anyMatch(p -> p.matcher(lower).find());
    }
}
