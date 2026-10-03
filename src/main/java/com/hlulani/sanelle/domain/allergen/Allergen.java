package com.hlulani.sanelle.domain.allergen;

import java.util.List;
import java.util.Locale;
import java.util.regex.Pattern;

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

    MILK("Milk",
            List.of("milk", "buttermilk", "cream", "butter", "cheese", "yogurt", "yoghurt", "kefir", "whey", "casein",
                    "ghee", "feta", "parmesan", "mozzarella", "burrata", "brie", "cheddar", "ricotta",
                    "paneer", "halloumi", "mascarpone", "labneh", "skyr", "quark"),
            List.of("coconut milk", "coconut cream", "almond milk", "oat milk", "plant milk", "soy milk",
                    "soya milk", "rice milk", "cashew milk", "peanut butter", "almond butter", "nut butter",
                    "cashew butter", "cocoa butter", "cacao butter", "cream of tartar"),
            List.of("dark chocolate", "chocolate", "granola", "sausage", "deli ham")),

    EGG("Egg",
            List.of("egg", "eggs", "mayonnaise", "mayo", "meringue", "aioli"),
            List.of("eggplant"),
            List.of("fresh pasta", "egg noodle", "egg noodles")),

    PEANUT("Peanut",
            List.of("peanut", "peanuts", "groundnut"),
            List.of(),
            List.of("mixed nuts", "trail mix", "granola", "dark chocolate", "chocolate")),

    TREE_NUT("Tree nuts",
            List.of("almond", "almonds", "walnut", "walnuts", "pecan", "pecans", "pistachio", "pistachios",
                    "cashew", "cashews", "hazelnut", "hazelnuts", "macadamia", "brazil nut", "mixed nuts",
                    "nut butter", "praline", "marzipan", "frangipane"),
            List.of("nutmeg", "butternut", "coconut", "water chestnut", "pine nut"),
            List.of("granola", "dark chocolate", "chocolate", "plant milk", "energy ball", "trail mix", "pesto")),

    SOY("Soy",
            List.of("soy", "soya", "tofu", "tempeh", "edamame", "miso", "tamari"),
            List.of(),
            List.of("plant milk", "dark chocolate", "chocolate", "sausage", "granola", "deli ham")),

    GLUTEN("Gluten (wheat, barley, rye, oats)",
            List.of("wheat", "bread", "pasta", "couscous", "farro", "flour", "tortilla", "wrap", "barley", "rye",
                    "spelt", "semolina", "bulgur", "seitan", "soba", "soy sauce", "noodles", "cracker", "crackers"),
            List.of("buckwheat flour", "rice flour", "almond flour", "coconut flour", "chickpea flour",
                    "zucchini noodles", "rice noodles", "lettuce wrap", "everything bagel seasoning"),
            List.of("oats", "oat", "rolled oats", "granola", "stock", "broth", "sausage", "tamari",
                    "plant milk", "curry powder", "seasoning", "deli ham", "brown rice cakes")),

    FISH("Fish",
            List.of("fish", "salmon", "tuna", "cod", "halibut", "mackerel", "sardine", "sardines", "trout",
                    "anchovy", "anchovies", "haddock", "tilapia", "sea bass", "fish sauce"),
            List.of(),
            List.of("worcestershire", "caesar dressing")),

    SHELLFISH("Shellfish (crustaceans and molluscs)",
            List.of("shrimp", "prawn", "prawns", "crab", "lobster", "crayfish", "mussel", "mussels", "clam",
                    "clams", "oyster", "oysters", "scallop", "scallops", "squid", "octopus"),
            List.of(),
            List.of("fish sauce", "seafood stock")),

    SESAME("Sesame",
            List.of("sesame", "tahini", "hummus", "everything bagel seasoning"),
            List.of(),
            List.of("whole grain bread", "wholegrain bread", "sourdough bread", "granola", "seasoning")),

    MUSTARD("Mustard",
            List.of("mustard"),
            List.of(),
            List.of("curry powder", "mayonnaise", "sausage", "deli ham", "dressing", "seasoning")),

    CELERY("Celery",
            List.of("celery", "celeriac"),
            List.of(),
            List.of("stock", "broth", "curry powder", "sausage", "seasoning", "deli ham"));

    public enum Presence { CONTAINS, MAY_CONTAIN, NONE }

    private final String label;
    private final List<Pattern> contains;
    private final List<String> notThis;
    private final List<Pattern> mayContain;

    Allergen(String label, List<String> contains, List<String> notThis, List<String> mayContain) {
        this.label = label;
        this.contains = contains.stream().map(Allergen::word).toList();
        this.notThis = notThis;
        this.mayContain = mayContain.stream().map(Allergen::word).toList();
    }

    public String label() {
        return label;
    }

    /** How this allergen relates to one ingredient name. */
    public Presence in(String ingredientName) {
        if (ingredientName == null || ingredientName.isBlank()) return Presence.MAY_CONTAIN;
        String stripped = ingredientName.toLowerCase(Locale.ROOT);
        for (String lookAlike : notThis) {
            stripped = stripped.replace(lookAlike, " ");
        }
        final String text = stripped;
        if (contains.stream().anyMatch(p -> p.matcher(text).find())) return Presence.CONTAINS;
        String original = ingredientName.toLowerCase(Locale.ROOT);
        if (mayContain.stream().anyMatch(p -> p.matcher(original).find())) return Presence.MAY_CONTAIN;
        return Presence.NONE;
    }

    private static Pattern word(String w) {
        return Pattern.compile("\\b" + Pattern.quote(w) + "\\b");
    }
}
