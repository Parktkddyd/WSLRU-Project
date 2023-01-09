package realTimeUsg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class RealTimeUsgDAO {
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
	
	public HashMap<Integer, String> TimeList(int model, int UsingTime){		
		HashMap<Integer, String> hm = new HashMap<>();
		try {
			getCon();
			String sql = "SELECT * FROM laundry JOIN reservation "
					+ "ON laundry.laundryNo = reservation.laundryNo "
					+ "JOIN user ON reservation.userID = user.userID "
					+ "WHERE laundryModel = ? AND reserveUsingTime = ? AND reserveAvailable = ? AND laundryAvailable IN (?, ?)"
					+ "ORDER BY reserveNo";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, model);
			pstmt.setInt(2, UsingTime);
			pstmt.setInt(3, 1);
			pstmt.setInt(4, 2);
			pstmt.setInt(5, 3);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				hm.put(rs.getInt("laundryNo"), rs.getInt("laundryAvailable") + " " 
											    + rs.getString("reserveNo") + " "
											    + rs.getString("userName"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hm;
	}
}
