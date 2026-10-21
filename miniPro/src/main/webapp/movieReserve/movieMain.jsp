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
                    <div class="movie_card">
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
                    <div class="movie_card">
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

<style>
.main_container {
    max-width: 1000px;
    margin: 40px auto;
    padding: 0 20px;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.section_title {
    font-size: 22px;
    color: #333;
    margin-bottom: 20px;
    font-weight: 700;
}

/* 1. 슬라이드 틀 (영역을 벗어나는 카드는 숨김 처리) */
.movie_slider_wrap {
    width: 100%;
    overflow: hidden;
    position: relative;
    padding: 10px 0;
}

/* 2. 카드를 가로로 길게 배치하고 애니메이션 적용 */
.movie_card_container {
    display: flex;
    gap: 30px; /* 카드 사이 간격 */
    width: max-content; /* 내용물 크기만큼 너비 확장 */
    animation: rollingAnimation 20s linear infinite; /* 20초 동안 무한 반복 */
}

/* 마우스를 올렸을 때 애니메이션 일시 정지 */
.movie_slider_wrap:hover .movie_card_container {
    animation-play-state: paused;
}

/* 3. 개별 영화 카드 스타일 */
.movie_card {
    width: 200px; /* 카드 고정 너비 */
    background: #ffffff;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
    overflow: hidden;
    transition: transform 0.3s ease;
    flex-shrink: 0; /* 카드가 찌그러지지 않도록 고정 */
}

.movie_card:hover {
    transform: translateY(-5px); /* 마우스 올리면 살짝 떠오름 */
}

.movie_card a {
    text-decoration: none;
    color: #333;
}

.movie_card img {
    width: 100%;
    height: 280px;
    object-fit: cover;
    display: block;
    
}

.movie_card h4 {
    font-size: 15px;
    text-align: center;
    padding: 15px 10px;
    margin: 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis; /* 제목이 길 경우 말줄임 처리 */
}

/* 4. 오른쪽에서 왼쪽으로 흐르는 애니메이션 키프레임 */
@keyframes rollingAnimation {
    0% {
        transform: translateX(0);
    }
    100% {
        transform: translateX(-50%); /* 전체 복제된 아이템 길이만큼 이동 후 초기화 */
    }
}
</style>
</html>