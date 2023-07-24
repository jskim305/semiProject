<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="source/css/style.css" rel="stylesheet" />

</head>
<body>
	<header>
		<div class="logo"><img src="https://iei.or.kr/resources/images/main/logo.svg"></div>
		<nav>
			<ul class="nav">
				<tr>
					<li><a href="review/reviewBoard.jsp">게시판</a></li>
				<% if(id==null) { %>
					<li><a href="user/login.jsp">로그인</a></li>
				<% } else { %>
					<li><a href="user/logout.jsp">로그아웃</a></li>
				<% } %> 
				</tr>
			</ul>
		</nav>
		<div id="login">
			<% if(id != null){ %>
				<p>[<%=id %>님 로그인 상태]</p>
			<% } %>
		</div>
	</header>
	<article id="content">
		<img src="resource/img/side1.png">
	</article>
</body>
</html>