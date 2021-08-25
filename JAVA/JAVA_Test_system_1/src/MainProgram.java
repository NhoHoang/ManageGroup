import java.util.Locale;
import java.util.Scanner;

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
		account2.setId(2);
		account2.setEmail("test2@gmail.com");
		account2.setUserName("NguyenTest2");
		account2.setFullName("Nguyen Thi Test2");
		account2.setDeparment(department3);
		account2.setPostion(position2);
		account2.gender = (Gender.FEMALE);
		Group[] groupOfAccount2 = { nhom1, nhom2, nhom5 };
		account2.groups = groupOfAccount2;

		Account account3 = new Account();
		account3.setId(3);
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
		account5.groups = new Group[] { nhom2, nhom5 };

		Account account6 = new Account(6, "NguyenTest6", "Nguyen Van Test3", department1, position3, Gender.MALE);
		Group[] groupOfAccount6 = { nhom3 };
		account6.groups = groupOfAccount6;

		Account account7 = new Account(7, "NguyenTest7", "Nguyen Van Test6", department2, position1, Gender.FEMALE);
		Group[] groupOfAccount7 = { nhom1 };
		account7.groups = groupOfAccount7;

		nhom1.accounts = new Account[] { account1, account3, account4 };
		nhom2.accounts = new Account[] { account1, account2, account5 };
		nhom3.accounts = new Account[] { account6 };
		nhom4.accounts = new Account[] { account3, account4 };
		nhom5.accounts = new Account[] { account5, account4 };

		// System.out.println(account5.toString());
		System.out.println("Question1: ");
		// Question1:
		if (account2.deparment == null) {
			System.out.println("Nhân viên này chưa có phòng ban");
		} else {
			System.out.println("Phòng ban của nhân viên này là " + account2.deparment.name);
		}
		System.out.println("Question2: ");
		// Question2:
		int countGroupOfAcc2 = account2.groups.length;

		if (account2.groups == null) {
			System.out.println("Nhân viên này chưa có group");
		} else {
			if (countGroupOfAcc2 == 2) {
				System.out.println("Group của nhân viên này là Java Fresher, C# Fresher");
			} else {
				if (countGroupOfAcc2 == 3) {
					System.out.println("Nhân viên này là người quan trọng, tham gia nhiều group");
				} else {
					if (countGroupOfAcc2 >= 4) {
						System.out.println("Nhân viên này là người hóng chuyện, tham gia tất cả các group");
					}
				}

			}

		}

		System.out.println("Question3: ");
		// Question3:
		System.out.println((account2.deparment == null) ? "Nhân viên này chưa có phòng ban"
				: "Phòng ban của nhân viên này là " + account2.deparment.name);

		System.out.println("Question4: ");
		// Question4:

		System.out.println(account1.postion.name.toString() == "DEV" ? "Day la DEV" : "Day khong phai DEV");

		System.out.println("Question5: ");
		// Question5:
		int countAccount = nhom1.accounts.length;

		switch (countAccount) {
		case 1:
			System.out.println("Nhóm có một thành viên");
			break;
		case 2:
			System.out.println("Nhóm có hai thành viên");
			break;
		case 3:
			System.out.println("Nhóm có ba thành viên");
			break;

		default:
			System.out.println("Nhóm có nhiều thành viên");
		}

		System.out.println("Question6: ");
		// Question 6:

		if (countGroupOfAcc2 >= 4) {
			System.out.println("Nhân viên này là người hóng chuyện, tham gia tất cả các group");
		} else {
			switch (countGroupOfAcc2) {
			case 0:
				System.out.println("Nhân viên này chưa có group");
			case 2:
				System.out.println("Group của nhân viên này là Java Fresher, C# Fresher");
			case 3:
				System.out.println("Nhân viên này là người quan trọng, tham gia nhiều group");

				// case countGroup >=4:
			}

		}

		System.out.println("Question7: ");
		// Question 7:

		switch (account1.postion.name) {
		case DEV:
			System.out.println("thang nay là DEV");
			break;
		default:
			System.out.println("thang nay ko là DEV");
		}

		System.out.println("Question8: ");
		// Question 8:

		Account acc[] = new Account[] { account1, account2, account3, account4, account4, account5, account6,
				account7 };
		for (Account accountX : acc) {
			System.out.println("AccountID:" + accountX.id + " has " + " Name: " + accountX.fullName);
		}

		System.out.println("Question9: ");
		// Question9:
		Department deptArray[] = { department1, department2, department3, department4, department5, department6,
				department7 };

		for (Department deptX : deptArray) {
			System.out.println("Result: DeptID" + deptX.id + " has name: " + deptX.name);
		}

		System.out.println("Question10: ");
		// Question10:
		Account accQues10[] = new Account[] { account1, account2, account3, account4, account4, account5, account6,
				account7 };
		for (int i = 0; i < accQues10.length; i++) {
			System.out.println("Thong tin cua Account thu " + (i + 1) + " la:");
			System.out.println("Email: " + accQues10[i].email);
			System.out.println("Fullname: " + accQues10[i].fullName);
			System.out.println("Phong ban:" + accQues10[i].deparment.name);
			System.out.println("\n");
		}

		System.out.println("Question11: ");
		// Question11:
		Department deptQues11[] = { department1, department2, department3, department4, department5, department6,
				department7 };
		for (int i = 0; i < deptQues11.length; i++) {
			System.out.println("Thông tin department thứ " + (i + 1) + " la:");
			System.out.println("ID:" + deptQues11[i].id);
			System.out.println("Name: " + deptQues11[i].name);
			System.out.println("\n");
		}

		System.out.println("Question13: ");
		// Question13:
		Account accQues13[] = new Account[] { account1, account2, account3, account4, account4, account5, account6,
				account7 };
		for (int i = 0; i < accQues13.length; i++) {
			if (i == 1) {
				continue;
			}
			System.out.println("thong tin cua account co ID=" + (i + 1) + " la:");
			System.out.println("Email:" + accQues13[i].email);
			System.out.println("Fullname: " + accQues13[i].fullName);
		}

		System.out.println("Question14: ");
		// Question14:

		Account accQues14[] = new Account[] { account1, account2, account3, account4, account4, account5, account6,
				account7 };
		for (int i = 0; i < accQues14.length; i++) {

			System.out.println("thong tin cua account co ID=" + (i + 1) + " la:");
			System.out.println("Email:" + accQues14[i].email);
			System.out.println("Fullname: " + accQues14[i].fullName);
			if ((i + 1) > 4) {
				break;
			}
		}

		System.out.println("Question15: ");
		// Question15:
		System.out.println("so chan nho hon 20:");
		for (int i = 1; i < 20; i++) {
			if (i % 2 == 0) {
				System.out.print(i + ",");
				System.out.print("\n");
			}
		}

		System.out.println("Question16-10: ");
		// Question16-10:
		int j = 0;
		while (j < accQues10.length) {
			System.out.println("Thong tin cua Account thu " + (j + 1) + " la:");
			System.out.println("Email: " + accQues10[j].email);
			System.out.println("Fullname: " + accQues10[j].fullName);
			System.out.println("Phong ban:" + accQues10[j].deparment.name);
			System.out.println("\n");
			j += 1;
		}
		System.out.println("Question16-13: ");
		// Question16-13:

		int i = 0;
		while (i < accQues13.length) {

			if (i != 1) {
				
				System.out.println("thong tin cua account co ID=" + (i + 1) + " la:");
				System.out.println("Email:" + accQues13[i].email);
				System.out.println("Fullname: " + accQues13[i].fullName);

			}
			i += 1;

		}

		System.out.println("Question16-14: ");
		// Question16-14:
		int i1 = 0;
		while (i1 < accQues14.length) {
			if (i1 < 3) {
				System.out.println("thong tin cua account co ID=" + (i1 + 1) + " la:");
				System.out.println("Email:" + accQues14[i1].email);
				System.out.println("Fullname: " + accQues14[i1].fullName);
			}
			i1 += 1;
		}

		System.out.println("Question17-14: ");
		// Question17-14:
		int i2 = 0;
		do {
			if (i2 < 3) {
				System.out.println("thong tin cua account co ID=" + (i2 + 1) + " la:");
				System.out.println("Email:" + accQues14[i2].email);
				System.out.println("Fullname: " + accQues14[i2].fullName);
				i2 += 1;
			}
		} while (i2 < accQues14.length);

		
	
		//Excersie 2:
		System.out.println( "Excersie 2");
		int j3 =100000000; 
		System.out.printf(Locale.US, "%,d%n", j3); 
		
		
		
		
		
	}
}
