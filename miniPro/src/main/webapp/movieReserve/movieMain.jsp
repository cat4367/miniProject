<%@page import="dto.Movie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.MovieRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>싱글벙글 영화관</title>
<link rel="stylesheet" href="moviestyle.css">
</head>
<body>
	<jsp:include page="head.jsp" flush="false"/>
<link rel="stylesheet" href="mainstyle.css">
	<%
		MovieRepository movieDao = new MovieRepository();
		ArrayList<Movie> movieList = movieDao.getMovieList();
	%>
	
	<main class="main_container">
        <!-- 현재 상영 중인 영화 롤링 섹션 -->
        <section class="now_playing_section">
            <h3 class="section_title">🔥 현재 상영 중인 영화</h3>
            
            <div class="movie_slider_wrap">
                <div class="movie_card_container">
                    
                    <!-- DB 데이터 반복문 또는 예시 카드들 (무한 효과를 위해 내부 아이템들을 충분히 구성) -->
                    <%
	                    for(int i = 0; i < movieList.size(); i++){
	        				Movie movie = movieList.get(i); 
                    %>
                    <div class="movie_card3">
                        <a href="movieDetail.jsp?movie_id=<%=movie.getMovieId() %>">
                            <img src="<%=movie.getImg_src() %>" alt="영화포스터">
                            <h4><%=movie.getTitle() %></h4>
                        </a>
                    </div>
                    <% } %>

                    <!-- 롤링이 끊기지 않고 부드럽게 이어지도록 동일한 카드를 한 번 더 복제해서 넣어주면 완벽합니다 -->
                    <%
	                    for(int i = 0; i < movieList.size(); i++){
	        				Movie movie = movieList.get(i); 
                    %>
                    <div class="movie_card3">
                        <a href="movieDetail.jsp?movie_id=<%=movie.getMovieId() %>">
                            <img src="<%=movie.getImg_src() %>" alt="영화포스터">
                            <h4><%=movie.getTitle() %></h4>
                        </a>
                    </div>
                    <% } %>
                </div>
            </div>
        </section>
    </main>
	<jsp:include page="foot.jsp" flush="false"/>
</body>
</html>