<%@page import="java.io.PrintWriter"%>
<%@page import="reservation.Reservation"%>
<%@page import="reservation.ReservationDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="Reservation" class="reservation.Reservation"></jsp:useBean>
<jsp:setProperty property="*" name="Reservation"/>
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

.form-myReservation {
  width: 100%;
  max-width: 950px;
  padding: 4rem;
  margin: auto;
}

</style>
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
	location.href="../Main.jsp";
</script>
<%
	}
%>
<%
	ReservationDAO rsv = new ReservationDAO(); //resrvationDAO 객체 생성
	
	int pageNumber = 1; //기본 첫페이지
	int blockNumber = 1; // 기본 블럭;
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	if(request.getParameter("blockNumber") != null){
		blockNumber = Integer.parseInt(request.getParameter("blockNumber"));
	}
	/* 총 레코드 수 */
	int rowCount = rsv.getmyReservationCount(sessionID);
	
	/* 총 페이지 수 구하는 과정 */
	int pageSize = 10; //페이지는 레코드 10개 단위로
	int pageCount = (int)Math.ceil((double)rowCount / pageSize);
	
	/* 총 블럭 수 구하는 과정 */
	int blockSize = 5; // 블럭은 5페이지 단위로
	int blockCount = (int)Math.ceil((double)pageCount / blockSize);
%>
<jsp:include page="../layout/nav.jsp"/>
<main class="form-myReservation">
    <table class="table" style="text-align: center;">
    <thead>
    <tr class="table-info">
    <th scope="col">예약번호</th><th scope="col">예악날짜</th><th scope="col">사용시간</th><th colspan="2" scope="col">사용여부</th>
    </tr>
    </thead>
    <tbody>
    <%
    	ArrayList<Reservation> rsvList = rsv.getMyReservationList(sessionID, pageNumber);
    	for(int i=0; i<rsvList.size(); i++){
    %>
    	<tr height = "55" style="vertical-align: middle;">
    	<td><%=rsvList.get(i).getReserveNo()%></td>
    	<td><%=rsvList.get(i).getReserveDate() %></td>
    	<td><%=rsvList.get(i).getReserveUsingTime() %>분</td>
    		<%
    		    int rsvStat = rsvList.get(i).getReserveAvailable();
    			if(rsvStat == 0){
    		%>
    		<td width="142" align="right">미사용</td>
    		<td width ="80"><a onclick="return confirm('예약을 취소하시겠습니까?')" href="myReservationProc.jsp?Cancel=3"
    						 class="btn btn-danger">취소</a></td>
    		<%
    			}else if(rsvStat == 1){
    		%>
    			<td colspan="2">사용 중</td>
    		<%
    			}else if(rsvStat == 2){
    		%>
    			<td colspan="2">사용완료</td>	
    		<%
    			}else if(rsvStat == 3){
    		%>
    			<td colspan="2">취소완료</td>
    		<%
    			}
    		%>
    	</tr>
    <%
    	}
    %>
    <tr>
     <!-- 페이징 -->
    <td colspan="8">
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
    	<a class="btn btn-outline-primary" href="myReservation.jsp?pageNumber=<%=(blockNumber-1)*5 %>&blockNumber=<%=blockNumber-1%>" role="button">이전</a>
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
    	<a class="btn btn-outline-primary" href="myReservation.jsp?pageNumber=<%=i%>&blockNumber=<%=blockNumber%>" role="button"><%=i%></a>
    	<!--이외의 페이지 버튼에는 링크를 달아 해당 페이지에 들어갈 수 있음-->
    <%			
    			}
    		}
    %>
    <%
    	if(endPage < pageCount){ // 현재 블록의 가장 끝 페이지보다 총 페이지수가 많다면
    %>
    	<a class="btn btn-outline-primary" href="myReservation.jsp?pageNumber=<%=(blockNumber*5)+1 %>&blockNumber=<%=blockNumber+1 %>" role="button">다음</a>
    <%    
    	} // 다음 버튼 생성
    }
    %>
    	</div>
    </div>
    </td>
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