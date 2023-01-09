package reservation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

public class ReservationDAO {
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
	
	public String getReserveNoDateFormat(){
		try {
			getCon();
			String sql = "SELECT DATE_FORMAT(NOW(),'%Y%m%d')";
			PreparedStatement pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //DB 오류
	}
	
	public String getNextReserveNo() {
		try {
			getCon();
			String RsvNum;
			String sql = "SELECT reserveNo FROM reservation WHERE reserveNo like ? ORDER BY reserveNo DESC";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, getReserveNoDateFormat() + "%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				RsvNum = String.format("%05d", Integer.parseInt(rs.getString(1).substring(9, 13))+1);
				return getReserveNoDateFormat()+RsvNum; // 제일 첫번째 예약이 아니라면 가장 최근에 예약한 예약번호에 1더하기
			} else{
				RsvNum = String.format("%05d", 1);
				return getReserveNoDateFormat()+RsvNum; // 첫번째 예약번호로 리턴
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //DB 오류
	}
	
	public int searchReservation(String id) {
		try {
			getCon();
			String sql = "SELECT userID, reserveAvailable FROM reservation WHERE userID = ? and reserveAvailable IN (?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, 0);
			pstmt.setInt(3, 1);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return 2; // 이미 예약이 되어 있다.
			}else {
				return 1; // 예약 가능
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int MakeReservation(String id, int usingTime, String currentTime) {
		try {
			getCon();
			String sql = "INSERT INTO reservation(reserveNo, userID, reserveUsingTime, reserveDate, reserveAvailable)"
					+ " VALUES(?, ?, ?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, getNextReserveNo());
			pstmt.setString(2, id);
			pstmt.setInt(3, usingTime);
			pstmt.setString(4, currentTime);
			pstmt.setInt(5, 0);
			return pstmt.executeUpdate(); // 양수의 값 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 음수일 시 DB 오류
	}
	
	public ArrayList<Reservation> getMyReservationList(String id, int pageNumber){
		ArrayList<Reservation> rsvList = new ArrayList<Reservation>();
		try {
			getCon();
			String sql = "SELECT reserveNo, reserveDate, reserveUsingTime, reserveAvailable"
					+ " FROM Reservation WHERE userID = ? ORDER BY reserveNo DESC LIMIT 10 OFFSET ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, (pageNumber-1)*10); 
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Reservation rsv = new Reservation();
				rsv.setReserveNo(rs.getString(1));
				rsv.setReserveDate(rs.getString(2));
				rsv.setReserveUsingTime(rs.getInt(3));
				rsv.setReserveAvailable(rs.getInt(4));
				rsvList.add(rsv);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return rsvList;
	}
	
	public int getmyReservationCount(String id) {
		try {
			int rowCount = 0;
			getCon();
			String sql = "SELECT COUNT(*) FROM reservation WHERE userID = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rowCount = rs.getInt(1);
				return rowCount;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public int CancelReservation(int cancel, String id) {
		try {
			getCon();
			String sql = "UPDATE reservation SET reserveAvailable = ? WHERE userID = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cancel);
			pstmt.setString(2, id);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB오류
	}
	
	public Queue<Reservation> NoUsingList(int UsingTime, int ldryCnt){
		Queue<Reservation> list = new LinkedList<>();
		try {
			getCon();
			String sql = "SELECT * FROM reservation WHERE reserveUsingTime = ? AND reserveAvailable = ? "
					+ "ORDER BY reserveDate LIMIT ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, UsingTime);
			pstmt.setInt(2, 0);
			pstmt.setInt(3, ldryCnt);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Reservation noUse = new Reservation();
				noUse.setReserveNo(rs.getString(1));
				noUse.setUserID(rs.getString(2));
				noUse.setLaundryNo(rs.getInt(3));
				noUse.setReserveUsingTime(rs.getInt(4));
				noUse.setReserveDate(rs.getString(5));
				noUse.setReserveAvailable(rs.getInt(6));
				list.add(noUse);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int UpdateLdryNum(Reservation rsvPerson) {
		try {
			getCon();
			String sql = "UPDATE reservation SET laundryNo = ?, reserveAvailable = ? WHERE userID = ? AND reserveAvailable = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rsvPerson.getLaundryNo());
			pstmt.setInt(2, rsvPerson.getReserveAvailable());
			pstmt.setString(3, rsvPerson.getUserID());
			pstmt.setInt(4, 0);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; //DB 오류
	}
	
	public Reservation PerformedRsvPerson(int ldryNo) {
		Reservation rsvOne = new Reservation();
		try {
			getCon();
			String sql = "SELECT * FROM reservation WHERE reserveAvailable = ? AND laundryNo = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, 1);
			pstmt.setInt(2, ldryNo);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rsvOne.setReserveNo(rs.getString(1));
				rsvOne.setUserID(rs.getString(2));
				rsvOne.setLaundryNo(rs.getInt(3));
				rsvOne.setReserveUsingTime(rs.getInt(4));
				rsvOne.setReserveDate(rs.getString(5));
				rsvOne.setReserveAvailable(rs.getInt(6));
				return rsvOne;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null; // 오류
	}
	
	public int PerformedLdry(Reservation rsvPerson) {
		try {
			getCon();
			String sql = "UPDATE reservation SET reserveAvailable = ? WHERE laundryNo = ? AND userID = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rsvPerson.getReserveAvailable());
			pstmt.setInt(2, rsvPerson.getLaundryNo());
			pstmt.setString(3, rsvPerson.getUserID());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // DB 오류
	}
	
	public ArrayList<String> OrderList(int UsingTime){
		ArrayList<String> list = new ArrayList<>();
		try {
			getCon();
			String sql = "SELECT reserveNo FROM reservation WHERE reserveUsingTime = ? AND reserveAvailable = ? ORDER BY reserveNo";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, UsingTime);
			pstmt.setInt(2, 0);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String order = null;
				order = rs.getString(1);
				list.add(order);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	public String getMyOrder(String id) {
		try {
			getCon();
			String sql = "SELECT reserveNo FROM reservation where reserveAvailable = ? AND userID = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, 0);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null; //DB 오류
	}
}
