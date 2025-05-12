package com.mbc.pet.user;


public class PasswordValidator {

    // 영문자 + 숫자 조합, 8자 이상
    private static final String PASSWORD_PATTERN = "^(?=.*[a-zA-Z])(?=.*\\d).{8,}$";

    public static boolean isValid(String password) {
        if (password == null) return false;
        return password.matches(PASSWORD_PATTERN);
    }
}