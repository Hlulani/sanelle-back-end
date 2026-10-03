package com.hlulani.sanelle.domain.valueobject;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.util.Objects;

@Embeddable
public class Ingredient {

    @Column(name = "name", nullable = false)
    private String name;

    // DB column is nullable (your table shows amount can be null)
    @Column(name = "amount")
    private String amount;

    protected Ingredient() {
        // JPA only
    }

    public Ingredient(String name, String amount) {
        this.name = Objects.requireNonNull(name, "name must not be null");
        this.amount = amount;
    }

    public String getName() {
        return name;
    }

    public String getAmount() {
        return amount;
    }

    // Recommended for embeddables used in collections
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Ingredient that)) return false;
        return Objects.equals(name, that.name)
                && Objects.equals(amount, that.amount);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, amount);
    }

    @Override
    public String toString() {
        return "Ingredient{name='%s', amount='%s'}".formatted(name, amount);
    }
}
