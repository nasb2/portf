package com.spring.portf.dao;

import com.spring.portf.domain.CommentDto;

import java.util.List;

public interface CommentDao {
    int commentCnt() throws Exception;

    CommentDto select(Integer cno) throws Exception;

    List<CommentDto> selectAllComments() throws Exception;

    List<CommentDto> selectCommentList(Integer bno) throws Exception;

    List<CommentDto> selectReplyList(Integer bno, Integer pcno) throws Exception;

    int deleteAll() throws Exception;

    int delete(Integer cno, String commenter) throws Exception;

    int insert(CommentDto commentDto) throws Exception;

    int update(CommentDto commentDto) throws Exception;
}
