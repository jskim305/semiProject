<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ page import="review.ReviewBean" %>
<%
	int review_no = Integer.parseInt(request.getParameter("review_no"));
	String nowPage = request.getParameter("nowPage");
	
	ReviewBean bean = (ReviewBean)session.getAttribute("bean"); 
%>

<!DOCTYPE html>

<style>
	h1{background-color:#CEF279;}
	body{background-color:#FAECC5;}
</style>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<h1>리뷰 변경</h1>
	<form method="post" name="updateFrm" action="reviewUpdate.bo">
		<table width="500px">
			<tr>
				<th>제 목</th>
				<td><input name="title"  value="<%=bean.getTitle() %>" size="45px"></td>
			</tr>
			<tr>
				<th>책 제목</th>
				<td><input name="book_name" value="<%=bean.getBook_name() %>" size="10px"></td>
			</tr>
			<tr>
				<th>저 자</th>
				<td><input name="author" value="<%=bean.getAuthor() %>" size="10px"></td>
			</tr>
			<tr>
				<th>출판사</th>
				<td><input name="publisher" value="<%=bean.getPublisher() %>" size="10px"></td>
			</tr>
			<tr>
				<th>평 점</th>
				<td><input type="range" name="score" min="0" max="5" step="1" oninput="document.getElementById('value').innerHTML=this.value;">
					<span id="value"></span>
				</td>
			</tr>	
			<tr>
				<th>내 용</th>
				<td><textarea name="content" placeholder="내용입력" cols="50" rows="10" style="resize:none"><%=bean.getContent() %></textarea></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="review_pw" size="10px" required> 수정시에는 비밀번호가 필요합니다.</td>
			</tr>
			<tr>
				<td colspan="2"><hr></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정완료">
					<input type="reset" value="다시수정">
					<input type="button" value="뒤로" onclick="history.go(-1)">
				</td>
			</tr>
		</table>
		<input type="hidden" name="review_no" value="<%=review_no %>">
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
	</form>
</div>
</body>
</html>