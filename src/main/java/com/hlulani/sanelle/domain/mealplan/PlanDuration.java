package com.hlulani.sanelle.domain.mealplan;

public enum PlanDuration {
    DAYS_7(7), DAYS_14(14), DAYS_30(30);

    private final int days;

    PlanDuration(int days) {
        this.days = days;
    }

    public int days() {
        return days;
    }

    /** Anything unrecognised plans one week. */
    public static PlanDuration from(String value) {
        for (PlanDuration d : values()) {
            if (d.name().equals(value)) return d;
        }
        return DAYS_7;
    }
}
