<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	li {
 		list-style-type: none;
	}
	li a img {
		margin-right: 5px;
    	margin-bottom: 4px;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" />
</head>
<body>
<div class="container">
	<div class="signupBox">
		<h1>회원가입</h1>
	</div>
	<form action="signup" method="post">
	<div class="idBox">
		<label for="id" class="form-label"></label> 
		<input type="text" class="form-control" id="id" placeholder="아이디" name="id">
		<small class="form-text text-muted">영문자 소문자로 시작하고 5글자~10글자 이내로 입력하세요</small>
        <div class="valid-feedback">사용 가능한 아이디 입니다.</div>
        <div class="invalid-feedback">사용할 수 없는 아이디 입니다.</div>
	</div>
	<div class="pwdBox">
		<label for="pwd" class="col-form-label"></label> 
		<input type="password" id="pwd" class="form-control" placeholder="비밀번호" name="password">
		<small class="form-text text-muted">특수 문자를 하나 이상 조합하세요.</small>
        <div class="invalid-feedback">비밀 번호를 확인 하세요</div>
	</div>
	<div>
        <label class="control-label" for="pwd2"></label>
        <input class="form-control" type="password" name="password2" id="pwd2" placeholder="비밀번호 확인"/>
    </div>
	<div class="serverBox" style="margin-top:12px;">
	<li class="nav-item dropdown">
    <a class="server nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">서버 선택</a>
    <ul class="dropdown-menu">
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_16.png">버닝</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_16.png">버닝2</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_16.png">버닝3</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_8.png">스카니아</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_12.png">베라</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_9.png">루나</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_10.png">제니스</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_11.png">크로아</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_7.png">유니온</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_13.png">엘리시움</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_6.png">이노시스</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_5.png">레드</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_4.png">오로라</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_14.png">아케인</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_15.png">노바</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_3.png">리부트</a></li>
      <li><a class="dropdown-item" href="#"><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/world_icon/icon_3.png">리부트2</a></li>
    </ul>                                            
  </li>
  </div>
  <div id="hiddenServer">
  	
  </div>
  <div class="d-grid gap-2">
  	<button class="btn btn-primary" style="margin-top:10px;" type="submit" disabled>회원 가입</button>
  </div>
	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src=" https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
<script>
	let isServerValid = false;
    let isIdValid=false;
    let isPwdValid=false;
	
      //폼 전체의 유효성 여부를 판단해서 제출버튼의 disabled 속성을 관리하는 함수 
      function checkFormState(){
         if(isIdValid && isPwdValid && isServerValid){
            $("button[type=submit]").removeAttr("disabled");
         }else{
            //속성명만 추가할때는 value 에 빈 문자열을 작성하면 된다.
            $("button[type=submit]").attr("disabled", "");
         }
      }
      
      // id 입력란에 입력을 했을때 실행할 함수 등록
      $("#id").on("input", (e)=>{
         //입력한 아이디 읽어오기
         const inputId=e.target.value;
         //정규표현식
         const reg=/^[a-z].{4,9}$/;
         //정규표현식 통과 여부를 변수에 저장
         isIdValid=reg.test(inputId);
         //만일 유효하다면 
         if(isIdValid){
            $(e.target).removeClass("is-invalid").addClass("is-valid");
         }else{//유효하지 않다면
            $(e.target).removeClass("is-valid").addClass("is-invalid");
         }
         checkFormState();
      });
   
      //비밀번호 입력란과 비밀번호 확인란에 입력했을때 실행할 함수 등록(다중선택)
      $("#pwd, #pwd2").on("input", ()=>{
         //비밀번호 입력란과 확인란에 입력한 비밀번호를 모두 읽어온다.
         const pwd=$("#pwd").val();
         const pwd2=$("#pwd2").val();
         //특수문자가 포함되었는지 여부를 검증할 정규 표현식
         const reg=/[\W]/;
         //정규표현식도 통과하고 비밀번호 입력란과 확인란도 같은지 확인해서 비밀번호 유효성 여부에 반영
         isPwdValid = reg.test(pwd) && (pwd == pwd2);
         if(isPwdValid){
            $("#pwd").removeClass("is-invalid").addClass("is-valid");
         }else{
            $("#pwd").removeClass("is-valid").addClass("is-invalid");
         }
         checkFormState();
      });
      
      //서버 선택할때마다 바뀌는 로직
	const arr = document.querySelectorAll(".dropdown-item");
	for(let i=0; i<arr.length; i++) {
		arr[i].addEventListener("click", (e)=>{
			$(".server").text(e.target.innerText);
			const imgSrc = e.target.querySelector("img").getAttribute("src");
			const serverInfo = `<input type="hidden" value="\${imgSrc}" name="server">`;
			document.querySelector("#hiddenServer").innerHTML = serverInfo;
			isServerValid = true;
			checkFormState();
		})
	}
   </script>
</body>
</html>