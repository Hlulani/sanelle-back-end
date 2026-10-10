package com.hlulani.sanelle.security;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class AccountRolesTest {

    @Test
    void listedAddressesAreEvidenceEditorsWhateverTheirCaseOrSpacing() {
        AccountRoles roles = new AccountRoles(" Editor@Example.com ,second@example.com,");

        assertThat(roles.of("editor@example.com")).containsExactly(AccountRoles.EVIDENCE_EDITOR);
        assertThat(roles.of("SECOND@example.com ")).containsExactly(AccountRoles.EVIDENCE_EDITOR);
    }

    @Test
    void everyoneElseHasNoRoles() {
        AccountRoles roles = new AccountRoles("editor@example.com");

        assertThat(roles.of("reader@example.com")).isEmpty();
        assertThat(roles.of(null)).isEmpty();
    }

    @Test
    void anEmptySettingMeansNoEditors() {
        assertThat(new AccountRoles("").of("editor@example.com")).isEmpty();
        assertThat(new AccountRoles(null).of("")).isEmpty();
    }
}
