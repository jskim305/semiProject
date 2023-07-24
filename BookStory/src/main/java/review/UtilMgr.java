package review;

import java.io.File;
import java.io.UnsupportedEncodingException;

public class UtilMgr {
	public static String con(String s) {
		String str = null;
		try {
//			str = new String(s.getBytes("UTF-8"), "ISO-8859-1");
			str = new String(s.getBytes("8859_1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return str;
	} // end of con
	
	public static void delete(String s) {	// 첨부파일 삭제
		File file = new File(s);
		if(file.isFile())
			file.delete();
	}// end of delete
	
}// end of class
