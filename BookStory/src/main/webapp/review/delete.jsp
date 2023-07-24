<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="review.ReviewBean" %>
<jsp:useBean id="rMgr" class="review.ReviewMgr" />  

<!DOCTYPE html>
<style>
	h3{background-color:#A6A6A6;}
	body{background-color:#FAECC5;}
</style>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int review_no = Integer.parseInt(request.getParameter("review_no"));
	String nowPage = request.getParameter("nowPage");
	
	if(request.getParameter("review_pw") != null){
		String inPass = request.getParameter("review_pw");	// input에 넣은 패스워드
		String dbPass = ((ReviewBean)session.getAttribute("bean")).getReview_pw();
		
		if(dbPass.equals(inPass)){
			boolean result = rMgr.deleteBoard(review_no);
			
			if(result){//삭제 완료 후 화면 전환
				String url = "reviewBoard.jsp?nowPage="+nowPage;
				response.sendRedirect(url);	
			}
			else{// 삭제가 제대로 되지 않은 경우
				out.print("<script>");
				out.print("alert('삭제 실패!');");
				out.print("history.go(-2);");
				out.print("</script>");
			}
			
		}
		else {
			out.print("<script>");
			out.print("alert('비밀번호가 맞지않습니다.');");
			out.print("history.back();");
			out.print("</script>");
		}

	}
	else{	// 처음 delete.jsp에 들어왔을 때
%>
	<div align="center">
		<h3>사용자의 비밀번호를 입력해주세요</h3>
		<form method="post" name="deleteFrm" action="delete.jsp">
			<table width="500px">
				<tr align="center">
					<td><input type="password" name="pass" size="10px" required></td>
				</tr>
				
				<tr align="center">
					<td>
					<br>
						<input type="submit" value="삭제완료">
						<input type="reset" value="다시쓰기">
						<input type="button" value="뒤로" onclick="history.back()">
					</td>
				</tr>
			</table>
			<input type="hidden" name="review_no" value="<%=review_no %>">
			<input type="hidden" name="nowPage" value="<%=nowPage %>">
		</form>
	</div>

<%	} %>

</body>
</html>