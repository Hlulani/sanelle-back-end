package com.hlulani.sanelle.domain.allergen;

import com.hlulani.sanelle.domain.food.Terms;

import java.util.List;
import java.util.Locale;

/**
 * Allergens a person can list, based on the allergens EU and UK food labels must
 * declare (sulphites and lupin are left out: no recipe here uses them).
 *
 * Each allergen has three word lists, matched against the full ingredient name
 * in lower case, including any "(or ...)" alternative:
 *  - contains:   names that mean the allergen is in it ("feta" -> milk)
 *  - notThis:    look-alikes removed before matching ("coconut milk" is not milk)
 *  - mayContain: composite ingredients that often hide it ("chicken stock" -> celery)
 *
 * This supports leaving meals out. It does not make any meal allergy-safe.
 */
public enum Allergen {

    MILK(
            List.of("milk", "buttermilk", "cream", "butter", "cheese", "yogurt", "yoghurt", "kefir", "whey", "casein",
                    "ghee", "feta", "parmesan", "mozzarella", "burrata", "brie", "cheddar", "ricotta",
                    "paneer", "halloumi", "mascarpone", "labneh", "skyr", "quark", "gouda", "camembert"),
            List.of("coconut milk", "coconut cream", "almond milk", "oat milk", "plant milk", "soy milk",
                    "soya milk", "rice milk", "cashew milk", "peanut butter", "almond butter", "nut butter",
                    "cashew butter", "hazelnut butter", "walnut butter", "sunflower seed butter",
                    "cocoa butter", "cacao butter", "cream of tartar"),
            List.of("dark chocolate", "chocolate", "granola", "sausage", "deli ham")),

    EGG(
            List.of("egg", "eggs", "mayonnaise", "mayo", "meringue", "aioli"),
            List.of("eggplant"),
            List.of("fresh pasta", "egg noodle", "egg noodles")),

    PEANUT(
            List.of("peanut", "peanuts", "groundnut"),
            List.of(),
            List.of("mixed nuts", "trail mix", "granola", "dark chocolate", "chocolate")),

    TREE_NUT(
            List.of("almond", "almonds", "walnut", "walnuts", "pecan", "pecans", "pistachio", "pistachios",
                    "cashew", "cashews", "hazelnut", "hazelnuts", "macadamia", "brazil nut", "mixed nuts",
                    "nut butter", "praline", "marzipan", "frangipane"),
            List.of("nutmeg", "butternut", "coconut", "water chestnut", "pine nut"),
            List.of("granola", "dark chocolate", "chocolate", "plant milk", "energy ball", "trail mix", "pesto")),

    SOY(
            List.of("soy", "soya", "tofu", "tempeh", "edamame", "miso", "tamari"),
            List.of(),
            List.of("plant milk", "dark chocolate", "chocolate", "sausage", "granola", "deli ham")),

    GLUTEN(
            List.of("wheat", "bread", "pasta", "couscous", "farro", "flour", "tortilla", "wrap", "barley", "rye",
                    "spelt", "semolina", "bulgur", "seitan", "soba", "soy sauce", "noodles", "cracker", "crackers"),
            List.of("buckwheat flour", "rice flour", "almond flour", "coconut flour", "chickpea flour",
                    "zucchini noodles", "rice noodles", "lettuce wrap", "everything bagel seasoning"),
            List.of("oats", "oat", "rolled oats", "granola", "stock", "broth", "sausage", "tamari",
                    "plant milk", "curry powder", "seasoning", "deli ham", "brown rice cakes")),

    FISH(
            List.of("fish", "salmon", "tuna", "cod", "halibut", "mackerel", "sardine", "sardines", "trout",
                    "anchovy", "anchovies", "haddock", "tilapia", "sea bass", "fish sauce"),
            List.of(),
            List.of("worcestershire", "caesar dressing")),

    SHELLFISH(
            List.of("shrimp", "prawn", "prawns", "crab", "lobster", "crayfish", "mussel", "mussels", "clam",
                    "clams", "oyster", "oysters", "scallop", "scallops", "squid", "octopus"),
            List.of(),
            List.of("fish sauce", "seafood stock")),

    SESAME(
            List.of("sesame", "tahini", "hummus", "everything bagel seasoning"),
            List.of(),
            List.of("whole grain bread", "wholegrain bread", "sourdough bread", "granola", "seasoning")),

    MUSTARD(
            List.of("mustard"),
            List.of(),
            List.of("curry powder", "mayonnaise", "sausage", "deli ham", "dressing", "seasoning")),

    CELERY(
            List.of("celery", "celeriac"),
            List.of(),
            List.of("stock", "broth", "curry powder", "sausage", "seasoning", "deli ham"));

    public enum Presence { CONTAINS, MAY_CONTAIN, NONE }

    private final Terms contains;
    private final List<String> notThis;
    private final Terms mayContain;

    Allergen(List<String> contains, List<String> notThis, List<String> mayContain) {
        this.contains = Terms.of(contains);
        this.notThis = notThis;
        this.mayContain = Terms.of(mayContain);
    }

    /** How this allergen relates to one ingredient name. */
    public Presence in(String ingredientName) {
        if (ingredientName == null || ingredientName.isBlank()) return Presence.MAY_CONTAIN;
        String stripped = ingredientName.toLowerCase(Locale.ROOT);
        for (String lookAlike : notThis) {
            stripped = stripped.replace(lookAlike, " ");
        }
        if (contains.foundIn(stripped)) return Presence.CONTAINS;
        if (mayContain.foundIn(ingredientName)) return Presence.MAY_CONTAIN;
        return Presence.NONE;
    }

    /** True only when the ingredient name itself names this allergen; "may contain" doesn't count. */
    public boolean isNamedIn(String ingredientName) {
        return in(ingredientName) == Presence.CONTAINS;
    }
}
