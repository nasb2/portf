package com.spring.portf.dao;

import com.spring.portf.domain.CommentDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class CommentDaoImpl implements CommentDao {
    @Autowired
    SqlSession session;

    private final String namespace = "com.spring.portf.dao.CommentMapper.";

    @Override
    public int commentCnt() throws Exception {
        return session.selectOne(namespace + "commentCnt");
    }

    @Override
    public CommentDto select(Integer cno) throws Exception {
        return session.selectOne(namespace + "select", cno);
    }

    @Override
    public List<CommentDto> selectAllComments() throws Exception {
        return session.selectList(namespace + "selectAll");
    }

    @Override
    public List<CommentDto> selectCommentList(Integer bno) throws Exception {
        return session.selectList(namespace + "selectCommentList", bno);
    }

    @Override
    public List<CommentDto> selectReplyList(Integer bno, Integer pcno) throws Exception {
        Map map = new HashMap();
        map.put("bno", bno);
        map.put("pcno", pcno);
        return session.selectList(namespace + "selectReplyList", map);
    }

    @Override
    public int deleteAll() throws Exception {
        return session.delete(namespace + "deleteAll");
    }

    @Override
    public int delete(Integer cno, String commenter) throws Exception {
        Map<Object, Object> map = new HashMap<>();
        map.put("cno", cno);
        map.put("commenter", commenter);
        return session.delete(namespace + "delete", map);
    }

    @Override
    public int insert(CommentDto commentDto) throws Exception {
        return session.insert(namespace + "insert", commentDto);
    }

    @Override
    public int update(CommentDto commentDto) throws Exception {
        return session.update(namespace + "update", commentDto);
    }
}
