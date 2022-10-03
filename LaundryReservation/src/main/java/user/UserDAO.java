package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {
	
	String dbID = "root";
	String dbPass = "root";
	String url = "jdbc:mysql://localhost:3306/laundry";
	Connection con; // 데이터베이스에 접근할 수 있도록 설정
	ResultSet rs;//데이터베이스의 테이블의 결과를 리턴받아 자바에 저장해주는 객체
	
	//
	public void getCon(){
		try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection(url, dbID, dbPass);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	int result; // 로그인 결과에 따른 결과값 저장
	public int login(String id, String pass) {
		//첫번째 데이터베이스 연결
		try {
		getCon();
		//쿼리문 작성
		String sql = "SELECT userpassword, useravailable from USER where userid = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			if(rs.getString(1).equals(pass)) {
					if(rs.getInt(2) == 1)
						return 3; // 로그인 성공
					else if(rs.getInt(2) == 0)
						return 2; // 회원가입 승인 대기중
					else
						return 1; // 회원가입 승인 거절
			}
			else
				return 0; // 비밀번호 불일치
		}
		return -1; //아이디가 없음
		}catch(Exception e) {
			e.getStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int getNextUser() {
		try {
			getCon();
			String sql = "SELECT userno FROM USER ORDER BY userno DESC";
			PreparedStatement pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery(sql);
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	} // 회원가입시 신청 순서를 번호로 나타내기 위함
	
	public int join(User user) {
		try {
			getCon(); // 커넥션
			
			String sql = "INSERT INTO USER VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setInt(2, getNextUser());
			pstmt.setString(3, user.getUserPassword());
			pstmt.setString(4, user.getUserName());
			pstmt.setString(5, user.getUserBirth());
			pstmt.setString(6, user.getUserGender());
			pstmt.setString(7, user.getUserDept());
			pstmt.setString(8, user.getUserPhoneNumber());
			pstmt.setString(9, user.getUserEmail());
			pstmt.setInt(10, 0);
			return pstmt.executeUpdate(); //0이상의 반환값을 가짐.
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<User> getJoinList(int pageNumber){
		ArrayList<User> list = new ArrayList<User>();
		try {
			getCon();
			String sql = "SELECT * FROM USER WHERE useravailable = 0 ORDER BY userno DESC LIMIT 10 OFFSET ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, (pageNumber-1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserNo(rs.getInt(2));
				user.setUserName(rs.getString(3));
				user.setUserBirth(rs.getString(4));
				user.setUserGender(rs.getString(5));
				user.setUserDept(rs.getString(6));
				user.setUserPhoneNumber(rs.getString(7));
				list.add(user);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	public ArrayList<User> getRejectList(int pageNumber){
		ArrayList<User> list = new ArrayList<User>();
		try {
			getCon();
			String sql = "SELECT * FROM USER WHERE useravailable = -1 ORDER BY userno DESC LIMIT 10 OFFSET ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, (pageNumber-1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserNo(rs.getInt(2));
				user.setUserName(rs.getString(3));
				user.setUserBirth(rs.getString(4));
				user.setUserGender(rs.getString(5));
				user.setUserDept(rs.getString(6));
				user.setUserPhoneNumber(rs.getString(7));
				list.add(user);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	
	public int Permission(String userID, int Permission) {
		try {
			getCon();
			String sql = "UPDATE USER SET useravailable=? where userid = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Permission);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return -1; //DB오류
	}
	
	public int DeleteUser(String userID, int Permission) {
		try {
			getCon();
			String sql = "DELETE FROM USER  WHERE useravailable = ? and userid = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Permission);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB오류
	}
}
