<%@page import="user.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="User" class="user.User"></jsp:useBean>
<jsp:setProperty property="*" name="User"/>
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
  padding-top: 20px;
  background-color: #f5f5f5;
}

.form-joinManage {
  width: 100%;
  max-width: 950px;
  padding: 60px;
  margin: auto;
}
</style>
</head>
<body>
<%
	String sessionID = null;
	if(session.getAttribute("sessionID") != null)
		sessionID = (String)session.getAttribute("sessionID");
	
	if(sessionID ==null){
%>
<script>
	alert("접근 권한이 없습니다.");
	location.href="Main.jsp";
</script>
<%
	}else{
		if(!sessionID.equals("admin")){
%>
	<script>
	alert("접근 권한이 없습니다.");
	location.href="Main.jsp";
	</script>
<%
		}
	}
	
	int pageNumber = 1; //기본 첫페이지
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
            	회원정보
          	</a>
          <!-- 만일 로그인이 되어 있지 않다면  하단에 user session에 따른 java코드 추가-->
 		  <ul class="dropdown-menu dropdown-menu-login" aria-labelledby="loginDropdownMenuLink">
            <!-- <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
            <li><a class="dropdown-item" href="join.jsp">회원가입</a></li> -->
           	<!-- 로그인이 된 상태라면 하단에 user session에 따른 java코드 추가-->
            <li><a class="dropdown-item" href="memberinfo.jsp">내 정보</a></li>
            <li><a class="dropdown-item" href="logoutProc.jsp">로그아웃</a></li>
          </ul>
          <% 
        	if(sessionID!=null && sessionID.equals("admin")){
        %>
        	<li class="nav-item dropdown">
       		<a class="nav-link dropdown-toggle" href="#" id="ManageMemberDropdownLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	회원 관리
          	</a>
          	<ul class="dropdown-menu dropdown-menu-login" aria-labelledby="ManageMemberDropdownLink">
            <li><a class="dropdown-item" href="joinManage.jsp">회원가입 관리</a></li>
            <li><a class="dropdown-item" href="joinReject.jsp">거절회원 관리</a></li>
         	</ul>
         	</li>
        <%
        	}
        %>
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

<main class="form-joinManage">
    <table class="table" style="text-align: center;">
    <thead>
    <tr class="table-info">
    <th scope="col">ID</th><th scope="col">이름</th><th scope="col">생년월일</th><th scope="col">성별</th><th scope="col">소속</th><th scope="col">휴대폰번호</th><th scope="col">승인여부</th>
    </tr>
    </thead>
    <tbody>
    <%
    	UserDAO user = new UserDAO();
    	ArrayList<User> list = user.getJoinList(pageNumber);
    	for(int i=0; i<list.size(); i++){
    %>
    	<tr>
    	<td><%=list.get(i).getUserID() %></td>
    	<td><%=list.get(i).getUserName() %></td>
		<td><%=list.get(i).getUserBirth() %></td>
		<td><%=list.get(i).getUserGender() %></td>
		<td><%=list.get(i).getUserDept() %></td>
		<td><%=list.get(i).getUserPhoneNumber() %></td>
		<td>
		<div class="btn-group" role="group" aria-label="Permission">
		<a onclick="return confirm('승인하시겠습니까?')" href="joinManageProc.jsp?userID=<%= list.get(i).getUserID()%>&Permission=1" class="btn btn-primary">승인</a>
		<a onclick="return confirm('승인 거절하시겠습니까?')" href="joinManageProc.jsp?userID=<%=list.get(i).getUserID()%>&Permission=-1" class="btn btn-danger">거절</a>
		</div>
		</td>
    	</tr>
    <%
    	}
    %>
    </tbody>
    </table>
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