<%@page import="question.Question"%>
<%@page import="question.QuestionDAO"%>
<%@page import="java.io.PrintWriter"%>
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

.form-questionUpdate {
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
	Question result = qusDAO.viewQuestion(questionID);
	if(result != null){
%>
<jsp:include page="../layout/nav.jsp"/>
<main class="form-questionUpdate" style="text-align:center;">
	<form action="questionUpdateProc.jsp" method="post">
		<input type="hidden" name="questionID" value=<%=questionID %>>
		<table class="table table-borderless">
		<tr>
			<td width="100" style="font-size:1.5rem;">제목 </td>
			<td width="800"><input type="text" name="questionTitle" value="<%=result.getQuestionTitle() %>" class="form-control mb-3" placeholder="제목을 입력해주세요." required></td>
		</tr>
		<tr><td colspan="2"><textarea name="questionContent" class="form-control" placeholder="내용을 입력해주세요." rows="20" required><%=result.getQuestionContent() %></textarea></td></tr>
		<tr><td colspan="2" style="text-align:right;"><button type="submit" class="btn btn-primary">글 수정</button>
		 	<a onclick="return confirm('글 목록으로 가시겠습니까?')" href="questionList.jsp" class="btn btn-primary">글 목록</a></td></tr>
		</table>
	</form>
</main>
<jsp:include page="../layout/footer.jsp"/>
<%
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