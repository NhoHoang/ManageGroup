import java.time.LocalDate;

public class Group {
	int id;
	String name;
	Account creator;
	LocalDate createDate;
	Account[] accounts;
	public Group(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	
	public Group() {
		super();
	}
	public int getId() {
		return id;
	}

	public void setId(byte id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Account getCreator() {
		return creator;
	}

	public void setCreator(Account creator) {
		this.creator = creator;
	}

}
