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
	<jsp:include page="head.jsp" flush="false"/>
	<%
		MovieRepository movieDao = new MovieRepository();
		ArrayList<Movie> movieList = movieDao.getMovieList();
	%>
	
	<div class="scheduleBox">
		<%	String[] screenNum = {"1관","2관","3관","4관"}; 
			for(int i = 0; i < 4; i++) {				
		%>
			<div class="screen_section">
			<p class="scheduleNum">----------------------------&lt;<%= screenNum[i] %>&gt;----------------------------</p>
			<div class="forBox">
			<%
				for(int j = 0; j < movieList.size(); j++){
					Movie movie = movieList.get(j);
					if (screenNum[i].equals(movie.getScreenId())){
			%>
				<a href="seatSelect.jsp?m.movie_id=<%= movie.getMovieId() %>" class="movie_card2">
					
					<div class="screen_badge">
                        <%= movie.getScreenName() != null ? movie.getScreenName() : screenNum[i] %>
                    </div>
					<img src="<%=movie.getImg_src()%>" alt="영화 포스터">
					
					<div class="movie_title2"><%= movie.getTitle() %></div>
					
					<div class="movie_info2">
						잔여 좌석: <%= movie.getSeat() %>석/<%= movie.getSeat() %>석<br>
						시작 시간: <%= movie.getStartTime() %>	
					</div>
				</a>
			<% };}; %>	
		</div>
		</div>
	<% }; %>
	</div>
	
	
	<jsp:include page="foot.jsp" flush="false"/>
</body>
</html>