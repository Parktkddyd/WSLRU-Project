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
	request.setCharacterEncoding("utf-8");
	String sessionID = null;
	int questionID = Integer.parseInt(request.getParameter("questionID"));
	QuestionDAO qusDAO = new QuestionDAO();
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
	Date now = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String writeTime = sdf.format(now);
	String updateTitle = request.getParameter("questionTitle");
	String updateContent = request.getParameter("questionContent");
	
	Question prevResult = qusDAO.viewQuestion(questionID);
	String prevTitle = prevResult.getQuestionTitle();
	String prevContent = prevResult.getQuestionContent();
	
	if(updateTitle.equals(prevTitle) && updateContent.equals(prevContent)){
		PrintWriter Out = response.getWriter();
		Out.println("<script>");
		Out.println("alert('변경된 사항이 없습니다.')");
		Out.println("history.back()");
		Out.println("</script>");
	}else{		
		int UpdateResult = qusDAO.updateQuestion(questionID, updateTitle, updateContent, writeTime);
		if(UpdateResult > 0){
			PrintWriter Out = response.getWriter();
			Out.println("<script>");
			Out.println("alert('게시글이 정상적으로 수정되었습니다.')");
			Out.println("location.href='questionList.jsp'");
			Out.println("</script>");
		}else{
			PrintWriter Out = response.getWriter();
			Out.println("<script>");
			Out.println("alert('데이터베이스 오류입니다.')");
			Out.println("history.back()");
			Out.println("</script>");
	}
}
%>

</body>
</html>