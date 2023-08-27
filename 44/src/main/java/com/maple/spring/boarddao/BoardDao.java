package com.maple.spring.boarddao;

import java.util.List;

import com.maple.spring.boarddto.BoardDto;
 
public interface BoardDao {
   public int insert(BoardDto dto);
   public void update(BoardDto dto);
   public void delete(int num);
   public List<BoardDto> getList(BoardDto dto);
   public int getCount(BoardDto dto);
   public BoardDto getDetail(BoardDto dto);
   public void addViewCount(int num);
   public void addAgree(int num);
   public BoardDto getAgreeCount(int num);
}