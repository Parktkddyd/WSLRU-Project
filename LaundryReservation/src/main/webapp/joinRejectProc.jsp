<%@page import="user.UserDAO"%>
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
	UserDAO user = new UserDAO();
	
	int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	int blockNumber = Integer.parseInt(request.getParameter("blockNumber"));
	int blockSize = 5;
%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = request.getParameter("userID");
	int Permission = Integer.parseInt(request.getParameter("Permission"));
	int result = user.Permission(userID, Permission);
	int listSize = user.getRejectList(pageNumber).size();
	if(result >0){
		if(Permission == 1){
			PrintWriter Out =response.getWriter();
			Out.println("<script>");
			Out.println("alert('승인처리가 정상적으로 되었습니다.')");
			if(user.getRejectList(pageNumber).isEmpty()){/*현재 페이지에서 보여지는 리스트가 0개일 때 */
				if(pageNumber % blockSize == 0) /* 현재 페이지가 블락의 끝 번호일 경우 페이지 번호와 블락번호 같이 감소*/
					Out.println("location.href='joinReject.jsp?pageNumber="+ --pageNumber + "&blockNumber="+ --blockNumber +"'");
				else/* 아니면 페이지 번호만 감소 */
					Out.println("location.href='joinReject.jsp?pageNumber="+ --pageNumber + "&blockNumber="+ blockNumber +"'");
			}else/* 리스트가 0개가 아니라면 원래 페이지 번호와 블락 번호로 이동 */
				Out.println("location.href='joinReject.jsp?pageNumber="+pageNumber + "&blockNumber="+ blockNumber +"'");
			Out.println("</script>");
		}else{
			int delResult = user.DeleteUser(userID, Permission);
			if(delResult > 0){
			PrintWriter Out =response.getWriter();
			Out.println("<script>");
			Out.println("alert('삭제처리가 정상적으로 되었습니다.')");
			if(user.getRejectList(pageNumber).isEmpty()){/*현재 페이지에서 보여지는 리스트가 0개일 때 */
				if(pageNumber % blockSize == 0) /* 현재 페이지가 블락의 끝 번호일 경우 페이지 번호와 블락번호 같이 감소*/
					Out.println("location.href='joinReject.jsp?pageNumber="+ --pageNumber + "&blockNumber="+ --blockNumber +"'");
				else/* 아니면 페이지 번호만 감소 */
					Out.println("location.href='joinReject.jsp?pageNumber="+ --pageNumber + "&blockNumber="+ blockNumber +"'");
			}else/* 리스트가 0개가 아니라면 원래 페이지 번호와 블락 번호로 이동 */
				Out.println("location.href='joinReject.jsp?pageNumber="+pageNumber + "&blockNumber="+ blockNumber +"'");
			Out.println("</script>");
			}
		}
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