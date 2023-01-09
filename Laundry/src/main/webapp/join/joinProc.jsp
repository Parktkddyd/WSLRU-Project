<%@page import="user.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="User" class="user.User"/> <!-- 객채생성 User User =  new User()과 같은 뜻--> 
<jsp:setProperty property="*" name="User"/> <!--name = usebean의 id , property = 가져올 속성 -->
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
		int result = user.join(User);
		
 		 if(result == -1){
			PrintWriter Out = response.getWriter();
			Out.println("<script>");
			Out.println("alert('중복된 아이디입니다.')");
			Out.println("history.back()");
			Out.println("</script>");
		}else{
			PrintWriter Out = response.getWriter();
			Out.println("<script>");
			Out.println("alert('회원가입 신청이 정상적으로 되었습니다.')");
			Out.println("location.href='../Main.jsp'");
			Out.println("</script>");
		} 
	%>
</body>
</html>