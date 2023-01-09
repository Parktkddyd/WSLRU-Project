<%@page import="reservation.ReservationDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.PrintWriter"%>
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
	if(session.getAttribute("sessionID") != null){
		sessionID = (String)session.getAttribute("sessionID");
	
		if(request.getParameter("reserveUsingTime") == null){
			PrintWriter Out = response.getWriter();
			Out.println("<script>");
			Out.println("alert('정상적이지 않은 접근입니다.')");
			Out.println("location.href='../Main.jsp'");
			Out.println("</script>");
		}
	}
	else{
		PrintWriter Out = response.getWriter();
		Out.println("<script>");
		Out.println("alert('로그인을 해주세요')");
		Out.println("location.href='../login/login.jsp'");
		Out.println("</script>");
	}
	Date nowDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
	
	String id = sessionID;
	int usingTime = Integer.parseInt(request.getParameter("reserveUsingTime"));
	String currentTime = sdf.format(nowDate);
	
	ReservationDAO RsvDAO = new ReservationDAO();
	int SearchRes = RsvDAO.searchReservation(id);
	if(SearchRes == 1){
		int InsertRes = RsvDAO.MakeReservation(id, usingTime, currentTime);
		if(InsertRes == -1){
			PrintWriter Out = response.getWriter();
			Out.println("<script>");
			Out.println("alert('데이터베이스 오류입니다.')");
			Out.println("history.back()");
			Out.println("</script>");
		}else{
			PrintWriter Out = response.getWriter();
			Out.println("<script>");
			Out.println("alert('예약이 성공적으로 되었습니다!')");
			Out.println("location.href='reservation.jsp'");
			Out.println("</script>");
		}
	}else if(SearchRes == 2){
		PrintWriter Out = response.getWriter();
		Out.println("<script>");
		Out.println("alert('이미 예약이 되어 있습니다.')");
		Out.println("location.href='reservation.jsp'");
		Out.println("</script>");
	}else{
		PrintWriter Out = response.getWriter();
		Out.println("<script>");
		Out.println("alert('데이터베이스 오류입니다.')");
		Out.println("history.back()");
		Out.println("</script>");
	}
%>
</body> 
</html>