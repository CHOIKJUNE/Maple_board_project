package com.maple.spring;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.maple.spring.boarddto.BoardDto;
import com.maple.spring.boardservice.BoardService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private BoardService service;
	
	@RequestMapping("/")
	public String home(BoardDto dto, HttpServletRequest request) {
		service.getBoardList(dto, request);
		return "home";
	}
	
}
