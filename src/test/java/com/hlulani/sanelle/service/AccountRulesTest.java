package com.hlulani.sanelle.service;

import com.hlulani.sanelle.exception.ErrorCode;
import com.hlulani.sanelle.exception.InvalidAccountDetailsException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.NullAndEmptySource;
import org.junit.jupiter.params.provider.ValueSource;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class AccountRulesTest {

    private static void assertFailsWith(Runnable check, ErrorCode code) {
        assertThatThrownBy(check::run)
                .isInstanceOf(InvalidAccountDetailsException.class)
                .satisfies(e -> assertThat(((InvalidAccountDetailsException) e).code()).isEqualTo(code))
                .hasMessageNotContaining("null");
    }

    @Test
    void aNameIsTrimmed() {
        assertThat(AccountRules.name("  Thandi  ")).isEqualTo("Thandi");
    }

    @ParameterizedTest
    @NullAndEmptySource
    @ValueSource(strings = {"   ", "\t"})
    void aMissingNameIsNameRequired(String name) {
        assertFailsWith(() -> AccountRules.name(name), ErrorCode.NAME_REQUIRED);
    }

    @Test
    void aNameOver80CharactersIsTooLong() {
        assertThat(AccountRules.name("a".repeat(80))).hasSize(80);
        assertFailsWith(() -> AccountRules.name("a".repeat(81)), ErrorCode.NAME_TOO_LONG);
    }

    @Test
    void anEmailIsTrimmedAndLowerCased() {
        assertThat(AccountRules.email("  Thandi@Example.COM ")).isEqualTo("thandi@example.com");
    }

    @ParameterizedTest
    @NullAndEmptySource
    @ValueSource(strings = {"thandi", "thandi@", "@example.com", "thandi@example", "tha ndi@example.com"})
    void anImplausibleEmailIsInvalid(String email) {
        assertFailsWith(() -> AccountRules.email(email), ErrorCode.EMAIL_INVALID);
    }

    @Test
    void aPasswordMustBe8To128Characters() {
        assertFailsWith(() -> AccountRules.password(null), ErrorCode.PASSWORD_TOO_SHORT);
        assertFailsWith(() -> AccountRules.password("1234567"), ErrorCode.PASSWORD_TOO_SHORT);
        assertThatCode(() -> AccountRules.password("12345678")).doesNotThrowAnyException();
        assertThatCode(() -> AccountRules.password("x".repeat(128))).doesNotThrowAnyException();
        assertFailsWith(() -> AccountRules.password("x".repeat(129)), ErrorCode.PASSWORD_TOO_LONG);
    }

    @Test
    void theTermsMustBeAccepted() {
        assertFailsWith(() -> AccountRules.termsAccepted(null), ErrorCode.TERMS_REQUIRED);
        assertFailsWith(() -> AccountRules.termsAccepted(false), ErrorCode.TERMS_REQUIRED);
        assertThatCode(() -> AccountRules.termsAccepted(true)).doesNotThrowAnyException();
    }
}
