<%@page import="dto.Movie"%>
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
<jsp:include page="head.jsp" flush="false"/>
<%
	request.setCharacterEncoding("UTF-8");	

	String selectedSeats = request.getParameter("selectedSeats");
	MovieRepository dao = new MovieRepository();
	Movie movie = dao.getMovieInfo(request.getParameter("movie_id"));
	
	int seatCount = selectedSeats.split(",").length;	//String 나눠서 인덱스화
	int totalPrice = (seatCount*movie.getPrice());
%>
	<div class="payment_container">
        <h2 class="movie_payment">영화 예매 결제</h2>
        
        <!-- 정보를 서버로 전송하기 위한 form 태그 -->
        <form action="payment.jsp" method="post">
            <!-- 숨겨서 함께 넘겨줄 데이터들 -->
            <input type="hidden" name="movie_id" value="<%= movie.getMovieId() %>">
            <input type="hidden" name="schedule_id" value="<%= movie.getScheduleId() %>">
            <input type="hidden" name="selectedSeats" value="<%= selectedSeats %>">

            <table class="payment_table">
                <tr>
                    <th>영화 제목</th>
                    <td><%= movie.getTitle() %></td>
                </tr>
                <tr>
                    <th>상영 시간</th>
                    <td><%= movie.getStartTime() %></td>
                </tr>
                <tr>
                    <th>상영관</th>
                    <td><%= movie.getScreenName() %></td>
                </tr>
                <tr>
                    <th>선택 좌석</th>
                    <td><strong><%= selectedSeats %></strong> (<%= seatCount %>석)</td>
                </tr>
                <tr>
                    <th>결제 금액</th>
                    <td>
                        <strong><%= String.format("%,d", totalPrice) %>원</strong>
                    </td>
                </tr>
                <tr>
                    <th>결제 방법</th>
                    <td>
                        <select class="paymentMethod" name="payment_method">
                            <option value="card">신용/체크카드</option>
                            <option value="bank">무통장 입금</option>
                            <option value="kakao">간편결제 (카카오페이)</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>예약자 성함</th>
                    <td>
                        <input class="userName" type="text" name="user_id" placeholder="성함을 입력해주세요" required>
                    </td>
                </tr>
            </table>

            <button type="submit" class="pay_btn">결제 및 예매 완료</button>
        </form>
    </div>
<%
	String userId = request.getParameter("user_id");
	if(userId != null && !userId.trim().isEmpty()){
		
		String selectedSeat = request.getParameter("selectedSeats");
		String scheduleId = request.getParameter("schedule_id");
		
		movie.setUserId(userId);
		movie.setSeatNum(selectedSeat);
		movie.setScheduleId(Integer.parseInt(scheduleId));
		
		
		dao.addCustomer(movie);
%>
<script>
	alert('예약이 완료되었습니다. 메인페이지로 이동합니다');
	location.href='movieMain.jsp';
</script>
<%	
		return;
	}
%>

<jsp:include page="foot.jsp" flush="false"/>
</body>
</html>