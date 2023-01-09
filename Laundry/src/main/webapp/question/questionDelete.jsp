<%@page import="question.Question"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="question.QuestionDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
	int questionID = Integer.parseInt(request.getParameter("questionID"));
	QuestionDAO qusDAO = new QuestionDAO();
	Question qusInfo = qusDAO.QuestionInfo(questionID);
	String verifyID = qusDAO.getUserID(questionID);
	
	if(session.getAttribute("sessionID") != null)
		sessionID = (String)session.getAttribute("sessionID");
	
	if(sessionID ==null){
%>
	<script>
		alert("로그인을 해주세요.");
		location.href="../login/login.jsp";
	</script>
<%
}else{
	if(!sessionID.equals(verifyID) && !sessionID.equals("admin")){
%>
	<script>
		alert("접근 권한이 없습니다.");
		location.href="questionList.jsp";
	</script>
<%
	}
}	
		int DeleteResult = qusDAO.deleteQuestion(questionID);
		if(DeleteResult > 0){
			if(qusInfo.getQuestionDepth() == 0){
				int DeleteReply = qusDAO.deleteReplyCascade(questionID);
			}
			PrintWriter Out = response.getWriter();
			Out.println("<script>");
			Out.println("alert('게시글이 정상적으로 삭제되었습니다.')");
			Out.println("location.href='questionList.jsp'");
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