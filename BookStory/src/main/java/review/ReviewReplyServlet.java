package review;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BoardReplyServlet
 */
@WebServlet("/review/reviewReply.bo")
public class ReviewReplyServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	
		ReviewBean reBean = new ReviewBean();
		reBean.setUser_id(request.getParameter("user_id"));
		reBean.setTitle(request.getParameter("title"));
		reBean.setContent(request.getParameter("content"));
		reBean.setReview_pw(request.getParameter("review_pw"));
		
		ReviewMgr rMgr = new ReviewMgr();
		// comment에 관련된 부분 
	//	rMgr.replyUpBoard(reBean.getRef(), reBean.getPos());
	//	rMgr.replyBoard(reBean);
		
		response.sendRedirect("reviewBoard.jsp?nowPage="+request.getParameter("nowPage"));
		
	}

}
