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
		display : flex;
		align-items : center;
		padding-top : 7rem;
		background-color : #f5f5f5;
	}
	.form-MakeReservation{
		width: 100%;
		max-width: 35rem;
		margin : auto;
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
<main class="form-MakeReservation">
    <form action="mkReservationProc.jsp" method="post" onsubmit="return confirm('예약신청을 하시겠습니까?')">
   		 <table class="table table-borderless" style="text-align: center">    	
	    	<tr class ="tableHeader">
		    	<td colspan="2" style="height : 5rem;">
		    	<h1><b>예약신청</b></h1>
		    	</td>
		   	</tr>
		   	<tr>
		   	<td style="vertical-align : bottom; height: 7rem;"><h4>사용할 시간을 선택해주세요.</h4></td>
		    </tr>
		    <tr class = "tableMain" style="height : 10rem;">
		    	<td style="vertical-align : top;">
		    		<div class="btn-group" role="group" aria-label="UsingTimebuttonGroup">
			    		<input type="radio" class="btn-check" name="reserveUsingTime" id="btn-check-shortTime" value="50" autocomplete = "off" checked>
			    		<label class ="btn btn-lg btn-outline-primary" for="btn-check-shortTime">50분</label>
			    		
			    		<input type="radio" class="btn-check" name="reserveUsingTime" id="btn-check-LongTime" value="80" autocomplete = "off">
			    		<label class ="btn btn-lg btn-outline-primary" for="btn-check-LongTime">1시간 20분</label>
		    		</div>
		    	</td>
	    	</tr>
	    	<tr class = "tableFooter">
	    		<td colspan="2" style="height : 7rem;">
	    			<button class = "w-50 btn btn-lg btn-primary" type="submit" style="margin-bottom: 5px;">예약하기</button>
	    			<a onclick ="return confirm('예약신청을 취소하시겠습니까?')" href="reservation.jsp" class="w-50 btn btn-lg btn-danger">예약취소</a>	
	    		</td>
	    	</tr>
		</table>
    </form>
</main>
<jsp:include page="../layout/footer.jsp"/>
<!-- footer end -->

<!-- Bootstrap core javascript -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>