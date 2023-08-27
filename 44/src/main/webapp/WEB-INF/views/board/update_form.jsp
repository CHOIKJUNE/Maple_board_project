<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/update_form</title>
<style>
	 .container {
      display: flex;
      flex-direction: column;
      justify-content: end;
       margin-bottom: 10px;
        height: 30vh;  
   }
   textarea {
      width: 768px;
      height: 300px;
   }
   .content {
      display: flex;
      justify-content: center;
   }
   .title {
      border: 1px solid #e6e6e6;
      padding: 10px;
      border-radius: 4px;
      font-size: 16px;
       color: #666666;
   }
   body {
      color: #666666;
   }
   body h1 {
      font-size: 34px;
       color: #333;
   }
   .buttonSet {
      margin-top: 6px;
      padding-left: 320px;
   }
   #resetBtn {
      min-width: 53px;
       font-size: 16px;
       color: #fff;
          text-align: center;
         background-color: #747a86;
       border-radius: 2px;
          padding: 12px 14px 12px 14px;
       border: 1px solid #747a86;
       display: inline-block;
       line-height: 1;
       cursor: pointer;
   }
   #submitBtn {
       min-width: 53px;
       font-size: 16px;
       color: #fff;
       text-align: center;
       background-color: #455d9d;
       border-radius: 2px;
       padding: 12px 14px 12px 14px;
       border: 1px solid #455d9d;
       display: inline-block;
       line-height: 1;
       cursor: pointer;
   }
</style>
</head>
<body style="margin-left:60vh;">
	<div class="container">
		<h1>자유 게시판</h1>
   			<form action="" method="post" id="boardForm">
      			<label>제목</label>
         			<input class="title form-control" name="title" type="text" value="${dto.title}">
         			<input type="hidden" id="writer" name="writer" value="${id}">
	</div>
    	<label for="content" class="form-label"></label>
  			<textarea class="form-control" id="content" name="content" rows="10">${dto.content}</textarea>
     			<div class="buttonSet">
        			<button type="reset" id="resetBtn">취소</button>
        			<button type="button" id="submitBtn">수정</button>
      			</div>
   			</form>
</body>
 <script>
      //게시글 제출하면 실행되는 코드
      document.querySelector("#submitBtn").addEventListener("click",(e)=>{
         e.preventDefault();
         const boardInfo = {
        	   "num": "${dto.num}",
               "title":document.querySelector(".title").value,
               "writer":document.querySelector("#writer").value,
               "content":document.querySelector("#content").value
         };
         const jsonBoardInfo = JSON.stringify(boardInfo);
         fetch("${pageContext.request.contextPath}/board/update", {
            method:"POST",
            headers:{
                "Content-Type": "application/json"
             },
             body:jsonBoardInfo
         })
         .then(res=>res.json())
         .then(data=>{
            console.log(data);
            if(data.msg=="제목 또는 내용을 입력해주세요.") {
            	alert(data.msg);
            	location.href = "${pageContext.request.contextPath}/board/update_form?num=${dto.num}";
            }
            else {
            	console.log("성공")
            	location.href = "${pageContext.request.contextPath}/";
            }
          })
      })
   </script>    
</html>