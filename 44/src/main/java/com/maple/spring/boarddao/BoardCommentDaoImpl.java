package com.maple.spring.boarddao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.maple.spring.boarddto.BoardCommentDto;

@Repository
public class BoardCommentDaoImpl implements BoardCommentDao {
	
	@Autowired
	SqlSession session;
	
	@Override
	public List<BoardCommentDto> getList(BoardCommentDto commentDto) {
		return session.selectList("BoardComment.getList", commentDto);
	}

	@Override
	public void delete(int num) {
		session.update("BoardComment.delete", num);
	}

	@Override
	public void insert(BoardCommentDto dto) {
		session.insert("BoardComment.insert", dto);
	}
	//저장될 예정인 댓글의 글번호를 얻어내서 리턴해주는 메소드 
	@Override
	public int getSequence() {
		return session.selectOne("BoardComment.getSequence");
	}

	@Override
	public void update(BoardCommentDto dto) {
		session.update("BoardComment.update", dto);
	}

	@Override
	public BoardCommentDto getData(int num) {
		return session.selectOne("BoardComment.getData", num);
	}
	//하나의 원글에 몇개의 댓글이 있는지 리턴하는 메소드 
	@Override
	public int getCount(int ref_group) {
		return session.selectOne("BoardComment.getCount", ref_group);
	}
	
}
