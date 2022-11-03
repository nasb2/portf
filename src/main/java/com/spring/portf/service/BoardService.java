package com.spring.portf.service;

import com.spring.portf.domain.BoardDto;

import java.util.List;

public interface BoardService {
    int selectCnt() throws Exception;

    BoardDto read(Integer bno) throws Exception;

    List<BoardDto> selectAll() throws Exception;

    List<BoardDto> selectPage(Integer offset, Integer pageSize) throws Exception;

    int delete(Integer bno, String writer) throws Exception;

    int deleteAll() throws Exception;

    int insert(BoardDto boardDto) throws Exception;

    int update(BoardDto boardDto) throws Exception;

    int updateViewCnt(Integer bno, Integer viewCnt) throws Exception;

    int updateCommentCnt(Integer bno, Integer cnt) throws Exception;

    int clearCommentCnt() throws Exception;

    List<BoardDto> selectSearchData(String keyword, Integer offset, Integer pageSize) throws Exception;

    int selectSearchDataCnt(String keyword) throws Exception;
}
