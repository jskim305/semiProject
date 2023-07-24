<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*, review.*" %> 
<jsp:useBean id="rMgr" class="review.ReviewMgr" /> 
<%
	request.setCharacterEncoding("UTF-8");
	int totalRecord = 0;		// 전체 행의 수
	int numPerPage = 10;		// 페이지당 레코드 수
	int pagePerBlock = 5;		// 블록당 보여줄 페이지 수
	
	int totalPage = 0;			// 전체 페이지 수	ceil(totalRecord/numPerPage)
	int totalBlock = 0;			// 전체 블록 수		ceil(totalPage/pagePerBlock)
	
	int nowPage = 1;			// 현재 해당하는 페이지
	int nowBlock = 1;			// 현재 해당하는 블록
	
	int start = 0;				// DB테이블의 select 시작번호
	int end = 0;				// 가져온 레코드 중에서 10개씩만 가져오기
	int listSize = 0;			// 현재 읽어온 게시물의 수
	
	String keyWord="", keyField="";
	if(request.getParameter("keyWord") != null){
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	
	/*	[처음으로]를 누를 때	*/
	if(request.getParameter("reload")!= null){
		if(request.getParameter("reload").equals("true")){
			keyWord = "";
			keyField = "";
		}
	}
	
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	start = ((nowPage*numPerPage)-numPerPage)+1;
	end = nowPage*numPerPage;
	totalRecord = rMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil(totalRecord/(double)numPerPage);	// 전체페이지 수
	nowBlock = (int)Math.ceil(nowPage/(double)pagePerBlock);	// 현재블록 계산
	totalBlock = (int)Math.ceil(totalPage/(double)pagePerBlock);// 전체블록 계산
	
	String id = (String)session.getAttribute("idKey");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	a:link{text-decoration:none; color:black;}
	a:hover{text-decoration:yes; color:blue;}
	a:visited{text-decoration:none; color:gray;}
</style>

<script>
	function read(review_no){
		readFrm.review_no.value = review_no;
		readFrm.action = "read.jsp";
		readFrm.submit();
	}
	
	function list(){
		listFrm.action = "reviewBoard.jsp";
		listFrm.submit();
	}
	
	function paging(page){
		readFrm.nowPage.value = page;
		readFrm.submit();
	}
	
	function block(value){
		readFrm.nowPage.value = <%=pagePerBlock %>*(value-1)+1;
		readFrm.submit();
	}
	
</script>

</head>
<body bgcolor="#D5D5D5">
	<h2 align="center"><%=id %>의 Book Story에 오신걸 환영합니다.</h2>
	<table align="center" width="700px">
		<tr>
			<td colspan="5" >Total : <%=totalRecord %> Articles (<%=nowPage %> / <%=totalPage %>)Page</td>
		</tr>		
		<tr bgcolor="#BDBDBD">
			<th width="5%">번호</th>
			<th width="40%">제목</th>
			<th width="25%">책이름</th>
			<th width="15%">저자</th>
			<th width="15%">날짜</th>
		</tr>
		<%
			ArrayList<ReviewBean> alist = rMgr.getBoardList(keyField, keyWord, start, end);
			listSize = alist.size();
			
			for(int i=0; i<end; i++){
				if(i == listSize)
					break;
				
				ReviewBean bean = alist.get(i);
				
				int num = bean.getReview_no();
				//int depth = bean.getDepth();	이거는 comment에서 Reveiw_no로 가져오면서 Comment_date 내림차순으로 
		%>
		<tr>
			<td align="center"><%=totalRecord - (nowPage-1)*numPerPage -i %></td> <!-- 번호 -->
			<td align="center"><a href="javascript:read('<%=bean.getReview_no() %>')"><%=bean.getTitle() %></a></td>
			<td align="center"><%=bean.getBook_name() %></td>
			<td align="center"><%=bean.getAuthor() %></td>
			<td align="center"><%=bean.getReview_date().substring(0,10) %></td>
		</tr>
		
		
		<%	} %>
		<tr>
			<td colspan="5"><br/><br/></td>
		</tr>
		<tr>
			<!-- 페이징처리 시작 -->
			<td colspan="3">
			<%
				int pageStart = (nowBlock-1) * pagePerBlock + 1;
				int pageEnd = pageStart + pagePerBlock <= totalPage ? pageStart + pagePerBlock : totalPage+1;//totalPage+1??
				if(totalPage != 0){
					if(nowBlock > 1){
			%>
						<a href="javascript:block('<%=nowBlock-1 %>')">prev...</a>&nbsp;
			<%
					}
					for(; pageStart<pageEnd; pageStart++){
			%>
						<a href="javascript:paging('<%=pageStart %>')">[<%=pageStart %>]</a>&nbsp;
			<%			
					}
					if(totalBlock > nowBlock){
			%>
						<a href="javascript:block('<%=nowBlock+1 %>')">...next</a>
			<%
					}
				}
			%>
			</td>
			<!-- 페이징처리 끝 -->
			
			<td colspan="2" align="right">
				<a href = "post.jsp" >[글쓰기]</a>
				<a href = "javascript:list()">[처음으로]</a>
				<a href = "../index.jsp">[홈으로]</a>
			</td>
		</tr>
	</table>
	<hr width="700"/>
	<form name="searchFrm" method="get" action="reviewBoard.jsp">
		<table align="center" width="800">
			<tr>
				<td align="center">
					<select name="keyField">
						<option value="title">제목</option>
						<option value="author">저자</option>
						<option value="content">내용</option>
					</select>
					<input name="keyWord" required>
					<input type="submit" value="찾기">
					<input type="hidden" name="nowPage" value="1">
				</td>
			</tr>
		</table>
	</form>
	<!-- [처음으로] 누르면 화면이 reload -->
	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true">
		<input type="hidden" name="nowPage" value="1">
	</form>
	
	<!-- 제목을 누르면 상세보기 페이지로 갈 때 파라미터 값 -->
	<form name="readFrm" method="get">
			<input type="hidden" name="review_no">
			<input type="hidden" name="user_id" value="<%=id %>">
			<input type="hidden" name="nowPage" value="<%=nowPage %>">
			<input type="hidden" name="keyField" value="<%=keyField %>">
			<input type="hidden" name="keyWord" value="<%=keyWord %>">
	</form>
</body>
</html>