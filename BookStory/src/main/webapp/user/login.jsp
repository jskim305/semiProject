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

</head>
<body>

<%	if(id != null){	// 로그인한 사람	%>
	<h4><%=id %>님 환영합니다.</h4>
	<p>즐거운 하루 되세요</p>
	<a href="../index.jsp">홈으로</a>&emsp;
	<a href="logout.jsp">로그아웃</a>
<%	}
	
	else{
%>
	<form name="loginFrm" method="post" action="loginProc.jsp">
		<table align="center">
			<tr>
				<td colspan="2" align="center"><h2>로그인</h2></td>
			</tr>
			<tr>
				<td>아 이 디</td>
				<td><input name="loginId" required></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="loginPw" required></td>			
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="로그인">&emsp;
					<input type="button" value="회원가입" onclick="location.href='join.jsp'">
					<input type="button" value="홈으로" onclick="location.href='../index.jsp'">
				</td>
			</tr>
		</table>
	</form>	
<%	}	%>	
</body>
</html>