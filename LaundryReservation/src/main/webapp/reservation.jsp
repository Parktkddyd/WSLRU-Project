<%@page import="java.io.PrintWriter"%>
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
	.form-Reservation{
		margin-top: 5rem;
	}
	table td{
		height : 500px;
	}
	.card{
		margin: 0 auto;
		margin-top: 5rem;
		width : 18rem;
		height : 18rem;
	}
</style>
</head>
<body>

<%
	String sessionID = null;
	if(session.getAttribute("sessionID") != null)
		sessionID = (String)session.getAttribute("sessionID");
	else{
		PrintWriter Out = response.getWriter();
		Out.println("<script>");
		Out.println("alert('로그인을 해주세요')");
		Out.println("location.href='login.jsp'");
		Out.println("</script>");
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
          <!-- 만일 로그인이 되어 있지 않다면  하단에 user session에 따른 java코드 추가-->
 		  <%
          	if(sessionID == null){
          %>
          <li class="nav-item dropdown">
		 	<a class="nav-link dropdown-toggle" href="#" id="loginDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	로그인
          	</a>
 		  	<ul class="dropdown-menu dropdown-menu-login" aria-labelledby="loginDropdownMenuLink">
	            <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
	            <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
	        </ul>
            <%
          	} else{
            %>
            <li class="nav-item dropdown">
		 	<a class="nav-link dropdown-toggle" href="#" id="loginDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	회원정보
          	</a>
 		  	<ul class="dropdown-menu dropdown-menu-login" aria-labelledby="loginDropdownMenuLink">
            <!-- 로그인이 된 상태라면 하단에 user session에 따른 java코드 추가-->
            <li><a class="dropdown-item" href="memberinfo.jsp">내 정보</a></li>
            <li><a class="dropdown-item" href="logoutProc.jsp">로그아웃</a></li>
            </ul>
            <%
            	}
 		  	%>
          
        </li>
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
<main class="form-Reservation">
    <table class="table table-borderless" style="text-align: center;">
    	<tr>
	    	<td style="border-right : 1px solid;">
	    		<div class="card border-primary">
				  <div class="card-header text-white bg-primary">예약</div>
				  <div class="card-body text-primary">
				    <ul class="list-unstyled">
				    <li>예약을 하시려면</li>
				    <li>아래의 <b>예약하기</b> 버튼을</li>
				    <li>클릭해 주세요.</li>
				    </ul>
				  </div>
				  <a href="#" class="btn btn-primary">예약하기</a>
				</div>
	    	</td>
	    	<td>
	    		<div class="card border-primary">
				  <div class="card-header text-white bg-primary">예약내역</div>
				  <div class="card-body text-primary">
				    <ul class="list-unstyled">
				    <li>예약내역을 확인하시려면</li>
				    <li>아래의 <b>내역확인하기</b> 버튼을</li>
				    <li>클릭해 주세요.</li>
				    </ul>
				  </div>
				  <a href="#" class="btn btn-primary">내역확인하기</a>
				</div>
	    	</td>
    	</tr>
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