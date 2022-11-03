package com.spring.portf.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class PageHandlerTest {
    @Test
    public void test1() throws Exception {
        PageHandler ph = new PageHandler(100, 10, 10);
        assertTrue(ph.getBeginPage() == 1);
        ph.printNavi();
    }

    @Test // 게시물 수가 10미만
    public void test2() throws Exception {
        PageHandler ph = new PageHandler(9, 1, 10);
        assertTrue(ph.getEndPage() == ph.getBeginPage());
        ph.printNavi();
    }

    @Test // 경계값
    public void test3() throws Exception {
        PageHandler ph = new PageHandler(201, 21, 10);
        assertTrue(ph.getBeginPage() == 21);
        ph.printNavi();
    }

    @Test
    public void test4() throws Exception {
        PageHandler ph = new PageHandler(421, 27, 10);
        ph.printNavi();
        assertTrue(ph.getTotalPageCnt() == 43);
        ph = new PageHandler(421, 42, 10);
        System.out.println();
        ph.printNavi();
    }

    @Test
    public void test5() throws Exception {
        PageHandler ph = new PageHandler(110, 11, 10);
        ph.printNavi();
    }

    @Test
    public void test6() throws Exception {
        PageHandler ph = new PageHandler(200, 20, 10);
        ph.printNavi();
    }

    @Test
    public void test7() throws Exception {
        PageHandler ph = new PageHandler(11, 1, 10);
        ph.printNavi();
    }

    // 1~5 페이징
    @Test
    public void test8() throws Exception {
        PageHandler ph = new PageHandler(31, 1, 5);
        int endPage = ph.getEndPage();
        ph.setEndPage(Math.min(ph.getTotalPageCnt(), ph.getBeginPage() + 4));
        ph.setShowNext(endPage % 5 == 0 && endPage < ph.getTotalPageCnt());
        ph.printNavi();
    }
}