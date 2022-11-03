package com.spring.portf.controller;

import com.spring.portf.domain.PictureDto;
import com.spring.portf.service.PictureService;
import com.spring.portf.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class RegDateHandlerTest {
    @Autowired
    UserService userService;
    @Autowired
    PictureService pictureService;

    @Test
    public void test1() throws Exception {
        Integer pno = pictureService.selectAll().get(0).getPno();
        PictureDto pictureDto = pictureService.read(pno);

        Date regDate = pictureDto.getRegDate();
        System.out.println("regDate = " + regDate);
        Date today = new Date();

        long diffSeconds = (today.getTime() / 1000) - (regDate.getTime() / 1000);
        long diffMinutes = (today.getTime() / (60 * 1000)) - (regDate.getTime() / (60 * 1000));
        long diffHours = (today.getTime() / (60 * 60 * 1000)) - (regDate.getTime() / (60 * 60 * 1000));
        long diffDays = (today.getTime() / (60 * 60 * 24 * 1000)) - (regDate.getTime() / (60 * 60 * 24 * 1000));

        System.out.println("diffDays = " + diffDays + "일 전");
        System.out.println("diffHours = " + diffHours + "시간 전");
        System.out.println("diffMinutes = " + diffMinutes + "분 전");
        System.out.println("diffSeconds = " + diffSeconds + "초 전");

        String printDiff = "";

        if (diffSeconds < 60) {
            printDiff = "방금 전";
        } else if (diffMinutes < 60) {
            printDiff = diffMinutes + "분 전";
        } else if (diffHours < 24) {
            printDiff = diffHours + "시간 전";
        } else if (diffDays < 369) {
            printDiff = diffDays + "일 전";
        } else {
            printDiff = "오래된 글";
        }
        System.out.println(printDiff);
    }
}
