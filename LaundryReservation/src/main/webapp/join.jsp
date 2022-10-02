<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="UTF-8">
<meta name = "viewport" content="width=device-width, initial-scale=1.0">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="navbar-top-fixed.css?a" rel="stylesheet">
<title>세탁실</title>
<style>
body {
  display: flex;
  align-items: center;
  padding-top: 60px;
  background-color: #f5f5f5;
}

.form-join {
  width: 100%;
  max-width: 330px;
  padding: 15px;
  margin: auto;
}
<<<<<<< HEAD
.form-join h5{
	margin-top : 5px;
	margin-bottom : 5px;
}

</style>
</head>
<body>
<%
	String sessionID = null;
	if(session.getAttribute("sessionID") != null)
		sessionID = (String)session.getAttribute("sessionID");
	
	if(sessionID !=null){
%>
<script>
	alert("이미 로그인이 되어있습니다.");
	location.href="Main.jsp";
</script>
<%
	}
%>

<!-- nav -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-primary">
<div class="container-fluid">
	<a href="Main.jsp" class="navbar-brand">SP 무인 세탁실</a>
	<!-- 반응형 우측 아이콘 -->
	<button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
	aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
	 		 <span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id = "navbarCollapse">
	<ul class="navbar-nav me-auto mb-2 mb-lg-0">
		 <li class="nav-item">
            <a class="nav-link" href="reservation.jsp">예약하기</a>
		</li>
		<li class="nav-item dropdown">
		 	<a class="nav-link dropdown-toggle" href="#" id="loginDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	로그인
          	</a>
          <!-- 만일 로그인이 되어 있지 않다면  하단에 user session에 따른 java코드 추가-->
 		  <ul class="dropdown-menu dropdown-menu-login" aria-labelledby="loginDropdownMenuLink">
            <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
            <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
            <!-- 로그인이 된 상태라면 하단에 user session에 따른 java코드 추가-->
           <!--  <li><a class="dropdown-item" href="memberinfo.jsp">내 정보</a></li>
            <li><a class="dropdown-item" href="logoutProc.jsp">로그아웃</a></li> -->
          </ul>
        </li>
	</ul>	
	<!-- 추후에 검색기능 만들때 따로 수정 예정 -->
	<form class="d-flex">
	      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
	      <button class="btn btn-outline-success" type="submit">Search</button>
	</form>
	</div> 
</div>
</nav>
<!-- end nav -->

<main class="form-join">
  <form action="joinProc.jsp" method="post">
    <h1 class="h3 mb-3 fw-normal" align="center">회원가입</h1>
    <h5>아이디</h5>
    <div class="form-floating">
    <input type="text" class="form-control" id="userID" name="userID" placeholder="아이디" maxlength="20" required
    	oninvalid="this.setCustomValidity('아이디를 입력하세요.')"
      	oninput="this.setCustomValidity('')">
    <label for="userID">아이디는 최대 20자리 입니다.</label>
    </div>
    <h5>비밀번호</h5>
    <div class="form-floating">
      <input type="password" class="form-control" id="userPassword" name="userPassword" placeholder= "비밀번호" maxlength="20" required
      	oninvalid="this.setCustomValidity('비밀번호를 입력하세요.')"
      	oninput="this.setCustomValidity('')">
      <label for="userPassword">비밀번호는 최대 20자리 입니다.</label>
    </div>
    <h5>이름</h5>
    <div class="form-floating">
      <input type="text" class="form-control" id="userName" name="userName" placeholder= "이름" maxlength="20" required
      	oninvalid="this.setCustomValidity('이름을 입력하세요.')"
      	oninput="this.setCustomValidity('')">
      <label for="userName">이름을 입력하세요.</label>
    </div>
    <h5>생년월일</h5>
    <div class="form-floating">
      <input type="text" class="form-control" id="userBirth" name="userBirth" placeholder= "생년월일" maxlength="8" required
      	oninvalid="this.setCustomValidity('생년월일을 입력하세요.')"
      	oninput="this.setCustomValidity('')">
      <label for="userName">생년월일 8자를 입력해주세요.</label>
    </div>
    <h5>성별</h5>
    <div class="form-floating">
		<div class="form-check form-check-inline">
		  <input class="form-check-input" type="radio" id="userGender" name="userGender" value="M">
		  <label class="form-check-label" for="userGender">남</label>
	</div>
		<div class="form-check form-check-inline">
		  <input class="form-check-input" type="radio" id="userGender" name="userGender" value="F">
		  <label class="form-check-label" for="userGender">여</label>
	</div>
    </div>
    <h5>소속</h5>
    <div class="form-floating">
      <input type="text" class="form-control" id="userDept" name="userDept" placeholder= "소속" maxlength="20" required
      	oninvalid="this.setCustomValidity('소속을 입력하세요')"
      	oninput="this.setCustomValidity('')">
      <label for="userDept">소속을 입력하세요.</label>
    </div>
    <h5>전화번호</h5>
    <div class="form-floating">
      <input type="text" class="form-control" id="userPhoneNumber" name="userPhoneNumber" placeholder= "전화번호" maxlength="11" required
      	oninvalid="this.setCustomValidity('전화번호를 입력하세요.')"
      	oninput="this.setCustomValidity('')">
      <label for="userPhoneNumber">-를 제외 하고 입력해주세요.</label>
    </div>
    <h5>이메일</h5>
	<div class="form-floating">
      <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder= "이메일" maxlength="320">
