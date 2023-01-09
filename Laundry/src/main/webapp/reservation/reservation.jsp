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
	body{
		background-color : #f5f5f5;
		display : flex;
		align-items : center;
		padding-top : 10rem;
	}
	.form-Reservation{
		width: 100%;
		margin : auto;
	}
	table td{
		height : 30rem;
		vertical-align:middle;
	}
	.card{
		margin : 0 auto;
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
		Out.println("location.href='../login/login.jsp'");
		Out.println("</script>");
	}
%>
<jsp:include page="../layout/nav.jsp"/>
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
				  <a href="mkReservation.jsp" class="btn btn-primary">예약하기</a>
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
				  <a href="myReservation.jsp" class="btn btn-primary">내역확인하기</a>
				</div>
	    	</td>
    	</tr>
    </table>
</main>
<jsp:include page="../layout/footer.jsp"/>

<!-- Bootstrap core javascript -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>