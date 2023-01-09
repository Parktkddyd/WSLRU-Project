<%@page import="reservation.ReservationDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="User" class="user.User"></jsp:useBean>
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
	
	if(sessionID ==null){
%>
<script>
	alert("접근 권한이 없습니다.");
	location.href="../Main.jsp";
</script>
<%
	}
%>
	
<%
	request.setCharacterEncoding("UTF-8");
	int Cancel = Integer.parseInt(request.getParameter("Cancel"));
	
	ReservationDAO rsv = new ReservationDAO();
	int result = rsv.CancelReservation(Cancel, sessionID);
	if(result >0){
		PrintWriter Out =response.getWriter();
		Out.println("<script>");
		Out.println("alert('예약취소가 정상적으로 되었습니다.')");
		Out.println("location.href='myReservation.jsp'");
		Out.println("</script>");
	}else{
		PrintWriter Out =response.getWriter();
		Out.println("<script>");
		Out.println("alert('데이터베이스 오류입니다.')");
		Out.println("history.back()");
		Out.println("</script>");
	}
%>
</body>
</html>