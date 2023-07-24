package comment;

public class CommentBean {
	private int comment_no;
	private String user_id;
	private int review_no;
	private String pw;
	private String content;
	private String comment_date;

	
	public CommentBean() {

	}
	
	public CommentBean(int comment_no, String user_id, int review_no, String pw, String content, String comment_date) {
		super();
		this.comment_no = comment_no;
		this.user_id = user_id;
		this.review_no = review_no;
		this.pw = pw;
		this.content = content;
		this.comment_date = comment_date;
	}

	public int getComment_no() {
		return comment_no;
	}
	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getComment_date() {
		return comment_date;
	}
	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}
	
	@Override
	public String toString() {
		return "CommentBean [comment_no=" + comment_no + ", user_id=" + user_id + ", review_no=" + review_no + ", pw="
				+ pw + ", content=" + content + ", comment_date=" + comment_date + "]";
	}
		
}
