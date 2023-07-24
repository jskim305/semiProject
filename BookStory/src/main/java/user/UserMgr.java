package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.DBConnectionMgr;


public class UserMgr {
	private DBConnectionMgr pool;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	
	public UserMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean userInsert(UserBean bean) {
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "INSERT INTO USER_M VALUES(?,?,?,SYSDATE,?,?,?,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getPw());
			pstmt.setString(4, bean.getPhone());
			pstmt.setString(5, bean.getAddress());
			pstmt.setString(6, bean.getBirth());
			
			if(pstmt.executeUpdate() == 1)
				flag = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
		
	}// end of userInsert
	
	
	public boolean userLogin(String user_id, String pw) {
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "SELECT USER_ID FROM USER_M WHERE user_id=? and pw=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			
			flag = rs.next();
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return flag;
	} // end of userLogin
	
	public boolean userDelete(UserBean bean) {
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "DELETE FROM USER_M WHERE USER_ID=? AND PW=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setString(2, bean.getPw());
			pstmt.executeUpdate();
			
			flag = true;	
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	} // end of userDelete
	
	
}// end of UserMgr
