<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="review.ReviewBean" %>
<%@ page import="comment.CommentBean" %>

<jsp:useBean id="rMgr" class="review.ReviewMgr" />
<jsp:useBean id="cMgr" class="comment.CommentMgr" />  

<%
	request.setCharacterEncoding("UTF-8");
	int review_no = Integer.parseInt(request.getParameter("review_no"));
	String user_id = request.getParameter("id");
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	ReviewBean bean = rMgr.getBoard(review_no); 
	
	session.setAttribute("bean", bean);
%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	h2{background-color:#FFE08C; width:700px; text-align:center;}
	a:link{text-decoration:none; color:black;}
	a:hover{text-decoration:yes; color:blue;}
	th{background-color:#FFE08C;}
</style>

<script>
	function list(){
		listFrm.submit();
	}
	
	function download(filename){
		downFrm.filename.value = filename;
		downFrm.submit();
	}
</script>

</head>
<body>
	<h2><%=bean.getTitle() %></h2>
	<table width="700px">
		<tr>
			<th width="15%">이 름</th>
			<td width="40%"><%=bean.getUser_id() %></td>
			<th width="15%">등록날짜</th>
			<td width="30%"><%=bean.getReview_date().substring(0,10) %></td>
		</tr>
		<tr>
			<th>책 이름</th>
			<td><%=bean.getBook_name() %></td>
			<th>저 자</th>
			<td><%=bean.getAuthor() %></td>
		</tr>
		<tr>
			<td colspan="4">

				<pre><%=bean.getContent() %></pre>
			</td>
		</tr>

		<tr align="center">
			<td colspan="4">
				<hr>
				[
					<a href="javascript:list()">리스트</a> |
					<a href="update.jsp?nowPage=<%=nowPage %>&review_no=<%=review_no %>">수 정</a> |
					<a href="reply.jsp?nowPage=<%=nowPage %>">답 변</a> |
					<a href="delete.jsp?nowPage=<%=nowPage %>&review_no=<%=review_no %>">삭 제</a>
				]
			</td>
		</tr>
	</table>
	
	<table align="center" id="comment">
		<thead>
			<tr>
				<td> 댓글 작성
			<!-- 로그인한 사람만 댓글 달도록 하기 -->
			<%
				if(true){
			%>
					<td width="70%"><textarea row="3" cols="70" id="replyContent"></textarea></td>
					<td width="15%"><button onclick="insertReply();">댓글등록</button></td>
			<%
				} else{
			%>
					<td width="70%">로그인 후 사용가능한 서비스입니다.</td>
					<td width="15%"><button disabled>댓글등록</button></td>
			<%
				}
			%>
			</tr>
		</thead>
	</table>
		<br><br><br><hr>
	<table align="center" id="reply2">
		
	</table>
	
	<form name="listFrm" method="post" action="reviewBoard.jsp">
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
		<%
			if(!(keyWord==null || keyWord.equals("")) ){
		%>
			<input type="hidden" name="keyField" value="<%=keyField %>">
			<input type="hidden" name="keyWord" value="<%=keyWord %>">
		<%	}	%>	
	</form>
	
	
<script>
		$(function(){	// index.jsp가 실행되면 무조건 실행되는..jquery
			selectReplyList();
			setInterval(selectReplyList, 1000);	
			// 1000(1초)후 selectReplyList함수를 불러오는..
			// 실시간이 가능하나 리소스가 계속 쌓이는 단점..
		});
		
		function selectReplyList(){
			$.ajax({
				url : "rlist.bo",
				data : {review_no:<%=review_no %>},
				success : function(list){
					console.log(list);
					
					let result = "";
					for(let i=0; i<list.length; i++){
						result += "<tr>"
								+ "		<td>" + list[i].user_id + "</td>"
								+ "		<td>" + list[i].content + "</td>"
								+ "		<td>" + list[i].comment_date + "</td>"
								+ "</tr>";							
					} // end of for
					
					$("#reply2").html(result);
				},
				error : function(){
					console.log("댓글목록조회 ajax 통신 실패1");
				}
			});
		}
		
		function insertReply(){
			$.ajax({
				url : "rinsert.bo",
				data : {
					content : $("#replyContent").val(),
					review_no : <%=review_no %>,
					name : <%=user_id %>
				},
				type : "post",
				success : function(result){
					if(result == 1){
						selectReplyList();
						$("#replyContent").val("");
					}
				},
				error : function(){
					console.log("댓글등록 ajax 통신 실패2");
				}
			});
			
		}
		
	</script>	
	
	
</body>
</html>