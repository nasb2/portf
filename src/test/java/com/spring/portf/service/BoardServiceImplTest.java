package com.spring.portf.service;

import com.spring.portf.domain.BoardDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardServiceImplTest {
    @Autowired
    BoardService boardService;

    @Test
    public void updateViewCnt() throws Exception {
        boardService.deleteAll();
        BoardDto boardDto = new BoardDto("test", "test", "tester");
        boardService.insert(boardDto);

        Integer bno = boardService.selectAll().get(0).getBno();
        assertEquals(1, (int) boardService.read(bno).getViewCnt());
    }

    @Test
    public void selectSearchData() throws Exception {
        boardService.deleteAll();
        for (int i = 0; i < 20; i++) {
            String[] strArr = {"context?라", "Execution", "..default..", "listner",
                    "jdbc;;", "java나", "depen?dency", "spring^^", "{before}", "게class",
                    "(가)", "?자?바", "다$", "라", "###", "게시판", "1234", "4321", "*&@($?!", ""};
            BoardDto boardDto = new BoardDto(strArr[i], "test" + i, "tester");
            assertEquals(1, boardService.insert(boardDto));
        }
        String keyword = "게";
        System.out.println(boardService.selectSearchData(keyword, 0, 10));
        keyword = "ex";
        System.out.println(boardService.selectSearchData(keyword, 0, 10));
        keyword = "?";
        System.out.println(boardService.selectSearchData(keyword, 0, 10));
        keyword = "test2";
        System.out.println(boardService.selectSearchData(keyword, 0, 10));
    }

    @Test
    public void updateTest() throws Exception {
        BoardDto boardDto = new BoardDto("test", "test", "test");
        boardService.insert(boardDto);
        Integer bno = boardService.selectAll().get(0).getBno();
        boardDto.setTitle("테스트");
        boardDto.setBno(bno);
        boardService.update(boardDto);
        System.out.println(boardDto.getViewCnt());
    }


}