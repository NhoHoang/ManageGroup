import java.text.SimpleDateFormat;

public class MainProgram {
	public static void main(String[] args) {

		// add data dept
		Department department1 = new Department();// Instance
		department1.setId(1);
		department1.setName("Sale");

		Department department2 = new Department();
		department2.id = 2;
		department2.name = "Marketing";

		Department department3 = new Department();
		department3.id = 3;
		department3.name = "Ky thuat";

		Department department4 = new Department(4, "HR");
		Department department5 = new Department(5, "Quality Assurance");
		Department department6 = new Department(6, "Product Engineer");
		Department department7 = new Department(7, "Production Control");
		Department department8 = new Department(8, "Environment");

		// add data position
		Position position1 = new Position(1, PositionName.DEV);
		Position position2 = new Position(2, PositionName.LEADER);
		Position position3 = new Position(3, PositionName.TEST);
		Position position4 = new Position(4, PositionName.GM);
		Position position5 = new Position(5, PositionName.PM);
		Position position6 = new Position(6, PositionName.SCRUM_MASTER);

		// Tao group
		Group nhom1 = new Group(1, "Group1");
		Group nhom2 = new Group(2, "Group2");
		Group nhom3 = new Group(3, "Group3");
		Group nhom4 = new Group(4, "Group4");
		Group nhom5 = new Group(5, "Group5");

		// add data account
		Account account1 = new Account();
		account1.setId(1);
		account1.setEmail("test1@gmail.com");
		account1.setUserName("NguyenTest1");
		account1.setFullName("Nguyen Van Test1");
		account1.setDeparment(department3);
		account1.setPostion(position1);
		account1.gender = (Gender.MALE);
		Group[] groupOfAccount1 = { nhom1, nhom2 };
		account1.groups = groupOfAccount1;

		Account account2 = new Account();
		account2.setId(1);
		account2.setEmail("test2@gmail.com");
		account2.setUserName("NguyenTest2");
		account2.setFullName("Nguyen Thi Test2");
		account2.setDeparment(department3);
		account2.setPostion(position2);
		account2.gender = (Gender.FEMALE);
		Group[] groupOfAccount2 = { nhom1, nhom2, nhom5 };
		account2.groups = groupOfAccount2;

		Account account3 = new Account();
		account3.setId(1);
		account3.setEmail("test3@gmail.com");
		account3.setUserName("NguyenTest3");
		account3.setFullName("Nguyen Van Test3");
		account3.setDeparment(department1);
		account3.setPostion(position3);
		account3.gender = Gender.MALE;
		Group[] groupOfAccount3 = { nhom1, nhom4 };
		account3.groups = groupOfAccount3;

		Account account4 = new Account(4, "NguyenTest4", "Nguyen Van Test3", department5, position6, Gender.UNKNOWN);
		Group[] groupOfAccount4 = { nhom2, nhom4, nhom5 };
		account4.groups = groupOfAccount4;

		Account account5 = new Account(5, "NguyenTest5", "Nguyen Van Test3", department4, position6, Gender.FEMALE);
		Group[] groupOfAccount5 = { nhom3, nhom5 };
		account5.groups = groupOfAccount5;

		Account account6 = new Account(6, "NguyenTest6", "Nguyen Van Test3", department1, position3, Gender.MALE);
		Group[] groupOfAccount6 = { nhom3 };
		account6.groups = groupOfAccount6;

		Account account7 = new Account(7, "NguyenTest7", "Nguyen Van Test6", department2, position1, Gender.FEMALE);
		Group[] groupOfAccount7 = { nhom1 };
		account7.groups = groupOfAccount7;

		System.out.println(account5.toString());

	}

}