=======
.form-join div{
	margin-top : 20px;
	margin-bottom : 20px;
}

</style>
</head>
<body>
<!-- nav -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-primary">
<div class="container-fluid">
	<a href="Main.jsp" class="navbar-brand">SP 무인 세탁실</a>
	<!-- 반응형 우측 아이콘 -->
	<button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
	aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
	 		 <span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id = "navbarCollapse">
	<ul class="navbar-nav me-auto mb-2 mb-lg-0">
		 <li class="nav-item">
            <a class="nav-link" href="reservation.jsp">예약하기</a>
		</li>
		<li class="nav-item dropdown">
		 	<a class="nav-link dropdown-toggle" href="#" id="loginDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	회원정보
          	</a>
          <!-- 만일 로그인이 되어 있지 않다면  하단에 user session에 따른 java코드 추가-->
 		  <ul class="dropdown-menu dropdown-menu-login" aria-labelledby="loginDropdownMenuLink">
            <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
            <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
            <!-- 로그인이 된 상태라면 하단에 user session에 따른 java코드 추가-->
            <li><a class="dropdown-item" href="memberinfo.jsp">내 정보</a></li>
            <li><a class="dropdown-item" href="join.jsp">로그아웃</a></li>
          </ul>
        </li>
	</ul>	
	<!-- 추후에 검색기능 만들때 따로 수정 예정 -->
	<form class="d-flex">
	      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
	      <button class="btn btn-outline-success" type="submit">Search</button>
	</form>
	</div> 
</div>
</nav>
<!-- end nav -->

<main class="form-join">
  <form action="joinProc.jsp" method="post">
    <h1 class="h3 mb-3 fw-normal" align="center">회원가입</h1>
    <h5>아이디</h5>
    <div class="form-floating">
    <input type="text" class="form-control" id="userID" placeholder="아이디" maxlength="20">
    <label for="userID">아이디는 최대 20자리 입니다.</label>
    </div>
    <h5>비밀번호</h5>
    <div class="form-floating">
      <input type="password" class="form-control" id="userPassword" placeholder= "비밀번호" maxlength="20">
      <label for="userPassword">비밀번호는 최대 20자리 입니다.</label>
    </div>
    <h5>전화번호</h5>
    <div class="form-floating">
      <input type="text" class="form-control" id="userPhoneNumber" placeholder= "전화번호" maxlength="11">
      <label for="userPhoneNumber">-를 제외 하고 입력해주세요.</label>
    </div>
    <h5>이메일</h5>
	<div class="form-floating">
      <input type="email" class="form-control" id="userEmail" placeholder= "이메일" maxlength="50">
>>>>>>> refs/remotes/origin/main
      <label for="userEmail">example@gmail.com</label>
    </div>
    <button class="w-100 btn btn-lg btn-primary" type="submit" style="margin-bottom:10px;">회원가입</button>
  </form>
  <button class="w-100 btn btn-lg btn-primary" onclick="location.href = 'Main.jsp'">취소</button>
</main>

<footer class="container fluid justify-content-center fixed-bottom">
<p align="center">CopyRight 2022. SANGYONG PARK. All rights reserved.</p>
</footer>
<!-- footer end -->

<!-- Bootstrap core javascript -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>