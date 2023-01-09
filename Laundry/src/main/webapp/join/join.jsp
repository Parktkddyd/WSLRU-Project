<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="UTF-8">
<meta name = "viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<title>세탁실</title>
<style>
body {
  display: flex;
  align-items: center;
  padding-top: 5rem;
  background-color: #f5f5f5;
}

.form-join {
  width: 100%;
  max-width: 330px;
  padding: 15px;
  margin: auto;
}
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
	location.href="../Main.jsp";
</script>
<%
	}
%>

<jsp:include page="../layout/nav.jsp"/>

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
      <label for="userEmail">example@gmail.com</label>
    </div>
    <button class="w-100 btn btn-lg btn-primary" type="submit" style="margin-bottom:10px;">회원가입</button>
  </form>
  <button class="w-100 btn btn-lg btn-primary" onclick="location.href = 'Main.jsp'">취소</button>
</main>

<jsp:include page="../layout/footer.jsp"/>

<!-- Bootstrap core javascript -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>