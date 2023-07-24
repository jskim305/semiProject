<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="bean" class="review.ReviewBean" scope="session" />  
<%
	String nowPage = request.getParameter("nowPage");
%>


<!DOCTYPE html>
<style>
	h1{background-color:#B2CCFF;}
	body{background-color:#FAECC5;}
</style>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<h1>답변달기</h1>
	<form method="post" name="replyFrm" action="boardReply.bo">
		<table width="500px">
			<tr>
				<th>성 명</th>
				<td><input name="name" size="10px"></td>
			</tr>
			<tr>
				<th>제 목</th>
				<td><input name="subject" size="45px" value=" Re : <%=bean.getTitle() %>"></td>
			</tr>
			<tr>
				<th>내 용</th>
				<td><textarea name="content" cols="50" rows="10" style="resize:none">
<%=bean.getContent() %>
======== 댓글을 작성하세요. ======== 
				</textarea></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pass" size="10px" required></td>
			</tr>
			<tr>
				<td colspan="2"><hr></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="답변등록">
					<input type="reset" value="다시쓰기">
					<input type="button" value="뒤로" onclick="history.back()">
				</td>
			</tr>
		</table>
		<!-- 나의 정보 -->
		<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>">
		
		<!-- 앞에서 넘어온 값 -->
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
		
		<!-- 부모글의 정보 
		<input type="hidden" name="ref" value="<%=bean.getRef() %>">
		<input type="hidden" name="pos" value="<%=bean.getPos() %>">
		<input type="hidden" name="depth" value="<%=bean.getDepth() %>">
		-->
	</form>
</div>
</body>
</html>