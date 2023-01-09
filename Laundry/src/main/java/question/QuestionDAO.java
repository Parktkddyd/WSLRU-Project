package question;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class QuestionDAO {
	private String dbURL = "jdbc:mysql://localhost:3306/laundry";
	private String dbID = "root";
	private String dbPass = "rootpw";
	private Connection con;
	private ResultSet rs;
	
	public void getCon() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbID, dbPass);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getNextQuestion() {
		try {
			getCon();
			String sql = "SELECT questionID FROM question ORDER BY questionID DESC";
			PreparedStatement pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery(sql);
			if(rs.next()) {
				return rs.getInt(1) + 1; // 결과 있을 경우 해당 값 + 1
			}
			return 1; // 없을 경우 ID에 1부여
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB오류
	} // 다음 Q&A글을 나타내기 위함.
	
	public int getNextQuestionGroup(){
		try {
			getCon();
			String sql = "SELECT max(questionGroup) FROM question";
			PreparedStatement pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery(sql);
			if(rs.next()) {
				return rs.getInt(1) +1;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; //DB오류
	}
	
	public ArrayList<Question> getQuestionList(int pageNumber){
		ArrayList<Question> list = new ArrayList<Question>();
		try {
			getCon();
			String sql = "SELECT * FROM question WHERE questionAvailable = 0 or questionDepth = 0"
					+ " ORDER BY questionGroup desc, questionSorts asc LIMIT 10 OFFSET ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, (pageNumber-1)*10); 
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Question qus = new Question();
				qus.setQuestionID(rs.getInt(1));
				qus.setUserID(rs.getString(2));
				qus.setQuestionTitle(rs.getString(3));
				qus.setQuestionContent(rs.getString(4));
				qus.setQuestionDate(rs.getString(5));
				qus.setQuestionGroup(rs.getInt(6));
				qus.setQuestionDepth(rs.getInt(7));
				qus.setQuestionSorts(rs.getInt(8));
				qus.setQusetionAvailable(rs.getInt(9));
				list.add(qus);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	
	public ArrayList<Question> getMyQuestionList(int pageNumber, String id){
		ArrayList<Question> list = new ArrayList<Question>();
		try {
			getCon();
			String sql = "SELECT * FROM question WHERE (questionAvailable = 0 or questionDepth = 0) AND userID = ? ORDER BY questionGroup desc, questionSorts asc LIMIT 10 OFFSET ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, (pageNumber-1)*10); 
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Question qus = new Question();
				qus.setQuestionID(rs.getInt(1));
				qus.setUserID(rs.getString(2));
				qus.setQuestionTitle(rs.getString(3));
				qus.setQuestionContent(rs.getString(4));
				qus.setQuestionDate(rs.getString(5));
				qus.setQuestionGroup(rs.getInt(6));
				qus.setQuestionDepth(rs.getInt(7));
				qus.setQuestionSorts(rs.getInt(8));
				qus.setQusetionAvailable(rs.getInt(9));
				list.add(qus);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	
	public int getQuestionCount() {
		try {
			int rowCount = 0;
			getCon();
			String sql = "SELECT COUNT(*) FROM question WHERE questionAvailable = 0 or questionDepth = 0";
			PreparedStatement pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rowCount = rs.getInt(1);
				return rowCount;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return -1; //DB 오류
	}
	public String getUserID(int questionID) {
		try {
			getCon();
			String sql = "SELECT userID FROM question where questionID = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, questionID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1); //userID
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null; //DB 오류
	}
	
	public Question viewQuestion(int questionID) {
		try {
			getCon();
			String sql = "SELECT * FROM question where questionID = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, questionID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Question qus = new Question();
				qus.setQuestionID(rs.getInt(1));
				qus.setUserID(rs.getString(2));
				qus.setQuestionTitle(rs.getString(3));
				qus.setQuestionContent(rs.getString(4));
				qus.setQuestionDate(rs.getString(5));
				qus.setQuestionGroup(rs.getInt(6));
				qus.setQuestionDepth(rs.getInt(7));
				qus.setQuestionSorts(rs.getInt(8));
				qus.setQusetionAvailable(rs.getInt(9));
				return qus;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null; //DB 오류
	}
	
	public int writeQuestion(String id, String title, String content, String Date) {
		try {
			getCon();
			String sql = "INSERT INTO QUESTION VALUES(?,?,?,?,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, getNextQuestion());
			pstmt.setString(2, id);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.setString(5, Date);
			pstmt.setInt(6, getNextQuestionGroup());
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			return pstmt.executeUpdate(); // 정상 삽입 경우 0이상의 값 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //삽입 오류
	}
	
	public int updateQuestion(int qusID, String title, String content, String Date) {
		try {
			getCon();
			String sql = "UPDATE question SET questionTitle=?, questionContent=?, questionDate=? WHERE questionID = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, Date);
			pstmt.setInt(4, qusID);
			return pstmt.executeUpdate(); // 정상 삽입 경우 0이상의 값 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //삽입 오류
	}
	
	public int deleteQuestion(int qusID) {
		try {
			getCon();
			String sql = "UPDATE question SET questionAvailable = -1 WHERE questionID = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qusID);
			return pstmt.executeUpdate(); // 정상 삽입 경우 0이상의 값 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //삽입 오류
	}
	
	public Question QuestionInfo(int qusID) {
		try {
			getCon();
			String sql = "SELECT * FROM question WHERE questionID = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qusID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Question qus = new Question();
				qus.setQuestionID(rs.getInt(1));
				qus.setUserID(rs.getString(2));
				qus.setQuestionTitle(rs.getString(3));
				qus.setQuestionContent(rs.getString(4));
				qus.setQuestionDate(rs.getString(5));
				qus.setQuestionGroup(rs.getInt(6));
				qus.setQuestionDepth(rs.getInt(7));
				qus.setQuestionSorts(rs.getInt(8));
				qus.setQusetionAvailable(rs.getInt(9));
				return qus;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return null; // DB 오류
	}
	
	public int getReplyCount(int qusGroup, int qusDepth) {
		try {
			getCon();
			String sql = "SELECT COUNT(*) FROM question WHERE questionGroup = ? AND questionDepth = ? AND questionAvailable = 0";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qusGroup);
			pstmt.setInt(2, 1);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // DB 오류
	}
	public int writeReplyQuestion(String id, String title, String content, String Date, int qusGroup, int qusSorts) {
		try {
			getCon();
			String sql = "INSERT INTO QUESTION VALUES(?,?,?,?,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, getNextQuestion());
			pstmt.setString(2, id);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.setString(5, Date);
			pstmt.setInt(6, qusGroup);
			pstmt.setInt(7, 1);
			pstmt.setInt(8, qusSorts+1);
			pstmt.setInt(9, 0);
			return pstmt.executeUpdate(); // 정상 삽입 경우 0이상의 값 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //삽입 오류
	}
	
	public int deleteReply(int qusID) {
		try {
			getCon();
			String sql = "UPDATE question SET questionAvailable = -1 WHERE questionID = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qusID);
			return pstmt.executeUpdate(); // 정상 삽입 경우 0이상의 값 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //삽입 오류
	}
	
	public int deleteReplyCascade(int qusID) {
		try {
			getCon();
			String sql = "UPDATE question SET questionAvailable = -1 WHERE questionGroup = "
					+ "(SELECT questionGroup FROM (SELECT questionGroup FROM question WHERE questionID = ?)as subQuestion)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qusID);
			return pstmt.executeUpdate(); // 정상 삽입 경우 0이상의 값 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //삽입 오류
	}
}
