package com.maple.spring.usersdao;

import com.maple.spring.usersdto.UsersDto;

public interface UsersDao {
	public void insert(UsersDto dto);
	public UsersDto getData(String id);
}
