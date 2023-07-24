package note;

public class NoteBean {
	private int note_no;
	private String user_id;
	private String receive_id;
	private String content;
	private int authority;
	
	public int getNote_no() {
		return note_no;
	}
	public void setNote_no(int note_no) {
		this.note_no = note_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getReceive_id() {
		return receive_id;
	}
	public void setReceive_id(String receive_id) {
		this.receive_id = receive_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getAuthority() {
		return authority;
	}
	public void setAuthority(int authority) {
		this.authority = authority;
	}
	
	@Override
	public String toString() {
		return "NoteBean [note_no=" + note_no + ", user_id=" + user_id + ", receive_id=" + receive_id + ", content="
				+ content + ", authority=" + authority + "]";
	}
	
	
	
}
