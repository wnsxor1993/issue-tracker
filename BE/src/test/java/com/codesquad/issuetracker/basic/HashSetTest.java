package com.codesquad.issuetracker.basic;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.HashSet;

import static org.assertj.core.api.Assertions.assertThat;

public class HashSetTest {

    private final HashSet<String> hashSet = new HashSet<>();

    @BeforeEach
    void init() {
        hashSet.clear();
    }

    @Test
    @DisplayName("동등한 객체를 같은 HashSet에 삽입하면 먼저 삽입된 객체만 삽입된다.")
    public void duplicateAddTest() {
        String strA = new String("aaa");
        String strB = new String("aaa");

        hashSet.add(strA);
        hashSet.add(strB);
        String firstElement = hashSet.stream().findFirst().get();

        assertThat(hashSet.size()).isEqualTo(1);
        assertThat(firstElement).isSameAs(strA);
    }
}
