package review;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/review/reviewUpdate.bo")
public class ReviewUpdateServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		String nowPage = request.getParameter("nowPage");
		
		/* update.jsp에서 보낸 데이터를 받아오는 구문 */
		ReviewBean upBean = new ReviewBean();
		upBean.setReview_no(Integer.parseInt(request.getParameter("review_no")));
		upBean.setTitle(request.getParameter("title"));
		upBean.setBook_name(request.getParameter("book_name"));
		upBean.setAuthor(request.getParameter("author"));
		upBean.setPublisher(request.getParameter("publisher"));
		upBean.setScore(Integer.parseInt(request.getParameter("score")));
		upBean.setContent(request.getParameter("content"));
		
		upBean.setReview_pw(request.getParameter("review_pw"));
		
		/* session에 저장된 값을 받아와서 pass를 비교하는 구문 */
		HttpSession session = request.getSession();
		ReviewBean sessionBean = (ReviewBean)session.getAttribute("bean");
		
		ReviewMgr rMgr = new ReviewMgr();
		
		if(sessionBean.getReview_pw().equals(upBean.getReview_pw())) {
			rMgr.updateBoard(upBean);
			String url = "read.jsp?nowPage="+ nowPage + "&review_no=" + upBean.getReview_no();
			response.sendRedirect(url);
		}
		else {
			out.print("<script>");
			out.print("alert('비밀번호가 맞지않습니다.');");
			out.print("history.back();");
			out.print("</script>");
		}
	}
}
