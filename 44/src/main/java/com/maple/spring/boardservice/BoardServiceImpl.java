package com.maple.spring.boardservice;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.maple.spring.boarddao.BoardCommentDao;
import com.maple.spring.boarddao.BoardDao;
import com.maple.spring.boarddto.BoardCommentDto;
import com.maple.spring.boarddto.BoardDto;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDao dao;

	@Autowired
	private BoardCommentDao BoardCommentDao;

	@Override
	public void insertContent(BoardDto dto, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(dto.getTitle().isEmpty() || dto.getContent().equals("")) {
			map.put("msg", "제목 또는 내용을 입력해주세요.");
			request.setAttribute("msg", map);
			return;
		}
		int isNumValid = dao.insert(dto);
		if(isNumValid!=0) {
			map.put("msg", "성공");
			request.setAttribute("msg", map);
		}
	}

	@Override
	public Map<String, Object> updateContent(BoardDto dto) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(dto.getTitle().isEmpty() || dto.getContent().equals("")) {
			map.put("msg", "제목 또는 내용을 입력해주세요.");
			return map;
		}
		else {
			dao.update(dto);
			map.put("msg", "수정 완료");
			return map;
		}
	}

	@Override
	 public void deleteContent(Map<String, Object> deleteInfo) {
		int num = Integer.valueOf((String)deleteInfo.get("num"));
		dao.delete(num);
	}

	@Override
	public void getBoardList(BoardDto dto, HttpServletRequest request) {
		//한 페이지에 몇개의 글이 노출될 것인가? (1~10/ 11~20 등 총 10개의 글)
		//하단 에는 몇개의 페이지 디스플레이가 노출될 것인가?(1~5, 6~10 등 총 5개의 페이지디스플레이)
		final int PAGE_ROW_NUM = 10;
		final int PAGE_DISPLAY_NUM = 5;
		int pageNum = 1;
		//총 글의 개수

		String requestNum = (String)request.getParameter("pageNum");
		if(requestNum!=null) {
			pageNum = Integer.valueOf(requestNum); //6
		}

		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_NUM;   // 51
		int endRowNum = pageNum * PAGE_ROW_NUM;  // 60
		//dto에 담기
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);

		String condition = (String)request.getParameter("condition");
		String keyword = (String)request.getParameter("keyword");

		//만약 키워드가 넘어오지 않는다면
		if(keyword==null) {
			keyword="";
			condition="";
		}

		if(!keyword.equals("")){
			//검색 조건이 무엇이냐에 따라 분기 하기
			if(condition.equals("title_content")){//글 제목+내용 검색인 경우
				dto.setTitle(keyword);
				dto.setContent(keyword);
			}else if(condition.equals("title")){ //제목 검색인 경우
				dto.setTitle(keyword);
			}else if(condition.equals("writer")){ //작성자 검색인 경우
				dto.setWriter(keyword);
			} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
		}

		String encodedK=URLEncoder.encode(keyword);

		List<BoardDto> list = dao.getList(dto);
		int totalRow = dao.getCount(dto); // 총54개의 글
		//하단 시작 페이지 번호 // 6
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_NUM)*PAGE_DISPLAY_NUM;
		//하단 끝 페이지 번호 // 10
		int endPageNum=startPageNum+PAGE_DISPLAY_NUM-1;
		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_NUM); // 6
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; //보정해 준다. 
		}



		//응답에 필요한 데이터를 view page 에 전달하기 위해  request scope 에 담는다
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum); // 6
		request.setAttribute("startPageNum", startPageNum); // 6
		request.setAttribute("endPageNum", endPageNum); // 6
		request.setAttribute("totalPageCount", totalPageCount); //6
		request.setAttribute("encodedK", encodedK);
		request.setAttribute("totalRow", totalRow); // 54
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);
	}

	@Override
	public void getBoardDetail(HttpServletRequest request, HttpServletResponse response) {
		BoardDto dto = new BoardDto();
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		//글번호 얻어오기 (쿠키와 조회수 증가에 사용)
		int num = Integer.valueOf(request.getParameter("num"));
		//대댓글 그룹번호 얻어오기
		//      int comment_group = Integer.valueOf(request.getParameter("comment_group"));
		// [쿠키 관련 로직(새로고침 시 조회수 증가 방지)]
		Cookie[] getCook = request.getCookies();
		for(int i=0; i<getCook.length; i++) {
			//만약 저장된 쿠키key값이 존재한다면 반복문 탈출
			// 주의 : getCook[i].equals는 쿠키 객체 자체를 비교하는 것이기 때문에 .equals는 당연히 false이다.
			if(getCook[i].getName().equals(id + "readBoard" + num)) break;
			//만약 배열의 마지막 인덱스 값의 key마저 존재하지 않는다면
			if(i==getCook.length-1) {
				//쿠키 생성
				Cookie sendCook = new Cookie(id + "readBoard" + num, "read");
				//쿠키 지속시간을 1시간으로 설정
				sendCook.setMaxAge(60*60);
				//쿠키 보내고
				response.addCookie(sendCook);
				//조회수 올리기
				dao.addViewCount(num);
			}
		}
		// dto에 num 담기
		dto.setNum(num);

		String condition = (String)request.getParameter("condition");
		String keyword = (String)request.getParameter("keyword");
		if(keyword==null) {
			keyword="";
			condition="";
		}
		if(!keyword.equals("")){
			//검색 조건이 무엇이냐에 따라 분기 하기
			if(condition.equals("title_content")){//글 제목+내용 검색인 경우
				dto.setTitle(keyword);
				dto.setContent(keyword);
			}else if(condition.equals("title")){ //제목 검색인 경우
				dto.setTitle(keyword);
			}else if(condition.equals("writer")){ //작성자 검색인 경우
				dto.setWriter(keyword);
			} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
		}
		request.setAttribute("dto", dao.getDetail(dto));
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);

		//원글의 글번호를 이용해서 해당글에 달린 댓글 목록을 얻어온다.
		BoardCommentDto commentDto=new BoardCommentDto();
		commentDto.setRef_group(num);
		//1페이지에 해당하는 댓글 목록만 select 되도록 한다. 
		List<BoardCommentDto> commentList=BoardCommentDao.getList(commentDto);
		//원글의 글번호를 이용해서 댓글 전체의 갯수를 얻어낸다.
		int totalRow=BoardCommentDao.getCount(num);
		//request scope 에 글 하나의 정보 담기
		request.setAttribute("totalRow", totalRow); // 6
		request.setAttribute("commentList", commentList);
	}

	@Override
	public Map<String, Object> getAgreeCount(BoardDto dto, HttpServletRequest request, HttpServletResponse response) {
		//글번호 
		int num = dto.getNum();
		//로그인한 회원아이디
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		//만약 dto에 자바스크립트단에서의 num이 자바객체로 담긴다면 제대로 출력되야한다.
		Map<String, Object> map = new HashMap<String, Object>();
		Cookie[] getCook = request.getCookies();
		for(int i=0; i<getCook.length; i++) {
			//만약 저장된 쿠키key값이 존재한다면 반복문 탈출
			// 주의 : getCook[i].equals는 쿠키 객체 자체를 비교하는 것이기 때문에 .equals는 당연히 false이다.
			if(getCook[i].getName().equals(id + "agreeBoard" + num + "agree")) {
				map.put("agreeCount", null);
				break;
			}
			//만약 배열의 마지막 인덱스 값의 key마저 존재하지 않는다면
			if(i==getCook.length-1) {
				//쿠키 생성
				Cookie sendCook = new Cookie(id + "agreeBoard" + num + "agree", "agree");
				//쿠키 보내고
				response.addCookie(sendCook);
				//공감수 올리기
				dao.addAgree(num);
				map.put("agreeCount", "add");
			}
		}
		return map;
	}

	//댓글 추가
	@Override
	public void saveComment(HttpServletRequest request) {
		//폼 전송되는 파라미터 추출 
		int ref_group=Integer.parseInt(request.getParameter("ref_group")); //원글의 글번호
		String target_id=request.getParameter("target_id"); //댓글 대상자의 아이디
		String content=request.getParameter("content"); //댓글의 내용 
		String emoSrc = request.getParameter("emoSrc");
		/*
		 *  원글의 댓글은 comment_group 번호가 전송이 안되고
		 *  댓글의 댓글은 comment_group 번호가 전송이 된다.
		 *  따라서 null 여부를 조사하면 원글의 댓글인지 댓글의 댓글인지 판단할수 있다. 
		 */
		String comment_group=request.getParameter("comment_group");

		//댓글 작성자는 session 영역에서 얻어내기
		String writer=(String)request.getSession().getAttribute("id");
		//댓글의 시퀀스 번호 미리 얻어내기
		int seq=BoardCommentDao.getSequence();

		//저장할 댓글의 정보를 dto 에 담기
		BoardCommentDto dto=new BoardCommentDto();
		dto.setNum(seq);
		dto.setWriter(writer);
		dto.setTarget_id(target_id);
		dto.setContent(content);
		dto.setRef_group(ref_group);
		dto.setEmoSrc(emoSrc);
		//원글의 댓글인경우
		if(comment_group == null){
			//댓글의 글번호를 comment_group 번호로 사용한다.
			dto.setComment_group(seq);
		}else{
			//전송된 comment_group 번호를 숫자로 바꾸서 dto 에 넣어준다. 
			dto.setComment_group(Integer.parseInt(comment_group));
		}
		//댓글 정보를 DB 에 저장하기
		BoardCommentDao.insert(dto);	
	}

	//댓글 삭제
	@Override
	public Map<String, Object> deleteComment(Map<String, Object> deleteInfo, HttpServletRequest request) {
		//글번호 얻어오기
		int ref_group = Integer.valueOf((String)deleteInfo.get("num2"));
		//총 댓글 개수 가져오기
		int totalRow=BoardCommentDao.getCount(ref_group);
		//댓글번호 얻어오기
		int num = Integer.valueOf((String)deleteInfo.get("num"));
		//댓글을 삭제한다.(deleted 칼럼만 "yes"로 바꿔주기)
		BoardCommentDao.delete(num);
		//해당 댓글번호의 댓글 정보를 가져온다.
		BoardCommentDto dto = BoardCommentDao.getData(num);
		//만약 해당 닷글이 삭제되었다면
		if(dto.getDeleted().equals("yes")) {
			//totalRow에서 1씩 빼준다.
			totalRow -= 1;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("isDelete", "yes");
		map.put("totalRow", totalRow);
		return map;
	}

	//댓글 수정
	@Override
	public void modifyComment(HttpServletRequest request) {
		//댓글 번호 가져오기
		int num = Integer.valueOf(request.getParameter("num"));
		//수정한 내용 가져오기
		String content = request.getParameter("content");
		BoardCommentDto dto = new BoardCommentDto();
		dto.setNum(num);
		dto.setContent(content);
		BoardCommentDao.update(dto);
	}
}