<%@page import="dto.Movie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.MovieRepository"%>
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
    String movieId = request.getParameter("m.movie_id");

	MovieRepository dao = new MovieRepository();
	Movie movie = dao.getMovieInfo(movieId);
	
	ArrayList<String> reservedSeats = dao.reservedSeat(movie.getScheduleId());
%>
	<jsp:include page="head.jsp" flush="false"/>
	
	<div style="text-align: center; margin-top: 30px;">
        <h2><%= movie.getTitle() %> (<%= movie.getScreenName() %>)</h2>
        <p>상영 시간: <%= movie.getStartTime() %> | 총 좌석수: <%= movie.getSeat() %>석</p>
    </div>
    
    <form action="payment.jsp" method="post" onsubmit="return submit_check()">
        <!-- 넘어온 movie_id를 숨겨서 함께 전달 -->
        <input type="hidden" name="movie_id" value="<%= movieId %>">
        
        <!-- 만약 schedule 정보도 함께 담겨있다면 schedule_id도 숨겨서 같이 넘겨주면 좋습니다 -->
        <input type="hidden" name="schedule_id" value="<%= movie.getScheduleId() %>">
        
        <!-- 선택된 좌석 번호들이 담길 숨겨진 입력창 -->
        <input type="hidden" id="selectedSeatsInput" name="selectedSeats" value="">
        
		<div class="booking">
			<div class="screen-bar">SCREEN</div>
		    <div class="seat_container">
		    <%
		        int totalSeat = movie.getSeat(); 
		        String rowNum[] = {"A","B","C","D","E","F","G"};
		    	int row = (totalSeat/10);
		    	
		    	for(int i = 0; i < row; i++){
		    		String firstName = rowNum[i];
		    %>
		    	<div class="seat_row">
		    	<%
		    		for(int j = 1; j <= 10; j++){
		    			String seatName= firstName + j;
		    			
		    			String aisleStyle = "";
		    			if(j == 4 || j == 8) {
		    			    aisleStyle = "margin-left: 30px;"; 
		    			}
		    			Boolean isReserved = reservedSeats.contains(seatName);		//이미 예약된 좌석 확인
		    			if(isReserved){
		    	%>
		    		<div class="seat_item reserved" style="<%= aisleStyle %>">					
		    			<%=seatName %>
		    		</div>
		    	<%} else { %>
		    		<div class="seat_item" style="<%= aisleStyle %>" onclick="toggleSeat(this, '<%= seatName %>')">
		    			<%=seatName %>
		    		</div>
		    		<% } %>
		    	<% } %>
		    	</div>
			<% } %>
		    </div>
	    	<div style="text-align: center; margin-top: 30px;">
               <button type="submit" class="btn_payment">결제하기</button>
           	</div>
		</div>
	</form>
	
	
	<jsp:include page="foot.jsp" flush="false"/>
</body>
<script>
let selectedSeats = [];

function toggleSeat(e, seatName) {
    const index = selectedSeats.indexOf(seatName);

    if (index > -1) {
        // 이미 선택된 좌석이면 취소
        selectedSeats.splice(index, 1);
        e.style.backgroundColor = "";
        e.style.color = "";
    } else {
        // 새로 선택하면 빨간색으로 변경
        selectedSeats.push(seatName);				// selectedSeats변수에 seatName(클릭한 좌석) 추가
        e.style.backgroundColor = "#ff4d4d";
        e.style.color = "white";
    }
}

function submit_check() {
    if (selectedSeats.length === 0) {
        alert("좌석을 1개 이상 선택해주세요!");
        return false;
    }

    // 선택된 좌석들을 콤마로 묶어서 전달
    document.getElementById("selectedSeatsInput").value = selectedSeats.join(",");
    return true;
}
</script>
</html>