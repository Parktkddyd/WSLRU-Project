<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=edge" charset="UTF-8">
 <meta name = "viewport" content="width=device-width, initial-scale=1.0">
 <link href="css/bootstrap.min.css" rel="stylesheet">
<title>메인 페이지</title>
</head>
<body>
<!-- nav -->
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-primary">
<div class="container-fluid">
	<a href="#" class="navbar-brand">세탁기 예약 및 좌석현황 사이트</a>
	<!-- 반응형 우측 아이콘 -->
	<button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
	aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
	 		 <span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id = "navbarCollapse">
	<ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
            <a class="nav-link" href="notice.jsp">공지사항</a>
		</li>
		 <li class="nav-item">
            <a class="nav-link" href="reservation.jsp">좌석예약</a>
		</li>
		 <li class="nav-item">
            <a class="nav-link" href="qna.jsp">Q&A</a>
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

<!-- main -->

<!-- footer -->
<footer class="container fluid justify-content-center fixed-bottom">
<p align="center">CopyRight 2022. SANGYONG PARK. All rights reserved.</p>
</footer>
<!-- footer end -->
<script src ="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>