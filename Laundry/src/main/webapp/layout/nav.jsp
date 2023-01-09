<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String sessionID = null;
	if(session.getAttribute("sessionID") != null)
		sessionID = (String)session.getAttribute("sessionID");
%>
<!-- nav -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-primary">
<div class="container-fluid">
	<a href="${pageContext.request.contextPath}/Main.jsp" class="navbar-brand">SP 무인 세탁실</a>
	<!-- 반응형 우측 아이콘 -->
	<button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
	aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
	 		 <span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id = "navbarCollapse">
	<ul class="navbar-nav me-auto mb-2 mb-lg-0">
		 <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/reservation/reservation.jsp">예약하기</a>
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
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login/login.jsp">로그인</a></li>
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/join/join.jsp">회원가입</a></li>
	        </ul>
	       </li>
            <%
          	} else{
            %>
            <li class="nav-item dropdown">
		 	<a class="nav-link dropdown-toggle" href="#none" id="MemberInfoDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	회원정보
          	</a>
 		  	<ul class="dropdown-menu dropdown-menu-login" aria-labelledby="MemeberInfoDropdownMenuLink">
            <!-- 로그인이 된 상태라면 하단에 user session에 따른 java코드 추가-->
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/question/myQuestion.jsp">나의Q&A</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login/logoutProc.jsp">로그아웃</a></li>
            </ul>
            <%
            	}
 		  	%>
        <li class="nav-item dropdown">
		 	<a class="nav-link dropdown-toggle" href="#" id="BoardDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	게시판
          	</a>
          	<ul class="dropdown-menu " aria-labelledby="BoardDropdownMenuLink">
          		<li><a class="dropdown-item" href="${pageContext.request.contextPath}/notice/noticeList.jsp">공지사항</a></li>
	          	<li><a class="dropdown-item" href="${pageContext.request.contextPath}/question/questionList.jsp">Q&A</a></li>
	        </ul>
         </li>
        <% 
        	if(sessionID!=null && sessionID.equals("admin")){
        %>    
        <li class="nav-item dropdown">
       		<a class="nav-link dropdown-toggle" href="#" id="ManageMemberDropdownLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	회원 관리
          	</a>
          	<ul class="dropdown-menu dropdown-menu-login" aria-labelledby="ManageMemberDropdownLink">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/joinManage/joinManage.jsp">회원가입 관리</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/joinManage/joinReject.jsp">거절회원 관리</a></li>
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

<!-- Bootstrap core javascript -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>