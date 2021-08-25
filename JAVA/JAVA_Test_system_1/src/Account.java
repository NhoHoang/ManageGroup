
public class Account {
	int id;
	String email;
	String userName;
	String fullName;
	Department deparment;
	Position postion;
	Date createDate;
	Gender gender;
	Group[] groups;
	
	public Account(int id, String userName, String fullName, Department deparment, Position postion, Gender gender) {
		super();
		this.id = id;
		this.userName = userName;
		this.fullName = fullName;
		this.deparment = deparment;
		this.postion = postion;
		this.gender = gender;
	}

	
	public Account () {
		super();
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public Department getDeparment() {
		return deparment;
	}

	public void setDeparment(Department deparment) {
		this.deparment = deparment;
	}

	public Position getPostion() {
		return postion;
	}

	public void setPostion(Position postion) {
		this.postion = postion;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	@Override
	public String toString() {
		return "Account [id=" + id + ", fullName=" + fullName + "]";
	}

	
}






