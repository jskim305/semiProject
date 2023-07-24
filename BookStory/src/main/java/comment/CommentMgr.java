package comment;

import java.sql.*;
import java.util.ArrayList;

import db.DBConnectionMgr;

public class CommentMgr {
	private DBConnectionMgr pool;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	public CommentMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public ArrayList<CommentBean> getCommentList(int review_no){
		ArrayList<CommentBean> alist = new ArrayList<CommentBean>();
		
		try {
			con = pool.getConnection();
			sql = "select * from comment where review_no=? order by comment_date desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, review_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				/*
				ReplyBean bean = new ReplyBean();	// 빈 생성자로 객체 생성
				bean.setReno(rs.getInt(1));
				bean.setContent(rs.getString(2));
				bean.setRef(rs.getInt(3));
				bean.setName(rs.getString(4));
				bean.setRedate(rs.getString(5));
				alist.add(bean);
				*/
				
				// 생성자를 이용하면 위와 동일한 내용을 줄여서 작성 가능
				alist.add(new CommentBean(rs.getInt(1),
										rs.getString(2),
										rs.getInt(3),
										rs.getString(4),
										rs.getString(5),
										rs.getString(6)
										));
			}	// end of while
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return alist;
		
	}// end of getCommentList
	
	public int insertComment(CommentBean bean) {
		int flag = 0;
		
		try {
			con = pool.getConnection();
			sql = "insert into reply values(SEQ_COMMENT.NEXTVAL, ?, ?, ?, ?, SYSDATE)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setInt(2, bean.getReview_no());
			pstmt.setString(3, bean.getPw());
			pstmt.setString(4, bean.getContent());
			
			flag = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	
}// end of CommentMgr
