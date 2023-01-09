<%@page import="java.io.PrintWriter"%>
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
  padding-top: 7rem;
  background-color: #f5f5f5;
}

.form-signin {
  width: 100%;
  max-width: 330px;
  padding: 15px;
  margin: auto;
}

.form-signin .form-floating:focus-within {
  z-index: 2;
}

.form-signin input[type="text"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}  
</style>
</head>
<body>
<%
		String sessionID = null;
		if(session.getAttribute("sessionID") != null)
			sessionID = (String)session.getAttribute("sessionID");
		
		if(sessionID != null){
			PrintWriter Out =response.getWriter();
			Out.println("<script>");
			Out.println("alert('이미 로그인이 되어있습니다.')");
			Out.println("location.href='../Main.jsp'");
			Out.println("</script>");
		}
%>
<jsp:include page="../layout/nav.jsp"/>
<main class="form-signin">
  <form action="loginProc.jsp" method="post">
    <h1 class="h3 mb-3 fw-normal" align="center">로그인</h1>

    <div class="form-floating">
      <input type="text" class="form-control" id="userID" name = "userID" placeholder="아이디" maxlength="20" required
      	oninvalid="this.setCustomValidity('아이디를 입력하세요.')"
      	oninput="this.setCustomValidity('')">
      <label for="userID">아이디</label>
    </div>
    <div class="form-floating">
      <input type="password" class="form-control" id="userPassword" name = "userPassword" placeholder="비밀번호" maxlength="20" required
     	oninvalid="this.setCustomValidity('비밀번호를 입력하세요.')"
      	oninput="this.setCustomValidity('')">
      <label for="userPassword">비밀번호</label>
    </div>

    <button class="w-100 btn btn-lg btn-primary" type="submit" style="margin-bottom:10px">로그인</button>
  </form>
  <button class="w-100 btn btn-lg btn-primary" onclick="location.href = '${pageContext.request.contextPath}/join/join.jsp'">회원가입</button>
</main>

<jsp:include page="../layout/footer.jsp"/>

<!-- Bootstrap core javascript -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>