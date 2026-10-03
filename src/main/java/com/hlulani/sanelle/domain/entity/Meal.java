package com.hlulani.sanelle.domain.entity;

import com.hlulani.sanelle.domain.valueobject.Ingredient;
import jakarta.persistence.*;

import java.time.OffsetDateTime;
import java.util.*;

@Entity
@Table(name = "meals")
public class Meal {

    // --------------------
    // Identifiers
    // --------------------

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    // --------------------
    // Core fields
    // --------------------

    @Column(nullable = false)
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private MealType mealType;

    @Column(name = "image_url")
    private String imageUrl;

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Column(name = "why_it_helps", columnDefinition = "TEXT")
    private String whyItHelps;

    @Column(name = "vegetable_substitutes", columnDefinition = "TEXT")
    private String vegetableSubstitutes;

    @Column(name = "fresh_or_frozen", columnDefinition = "TEXT")
    private String freshOrFrozen;

    @Column(name = "color_palette", columnDefinition = "TEXT")
    private String colorPalette;

    @Column(name = "prep_time_minutes")
    private Integer prepTimeMinutes;

    public String getWhyItHelps() {
        return whyItHelps;
    }

    public void setWhyItHelps(String whyItHelps) {
        this.whyItHelps = whyItHelps;
    }

    public String getVegetableSubstitutes() {
        return vegetableSubstitutes;
    }

    public void setVegetableSubstitutes(String vegetableSubstitutes) {
        this.vegetableSubstitutes = vegetableSubstitutes;
    }

    public String getFreshOrFrozen() {
        return freshOrFrozen;
    }

    public void setFreshOrFrozen(String freshOrFrozen) {
        this.freshOrFrozen = freshOrFrozen;
    }

    public String getColorPalette() {
        return colorPalette;
    }

    public void setColorPalette(String colorPalette) {
        this.colorPalette = colorPalette;
    }

    public Integer getPrepTimeMinutes() {
        return prepTimeMinutes;
    }

    public void setPrepTimeMinutes(Integer prepTimeMinutes) {
        this.prepTimeMinutes = prepTimeMinutes;
    }

    // --------------------
    // Collections
    // --------------------

    @ElementCollection
    @CollectionTable(
            name = "meal_tags",
            joinColumns = @JoinColumn(name = "meal_id")
    )
    @Column(name = "tag", nullable = false)
    private Set<String> tags = new HashSet<>();

    @ElementCollection
    @CollectionTable(
            name = "meal_ingredients",
            joinColumns = @JoinColumn(name = "meal_id")
    )
    @AttributeOverrides({
            @AttributeOverride(name = "name", column = @Column(name = "name", nullable = false)),
            @AttributeOverride(name = "amount", column = @Column(name = "amount"))
    })
    private Set<Ingredient> ingredients = new HashSet<>();

    @ElementCollection
    @CollectionTable(
            name = "meal_instructions",
            joinColumns = @JoinColumn(name = "meal_id")
    )
    @OrderColumn(name = "step_order")
    @Column(name = "instruction", nullable = false)
    private List<String> instructions = new ArrayList<>();

    @ElementCollection
    @CollectionTable(
            name = "meal_dietary_tags",
            joinColumns = @JoinColumn(name = "meal_id")
    )
    @Column(name = "dietary_tag", nullable = false)
    private Set<String> dietaryTags = new HashSet<>();

    // --------------------
    // Audit
    // --------------------

    @Column(nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    // --------------------
    // Constructors
    // --------------------

    protected Meal() {
        // for JPA
    }

    public Meal(
            String name,
            MealType mealType,
            List<String> tags
    ) {
        this.name = name;
        this.mealType = mealType;
        if (tags != null) {
            this.tags.addAll(tags);
        }
    }

    // --------------------
    // Lifecycle hooks
    // --------------------

    @PrePersist
    void onCreate() {
        this.createdAt = OffsetDateTime.now();
    }

    // --------------------
    // Getters
    // --------------------

    public UUID getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public MealType getMealType() {
        return mealType;
    }

    public Set<String> getTags() {
        return tags;
    }

    public Set<Ingredient> getIngredients() {
        return ingredients;
    }

    public List<String> getInstructions() {
        return instructions;
    }

    public Set<String> getDietaryTags() {
        return dietaryTags;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }
}
