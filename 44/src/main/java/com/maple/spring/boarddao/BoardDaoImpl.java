package com.maple.spring.boarddao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.maple.spring.boarddto.BoardDto;

@Repository
public class BoardDaoImpl implements BoardDao{

	@Autowired
	private SqlSession session;

	@Override
	public int insert(BoardDto dto) {
		return session.insert("board.insert", dto);
	}
	
	@Override
	public void update(BoardDto dto) {
		session.update("board.update", dto);
	}

	@Override
	public void delete(int num) {
		session.delete("board.delete", num);
	}
	
	@Override
	public List<BoardDto> getList(BoardDto dto) {
		return session.selectList("board.getList", dto);
	}

	@Override
	public int getCount(BoardDto dto) {
		return session.selectOne("board.getCount", dto);
	}

	@Override
	public BoardDto getDetail(BoardDto dto) {
		return session.selectOne("board.getDetail", dto);
	}

	@Override
	public void addViewCount(int num) {
		session.update("board.addViewCount", num);
	}

	public int getCount() {
		return session.selectOne("board.getCount");
	}

	@Override
	public void addAgree(int num) {
		session.update("board.addAgree", num);
	}

	@Override
	public BoardDto getAgreeCount(int num) {
		return session.selectOne("board.getAgreeCount", num);
	}



}