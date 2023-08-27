<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<style>
	body {
		background-image: url("https://i.pinimg.com/originals/70/78/d9/7078d93a9111ee7a4235acf20c1ecf76.jpg");
	}
	.container {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		height: 100vh;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" />
</head>
<body>
<div class="container">
	<div class="loginBox">
		<h1>로그인</h1>
	</div>
	<form action="login" method="post" id="myForm">
	<c:choose>
		<c:when test="${empty encodeurl}">
			<input type="hidden" class="url" name="url" value="${pageContext.request.contextPath}/">
		</c:when>
		<c:otherwise>
			<input type="hidden" class="url" name="url" value="${encodeurl}">
		</c:otherwise>
	</c:choose>
	<div class="idBox">
		<label for="id" class="form-label"></label> 
		<input type="text" class="form-control" id="id" placeholder="아이디" name="id">
	</div>
	<div class="pwdBox">
		<label for="pwd" class="col-form-label"></label> 
		<input type="password" id="pwd" class="form-control" placeholder="비밀번호" name="password">
	</div>
  <div class="d-grid gap-2">
  	<button class="btn btn-primary" style="margin-top:10px;" type="submit" id="submitBtn">로그인</button>
  </div>
	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src=" https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
<script>
	//여기서 파일이 아닌 일반 input타입의 파라미터는 먼저 javascript객체로 변환 const data = {"name": "~~"}등으로 변환하고 JSON형태의 문자열로 변환한후 BODY본문에
	//요청해야한다.
	
	$("#submitBtn").on("click", (e)=>{
		e.preventDefault();
		const userInfo = {
				"id": document.querySelector("#id").value,
				"password": document.querySelector("#pwd").value,
				"url": document.querySelector(".url").value
		}
		const jsonUserInfo = JSON.stringify(userInfo);
		fetch("${pageContext.request.contextPath}/users/login", {
			method: "POST",
			headers: {
				    "Content-Type": "application/json"
		    },
			body: jsonUserInfo
		})
		.then(res=>res.json())
		.then(data=>{
			console.log(data);
			if(data.msg=="로그인 성공") {
				alert("로그인되었습니다");
				if(data.url.length>8) {
					location.href=data.url;
				}
				else{
					location.href=data.url;
				}
			}
			else{
				alert(data.msg);
				location.href="${pageContext.request.contextPath}/users/login_form?url=" + data.url;
			}
		})
	})
   </script>
</body>
</html>