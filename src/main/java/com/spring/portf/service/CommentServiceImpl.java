package com.spring.portf.service;

import com.spring.portf.dao.BoardDao;
import com.spring.portf.dao.CommentDao;
import com.spring.portf.domain.BoardDto;
import com.spring.portf.domain.CommentDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    BoardDao boardDao;
    @Autowired
    CommentDao commentDao;

    @Override
    public int commentCnt() throws Exception {
        return commentDao.commentCnt();
    }

    @Override
    public CommentDto read(Integer cno) throws Exception {
        return commentDao.select(cno);
    }

    @Override
    public List<CommentDto> selectAllComments() throws Exception {
        return commentDao.selectAllComments();
    }

    @Override
    public List<CommentDto> selectCommentList(Integer bno) throws Exception {
        return commentDao.selectCommentList(bno);
    }

    @Override
    public List<CommentDto> selectReplyList(Integer bno, Integer pcno) throws Exception {
        return commentDao.selectReplyList(bno, pcno);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteAll() throws Exception {
        BoardDto boardDto = new BoardDto();
        boardDto.setCommentCnt(0);
        boardDao.clearCommentCnt();
        return commentDao.deleteAll();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int remove(Integer cno, String commenter) throws Exception {
        Integer bno = commentDao.select(cno).getBno();
        boardDao.updateCommentCnt(bno, -1);
        return commentDao.delete(cno, commenter);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int write(CommentDto commentDto) throws Exception {
        Integer bno = commentDto.getBno();
        boardDao.updateCommentCnt(bno, 1);
//        throw new Exception();
        return commentDao.insert(commentDto);
    }

    @Override
    public int update(CommentDto commentDto) throws Exception {
        return commentDao.update(commentDto);
    }
}
