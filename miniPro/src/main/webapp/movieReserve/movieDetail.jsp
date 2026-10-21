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
	String movieId = request.getParameter("movie_id");
	MovieRepository dao = new MovieRepository();
	Movie movie = dao.getMovieInfo(movieId);
%>

	<div class="detail_container">
		<div class="poster_box">
			<img src="<%=movie.getImg_src()%>" alt="영화 포스터">
        </div>
            <div class="info_box">
                <h2 class="movie_title"><%= movie.getTitle() %></h2>
                <ul class="meta_list">
                    <li><span class="label">장르</span> <span><%= movie.getGenre() %></span></li>
                    <li><span class="label">개봉년도</span> <span><%= movie.getRelease() %>년</span></li>
                    <li><span class="label">감독</span> <span><%= movie.getDirector() %></span></li>
                    <li><span class="label">출연진</span> <span><%= movie.getActors() %></span></li>
                    <li><span class="label">관람등급</span> <span><%= movie.getRating() %></span></li>
                    <li><span class="label">제작사</span> <span><%= movie.getCompany() %></span></li>
                </ul>
                <div class="content_box">
                    <h4>줄거리</h4>
                    <p><%=movie.getContent() %></p>
                </div>
		</div>
    </div>
    <div class="btn_wrap">
        <a href="javascript:history.back();" class="back_btn">이전으로</a>
    </div>
<jsp:include page="foot.jsp" flush="false"/>
</body>
</html>