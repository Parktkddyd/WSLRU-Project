<%@page import="question.Question"%>
<%@page import="question.QuestionDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="User" class="user.User"></jsp:useBean>
<jsp:setProperty property="*" name="User"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="UTF-8">
<meta name = "viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<title>세탁실</title>
<style>
body {
  display: flex;
  align-items: center;
  padding-top: 1rem;
  background-color: #f5f5f5;
}

.form-joinManage {
  width: 100%;
  max-width: 950px;
  padding-top: 4rem;
  margin: auto;
}
a {
	text-decoration-line: none;
}

</style>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	QuestionDAO qus = new QuestionDAO(); //DAO 객체 생성
	
	int pageNumber = 1; //기본 첫페이지
	int blockNumber = 1; // 기본 블럭;
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	if(request.getParameter("blockNumber") != null){
		blockNumber = Integer.parseInt(request.getParameter("blockNumber"));
	}
	/* 총 레코드 수 */
	int rowCount = qus.getQuestionCount();
	
	/* 총 페이지 수 구하는 과정 */
	int pageSize = 10; //페이지는 레코드 10개 단위로
	int pageCount = (int)Math.ceil((double)rowCount / pageSize);
	
	/* if(rowCount % pageSize > 0)
		pageCount++; */
	
	/* 총 블럭 수 구하는 과정 */
	int blockSize = 5; // 블럭은 5페이지 단위로
	int blockCount = (int)Math.ceil((double)pageCount / blockSize);
	/* if(pageCount % blockSize > 0)
		blockCount++; */
%>
<jsp:include page="../layout/nav.jsp"/>
<main class="form-joinManage">
    <table class="table" style="text-align: center;">
    <thead>
    <tr class="table-info">
    <th scope="col">글번호</th><th scope="col">제목</th><th scope="col">작성일</th><th scope="col">작성자</th>
    </tr>
    </thead>
    <tbody>
    <%
    	ArrayList<Question> list = qus.getQuestionList(pageNumber);
    	for(int i=0; i<list.size(); i++){
    	if(list.get(i).getQuestionDepth() == 0){
    		if(list.get(i).getQusetionAvailable() == 0){
    %>
    	<tr>
    	<td><%=list.get(i).getQuestionID() %></td>
    	<td style="text-align:left;"><a href="questionView.jsp?questionID=<%=list.get(i).getQuestionID() %>"><%=list.get(i).getQuestionTitle() %></a></td>
    	<td><%=list.get(i).getQuestionDate() %></td>
		<td><%=list.get(i).getUserID() %></td>
    	</tr>
    <%
    		}else{
    %>
    	<tr>
    	<td><%=list.get(i).getQuestionID() %></td>
    	<td>*****삭제된 게시물입니다.*****</td>
    	<td><%=list.get(i).getQuestionDate() %></td>
		<td>*******</td>
    	</tr>
    <%			
    		}
    	}else{
    		if(list.get(i).getQusetionAvailable() == 0){
    %>
    	<tr>
    	<td><%=list.get(i).getQuestionID() %></td>
    	<td style="text-align:left;"><a href="questionView.jsp?questionID=<%=list.get(i).getQuestionID() %>">&nbsp;<%=list.get(i).getQuestionTitle() %></a></td>
    	<td><%=list.get(i).getQuestionDate() %></td>
		<td><%=list.get(i).getUserID() %></td>
    	</tr>
    <%
    		}
    	}
    }
    %>
    <tr>
    <!-- 페이징 -->
    <td colspan="3">
     <div class="btn-toolbar" style="display:inline-block;" role="toolbar" aria-label="joinManage-PagingButton">
  		<div class="btn-group me-2" role="group">
    <%
    	int startPage = ((pageNumber-1)/blockSize)*blockSize +1; /* 만일 현재 페이지가 5페이지라면 startPage = [(4/5)*5+1] == 1 */
    															 /* 만일 현재 페이지가 6페이지라면 startPage = [(5/5)*5+1] == 6 */
    	int endPage = startPage + blockSize - 1; /*총 페이지 수가 블록사이즈의 배수인 경우를 기본으로 생각*/ 
    	if(endPage > pageCount){
    		endPage = pageCount; /*마지막 자투리 블록의 경우 5의배수가 될 수 없으므로 그때는 남은 페이지를 모두 출력하기 위해 이 코드를 추가함.*/
    	} 
    	if(rowCount > 0){ // 레코드가 있을 때 페이징 수행
    		if(startPage > blockSize){ // 만일 시작 페이지가 블록사이즈 보다 크다면
    %>
    	<a class="btn btn-outline-primary" href="questionList.jsp?pageNumber=<%=(blockNumber-1)*5 %>&blockNumber=<%=blockNumber-1%>" role="button">이전</a>
    <% 			
    		} //이전 버튼 추가
    %>
    
    <% 
    	for(int i = startPage; i<= endPage; i++){
    		if(i == pageNumber){
    %>
    	 <button type="button" class="btn btn-primary"><%=i%></button> <!-- 블록단위로 페이지를 출력함 현재 보고있는 페이지는 버튼 비활성화-->
   		
   	<% 
    		}else{
    %>
    	<a class="btn btn-outline-primary" href="questionList.jsp?pageNumber=<%=i%>&blockNumber=<%=blockNumber%>" role="button"><%=i%></a>
    	<!--이외의 페이지 버튼에는 링크를 달아 해당 페이지에 들어갈 수 있음-->
    <%			
    			}
    		}
    %>
    <%
    	if(endPage < pageCount){ // 현재 블록의 가장 끝 페이지보다 총 페이지수가 많다면
    %>
    	<a class="btn btn-outline-primary" href="questionList.jsp?pageNumber=<%=(blockNumber*5)+1 %>&blockNumber=<%=blockNumber+1 %>" role="button">다음</a>
    <%    
    	} // 다음 버튼 생성
    }
    %>
    	</div>
    </div>
    </td>
    <td><a class="btn btn-primary" href="questionWrite.jsp" role="button">글쓰기</a></td>
    </tr>
    </tbody>
    </table>
</main>

<jsp:include page="../layout/footer.jsp"/>

<!-- Bootstrap core javascript -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>