package com.maple.spring.userscontroller;

import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.maple.spring.usersdto.UsersDto;
import com.maple.spring.usersservice.UsersService;

@Controller
public class UsersController {

	@Autowired
	private UsersService service;
	
	@RequestMapping("/users/signup_form")
	public String signupForm() {
		return "users/signup_form";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/users/signup")
	public String singUp(UsersDto dto) {
		service.addUser(dto);
		return "users/signup";
	}
	
	@RequestMapping("/users/login_form")
	public String loginForm(HttpServletRequest request) {
		String encodeurl = (String)request.getParameter("url");
		request.setAttribute("encodeurl", encodeurl);
		return "users/login_form";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/users/login")
	@ResponseBody 
	public Map<String, Object> login(@RequestBody UsersDto dto, HttpServletRequest request) {
		service.loginProcess(dto, request);
		Map<String, Object> map = (Map<String, Object>)request.getAttribute("map");
		map.put("url", dto.getUrl());
		return map;
	}
	
	@RequestMapping("/users/logout")
	public String logOut(HttpSession session) {
		session.removeAttribute("id");
		return "users/logout";
	}
}
