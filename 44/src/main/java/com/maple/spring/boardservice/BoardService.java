package com.maple.spring.boardservice;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.maple.spring.boarddto.BoardCommentDto;
import com.maple.spring.boarddto.BoardDto;

public interface BoardService {
   public void insertContent(BoardDto dto, HttpServletRequest request);
   public void getBoardList(BoardDto dto, HttpServletRequest request);
   public void getBoardDetail(HttpServletRequest request, HttpServletResponse response);
   public Map<String, Object> getAgreeCount(BoardDto dto, HttpServletRequest request, HttpServletResponse response);
   public void saveComment(HttpServletRequest request);
   public Map<String, Object> deleteComment(Map<String, Object> deleteInfo, HttpServletRequest request);
   public void deleteContent(Map<String, Object> deleteInfo);
   public Map<String, Object> updateContent(BoardDto dto);
   public void modifyComment(HttpServletRequest request);
}
