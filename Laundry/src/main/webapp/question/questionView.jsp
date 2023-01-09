<%@page import="question.Question"%>
<%@page import="java.io.PrintWriter"%>
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
	if(!verifyID.equals("admin")){
	
		if(!sessionID.equals(verifyID) && !sessionID.equals("admin")){
%>
		<script>
			alert("접근 권한이 없습니다.");
			location.href="questionList.jsp";
		</script>
<% 		
		}
	}
}
	Question result = qusDAO.viewQuestion(questionID);
	if(result != null){
%>
<jsp:include page="../layout/nav.jsp"/>
<main class="form-questionWrite" style="text-align:center;">
	<form action="questionWriteProc.jsp">
		<table class="table table-borderless">
		<tr>
			<td width="100" style="font-size:1.5rem;">제목 </td>
			<td width="800"><input type="text" name="questionTitle" value="<%=result.getQuestionTitle() %>"class="form-control mb-3" disabled readonly></td>
		</tr>
		<tr><td colspan="2"><textarea name="questionContent" class="form-control" rows="20" disabled readonly><%=result.getQuestionContent() %></textarea></td></tr>
		<tr>
		<% 
		if(sessionID != null){
			if(sessionID.equals("admin")){
		%>
		<td colspan="2" style="text-align:right;">
			<a onclick="return confirm('글 목록으로 가시겠습니까?')" href="questionList.jsp" class="btn btn-primary">글 목록</a>
			<a onclick="return confirm('답글을 작성하시겠습니까?')	" href="questionReplyWrite.jsp?questionID=<%=questionID %>" class="btn btn-primary">답글 작성</a>
			<a onclick="return confirm('글을 수정하시겠습니까?')" href="questionUpdate.jsp?questionID=<%=questionID %>" class="btn btn-primary">글 수정</a>
			<a onclick="return confirm('글을 삭제하시겠습니까?')" href="questionDelete.jsp?questionID=<%=questionID %>" class="btn btn-primary">글 삭제</a>
		</td>
		<%
			}else if(!sessionID.equals("admin") && sessionID.equals(verifyID)){
		%>
			<td colspan="2" style="text-align:right;">
				<a onclick="return confirm('글 목록으로 가시겠습니까?')" href="questionList.jsp" class="btn btn-primary">글 목록</a>
				<a onclick="return confirm('글을 수정하시겠습니까?')" href="questionUpdate.jsp?questionID=<%=questionID %>" class="btn btn-primary">글 수정</a>
				<a onclick="return confirm('글을 삭제하시겠습니까?')" href="questionDelete.jsp?questionID=<%=questionID %>" class="btn btn-primary">글 삭제</a>
			</td>
		<%
			}else{
		%>
		<td colspan="2" style="text-align:right;">
				<a onclick="return confirm('글 목록으로 가시겠습니까?')" href="questionList.jsp" class="btn btn-primary">글 목록</a>
			</td>
		<%		
			}
		}
		%>
		</tr>
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