
public class Position {
	// thuoc tinh
	int id;
	PositionName name;

	// ham khoi tao cos tham so

	public Position(int id, PositionName name) {
		super();
		this.id = id;
		this.name = name;
	}

	// ham khoi tao rong
	public Position() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public PositionName getName() {
		return name;
	}

	public void setName(PositionName name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "Position [id=" + id + ", name=" + name + "]";
	}

}
