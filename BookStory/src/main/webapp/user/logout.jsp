<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String msg = "로그아웃 하였습니다.";
	session.invalidate();
%>

<script>
	alert("<%=msg %>");
	location.href="../index.jsp";
</script>


</body>
</html>