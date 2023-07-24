<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mgr" class="user.UserMgr" />  
<jsp:useBean id="bean" class="user.UserBean" />
<jsp:setProperty property="*" name="bean" />

<%
	boolean result = mgr.userInsert(bean);
	String msg = "회원가입 실패";
	String location = "join.jsp";
	
	if(result){
		msg = "회원가입 완료";
		location = "index.jsp";
	}
	
%>

<script>
	alert("<%=msg %>");
	location.href="<%=location %>";
</script>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>