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

.form-joinReject {
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
	
	UserDAO user = new UserDAO(); //DAO 객체 생성
	
	int pageNumber = 1; //기본 첫페이지
	int blockNumber = 1; // 기본 블럭;
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	if(request.getParameter("blockNumber") != null){
		blockNumber = Integer.parseInt(request.getParameter("blockNumber"));
	}
	/* 총 레코드 수 */
	int rowCount = user.getRejectCount();
	
	/* 총 페이지 수 구하는 과정 */
	int pageSize = 10; //페이지는 레코드 10개 단위로
	int pageCount = rowCount / pageSize;
	if(rowCount % pageSize > 0)
		pageCount++;
	
	/* 총 블럭 수 구하는 과정 */
	int blockSize = 5; // 블럭은 5페이지 단위로
	int blockCount = pageCount / blockSize;
	if(pageCount % blockSize > 0)
		blockCount++;
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

<main class="form-joinReject">
    <table class="table" style="text-align: center;">
    <thead>
    <tr class="table-info">
     <th scope="col">회원번호</th><th scope="col">ID</th><th scope="col">이름</th><th scope="col">생년월일</th><th scope="col">성별</th><th scope="col">소속</th><th scope="col">휴대폰번호</th><th scope="col">승인여부</th>
    </tr>
    </thead>
    <tbody>
    <%
    	ArrayList<User> list = user.getRejectList(pageNumber);
    	for(int i=0; i<list.size(); i++){
    %>
    	<tr>
    	<td><%=list.get(i).getUserNo() %></td>
    	<td><%=list.get(i).getUserID() %></td>
    	<td><%=list.get(i).getUserName() %></td>
		<td><%=list.get(i).getUserBirth() %></td>
		<td><%=list.get(i).getUserGender() %></td>
		<td><%=list.get(i).getUserDept() %></td>
		<td><%=list.get(i).getUserPhoneNumber() %></td>
		<td>
		<div class="btn-group" role="group" aria-label="Permission">
		<a onclick="return confirm('재승인하시겠습니까?')" href="joinRejectProc.jsp?pageNumber=<%=pageNumber%>&blockNumber=<%=blockNumber%>&userID=<%=list.get(i).getUserID()%>&Permission=1" class="btn btn-primary">승인</a>
			<a onclick="return confirm('삭제하시겠습니까?')" href="joinRejectProc.jsp?pageNumber=<%=pageNumber%>&blockNumber=<%=blockNumber%>&userID=<%=list.get(i).getUserID()%>&Permission=-1" class="btn btn-danger">삭제</a>
		</div>
		</td>
    	</tr>
    <%
    	}
    %>
    <tr>
    <!-- 페이징 -->
    <td colspan="8">
     <div class="btn-toolbar" style="display:inline-block;" role="toolbar" aria-label="joinReject-PagingButton">
  		<div class="btn-group me-2" role="group">
    <%
    	int startPage = ((pageNumber-1)/blockSize)*blockSize +1;
    	int endPage = startPage + blockSize - 1;
    	if(endPage > pageCount){
    		endPage = pageCount;
    	}
    	if(rowCount > 0){	
    		if(startPage > blockSize){
    %>
    	<a class="btn btn-outline-primary" href="joinReject.jsp?pageNumber=<%=(blockNumber-1)*5 %>&blockNumber=<%=blockNumber-1%>" role="button">이전</a>
    <% 			
    		}
    %>
    
    <%
    	for(int i = startPage; i<= endPage; i++){
    		if(i == pageNumber){
    %>
    	 <button type="button" class="btn btn-primary"><%=i%></button>
   		
   	<% 
    		}else{
    %>
    	<a class="btn btn-outline-primary" href="joinReject.jsp?pageNumber=<%=i%>&blockNumber=<%=blockNumber%>" role="button"><%=i%></a>
    <%			
    			}
    		}
    %>
    <%
    	if(endPage < pageCount){
    %>
    	<a class="btn btn-outline-primary" href="joinReject.jsp?pageNumber=<%=(blockNumber*5)+1 %>&blockNumber=<%=blockNumber+1 %>" role="button">다음</a>
    <%    
    	}
    }
    %>
    	</div>
    </div>
    </td>
    </tr>
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