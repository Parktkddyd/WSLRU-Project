package laundry;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.HashMap;

public class LaundryDAO {
	private String dbID = "root";
	private String dbPass = "rootpw";
	private String url = "jdbc:mysql://localhost:3306/laundry";
	private Connection con;
	private ResultSet rs;
	
	public void getCon() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, dbID, dbPass);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public int LdryCount(int model) {
		try {
			getCon();
			String sql = "SELECT COUNT(*) FROM laundry WHERE laundryModel = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, model);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getInt(1); // 성공 시 0이상의 개수 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 연동 오류
	}
	
	public HashMap<Integer, Integer> AvlLdryList(int model){ // 세탁기 상태 담는 리스트
		HashMap<Integer, Integer> hm = new HashMap<>();
		try {
			getCon();
			String sql = "SELECT laundryNo, laundryAvailable from laundry "
						 + "WHERE laundryModel = ? ORDER BY laundryNo";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, model);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				hm.put(rs.getInt(1), rs.getInt(2));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hm;
	}
	
	public int InsertTime(String startTime, String endTime, int laundryNo) {
		try {
			getCon();
			String sql = "UPDATE laundry set laundryStartTime = ?, laundryEndTime = ?, laundryAvailable = ? "
					+ "WHERE laundryNo = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, startTime);
			pstmt.setString(2, endTime);
			pstmt.setInt(3, 2);
			pstmt.setInt(4, laundryNo);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; //DB 오류
	}
	
	public Date EndTime(int laundryNo) {
		Date EndTime = null;
		try {
			getCon();
			String sql = "SELECT laundryEndTime FROM laundry WHERE laundryNo = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, laundryNo);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				EndTime = rs.getTimestamp(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return EndTime;
	}
	
	public int UpdateStatus(int laundryNo) {
		try {
			getCon();
			String sql = "UPDATE laundry SET laundryAvailable = 3 WHERE laundryNo = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, laundryNo);
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	}
	
	public int InitStatus(int laundryNo) {
		try {
			getCon();
			String sql = "UPDATE laundry SET laundryAvailable = 1, laundryStartTime = null, laundryEndTime = null WHERE laundryNo = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, laundryNo);
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	}
}
