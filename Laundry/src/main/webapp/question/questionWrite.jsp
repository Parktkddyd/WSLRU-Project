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
	if(session.getAttribute("sessionID") != null)
		sessionID = (String)session.getAttribute("sessionID");
	
	if(sessionID ==null){
%>
	<script>
		alert("로그인을 해주세요.");
		location.href="../login/login.jsp";
	</script>
<%
}
%>
<jsp:include page="../layout/nav.jsp"/>
<main class="form-questionWrite" style="text-align:center;">
	<form action="questionWriteProc.jsp" method="post">
		<table class="table table-borderless">
		<tr>
			<td width="100" style="font-size:1.5rem;">제목 </td>
			<td width="800"><input type="text" name="questionTitle" class="form-control mb-3" placeholder="제목을 입력해주세요." required></td>
		</tr>
		<tr><td colspan="2"><textarea name="questionContent" class="form-control" placeholder="내용을 입력해주세요." rows="20" required></textarea></td></tr>
		<tr><td colspan="2" style="text-align:right;"><button type="submit" class="btn btn-primary">글 작성</button>
		 	<a onclick="return confirm('글 목록으로 가시겠습니까?')" href="questionList.jsp" class="btn btn-primary"">글 목록</a></td></tr>
		</table>
	</form>
</main>
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>