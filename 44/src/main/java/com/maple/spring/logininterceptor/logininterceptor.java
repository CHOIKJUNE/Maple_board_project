package com.maple.spring.logininterceptor;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

//濡쒓렇�씤�맂 �궗�슜�옄�씤吏� 寃��궗�븷 �씤�꽣�뀎�꽣
public class logininterceptor implements HandlerInterceptor{
	//Controller 硫붿냼�뱶 �닔�뻾吏곸쟾�뿉 濡쒓렇�씤�맂 �궗�슜�옄 �씤吏� 寃�利앹쓣 �빐�꽌 
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//�꽭�뀡 媛앹껜�쓽 李몄“媛믪쓣 �뼸�뼱���꽌 
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		//留뚯씪 濡쒓렇�씤�쓣 �븯吏� �븡�븯�떎硫�
		if(id == null) {
			//濡쒓렇�씤 �럹�씠吏�濡� 由щ떎�씪�젆�듃 �씠�룞 �떆�궎怨� false 瑜� 由ы꽩�븳�떎.

			//�썝�옒 媛��젮�뜕 url �젙蹂� �씫�뼱�삤湲�
			String url=request.getRequestURI();
			//만약 로그인하지 않은 상태에서 공감하기 버튼을 눌렀으면 로그인 후 addAgree페이지가 아닌 
			//detail페이지로 가야한다.
			System.out.println(url);
			if(url.equals("/myapp/board/addAgree")) {
				url = "/myapp/board/detail";
			}
			//GET 諛⑹떇 �쟾�넚 �뙆�씪誘명꽣瑜� query 臾몄옄�뿴濡� �씫�뼱�삤湲� ( a=xxx&b=xxx&c=xxx )
			String query=request.getQueryString();
			String encodedUrl=null;
			if(query==null) {//�쟾�넚 �뙆�씪誘명꽣媛� �뾾�떎硫� 
				encodedUrl=URLEncoder.encode(url);
			}else {
				// "/test/xxx.jsp?a=xxx&b=xxx ..."
				encodedUrl=URLEncoder.encode(url+"?"+query);
			}

			String cPath=request.getContextPath();
			response.sendRedirect(cPath+"/users/login_form?url="+encodedUrl);
			return false;
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}
}
