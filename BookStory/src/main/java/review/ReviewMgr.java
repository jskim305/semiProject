package review;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import review.UtilMgr;
import review.ReviewBean;
import db.DBConnectionMgr;

public class ReviewMgr {

	private DBConnectionMgr pool;
	private static final String SAVEFOLDER = "D:\\java_jskim\\04_jsp\\BookStory\\src\\main\\webapp\\source\\upload";
	private static final String ENCTYPE = "UTF-8";
	private static final int MAXSIZE = 50*1024*1024;
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	public ReviewMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public void reviewInsert(HttpServletRequest request) {
		MultipartRequest multi = null;
		String filename = null;
		
		try {
			con = pool.getConnection();
			File file = new File(SAVEFOLDER);
			if(!file.exists()) {
				file.mkdir();
			}
			
			multi = new MultipartRequest(request,
										 SAVEFOLDER,
										 MAXSIZE,
										 ENCTYPE,
										 new DefaultFileRenamePolicy());
			if(multi.getFilesystemName("filename") != null)
				filename = multi.getFilesystemName("filename");
			
			sql = "INSERT INTO REVIEW VALUES(SEQ_REVIEW.NEXTVAL,?,?,?,?,?,?,SYSDATE,?,?,?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("user_id"));			// user_id
			pstmt.setString(2, multi.getParameter("title"));			// title
			pstmt.setString(3, multi.getParameter("book_name"));		// book_name
			pstmt.setString(4, filename);								// book_picture
			pstmt.setString(5, multi.getParameter("author"));			// author
			pstmt.setString(6, multi.getParameter("publisher"));		// publisher
			
			if(multi.getParameter("score") != null)
				pstmt.setInt(7, Integer.parseInt(multi.getParameter("score")));	// score
			else
				pstmt.setInt(7, 0);
			
			pstmt.setString(8, multi.getParameter("content"));			// content
			pstmt.setString(9, multi.getParameter("review_pw"));		// review_pw
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}// end of reviewInsert
	
	public int getTotalCount(String keyField, String keyWord) {
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "SELECT COUNT(*) FROM REVIEW";
				pstmt = con.prepareStatement(sql);
			}
			else {
				sql = "SELECT COUNT(*) FROM REVIEW WHERE " + keyField + " like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			
			rs = pstmt.executeQuery();
			if(rs.next())
				totalCount = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return totalCount;
	} // end of getTotalCount
	
	public ArrayList<ReviewBean> getBoardList(String keyField, String keyWord, int start, int end) {
		ArrayList<ReviewBean> alist = new ArrayList<ReviewBean>();
		try {
			con = pool.getConnection();
			if(keyWord.equals("null")||keyWord.equals("")) {
				sql = "SELECT BT2.*"
					+  " FROM (SELECT ROWNUM R1, BT1.*"
					+		   " FROM(SELECT *"
					+		   		  " FROM REVIEW"
					+   		   	 " ORDER BY REVIEW_DATE DESC)BT1"
					+ 		   ")BT2"
					+ " WHERE R1 >= ? AND R1 <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} // end of if 
			else {
				sql = "SELECT BT2.*"
					+  " FROM (SELECT ROWNUM R1, BT1.*"
					+		   " FROM(SELECT *"
					+		   		  " FROM REVIEW"
					+   		   	 " ORDER BY REVIEW_DATE DESC)BT1"
					+ 		  " WHERE " + keyField + " like ?"
					+ 		   ")BT2"
					+ " WHERE R1 >= ? AND R1 <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);		
			} // end of else
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewBean bean = new ReviewBean();
				bean.setReview_no(rs.getInt("review_no"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setTitle(rs.getString("title"));
				bean.setBook_name(rs.getString("book_name"));
				bean.setBook_picture(rs.getString("book_picture"));
				bean.setAuthor(rs.getString("author"));
				bean.setPublisher(rs.getString("publisher"));
				bean.setReview_date(rs.getString("review_date"));
				bean.setScore(rs.getInt("score"));
				bean.setContent(rs.getString("content"));
				bean.setReview_pw(rs.getString("review_pw"));
				bean.setIsOpen(rs.getInt("isOpen"));
				
				alist.add(bean);
			} // end of while
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
		return alist;
	} // end of getBoardList 
	
	public ReviewBean getBoard(int review_no) {
		ReviewBean bean = new ReviewBean();
		
		try {
			con = pool.getConnection();
			sql = "select * from review where review_no = " + review_no;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setReview_no(rs.getInt("review_no"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setTitle(rs.getString("title"));
				bean.setBook_name(rs.getString("book_name"));
				bean.setBook_picture(rs.getString("book_picture"));
				bean.setAuthor(rs.getString("author"));
				bean.setPublisher(rs.getString("publisher"));
				bean.setReview_date(rs.getString("review_date"));
				bean.setScore(rs.getInt("score"));
				bean.setContent(rs.getString("content"));
				bean.setReview_pw(rs.getString("review_pw"));
				bean.setIsOpen(rs.getInt("isOpen"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return bean;
	} // end of getBoard
	
	public void updateBoard(ReviewBean upBean) {
		try {
			con = pool.getConnection();
			sql = "UPDATE REVIEW SET TITLE = ?, BOOK_NAME = ?, AUTHOR = ?, PUBLISHER = ?, SCORE = ?, CONTENT = ? WHERE REVIEW_NO = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, upBean.getTitle());
			pstmt.setString(2, upBean.getBook_name());
			pstmt.setString(3, upBean.getAuthor());
			pstmt.setString(4, upBean.getPublisher());
			pstmt.setInt(5, upBean.getScore());
			pstmt.setString(6, upBean.getContent());
			pstmt.setInt(7, upBean.getReview_no());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
	}// end of updateBoard
	
	public boolean deleteBoard(int review_no) {
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "SELECT count(*) FROM COMMENT WHERE REVIEW_NO=?";
			//comment 테이블에 있는 댓글이 몇개나 있는지 확인
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, review_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int result = rs.getInt(1);
				
				if(result != 0) {	// 리뷰에 댓글이 있는 경우
					sql = "DELETE FROM COMMENT WHERE REVIEW_NO=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, review_no);
					pstmt.executeUpdate();
				}
				
				// 지우려는 글에 책표지 파일이 있는지 확인
				sql = "SELECT BOOK_PICTURE FROM REVIEW WHERE REVIEW_NO=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, review_no);
				rs = pstmt.executeQuery();
				
				if(rs.next() && rs.getString(1) != null) {	// 책표지 파일이 있는 경우
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
					if(file.exists()) {
						UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));// 책표지 파일 삭제
					}
				}
				
				// 리뷰 삭제
				sql = "DELETE FROM REVIEW WHERE REVIEW_NO=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, review_no);
				pstmt.executeUpdate();

				flag = true;

				
			}// end of if(rs.next())
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
		
	} // end of deleteBoard
	
	
	
}// end of ReviewMgr
