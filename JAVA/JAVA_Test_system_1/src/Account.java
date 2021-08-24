import java.time.LocalDate;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Account {
	int id;
	String email;
	String userName;
	String fullName;
	Department deparment;
	Position postion;
	LocalDate createDate;
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

	public LocalDate getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDate createDate) {
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
		return "Account có id=" + id + ", fullName=" + fullName + ", deparment=" + deparment + ", postion=" + postion
				+ ", gender=" + gender + "";
	}

	
}






