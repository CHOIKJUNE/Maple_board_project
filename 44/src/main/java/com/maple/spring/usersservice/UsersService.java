package com.maple.spring.usersservice;

import javax.servlet.http.HttpServletRequest;

import com.maple.spring.usersdto.UsersDto;

public interface UsersService {
	public void addUser(UsersDto dto);
	public void loginProcess(UsersDto dto, HttpServletRequest request);
}
