<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="mMgr" class="user.UserMgr" />  
<%
	request.setCharacterEncoding("UTF-8");
	String user_id = request.getParameter("loginId");
	String pw = request.getParameter("loginPw");
	
	boolean result = mMgr.userLogin(user_id, pw);
	
	String msg = "로그인 실패";
	if(result){
		session.setAttribute("idKey", user_id);
		msg = "로그인 성공";	
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>
	alert("<%=msg %>");
	location.href="../index.jsp";
</script>

</body>
</html>