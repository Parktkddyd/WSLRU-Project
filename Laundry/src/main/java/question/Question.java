package question;

public class Question {
	private int questionID;
	private String userID;
	private String questionTitle;
	private String questionContent;
	private String questionDate;
	private int questionGroup;
	private int questionDepth;
	private int questionSorts;
	private int qusetionAvailable;

	public int getQuestionID() {
		return questionID;
	}
	public void setQuestionID(int questionID) {
		this.questionID = questionID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getQuestionTitle() {
		return questionTitle;
	}
	public void setQuestionTitle(String questionTitle) {
		this.questionTitle = questionTitle;
	}
	public String getQuestionContent() {
		return questionContent;
	}
	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}
	public String getQuestionDate() {
		return questionDate;
	}
	public void setQuestionDate(String questionDate) {
		this.questionDate = questionDate;
	}
	public int getQuestionGroup() {
		return questionGroup;
	}
	public void setQuestionGroup(int questionGroup) {
		this.questionGroup = questionGroup;
	}
	public int getQuestionDepth() {
		return questionDepth;
	}
	public void setQuestionDepth(int questionDepth) {
		this.questionDepth = questionDepth;
	}
	public int getQuestionSorts() {
		return questionSorts;
	}
	public void setQuestionSorts(int questionSorts) {
		this.questionSorts = questionSorts;
	}
	public int getQusetionAvailable() {
		return qusetionAvailable;
	}
	public void setQusetionAvailable(int qusetionAvailable) {
		this.qusetionAvailable = qusetionAvailable;
	}
}
