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
	<div class=listbox>
		<div class="movie_list">
			<div class="movie_card">
				<img alt="포스터" src="img/a10.webp">
				<div class="movie_info">
					<h3>타이틀</h3>
					<p>간단한내용</p>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="foot.jsp" flush="false"/>
</body>
</html>