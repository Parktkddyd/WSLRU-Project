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
	<a href="#" class="navbar-brand">SP 무인 세탁실</a>
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
<div class="container">
	<div class="row">
		<div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 div_left">
			<div class="bulletin">
			<header class="sectionHeader">
				<a id="noticeHeader" style="margin-left:2%; font-size:20px; font-weight : bold; cursor: pointer; color:black;">공지사항</a>
				<a id="qnaHeader" style="margin-left:2%;font-size:20px;font-weight: bold;color:#BDBDBD;cursor: pointer;">Q&A</a>
			</header>
			<div style=padding:10px;">
			<table class="table" id="noticetable" style="margin:0";>
			<tr class="notice_tr">
				<td style="border-top:none;">공지사항 예시</td>
			</tr>
			<tr class="notice_tr">
				<td style="border-top:none;">공지사항 예시</td>
			</tr>
			<tr class="notice_tr">
				<td style="border-top:none;">공지사항 예시</td>
			</tr>
			<tr class="notice_tr">
				<td style="border-top:none;">공지사항 예시</td>
			</tr>
			<tr class="notice_tr">
				<td style="border-top:none;">공지사항 예시</td>
			</tr>
			<tr class="qna_tr" style="display:none;">
				<td style="border-top:none;">Q&A 예시</td>
			</tr>
			<tr class="qna_tr" style="display:none;">
				<td style="border-top:none;">Q&A 예시</td>
			</tr>
			<tr class="qna_tr" style="display:none;">
				<td style="border-top:none;">Q&A 예시</td>
			</tr>
			<tr class="qna_tr" style="display:none;">
				<td style="border-top:none;">Q&A 예시</td>
			</tr>
			<tr class="qna_tr" style="display:none;">
				<td style="border-top:none;">Q&A 예시</td>
			</tr>
			</table>
			</div>
			</div>
		</div>
		<div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 div_right">
			<div class="reservation">
			<img src="img/example.png?a" class="img-fluid max-width: 100%" alt="">
			</div>
		</div>
	</div>
</div>
<footer class="container fluid justify-content-center fixed-bottom">
<p align="center">CopyRight 2022. SANGYONG PARK. All rights reserved.</p>
</footer>
<!-- footer end -->

<!-- Bootstrap core javascript -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script>

$('#noticeHeader').on('click',function(){
	$(this).css('color','black');
	$('#qnaHeader').css('color','#BDBDBD');
	$('.qna_tr').css('display','none');
	$('.notice_tr').show();
});

$('#qnaHeader').on('click',function(){
	$(this).css('color','black');
	$('#noticeHeader').css('color','#BDBDBD');
	$('.notice_tr').css('display','none');
	$('.qna_tr').show();
});
</script>
</body>
</html>