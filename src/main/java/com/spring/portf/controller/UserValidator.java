package com.spring.portf.controller;

import com.spring.portf.domain.UserDto;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

public class UserValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return UserDto.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        UserDto userDto = (UserDto) target;
        String id = userDto.getId();
        String pwd = userDto.getPwd();
        String name = userDto.getName();
        String email = userDto.getEmail();
        Date birth = userDto.getBirth();

        String regexId = "^[a-z0-9]*$";
        String regexPwd = "^[a-zA-Z0-9]*$";
        String regexName = "^[가-힣a-zA-z]*$";
        String regexEmail = "^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*.[a-zA-Z]{2,3}$";
        String regexYear = "^(19|20)[0-9]{2}$";
        String regexDay = "^[0-3]?[0-9]{1}$";

        // 0. 공백 존재 여부 확인
        for (int i = 0; i < id.length(); i++) {
            if (id.contains(" ")) {
                errors.rejectValue("id", "GAP_ID");
                userDto.setId(id.trim());
                return;
            }
        }

        for (int i = 0; i < pwd.length(); i++) {
            if (pwd.contains(" ")) {
                errors.rejectValue("pwd", "GAP_PWD");
                userDto.setPwd(pwd.trim());
                return;
            }
        }

        for (int i = 0; i < name.length(); i++) {
            if (name.contains(" ")) {
                errors.rejectValue("name", "GAP_NAME");
                userDto.setName(name.trim());
                return;
            }
        }

        for (int i = 0; i < email.length(); i++) {
            if (email.contains(" ")) {
                errors.rejectValue("email", "GAP_EMAIL");
                userDto.setEmail(email.trim());
                return;
            }
        }

        // 1. 필드 null 또는 공백 검증
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "id", "EMPTY_ID");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pwd", "EMPTY_PWD");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "EMPTY_NAME");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "EMPTY_EMAIL");

        // 2. 필드 길이, 정규식 검증
        if (!Pattern.matches(regexId, id)) {
            errors.rejectValue("id", "REGEX_ERR");
            return;
        }

        if (id.length() < 4 || id.length() > 12) {
            errors.rejectValue("id", "LENGTH_ERR");
            return;
        }

        if (!Pattern.matches(regexPwd, pwd)) {
            errors.rejectValue("pwd", "REGEX_ERR");
            return;
        }

        if (pwd.length() < 4 || pwd.length() > 12) {
            errors.rejectValue("pwd", "LENGTH_ERR");
            return;
        }

        if (!Pattern.matches(regexName, name)) {
            errors.rejectValue("name", "REGEX_ERR");
            return;
        }

        if (name.length() < 2 || name.length() > 10) {
            errors.rejectValue("name", "LENGTH_ERR");
            return;
        }

        if (!Pattern.matches(regexEmail, email)) {
            errors.rejectValue("email", "REGEX_ERR");
            return;
        }

        if (email.length() < 5 || email.length() > 30) {
            errors.rejectValue("email", "LENGTH_ERR");
            return;
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String birthStr = sdf.format(birth);
            String yyyy = birthStr.substring(0, 4).trim();
            String dd = birthStr.substring(8).trim();

            if (!Pattern.matches(regexYear, yyyy)) {
                errors.rejectValue("birth", "BIRTH_YEAR");
                return;
            }

            if (!Pattern.matches(regexDay, dd)) {
                errors.rejectValue("birth", "BIRTH_DAY");
            }

        } catch (Exception e) {
            // 생년월일이 공란일 때도 여기로 빠지게
            errors.rejectValue("birth", "BIRTH_ERR");
        }
    }
}
