<%@page import="user.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="User" class="user.User"/> <!-- 객채생성 User User =  new User()과 같은 뜻--> 
<jsp:setProperty property="userID" name="User"/> <!--name = usebean의 id , property = 가져올 속성 -->
<jsp:setProperty property="userPassword" name="User"/> <!--name = usebean의 id , property = 가져올 속성 -->
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
		
		if(sessionID != null){
			PrintWriter Out =response.getWriter();
			Out.println("<script>");
			Out.println("alert('이미 로그인이 되어있습니다.')");
			Out.println("location.href='../Main.jsp'");
			Out.println("</script>");
		}
		
		UserDAO user = new UserDAO();
		int result = user.login(User.getUserID(), User.getUserPassword());
		
		if(result == 3){
			session.setAttribute("sessionID", User.getUserID());
			session.setMaxInactiveInterval(60*10);
			PrintWriter Out =response.getWriter();
			Out.println("<script>");
			Out.println("location.href='../Main.jsp'");
			Out.println("</script>");
		}
		
		if(result == 2){
			PrintWriter Out =response.getWriter();
			Out.println("<script>");
			Out.println("alert('승인 대기중입니다. 관리자에게 문의하세요.')");
			Out.println("history.back()");
			Out.println("</script>");
		}
		if(result == 1){
			PrintWriter Out =response.getWriter();
			Out.println("<script>");
			Out.println("alert('승인이 거절되었습니다. 관리자에게 문의하세요.')");
			Out.println("history.back()");
			Out.println("</script>");
		}
		if(result == 0){
			PrintWriter Out =response.getWriter();
			Out.println("<script>");
			Out.println("alert('비밀번호가 일치하지 않습니다.')");
			Out.println("history.back()");
			Out.println("</script>");
		}
		
		if(result == -1){
			PrintWriter Out =response.getWriter();
			Out.println("<script>");
			Out.println("alert('존재하지 않는 아이디입니다.')");
			Out.println("history.back()");
			Out.println("</script>");
		}
		
		if(result == -2){
			PrintWriter Out =response.getWriter();
			Out.println("<script>");
			Out.println("alert('데이터베이스 오류입니다.')");
			Out.println("history.back()");
			Out.println("</script>");
		}
	%>
</body>
</html>