package reservation;

public class Reservation {
		private String reserveNo;
		private String userID;
		private int laundryNo;
		private int reserveUsingTime;
		private String reserveDate;
		private int reserveAvailable;
		
		public String getReserveNo() {
			return reserveNo;
		}
		public void setReserveNo(String reserveNo) {
			this.reserveNo = reserveNo;
		}
		public String getUserID() {
			return userID;
		}
		public void setUserID(String userID) {
			this.userID = userID;
		}
		public int getLaundryNo() {
			return laundryNo;
		}
		public void setLaundryNo(int laundryNo) {
			this.laundryNo = laundryNo;
		}
		public int getReserveUsingTime() {
			return reserveUsingTime;
		}
		public void setReserveUsingTime(int reserveUsingTime) {
			this.reserveUsingTime = reserveUsingTime;
		}
		public String getReserveDate() {
			return reserveDate;
		}
		public void setReserveDate(String reserveDate) {
			this.reserveDate = reserveDate;
		}
		public int getReserveAvailable() {
			return reserveAvailable;
		}
		public void setReserveAvailable(int reserveAvailable) {
			this.reserveAvailable = reserveAvailable;
		}
}
