package review;

public class ReviewBean {
	private int review_no;
	private String user_id;
	private String title;
	private String book_name;
	private String book_picture;
	private String author;
	private String publisher;
	private String review_date;
	private int score;
	private String content;
	private String review_pw;
	private int isOpen;
	
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getBook_picture() {
		return book_picture;
	}
	public void setBook_picture(String book_picture) {
		this.book_picture = book_picture;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReview_pw() {
		return review_pw;
	}
	public void setReview_pw(String review_pw) {
		this.review_pw = review_pw;
	}
	public int getIsOpen() {
		return isOpen;
	}
	public void setIsOpen(int isOpen) {
		this.isOpen = isOpen;
	}
	
	@Override
	public String toString() {
		return "ReviewBean [review_no=" + review_no + ", user_id=" + user_id + ", title=" + title + ", book_name="
				+ book_name + ", book_picture=" + book_picture + ", author=" + author + ", publisher=" + publisher
				+ ", review_date=" + review_date + ", score=" + score + ", content=" + content + ", review_pw="
				+ review_pw + ", isOpen=" + isOpen + "]";
	}
}
