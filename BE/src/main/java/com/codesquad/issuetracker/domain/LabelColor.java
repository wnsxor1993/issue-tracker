package com.codesquad.issuetracker.domain;

import com.codesquad.issuetracker.excption.InvalidColorCodeException;
import com.codesquad.issuetracker.excption.InvalidColorValueRangeException;
import lombok.AccessLevel;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Embeddable
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@EqualsAndHashCode
public class LabelColor {

    private static final int COLOR_RADIX = 16;
    private static final int MIN_COLOR_VALUE = 0x000000;
    private static final int MAX_COLOR_VALUE = 0xffffff;
    private static final String COLOR_CODE_FORMAT = "%06x";

    /**
     * 16진수 색상 코드값을 숫자로 변환한 것
     */
    private int colorValue;

    private LabelColor(int colorValue) {
        this.colorValue = colorValue;
    }

    /**
     * 생성을 팩토리 메서드를 통해서만 하도록 함
     */
    public static LabelColor create(String colorCode) {
        int colorValue = parseToColorValue(colorCode);
        validateColorValueRange(colorValue);
        return new LabelColor(colorValue);
    }

    /**
     * 색상 코드값을 실제 정수값으로 변환하고, 파싱이 되지 않는 경우 비즈니스 로직으로 변환해서 throw
     */
    private static int parseToColorValue(String colorCode) {
        try {
            int colorValue = Integer.parseInt(colorCode, COLOR_RADIX);
            return colorValue;
        } catch (NumberFormatException nfe) {
            throw new InvalidColorCodeException("형식에 맞지 않는 색상코드입니다.");
        }
    }

    /**
     * 색상코드를 16진수로 변환한 값이 범위를 벗어날 경우 예외를 throw
     */
    private static void validateColorValueRange(int colorValue) {
        if (!isValidColorValueRange(colorValue)) {
            throw new InvalidColorValueRangeException("색상코드 16진수값이 유효하지 않습니다.");
        }
    }

    /**
     * 색상값(colorValue)의 범위가 유효한지 여부를 반환
     */
    private static boolean isValidColorValueRange(int colorValue) {
        return MIN_COLOR_VALUE <= colorValue && colorValue <= MAX_COLOR_VALUE;
    }

    /**
     * 색상 Hex 코드값
     */
    public String getColorCode() {
        return String.format(COLOR_CODE_FORMAT, colorValue);
    }

}
