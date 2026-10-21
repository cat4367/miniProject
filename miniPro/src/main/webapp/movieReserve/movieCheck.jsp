<%@page import="java.util.ArrayList"%>
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

	MovieRepository dao = new MovieRepository();
	ArrayList<Movie> customer = dao.customerList();
%>
	<div class=listbox>
	
		<div class="search_wrap">
			<input type="text" id="searchBox" placeholder="예약자 성함을 입력해주세요." onkeydown="checkReservation(event)">
		</div>
		<table class="tb" border="1">
			<thead>
				<tr>
					<th>예약번호</th>
					<th>예약자</th>
					<th>영화 제목</th>
					<th>상영시간</th>
					<th>상영관 정보</th>
					<th>예약좌석</th>
					<th>예약한 시간</th>					
				</tr>
			</thead>
			<tbody id=customerTable>
				<%
					for(Movie m : customer){
				%>
				<tr>
					<td><%= m.getReservationId() %></td>
					<td><%= m.getUserId() %></td>
					<td>
						<a href="movieDetail.jsp?movie_id=<%= m.getMovieId() %>" class="movie_link">
                        <%= m.getTitle() %>
                    	</a>
					</td>
					<td><%= m.getStartTime() %></td>
					<td><%= m.getScreenName() %></td>
					<td><%= m.getSeatNum() %></td>
					<td><%= m.getReservationTime() %></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>

	<jsp:include page="foot.jsp" flush="false"/>
</body>
<script>
function checkReservation(event) {

    if (event.key === "Enter") {			    // 엔터 키를 눌렀을 때만 동작
        let keyword = document.getElementById("searchBox").value.trim().toLowerCase();
        if (!keyword) return;

        let rows = document.querySelectorAll("#customerTable tr");
        let found = false;
        let resId = "";

        // 테이블 행을 돌며 예약자와 비교
        for (let row of rows) {
            let userId = row.cells[1].innerText.trim().toLowerCase();
            
            if (userId === keyword) {
                resId = row.cells[0].innerText.trim(); // 예약번호 가져오기
                found = true;
                break;
            }
        }

        // 결과에 따른 알림 창 출력
        if (found) {
            alert("해당 예약자의 예약번호는 [" + resId + "] 입니다.");
        } else {
            alert("예약자에 없는 명단입니다.");
        }
    }
}
</script>
</html>