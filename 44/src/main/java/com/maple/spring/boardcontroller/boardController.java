package com.maple.spring.boardcontroller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maple.spring.boarddto.BoardCommentDto;
import com.maple.spring.boarddto.BoardDto;
import com.maple.spring.boardservice.BoardService;
import com.maple.spring.usersservice.UsersService;

@Controller
public class boardController {
   
   @Autowired
   private BoardService service;
   
   @RequestMapping("/board/insert_form")
   public String insertForm() {
      return "board/insert_form";
   }
   
   @RequestMapping("/board/insert")
   @ResponseBody
   public Map<String, Object> insert(@RequestBody BoardDto dto, HttpServletRequest request) {
      service.insertContent(dto, request);
      Map<String, Object> map = (Map<String, Object>)request.getAttribute("msg");
      return map;
   }
   
   @RequestMapping("/board/update_form")
   public String updateForm(HttpServletRequest request, HttpServletResponse response) {
	   service.getBoardDetail(request, response);
	   return "board/update_form";
   }
   
   @RequestMapping("/board/update")
   @ResponseBody
   public Map<String, Object> update(@RequestBody BoardDto dto) {
	   Map<String, Object> map = service.updateContent(dto);
	   return map;
   }
   
   @RequestMapping("/board/delete")
   public void delete(@RequestBody Map<String, Object> deleteInfo) {
	   service.deleteContent(deleteInfo);
   }
   
   @RequestMapping("/board/detail") 
   public String detail(HttpServletRequest request, HttpServletResponse response) {
	   String condition = request.getParameter("condition");
	   String keyword = request.getParameter("keyword");
	   service.getBoardDetail(request, response);
	   return "board/detail";
   }
   
   @RequestMapping("/board/addAgree")
   @ResponseBody
   public Map<String, Object> agree(@RequestBody BoardDto dto, HttpServletResponse response, HttpServletRequest request) {;
	   Map<String, Object> map = service.getAgreeCount(dto, request, response);
	   return map;
   }
   
   //댓글 추가
   @RequestMapping("/board/comment_insert")
   public String commentInsert(HttpServletRequest request, int ref_group) {
	   String condition = request.getParameter("condition");
	   String keyword = request.getParameter("keyword");
	   try {
	        // 키워드를 UTF-8 인코딩하여 URL에 안전하게 붙임
	        String encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
	        service.saveComment(request);
	        // 인코딩된 키워드를 URL에 붙임
	        return "redirect:/board/detail?num=" + ref_group + "&condition=" + condition + "&keyword=" + encodedKeyword;
	    } catch (UnsupportedEncodingException e) {
	        // 예외 처리
	        e.printStackTrace();
	    }
	   return "redirect:/board/detail?num="+ref_group + "&condition=" + condition + "&keyword=" + keyword;
   }
   
   //댓글 삭제
   @RequestMapping("/board/comment_delete")
   @ResponseBody
   public Map<String, Object> commentDelete(@RequestBody Map<String, Object> deleteInfo, HttpServletRequest request) {
	   Map<String , Object> map = service.deleteComment(deleteInfo, request);
	   return map;
   }
   
   //댓글 수정
   @RequestMapping("/board/comment_modify")
   public String commentModify(HttpServletRequest request, int ref_group) {
	   String condition = request.getParameter("condition");
	   String keyword = request.getParameter("keyword");
	   try {
	        // 키워드를 UTF-8 인코딩하여 URL에 안전하게 붙임
	        String encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
	        service.modifyComment(request);
	        // 인코딩된 키워드를 URL에 붙임
	        return "redirect:/board/detail?num=" + ref_group + "&condition=" + condition + "&keyword=" + encodedKeyword;
	    } catch (UnsupportedEncodingException e) {
	        // 예외 처리
	        e.printStackTrace();
	    }
	   return "redirect:/board/detail?num=" + ref_group + "&condition=" + condition + "&keyword=" + keyword;
   }
   
}