<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/detail</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/detail_page_style.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" />
<style>
	 .comment_modify_submitBtn {
		height: 56px;
   		background-color: #e8eaee;
   	 	display: flex;
    	justify-content: flex-end;
    	align-items: center;
	}
	.comment_modifyBox {
		display: none;
	}
	.modify_submitBtn2 {
		min-width: 53px;
    	font-size: 16px;
    	color: #fff !important;
    	text-align: center;
    	background-color: #747a86;
    	border-radius: 2px;
    	padding: 9px 14px 9px 14px;
    	border: 1px solid #747a86;
    	display: inline-block;
    	line-height: 1;
    	margin-top: 16px;
    	margin-left: 5px;
	}
</style>
</head>
<body>
   <div class="container">
      <h1 class="con_title">
      자유 게시판
      <span class="con_title_btn"><a href="${pageContext.request.contextPath}/" class="back_btn">목록</a></span>
      </h1>
      <p class="qs_title" style="margin-top:30px">
         <span>${dto.title}</span>
      </p>
      <div class="qs_info_wrap">
         <span class="qs_id">
            <img src="${dto.server}" style="margin-right:3px">${dto.writer}
         </span>
         <div class="qs_info">
            <p><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/eye_new.png">${dto.viewcount}</p>
            <p class="last"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/sub_date_new.png">${dto.regdate}</p>
         </div>
      </div>
         <div class="qs_text">
         ${dto.content}
         </div>
         <div class="empathy_info">
            <a href="javascirpt:" id="agreeLink"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/empathy_btn_off.png"></a>
            <a href="" id="agreeCount"><span id="agreeBox">${dto.agree} 명</span></a>
         </div>
         <div class="qs_btn" style="${id eq dto.writer ? '' : 'display:none'}">
         	<div>
         	<a href="${pageContext.request.contextPath}/board/update_form?num=${dto.num}" class="board_updateBtn" data-num="${dto.num}"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/view_btn01.png"></a>
         	<a href="javascript:" class="board_deleteBtn" data-num="${dto.num}"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/view_btn02.png"></a>
         	</div>
         </div>
		<div class="comment_box">
			<div class="comment_info">
				<div class="comment_counts">
					<span class="comments">댓글</span><span class="howManyComments">${totalRow}</span>
				</div>
				<!-- 댓글 목록 -->
				<div class="users_comments">
						<c:forEach var="tmp" items="${commentList}">
							<c:choose>
								<c:when test="${tmp.num eq tmp.comment_group}">
									<c:choose>
										<c:when test="${tmp.deleted eq 'yes'}">
											<div class="delete_msg_style"><span>[삭제된 댓글입니다]</span><a href="" class="comment_comment" style="display:none"></a><a href="" class="comment_modify" style="display:none"></a></div>
										</c:when>
										<c:otherwise>
										<div class="each_users_comments">
											<div class="each_users_comments_info">
												<div>
													<a href="javascript:" style="text-decoration:none" class="user_server"><img src="${tmp.server}" class="users_serverImg" style="margin-bottom:4px"><span class="user_name">${tmp.writer}</span></a>
												<span class="user_comment_regdate">${tmp.regdate}</span>
													<span class="button_set">
														<span><a href="" class="comment_modify" style="${empty id || id ne tmp.writer ? 'display:none' : ''}" data-num="${tmp.num}" data-num2="${dto.num}">수정</a></span>
														<span><a href="" class="comment_delete" style="${empty id || id ne tmp.writer ? 'display:none' : ''}" data-num="${tmp.num}" data-num2="${dto.num}">삭제</a></span>
														<span><a href="" class="comment_comment" style="${empty id ? 'display:none' : ''}" data-num="${tmp.num}" data-writer="${tmp.writer}">답글</a></span>
													</span>
												</div>
											</div>
											<div class="each_users_comments_comment">
												${tmp.content}
												<c:if test="${not empty tmp.emoSrc}">
													<img src="${tmp.emoSrc}" alt="이모티콘" style="width: 35px">
												</c:if>
											</div>
										</div>
										</c:otherwise>
									</c:choose>
								</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${tmp.deleted eq 'yes'}">
												<a href="" class="comment_comment" style="display:none"></a><a href="" class="comment_modify" style="display:none"></a>
											</c:when>
											<c:otherwise>
												<div class="comment_comment_form">
													<div class="each_users_comments_info">
														<div class="comment_comment_info">
															<img src="${pageContext.request.contextPath}/resources/img/right-and-down.png" class="comment_arrow" style="margin-right:5px">
															<a href="javascript:" style="text-decoration:none" class="user_server"><img src="${tmp.server}" class="users_serverImg" style="margin-bottom:4px"><span class="user_name">${tmp.writer}</span></a>
														<span class="user_comment_regdate" style="margin-top: 5px; margin-left: 8px;">${tmp.regdate}</span>
															<span><a href="" class="comment_modify" style="${empty id || id ne tmp.writer ? 'display:none' : ''}" data-num="${tmp.num}" data-num2="${dto.num}">수정</a></span>
															<span><a href="" class="comment_comment_delete" style="${empty id || id ne tmp.writer ? 'display:none' : 'margin:0px 5px' }" data-num="${tmp.num}" data-num2="${dto.num}">삭제</a></span>
															<span><a href="" class="comment_comment" style="${empty id ? 'display:none' : ''}" data-num="${tmp.num}">답글</a></span>
														</div>
													</div>
													<div class="each_users_comments_comment" style="padding-left: 70px;">
														<a href="javascript:" class="comment_comment_target_id">@${tmp.target_id}</a>
														${tmp.content}
														<c:if test="${not empty tmp.emoSrc}">
															<img src="${tmp.emoSrc}" alt="이모티콘" style="width: 35px">
														</c:if>
													</div>
												</div>
											</c:otherwise>
										</c:choose>
										</c:otherwise>
								</c:choose>
								<div class="comment_commentBox">
								<form action="${pageContext.request.contextPath}/board/comment_insert" method="post">
									<textarea class="comment_comment_textarea" rows=5 cols=30 name="content"></textarea>
									<!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
									<input type="hidden" name="ref_group" value="${dto.num}"/>
									<!-- 원글의 작성자가 댓글의 대상자가 된다. -->
									<input type="hidden" name="target_id" value="${tmp.writer}"/>
									<!-- 댓글의 그룹이 대댓글의 그룹이 된다.-->
									<input type="hidden" name="comment_group" value="${tmp.comment_group}">
									<input type="hidden" name="condition" value="${condition}">
									<input type="hidden" name="keyword" value="${keyword}">
									<div class="comment_comment_submitBtn">
										<button class="textarea_submitBtn2" type="submit" style="margin-bottom: 15px">등록</button>
									</div>
								</form>
								</div>
								<div class="comment_modifyBox">
									<form action="${pageContext.request.contextPath}/board/comment_modify" method="post" class="modify_form">
										<textarea class="comment_comment_textarea" rows=5 cols=30 name="content">${tmp.content}</textarea>
											<input type="hidden" name="ref_group" value="${dto.num}"/>
											<input type="hidden" name="num" value="${tmp.num}"/>
											<input type="hidden" name="condition" value="${condition}">
											<input type="hidden" name="keyword" value="${keyword}">
											<div class="comment_modify_submitBtn">
												<button class="modify_submitBtn2" type="submit" style="margin-bottom: 15px">수정</button>
											</div>
									</form>
								</div>
						</c:forEach>
				</div>
			</div>
			<div class="comment_textarea">
				<div class="comment_textarea_menu">
					<div class="textarea">
						<form action="${pageContext.request.contextPath}/board/comment_insert" method="post" id="commentForm">
							<textarea name="content" rows="5" cols="30" ${empty id ? 'disabled' : ' '} id="content">${empty id? '로그인 후, 이용해주세요' : ' ' }</textarea>
							<!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
							<input type="hidden" name="ref_group" value="${dto.num }"/>
							<!-- 원글의 작성자가 댓글의 대상자가 된다. -->
							<input type="hidden" name="target_id" value="${dto.writer }"/>
							<input type="hidden" name="condition" value="${condition}">
							<input type="hidden" name="keyword" value="${keyword}">
						</form>
					</div>
					<div class="textarea_btn">
						<span class="textarea_emo">
							<a href="javascript:emoBoxAppear()" class="textarea_emoBtn"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon_off.png" alt="이모티콘"></a>
						</span> 
						<span class="textarea_font_refrain_box">(<span class="textarea_font_refrain"></span>/200)</span>
						<button class="textarea_submitBtn" type="button">등록</button>
					</div>
				</div>
				<div class="emo_box">
					<div class="emo_imgBox" style="margin-top:35px">
					<!--하이퍼링크에 #를 넣으면 새로고침x  --> 
						<a href="#" style="margin-left:30px"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon1.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon2.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon3.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon4.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon5.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon6.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon7.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon8.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon9.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon10.png"></a>
					</div>
					<div class="emo_imgBox" style="margin-top:20px">
						<a href="#" style="margin-left:30px"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon11.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon12.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon13.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon14.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon15.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon16.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon17.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon18.png"></a>
						<a href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon19.png"></a>
					</div>
					<span class="emo_close"><a href="#" class="emo_close_btn">닫기</a></span>
				</div>
			</div>
		</div>
		<div class="next_prev">
         <div class="prev">
            <span><a href="${pageContext.request.contextPath}/board/detail?num=${dto.prevNum}&condition=${condition}&keyword=${keyword}" class="prev_btn"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/page_up.png">이전글</a></span>
            <span class="prev_content_box"><a href="${pageContext.request.contextPath}/board/detail?num=${dto.prevNum}&condition=${condition}&keyword=${keyword}" class="prev_content">${dto.prevContent }</a></span>
            <span class="regdate" style="margin-top:15px;">
         	   <img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/sub_date_new.png" id="prev_regdate_img">${dto.prevRegDate}
            </span>
         </div>
         <div class="next">
            <span><a href="${pageContext.request.contextPath}/board/detail?num=${dto.nextNum}&condition=${condition}&keyword=${keyword}" class="next_btn"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/page_down.png">다음글</a></span>
            <span class="next_content_box"><a href="${pageContext.request.contextPath}/board/detail?num=${dto.nextNum}&condition=${condition}&keyword=${keyword}" class="next_content">${dto.nextContent }</a></span>
            <span class="regdate" style="margin-top:15px;">      
            	<img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/sub_date_new.png" id="next_regdate_img">${dto.nextRegDate}
            </span>
         </div>
         </div>
      </div>
      <script src="https://kit.fontawesome.com/3ae725bb79.js" crossorigin="anonymous"></script>
      <script>
         if("${dto.nextContent}"==="마지막 글입니다.") {
            document.querySelector("#next_regdate_img").classList.add("hidden_regdate_img");
            const p = `<p>마지막 글입니다</p>`;
            document.querySelector(".next_content").innerHTML = p;
            document.querySelector(".next_content").addEventListener("mouseover", (e)=>{
               e.target.classList.add("noClick");
            })
            document.querySelector(".next_btn").addEventListener("mouseover", (e)=>{
               e.target.classList.add("noClick");
            })
         }
         if("${dto.prevContent}"==="마지막 글입니다.") {
        	document.querySelector("#prev_regdate_img").classList.add("hidden_regdate_img");
            const p = `<p>마지막 글입니다</p>`;
            document.querySelector(".prev_content").innerHTML = p;
            document.querySelector(".prev_content").addEventListener("mouseover", (e)=>{
               e.target.classList.add("noClick");
            })
            document.querySelector(".prev_btn").addEventListener("mouseover", (e)=>{
               e.target.classList.add("noClick");
            })
         }
         
         //공감 버튼을 누르면 ajax형식으로 공감수를 올리는 코드
         document.querySelector("#agreeLink").addEventListener("click", ()=>{
        	 //글번호 
        	 const num = "${dto.num}";
        	 const boardInfo = {
        			 "num": num
        	 };
        	 fetch("${pageContext.request.contextPath}/board/addAgree", {
        		 method: "POST",
        		 headers: {
        			 'Content-Type': 'application/json'
        		 },
        		 body: JSON.stringify(boardInfo)
        	 })
        	 .then(res=>res.json())
        	 .then(data=>{
        		 console.log(data);
        		 if(data.agreeCount===null) {
        			 alert("이미 추천하였습니다.");
        			 location.href="${pageContext.request.contextPath}/board/detail?num=${dto.num}&condition=${condition}&keyword=${keyword}";
        		 }
        		 else {
        		 	location.href="${pageContext.request.contextPath}/board/detail?num=${dto.num}&condition=${condition}&keyword=${keyword}";
        		 }
        	 })
         })
         
         //공감박스에 마우스 올리면 색깔 변하는 코드
         document.querySelector("#agreeCount > span").addEventListener("mouseover", (e)=>{
        	 e.target.style.border = "1px solid #666";
         })
         document.querySelector("#agreeCount > span").addEventListener("mouseout", (e)=>{
        	 e.target.style.border = "1px solid #e3e3e3";
         })
         
         let newAgreeBox = "";
         //몇명이 곰강핬는지에 대한 정보가 들어있는 박스를 누르면 몇명이 공감했는지 말해주고 박스형태가 바뀌는 코드
         document.querySelector("#agreeCount").addEventListener("click", (e)=>{
        	 if(newAgreeBox==="") {
	        	 e.preventDefault();
	        	 newAgreeBox = `<span class="newAgreeBox">${dto.agree}명 공감</span>`;
	        	 e.target.innerHTML = newAgreeBox;
	        	 document.querySelector("#agreeBox").style.padding = "13px 0px 16px 2px";
        	 }
        	 else {
        		 e.target.style.pointerEvents = "none";
        	 }
         })
         
         //이모티콘 버튼의 관리 상태함수
         let isEmoClick = true;
       	 //이모티콘 버튼 요소
         const emoBtn = document.querySelector(".textarea_emoBtn");
         //이모티콘 버튼 노란색으로 바뀌는 src
         const newImgSrc = "https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon_on.png";
         //이모티콘 버튼 원래색으로 돌아오는 src
         const defaultImgSrc = "https://ssl.nexon.com/s2/game/maplestory/renewal/common/emoticon_off.png";
         
         //댓글 폼의 이모티콘 버튼 클릭하면 호출되는 함수
         function emoBoxAppear() {
        	//만약 이모티콘 박스가 나타나야한다면
        	if(isEmoClick) {
        	//이모티콘 버튼의 색깔을 노란색으로 바꾼다.
        	emoBtn.querySelector("img").src = newImgSrc;
        	//박스 나타나고
        	document.querySelector(".emo_box").style.display = "block";
        	//다음글,이전글 칸 사라지게 하기
        	document.querySelector(".next_prev").style.display = "none";
        	//마우스르 올렸을 때 사진의 테두리를 오렌지색으로 바꾸기
        	const emoImg = document.querySelectorAll(".emo_imgBox img");
        	emoImg.forEach((items)=>{
        		//마우스 올리면 테두리 색깔 바뀐다.
        		items.addEventListener("mouseover", (e)=>{
        			e.target.style.border = "1px solid #f68500";
        		})
        		//마우스 내리면 색깔 원래대로
        		items.addEventListener("mouseout", (e)=>{
        			e.target.style.border = "0px";
        		})
        		//이모티콘 클릭하면 이모티콘 버튼옆에 이모티콘 추가되는 코드
        		items.addEventListener("click", (e)=>{
        			//이모티콘을 클릭하면 기본 동작을 막는다(여기선 페이지 최상단으로 이동하는 이벤트)
        			e.preventDefault();
 					//존재할수도 있고 안할수도 있는 이모티콘
        			const newEmo = document.querySelector(".form_img_option");
 					//이모티콘 삭제버튼
 					const emoDeleteLink = document.querySelector("#emoDeleteLink");
 					//이모티콘 경로 포함된 input요소
 					const hiddenFormSrc = document.querySelector("#hiddenEmoSrc");
        			//만약 이미 이모티콘이 올려져있다면 
        			if(newEmo) {
        				//이모티콘을 삭제하고
        				newEmo.remove();
        				emoDeleteLink.remove();
        				hiddenFormSrc.remove();
        				//이미지 요소 만들어준다.
        				const imgElement = document.createElement("img");
        				//경로 속성 추가해주기
        				imgElement.src = e.target.src;
        				//form제출에 필요한 데이터 만들어주고
        				const hiddenEmoSrc = `<input type="hidden" name="emoSrc" value="\${imgElement.src}" id="hiddenEmoSrc">`;
        				//form내부에 삽입하기
        				document.querySelector("#commentForm").insertAdjacentHTML("beforeend", hiddenEmoSrc);
        				//이미지 사이즈 조정, 위치 조정
        				imgElement.classList.add("form_img_option");
        				//append()로 DOM요소를 추가하면 자식요소가 이미 있어도 그 아래로 차곡차곡 쌓인다.
        				document.querySelector(".textarea_emo").append(imgElement);
        				//이모티콘 삭제 버튼도 만들기
        				const emoDeleteBtn = `<a href="javascript:emoDelete()" id="emoDeleteLink">
        											<img id="emoDeleteBtn" src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/sum_emoticon_del.png" alt="이모티콘 삭제버튼">
        									  </a>`;
        				document.querySelector(".textarea_emo").insertAdjacentHTML("beforeend", emoDeleteBtn);
        				document.querySelector("#emoDeleteBtn").classList.add("emo_delete_btn");
        			}
        			//이모티콘이 없다면 이모티콘을 띄움과 동시에 form에 추가해줘한다.
        			else {
        				const imgElement = document.createElement("img");
        				//경로 속성 추가해주기
        				imgElement.src = e.target.src;
        				//form제출에 필요한 데이터 만들어주고
        				const hiddenEmoSrc = `<input type="hidden" name="emoSrc" value="\${imgElement.src}" id="hiddenEmoSrc">`;
        				//form내부에 삽입하기
        				document.querySelector("#commentForm").insertAdjacentHTML("beforeend", hiddenEmoSrc);
        				//이미지 사이즈 조정, 위치 조정
        				imgElement.classList.add("form_img_option");
        				//append()로 DOM요소를 추가하면 자식요소가 이미 있어도 그 아래로 차곡차곡 쌓인다.
        				document.querySelector(".textarea_emo").append(imgElement);
        				const emoDeleteBtn = `<a href="javascript:emoDelete()" id="emoDeleteLink">
													<img id="emoDeleteBtn" src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/sum_emoticon_del.png" alt="이모티콘 삭제버튼">
					  						  </a>`;
						document.querySelector(".textarea_emo").insertAdjacentHTML("beforeend", emoDeleteBtn);
						document.querySelector("#emoDeleteBtn").classList.add("emo_delete_btn");
        			}
        		})
        	})
        		//isEmoClick을 false로 바꾼다.
        		isEmoClick = false;
        	}
        	
        	else {
        		//이모티콘 버튼 색깔 원래대로 만들고
            	emoBtn.querySelector("img").src = defaultImgSrc;
        		//이모티콘 박스 없애고
        		document.querySelector(".emo_box").style.display = "none";
        		//다시 다음글, 이전글 칸 만들어주기
        		document.querySelector(".next_prev").style.display = "flex";
        		//isEmoClick을 true로 바꿔 한번 더 누르면 위의 if문 실행되도록 하기
        		isEmoClick = true;
        	}
      	}
         
        	//닫기 버튼을 눌러도 이모티콘 박스가 없어지는 코드
        	document.querySelector(".emo_close_btn").addEventListener("click", (e)=>{
        		 	e.preventDefault();
      				//버튼 색깔 원래대로 바꾸기
             		emoBtn.querySelector("img").src = defaultImgSrc;
         			//이모티콘 박스 없애고
         			document.querySelector(".emo_box").style.display = "none";
         			//다시 다음글, 이전글 칸 만들어주기
         			document.querySelector(".next_prev").style.display = "flex";
         			//isEmoClick을 true로 바꿔 한번 더 누르면 위의 if문 실행되도록 하기
         			isEmoClick = true;
        	 })
         	
        	//이모티콘 옆의 x버튼 누르면 이모티콘 사라지는 함수
         	function emoDelete() {
        	 	document.querySelector(".form_img_option").remove();
        	 	document.querySelector("#emoDeleteLink").remove();
         	}
        	
        	let saveComment = ""; // 최근 200글자를 저장하는 변수
        	
        	//textarea에 사용자가 글을 입력할 때마다 발생하는 이벤트
        	document.querySelector("#content").addEventListener("input", (e)=>{
        		//글자수를 읽어온다.
        		let commentLength = e.target.value.length;
        		const numberOfChar = document.querySelector(".textarea_font_refrain");
        		//실시간으로 글자수를 보여준다.
        		numberOfChar.innerText = commentLength;
                // 글자수가 200글자를 초과하면
                if (commentLength > 200) {
                    alert("200글자를 초과하였습니다.");

                    // 최근 200글자를 저장한다.
                    saveComment = e.target.value.substring(0, 200);
                    numberOfChar.innerText = commentLength-1;
                    // 입력된 내용을 200글자로 제한한다.
                    e.target.value = saveComment;
                } else {
                    // 글자수가 200글자 이하면 최근 내용을 업데이트한다.
                    saveComment = e.target.value;
                }
        	})
        	
        	//등록하기 버튼 누르면 댓글 폼 제출되는 코드
        	document.querySelector(".textarea_submitBtn").addEventListener("click", (e)=>{
        		const content = document.querySelector("#content");
        		const form = document.querySelector("#commentForm");
        		//로그인하지 않았다면 폼 제출을 막는다
        		if(content.value=="로그인 후, 이용해주세요") {
        			alert("로그인 후, 이용해주세요");
        			e.preventDefault();
        		}
        		//로그인 했다면 내용 읽어오고
        		else {
        			let commentValue = document.querySelector("#content").value;
        			//만약 아무것도 입력하지 않았다면(띄어쓰기만 입력해도)
        			if(commentValue.trim().length===0) {
        				alert("내용이 없습니다.");
        				//폼 제출막음
        				e.preventDefault();
        			}
        			else {
        				form.submit();
        			}
        		}
        	})

        	
        	//댓글과 대댓글의 답글 버튼 눌렀을 때 댓글 폼 나타나는 코드
        	const comment_comment = document.querySelectorAll(".comment_comment");
        	//대댓글 폼 요소
        	const commentBox = document.querySelectorAll(".comment_commentBox");
        	//수정 폼 요소
        	const modifyBox = document.querySelectorAll(".comment_modifyBox");
        	comment_comment.forEach((button, index)=>{
        		button.addEventListener("click", (e)=>{
        			//댓글 각각의 번호를 가져온다.
        			const num = button.dataset.num;
        			e.preventDefault();
        			commentBox.forEach((box, boxIndex) => {
        				modifyBox.forEach((box2, boxIndex2)=>{
	        	            if (boxIndex === index) {
	        	                box.style.display = "block";
	        	                box2.style.display = "none";
	        	            } else {
	        	                box.style.display = "none";
	        	            }
        				})
        	        });
        		})
        	})
        	
        	//댓글과 대댓글의 수정 버튼 눌렀을 때 수정 폼 나타나는 코드
        	//수정 버튼 요소 
        	const comment_modify = document.querySelectorAll(".comment_modify");
        	comment_modify.forEach((button, index)=>{
        		button.addEventListener("click", (e)=>{
        			//댓글 각각의 번호를 가져온다.
        			const num = button.dataset.num;
        			e.preventDefault();
        			modifyBox.forEach((box, boxIndex) => {
        				commentBox.forEach((box2, boxIndex2)=>{
	        	            if (boxIndex === index) {
	        	                box.style.display = "block";
	        	                box2.style.display = "none";
	        	            } else {
	        	                box.style.display = "none";
	        	            }
        				}) 
        	        });
        		})
        	})
        	
        	//댓글(대댓글 아님) 삭제버튼 누를때 실행되는 코드
        	const commentDeleteBtn = document.querySelectorAll(".comment_delete");
        	commentDeleteBtn.forEach((button,buttonIndex)=>{
        		button.addEventListener("click", (e)=>{
        			const isDelete = confirm("삭제하시겠습니까?");
        			if(isDelete) {
        				e.preventDefault();
        				//댓글번호
        				const num = button.dataset.num;
        				//글번호
        				const num2 = button.dataset.num2;
        				//db에 변수 보내기
        				const deleteInfo = {
        						"num": num,
        						"num2": num2
        				};
        				fetch("${pageContext.request.contextPath}/board/comment_delete", {
        	        		 method: "POST",
        	        		 headers: {
        	        			 'Content-Type': 'application/json'
        	        		 },
        	        		 body: JSON.stringify(deleteInfo)
        	        	 })
        	        	 .then(res=>res.json())
        	        	 .then(data=>{
        	        		 if(data.isDelete==="yes") {
        	        			 const eachComment = button.closest(".each_users_comments");
        	        			 const deleteMsg = document.createElement("div");
	        					 deleteMsg.innerText = "[삭제된 댓글입니다]";
	        					 deleteMsg.classList.add("delete_msg_style");
	        					 eachComment.innerHTML = "";
	        					 eachComment.append(deleteMsg); // deleteMsg 요소를 추가
	        					 //목적: 댓글이 삭제되도 buttonIndex유지시키기.
        	        			 const commentsCount = document.querySelector(".howManyComments");
        	        			 commentsCount.innerText = data.totalRow;
        	        	 }})
        			}
        			else {
        				e.preventDefault();
        			}
        		})
        	})
        	
        	//대댓글  삭제버튼 누를때 실행되는 코드
        	const commentDeleteBtn2 = document.querySelectorAll(".comment_comment_delete");
        	commentDeleteBtn2.forEach((button,buttonIndex)=>{
        		button.addEventListener("click", (e)=>{
        			const isDelete = confirm("삭제하시겠습니까?");
        			if(isDelete) {
        				e.preventDefault();
        				const num = button.dataset.num;
        				const num2 = button.dataset.num2;
        				//db에 변수 보내기
        				const deleteInfo = {
        						"num": num,
        						"num2": num2
        				};
        				fetch("${pageContext.request.contextPath}/board/comment_delete", {
        	        		 method: "POST",
        	        		 headers: {
        	        			 'Content-Type': 'application/json'
        	        		 },
        	        		 body: JSON.stringify(deleteInfo)
        	        	 })
        	        	 .then(res=>res.json())
        	        	 .then(data=>{
        	        		 if (data.isDelete === "yes") {
        	                     const replyForm = button.closest(".comment_comment_form");
        	                     replyForm.remove();
        	                     //화면에 출력되는 댓글 수도 1 감소시켜한다.
	        					 const commentsCount = document.querySelector(".howManyComments");
	        					 commentsCount.innerText = data.totalRow;
	        					 console.log(buttonIndex);
        	                 }        	        	 
        	        	})
        			}
        			else {
        				e.preventDefault();
        			}
        		})
        	})
        	
        	//게시글 삭제 버튼 누를 떄 실행되는 코드
        	const boardDeleteBtn = document.querySelector(".board_deleteBtn");
			boardDeleteBtn.addEventListener("click", (events) => {
    			const isDelete = confirm("삭제하시겠습니까?");
    			if (!isDelete) {
        			events.preventDefault(); // 삭제를 하지 않을 경우에는 기본 동작(링크 이동)을 막음
    			} else {
    				const num = event.currentTarget.dataset.num;
    				const deleteInfo = {
    						"num": num
    				}
    				fetch("${pageContext.request.contextPath}/board/delete", {
    	        		 method: "POST",
    	        		 headers: {
    	        			 'Content-Type': 'application/json'
    	        		 },
    	        		 body: JSON.stringify(deleteInfo)
    	        	 })
    	        	 .then(()=>{
    	        		 console.log("Deletion successful.");
    	                 location.href = "${pageContext.request.contextPath}/"; // 삭제 후 리다이렉트
    	        	 })
    			}
			});
			
			//유저정보 하이퍼 링크 비활성화 코드
			document.querySelectorAll(".user_server").forEach((items,index)=>{
				items.addEventListener("mouseover", (e)=>{
					e.target.style.cursor = "auto";
				})
			})
			
			document.querySelectorAll(".comment_comment_target_id").forEach((items,index)=>{
				items.addEventListener("mouseover", (e)=>{
					e.target.style.cursor = "auto";
				})
			})
			</script>
</body>
</html>