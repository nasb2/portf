package com.spring.portf.service;

import com.spring.portf.domain.CommentDto;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface CommentService {
    int commentCnt() throws Exception;

    CommentDto read(Integer cno) throws Exception;

    List<CommentDto> selectAllComments() throws Exception;

    List<CommentDto> selectCommentList(Integer bno) throws Exception;

    List<CommentDto> selectReplyList(Integer bno, Integer pcno) throws Exception;

    @Transactional(rollbackFor = Exception.class)
    int deleteAll() throws Exception;

    @Transactional(rollbackFor = Exception.class)
    int remove(Integer cno, String commenter) throws Exception;

    @Transactional(rollbackFor = Exception.class)
    int write(CommentDto commentDto) throws Exception;

    int update(CommentDto commentDto) throws Exception;
}
