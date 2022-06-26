package com.codesquad.issuetracker.basic;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class StringTest {

    @Test
    @DisplayName("따로 생성된 String들의 주솟값은 다르다.")
    public void notSameTest() {
        String strA = new String("aaa");
        String strB = new String("aaa");

        assertThat(strA).isNotSameAs(strB);
    }

    @Test
    @DisplayName("같은 문자열인 String 객체는 동등하다.")
    public void equalsTest() {
        String strA = new String("aaa");
        String strB = new String("aaa");

        assertThat(strA).isEqualTo(strB);
    }
}
