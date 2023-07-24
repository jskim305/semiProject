<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
%>


<style>
	h1{background-color:#FFE08C;}
	body{background-color:#FAECC5;}
</style>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<h1>책 리뷰 작성</h1>
	<form method="post" name="postFrm" action="reviewPost.bo" enctype="multipart/form-data">
		<table width="500px">
			<tr>
				<th>성 명</th>
				<td><input name="user_id" size="10px" value="<%=id %>" readonly></td>
			</tr>
			<tr>
				<th>책 제목</th>
				<td><input name="book_name" size="10px"></td>
			</tr>
			<tr>
				<th>저 자</th>
				<td><input name="author" size="10px"></td>
			</tr>
			<tr>
				<th>출판사</th>
				<td><input name="publisher" size="10px"></td>
			</tr>
			<tr>
				<th>평 점</th>
				<td><input type="range" name="score" min="0" max="5" step="1" oninput="document.getElementById('value').innerHTML=this.value;">
					<span id="value"></span>
				</td>
			</tr>			
			<tr>
				<th>제 목</th>
				<td><input name="title" size="45px"></td>
			</tr>
			<tr>
				<th>내 용</th>
				<td><textarea name="content" placeholder="내용입력" cols="50" rows="10" style="resize:none"></textarea></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="review_pw" size="10px"></td>
			</tr>
			<tr>
				<th>책표지 업로드</th>
				<td><input type="file" name="filename"></td>
			</tr>
			<tr>
				<td colspan="2"><hr></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="등록">
					<input type="reset" value="다시쓰기">
					<input type="button" value="리스트" onclick="location.href='reviewBoard.jsp'">
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>