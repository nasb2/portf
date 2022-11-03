package com.spring.portf.service;

import com.spring.portf.dao.BoardDao;
import com.spring.portf.domain.BoardDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService {
    @Autowired
    BoardDao boardDao;

    @Override
    public int selectCnt() throws Exception {
        return boardDao.selectCnt();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public BoardDto read(Integer bno) throws Exception {
        Integer viewCnt = boardDao.select(bno).getViewCnt();
        boardDao.updateViewCnt(bno, viewCnt);
        return boardDao.select(bno);
    }

    @Override
    public List<BoardDto> selectAll() throws Exception {
        return boardDao.selectAll();
    }

    @Override
    public List<BoardDto> selectPage(Integer offset, Integer pageSize) throws Exception {
        return boardDao.selectPage(offset, pageSize);
    }

    @Override
    public int delete(Integer bno, String writer) throws Exception {
        return boardDao.delete(bno, writer);
    }

    @Override
    public int deleteAll() throws Exception {
        return boardDao.deleteAll();
    }

    @Override
    public int insert(BoardDto boardDto) throws Exception {
        return boardDao.insert(boardDto);
    }

    @Override
    public int update(BoardDto boardDto) throws Exception {
        return boardDao.update(boardDto);
    }

    @Override
    public int updateViewCnt(Integer bno, Integer viewCnt) throws Exception {
        return boardDao.updateViewCnt(bno, viewCnt);
    }

    @Override
    public int updateCommentCnt(Integer bno, Integer cnt) throws Exception {
        return boardDao.updateCommentCnt(bno, cnt);
    }

    @Override
    public int clearCommentCnt() throws Exception {
        return boardDao.clearCommentCnt();
    }

    @Override
    public List<BoardDto> selectSearchData(String keyword, Integer offset, Integer pageSize) throws Exception {
        return boardDao.selectSearchData(keyword, offset, pageSize);
    }

    @Override
    public int selectSearchDataCnt(String keyword) throws Exception {
        return boardDao.selectSearchDataCnt(keyword);
    }
}
