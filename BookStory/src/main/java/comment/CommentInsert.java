package comment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/comment/rinsert.bo")
public class CommentInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String content = request.getParameter("content");
		int review_no = Integer.parseInt(request.getParameter("review_no"));
		String user_id = request.getParameter("user_id");
		String pw = request.getParameter("pw");
		
		CommentBean bean = new CommentBean();
		bean.setUser_id(user_id);
		bean.setReview_no(review_no);
		bean.setPw(pw);
		bean.setContent(content);
		
		int result = new CommentMgr().insertComment(bean);
		
		response.getWriter().print(result);
	}

}
