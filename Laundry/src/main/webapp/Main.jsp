<%@page import="java.io.PrintWriter"%>
<%@page import="reservation.ReservationDAO"%>
<%@page import="reservation.Reservation"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="realTimeUsg.RealTimeUsgDAO"%>
<%@page import="laundry.Laundry"%>
<%@page import="java.util.*"%>
<%@page import="laundry.LaundryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="UTF-8">
<meta name = "viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<title>세탁실</title>
<style>
	body{
		padding-top:4.5rem;
	}
</style>
<%if(session.getAttribute("sessionID")== null){%>
<style>
	#RealTime{
		filter: blur(5px);
    	-webkit-filter: blur(5px);
	}
</style>
<% 
}
%>
</head>
<body>
<jsp:include page="layout/nav.jsp"/>
<div class="container">
	<div class="row">
		<div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 div_left">
			<div class="bulletin">
			<header class="sectionHeader">
				<a id="noticeHeader" style="margin-left:2%; font-size:20px; font-weight : bold; cursor: pointer; color:black;">공지사항</a>
				<a id="qnaHeader" style="margin-left:2%;font-size:20px;font-weight: bold;color:#BDBDBD;cursor: pointer;">Q&A</a>
			</header>
			<div style=padding:10px;">
			<table class="table" id="noticetable" style="margin:0";>
			<tr class="notice_tr">
				<td style="border-top:none;"></td>
			</tr>
			<tr class="notice_tr">
				<td style="border-top:none;">공지사항 예시</td>
			</tr>
			<tr class="notice_tr">
				<td style="border-top:none;">공지사항 예시</td>
			</tr>
			<tr class="notice_tr">
				<td style="border-top:none;">공지사항 예시</td>
			</tr>
			<tr class="notice_tr">
				<td style="border-top:none;">공지사항 예시</td>
			</tr>
			<tr class="qna_tr" style="display:none;">
				<td style="border-top:none;">Q&A 예시</td>
			</tr>
			<tr class="qna_tr" style="display:none;">
				<td style="border-top:none;">Q&A 예시</td>
			</tr>
			<tr class="qna_tr" style="display:none;">
				<td style="border-top:none;">Q&A 예시</td>
			</tr>
			<tr class="qna_tr" style="display:none;">
				<td style="border-top:none;">Q&A 예시</td>
			</tr>
			<tr class="qna_tr" style="display:none;">
				<td style="border-top:none;">Q&A 예시</td>
			</tr>
			</table>
			</div>
			</div>
		</div>
		<div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 div_right">
			<div id="RealTime">
				    <table class="table" style="text-align: center;">
					    <thead>
					    <tr class="table-info">
					    <th scope="col">세탁기번호</th><th scope="col">세탁기상태</th><th scope="col">남은시간</th><th scope="col">예약번호</th><th scope="col">사용자명</th>
					    </tr>
					    </thead>
					    <tbody>
					    <!-- 50분 세탁기 영역 -->
					    <tr>
					    <th scope="col" colspan = "5" style="border-bottom: 0.1px solid;"> 세탁기[50분] </th>
					    </tr>
					    	
					    	<%
						    	//시작시간과 종료시간 설정하는 부분
					    		Date date = new Date();
					    		Calendar cal = Calendar.getInstance();
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								
								cal.setTime(date); //현재시간으로 설정
								Date StartTime = cal.getTime(); //현재시간
								String StartTimeForm = sdf.format(StartTime);
								cal.add(Calendar.MINUTE, 60); //
								Date ShortEndTime = cal.getTime(); // 끝나는 시간 60분을 더한 이유는 수거대기 시간 고려
								String ShortEndTimeForm = sdf.format(ShortEndTime);
								/* 50분짜리 */
								cal.add(Calendar.MINUTE, 30);
								Date LongEndTime = cal.getTime();
								String LongEndTimeForm = sdf.format(LongEndTime);
								/* 1시간 20분짜리 */
					    		/* 여기까지는 모든 세탁기가 다 공용으로 적용되는 부분 */
					    	%>
					    	
					    	<%
					    	    //사용 전이면서, 50분짜리에 예약한 예약 정보를 받아온다.
					    		ReservationDAO sRsvDAO = new ReservationDAO();
					    		LaundryDAO sLaundryDAO = new LaundryDAO();
					    		int sLaundryCount = sLaundryDAO.LdryCount(1); //모델 1 == 50분짜리 세탁기
					    		Queue<Reservation> noUsingShortList = sRsvDAO.NoUsingList(50, sLaundryCount);
					    		
					    		//실시간으로 데이터 뿌려주는 객체
					    		RealTimeUsgDAO sRealTimeUsgDAO = new RealTimeUsgDAO();
					    		HashMap<Integer, String> sLdryList = sRealTimeUsgDAO.TimeList(1, 50); // sLdry = shorttimelaundry -> 50분짜리
					    				
					    		//세탁기 테이블에서 50분전용 세탁기의 번호와 상태를 불러오는 부분
					    		HashMap<Integer, Integer> sAvlLdryList = sLaundryDAO.AvlLdryList(1); 
					    		Reservation sRsvPerson = null; //예약자
					    		for(int key : sAvlLdryList.keySet()){
					    			int sLaundryNo = key; //세탁기 번호
					    			switch(sAvlLdryList.get(sLaundryNo)){ 
						    			case 1: // 1번부터 key(세탁기 번호)의 value(세탁기 상태)가 사용 가능일 경우
						    				if(!noUsingShortList.isEmpty()){
						    					sRsvPerson = noUsingShortList.poll();
						    					sRsvPerson.setLaundryNo(sLaundryNo);
						    					sRsvPerson.setReserveAvailable(1);
						    					sRsvDAO.UpdateLdryNum(sRsvPerson); //세탁기 번호 업데이트.
						    					sRsvPerson = null;
						    					int result1 = sLaundryDAO.InsertTime(StartTimeForm, ShortEndTimeForm, sLaundryNo);
						    					if(result1<0){
							    					out.println("<script>");
							    					out.println("alert('DB 오류')");
							    					out.println("</script>");
							    				}
						    				}
						    			%>
						    					<tr>	
									    		<td><%= sLaundryNo %></td>
											    <td>사용가능</td>
											    <td></td>
											    <td></td>
												<td></td>
										    	</tr>
						    			<%	
							   					break;							   					
						    			case 2: //사용 중
						    				if(sLaundryDAO.EndTime(sLaundryNo) != null){
						    				long RemainTime = (sLaundryDAO.EndTime(sLaundryNo).getTime() - date.getTime()) / 60000; // 남은 시간
							    				if(RemainTime < 10){
							    					int result2 = sLaundryDAO.UpdateStatus(sLaundryNo);
							    					if(result2<0){
							    						out.println("<script>");
								    					out.println("alert('DB 오류')");
								    					out.println("</script>");
							    					}
						    				}
						    				String[] sLdryListStat2 = sLdryList.get(sLaundryNo).split(" "); //stat2 == available값이 2 사용중일때 . 
						    				%>
						    				<tr>
						    				<td><%= sLaundryNo %></td>
						    				<td>사용중</td>
						    				<td><%= RemainTime %></td>
						    				<td><%= sLdryListStat2[1] %></td>
						    				<td><%= sLdryListStat2[2] %></td>
						    				</tr>
						    				<%
						    				break;
						    				}						    				
						    			case 3: // 수거 대기
						    				if(sLaundryDAO.EndTime(sLaundryNo) != null){ //사용완료 됐을 때
						    				long RemainTime = (sLaundryDAO.EndTime(sLaundryNo).getTime() - date.getTime()) / 60000; // 남은 시간
						    						if(sLaundryDAO.EndTime(sLaundryNo).getTime() <= date.getTime()){
 						    							sRsvPerson = sRsvDAO.PerformedRsvPerson(sLaundryNo);
								    					sRsvPerson.setReserveAvailable(2);
								    					sRsvDAO.PerformedLdry(sRsvPerson);
								    					int result3 = sLaundryDAO.InitStatus(sLaundryNo);
								    					sRsvPerson = null;
								    					if(result3<0){
							    						out.println("<script>");
								    					out.println("alert('DB 오류')");
								    					out.println("</script>");
						    						}
						    				}
						    				if(RemainTime >=0){
						    				String[] sLdryListStat3 = sLdryList.get(sLaundryNo).split(" "); // stat3 = available = 3일때 
						    				%>
						    				<tr>
						    				<td><%= sLaundryNo %></td>
						    				<td>수거대기</td>
						    				<td><%= RemainTime %></td>
						    				<td><%= sLdryListStat3[1] %></td>
						    				<td><%= sLdryListStat3[2] %></td>
						    				</tr>
						    				<%
						    				}
						    					break;
						    				}
					    			}
					    		}					    		
					    	%>
					    	
					    	<%
					    		ArrayList<String> sOrderList = sRsvDAO.OrderList(50);
					    		String mySOrder = null;
					    	%>
					    	<tr>
					    		<th colspan="5" scope="col" style="border-top:0.1px solid;">현재 대기하고 있는 총 인원 수[50분]</th>
					    	</tr>
					    	<tr><td colspan="5"><%=sOrderList.size() %>명</td></tr>
					    	<tr>
					    		<th colspan="3" scope="col" style="border-top:0.1px solid;">내 예약번호</th><th colspan="2" scope="col" style="border-top:1px solid;">내 앞의 대기자 수</th>
					    	</tr>
					    	<%
					    		if(session.getAttribute("sessionID") !=null){
					    			mySOrder = sRsvDAO.getMyOrder(session.getAttribute("sessionID").toString());
					    		if(sOrderList.size() > 0){
					    		for(int i=0; i<sOrderList.size(); i++){
					    			if(mySOrder != null){
					    					if(mySOrder.equals(sOrderList.get(i))){
					    	%>
					    		<tr>
						    	<td colspan="3" style= "border-bottom: 0.1px solid;"><%=mySOrder %></td><td colspan="2" style = "border-bottom: 0.1px solid;"><%= i %>명</td>
						   		</tr>
					    	<%
					    					}
					    				}
					    			}
					    		}else{
					    	%>
					    		<tr>
					    			<td colspan="3" style= "border-bottom: 0.1px solid;">사용중이거나 예약내역이 없음</td><td colspan="2" style = "border-bottom: 0.1px solid;">예약 내역 없음</td>
					    		</tr>
					    	<% 		
					    		}
					    	}
					    	%>	
					    	<!--1시간 20분 세탁기 영역 -->
					    	<tr>
							<th scope="col" colspan = "5" style="border-bottom: 0.1px solid;">세탁기[1시간 20분]</th>
					    	</tr>
					   			<%
					    	    //사용 전이면서, 1시간20분짜리에 예약한 예약 정보를 받아온다.
					    		ReservationDAO lRsvDAO = new ReservationDAO();
					    		LaundryDAO lLaundryDAO = new LaundryDAO();
					    		int lLaundryCount = lLaundryDAO.LdryCount(2);
					    		Queue<Reservation> noUsingLongList = lRsvDAO.NoUsingList(80, lLaundryCount);
					    		
					    		//실시간으로 데이터 뿌려주는 객체
					    		RealTimeUsgDAO lRealTimeUsgDAO = new RealTimeUsgDAO();
					    		HashMap<Integer, String> lLdryList = sRealTimeUsgDAO.TimeList(2, 80); // sLdry = shorttimelaundry -> 50분짜리
					    		
					    		//세탁기 테이블에서 1시간20분전용 세탁기의 번호와 상태를 불러오는 부분
					    		HashMap<Integer, Integer> lAvlLdryList = lLaundryDAO.AvlLdryList(2); 
					    		Reservation lRsvPerson = null; //예약자
					    		for(int key : lAvlLdryList.keySet()){
					    			int lLaundryNo = key; //세탁기 번호
					    			switch(lAvlLdryList.get(lLaundryNo)){ 
						    			case 1: // 1번부터 key(세탁기 번호)의 value(세탁기 상태)가 사용 가능일 경우
						    				if(!noUsingLongList.isEmpty()){
						    					lRsvPerson = noUsingLongList.poll();
						    					lRsvPerson.setLaundryNo(lLaundryNo);
						    					lRsvPerson.setReserveAvailable(1);
						    					lRsvDAO.UpdateLdryNum(lRsvPerson); //세탁기 번호 업데이트.
						    					lRsvPerson = null;
						    					int result1 = lLaundryDAO.InsertTime(StartTimeForm, LongEndTimeForm, lLaundryNo);
						    					if(result1<0){
							    					out.println("<script>");
							    					out.println("alert('DB 오류')");
							    					out.println("</script>");
							    				}							   					
						    				}
						    			%>
					    					<tr>	
								    		<td><%= lLaundryNo %></td>
										    <td>사용가능</td>
										    <td></td>
										    <td></td>
											<td></td>
									    	</tr>
						    			<%
						    			break;
						    			case 2: //사용 중
						    				if(lLaundryDAO.EndTime(lLaundryNo) != null){
						    				long RemainTime = (lLaundryDAO.EndTime(lLaundryNo).getTime() - date.getTime()) / 60000; // 남은 시간
							    				if(RemainTime < 10){
							    					int result2 = lLaundryDAO.UpdateStatus(lLaundryNo);
							    					if(result2<0){
							    						out.println("<script>");
								    					out.println("alert('DB 오류')");
								    					out.println("</script>");
							    					}
						    				}
							    			String[] lLdryListStat2 = lLdryList.get(lLaundryNo).split(" ");
							    			%>
							    				<tr>
							    				<td><%= lLaundryNo %></td>
							    				<td>사용 중</td>
							    				<td><%= RemainTime %></td>
							    				<td><%= lLdryListStat2[1] %></td>
							    				<td><%= lLdryListStat2[2] %></td>
							    				</tr>
							    			<%
						    				break;
						    				}						    				
						    			case 3: // 수거 대기
						    				if(lLaundryDAO.EndTime(lLaundryNo) != null){ //사용완료 됐을 때
						    					long RemainTime = (lLaundryDAO.EndTime(lLaundryNo).getTime() - date.getTime()) / 60000; // 남은 시간
						    						if(lLaundryDAO.EndTime(lLaundryNo).getTime() <= date.getTime()){
 						    							lRsvPerson = lRsvDAO.PerformedRsvPerson(lLaundryNo);
								    					lRsvPerson.setReserveAvailable(2);
								    					lRsvDAO.PerformedLdry(lRsvPerson);
								    					int result3 = lLaundryDAO.InitStatus(lLaundryNo);
								    					lRsvPerson = null;
								    					if(result3<0){
							    						out.println("<script>");
								    					out.println("alert('DB 오류')");
								    					out.println("</script>");
						    						}
						    				}
						    					String[] lLdryListStat3 = lLdryList.get(lLaundryNo).split(" ");
						    					if(RemainTime >=0){
						    				%>
							    				<tr>
							    				<td><%= lLaundryNo %></td>
							    				<td>수거대기</td>
							    				<td><%= RemainTime %></td>
							    				<td><%= lLdryListStat3[1] %></td>
							    				<td><%= lLdryListStat3[2] %></td>
							    				</tr>
						    				<%
						    					}
						    					break;
						    				}
					    			}
					    		}
					    	%>					  
					    	<%
					    		ArrayList<String> lOrderList = sRsvDAO.OrderList(80);
					    		String myLOrder = null;
					    	%>
					    	<tr>
					    		<th colspan="5" scope="col" style="border-top:0.1px solid;">현재 대기하고 있는 총 인원 수[1시간 20분]</th>
					    	</tr>
					    	<tr><td colspan="5"><%=lOrderList.size() %>명</td></tr>
					    	<tr>
					    		<th colspan="3" scope="col" style="border-top:0.1px solid;">내 예약번호</th><th colspan="2" scope="col" style="border-top:1px solid;">내 앞의 대기자 수</th>
					    	</tr>
					    	<%
					    		if(session.getAttribute("sessionID") !=null){
					    			myLOrder = lRsvDAO.getMyOrder(session.getAttribute("sessionID").toString());
					    		if(lOrderList.size() > 0){
					    		for(int i=0; i<lOrderList.size(); i++){
					    			if(myLOrder != null){
					    				if(myLOrder.equals(lOrderList.get(i))){
					    	%>
					    		<tr>
						    	<td colspan="3" style= "border-bottom: 0.1px solid;"><%=myLOrder %></td><td colspan="2" style = "border-bottom: 0.1px solid;"><%= i %>명</td>
						   		</tr>
					    	<%
						    				}
						    			}
						    		}
					    		}else{
					    	%>
					    		<tr>
					    			<td colspan="3" style= "border-bottom: 0.1px solid;">사용중이거나 예약내역이 없음</td><td colspan="2" style = "border-bottom: 0.1px solid;">예약 내역 없음</td>
					    		</tr>
					    	<% 		
					    		}
					    	}
					    	%>				 					    				
					  </tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<jsp:include page="layout/footer.jsp"/>

<!-- Bootstrap core javascript -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script>
$('#noticeHeader').on('click',function(){
	$(this).css('color','black');
	$('#qnaHeader').css('color','#BDBDBD');
	$('.qna_tr').css('display','none');
	$('.notice_tr').show();
});

$('#qnaHeader').on('click',function(){
	$(this).css('color','black');
	$('#noticeHeader').css('color','#BDBDBD');
	$('.notice_tr').css('display','none');
	$('.qna_tr').show();
});

function autoRefresh_div()
{
var currentLocation = window.location;
$("#RealTime").load(currentLocation + ' #RealTime');
}
setInterval('autoRefresh_div()', 1000);
</script>
</body>
</html>