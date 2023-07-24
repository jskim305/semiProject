package comment;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;


@WebServlet("/comment/rlist.bo")
public class CommentList extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int review_no = Integer.parseInt(request.getParameter("review_no"));
		
		ArrayList<CommentBean> alist = new CommentMgr().getCommentList(review_no);
		
		response.setContentType("application/json; charset=UTF-8");
		new Gson().toJson(alist, response.getWriter());
	}

}
