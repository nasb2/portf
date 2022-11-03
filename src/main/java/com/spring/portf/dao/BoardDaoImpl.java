package com.spring.portf.dao;

import com.spring.portf.domain.BoardDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BoardDaoImpl implements BoardDao {
    @Autowired
    SqlSession session;
    private static String namespace = "com.spring.portf.dao.BoardMapper.";

    @Override
    public int selectCnt() throws Exception {
        return session.selectOne(namespace + "selectCnt");
    }

    @Override
    public BoardDto select(Integer bno) throws Exception {
        return session.selectOne(namespace + "select", bno);
    }

    @Override
    public List<BoardDto> selectAll() throws Exception {
        return session.selectList(namespace + "selectAll");
    }

    @Override
    public List<BoardDto> selectPage(Integer offset, Integer pageSize) throws Exception {
        Map map = new HashMap();
        map.put("offset", offset);
        map.put("pageSize", pageSize);
        return session.selectList(namespace + "selectPage", map);
    }

    @Override
    public int delete(Integer bno, String writer) throws Exception {
        Map map = new HashMap();
        map.put("bno", bno);
        map.put("writer", writer);
        return session.delete(namespace + "delete", map);
    }

    @Override
    public int deleteAll() throws Exception {
        return session.delete(namespace + "deleteAll");
    }

    @Override
    public int insert(BoardDto boardDto) throws Exception {
        return session.insert(namespace + "insert", boardDto);
    }

    @Override
    public int update(BoardDto boardDto) throws Exception {
        return session.update(namespace + "update", boardDto);
    }

    @Override
    public int updateViewCnt(Integer bno, Integer viewCnt) throws Exception {
        Map map = new HashMap();
        map.put("bno", bno);
        map.put("viewCnt", viewCnt);
        return session.update(namespace + "updateViewCnt", map);
    }

    @Override
    public int updateCommentCnt(Integer bno, Integer cnt) throws Exception {
        Map map = new HashMap();
        map.put("bno", bno);
        map.put("cnt", cnt);
        return session.update(namespace + "updateCommentCnt", map);
    }

    @Override
    public int clearCommentCnt() throws Exception {
        return session.update(namespace + "clearCommentCnt");
    }

    @Override
    public List<BoardDto> selectSearchData(String keyword, Integer offset, Integer pageSize) throws Exception {
        Map map = new HashMap();
        map.put("keyword", keyword);
        map.put("offset", offset);
        map.put("pageSize", pageSize);
        return session.selectList(namespace + "selectSearchData", map);
    }

    @Override
    public int selectSearchDataCnt(String keyword) throws Exception {
        return session.selectOne(namespace + "selectSearchDataCnt", keyword);
    }

}
