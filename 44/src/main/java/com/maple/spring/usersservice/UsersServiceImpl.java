package com.maple.spring.usersservice;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.maple.spring.usersdao.UsersDao;
import com.maple.spring.usersdto.UsersDto;

@Service
public class UsersServiceImpl implements UsersService {

	@Autowired
	private UsersDao dao;

	@Override
	public void addUser(UsersDto dto) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodePwd = encoder.encode(dto.getPassword());
		dto.setPassword(encodePwd);
		dto.setProfile(null);
		dao.insert(dto);
	}

	@Override
	public void loginProcess(UsersDto dto, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isValid = false;
		if(dto.getId().length()==0 || dto.getPassword().length()==0) {
			map.put("msg", "아이디 또는 비밀번호를 입력해주세요");
			request.setAttribute("map", map);
			return;
		}
		UsersDto resultDto = dao.getData(dto.getId());
		//만일 select된 회원 정보가 존재하고
		if(resultDto!=null) {
			isValid = BCrypt.checkpw(dto.getPassword(), resultDto.getPassword());
		}
		if(isValid) {
			//로그인 처리를 한다.
			map.put("msg", "로그인 성공");
			request.setAttribute("map", map);
			session.setAttribute("id", resultDto.getId());
			return;
		}
		if(resultDto!=null) {
			//Bcrypt클래스의 static 메서드를 이용해 입력한 비밀번호와 암호화해서 저장된 비밀번호 일치 여부를 알아내야한다.
		}
		map.put("msg", "아이디 또는 비밀번호를 확인해주세요");
		request.setAttribute("map", map);
		return;
	}
	
}
