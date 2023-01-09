<%@page import="question.Question"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="question.QuestionDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세탁실</title>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
  display: flex;
  align-items: center;
  padding-top: 1rem;
  background-color: #f5f5f5;
}

.form-questionWrite {
  width: 100%;
  max-width: 950px;
  padding-top: 4rem;
  margin: auto;
}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String sessionID = null;
	int questionID = Integer.parseInt(request.getParameter("questionID"));
	QuestionDAO qusDAO = new QuestionDAO();
	Question qusInfo = qusDAO.QuestionInfo(questionID);
	
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
	if(!sessionID.equals("admin")){
%>
	<script>
		alert("접근 권한이 없습니다.");
		location.href="questionList.jsp";
	</script>
<%		
	}else{
		if(qusDAO.getReplyCount(qusInfo.getQuestionGroup(), qusInfo.getQuestionDepth()) > 0){
%>
		<script>
			alert("작성한 답글이 있습니다 확인해주세요.");
			location.href="questionList.jsp";
		</script>
<%		
		}
	}
}
%>
<%
	Date now = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String writeTime = sdf.format(now);
	String Title = request.getParameter("questionReplyTitle");
	String Content = request.getParameter("questionReplyContent");
	
	int writeReplyResult = qusDAO.writeReplyQuestion(sessionID, Title, Content, writeTime, qusInfo.getQuestionGroup(), qusInfo.getQuestionSorts());
	if(writeReplyResult > 0){
		PrintWriter Out = response.getWriter();
		Out.println("<script>");
		Out.println("alert('답글 정상적으로 작성되었습니다.')");
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