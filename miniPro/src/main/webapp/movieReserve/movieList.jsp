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
	
	<div class=listbox>
		<div class="movie_list">
		<%
			for(int i = 0; i < movieList.size(); i++){
				Movie movie = movieList.get(i);
		%>
			<div class="movie_card">
				<div class="img_area">
					<img alt="포스터" src="<%=movie.getImg_src()%>">
					<a href="movieRv.jsp?" class="btn-booking">예매하기</a>
				</div>
				<div class="movie_info">
					<h3><%=movie.getTitle() %></h3>
					<p><%=movie.getRating() %> | <%=movie.getRelease() %></p>
					<hr>
					<p><%=movie.getDirector() %> | <%=movie.getGenre() %></p>
					<hr>
					<p><%=movie.getContent() %></p>
				</div>
			</div>
		<% } %>
		</div>
	</div>
	<jsp:include page="foot.jsp" flush="false"/>
</body>
</html>