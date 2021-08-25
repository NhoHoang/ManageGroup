import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Random;
import java.util.Date;

public class Main2 {

	public static void main(String[] args) {

		Department department4 = new Department(4, "HR");
		Department department5 = new Department(5, "Quality Assurance");
		Department department6 = new Department(6, "Product Engineer");
		Department department7 = new Department(7, "Production Control");
		Department department8 = new Department(8, "Environment");
		// Question 2 Ex2:
//		System.out.println("Excersie 2");
//		int j3 = 100000000;
//		System.out.printf(Locale.US, "%,d%n", j3);

		// Question 3:
//		System.out.println("\n--Question 2--");

//		String pattern = "yyyy-MM-dd-HH-mm-ss";
//		SimpleDateFormat simpleDateFormatOfQ2 = new SimpleDateFormat(pattern);
//
//			Exam[] exams = { exam1, exam2, exam3 };
//		for (Exam exam : exams) {
//			date = simpleDateFormat.format(Group.createDate);
//			System.out.println("ID: "+exam.id);
//			System.out.println("Code: "+exam.code);
//			System.out.println("Title: "+exam.title);
//		/	System.out.println("Category: "+exam.categorys.name);
//			System.out.println("Duration: "+exam.duration);
//			System.out.println("Creator: "+exam.accs.userName);
//		  System.out.println("Create Date: "+ date); //Gọi hàm pattern 
//		}
		////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////
		// Data
		String date = "20/15/1999";

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");

		Date a = null;
		try {
			// parse: chuyển kiểu String về kiểu Date
			a = (Date) simpleDateFormat.parse(date);// ép date(kiểu String về định dạng Date)
													// định dạng kiểu Date: Mon Mar 20 00:00:00 ICT 2000
			System.out.println(a);

			// format: chuyển kiểu Date về kiểu String
			String t = simpleDateFormat.format(a);//
			System.out.println(t);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		////////////////////////////////////////////////////////////////////////////////

		String date2 = "2021/05/06";
		SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat("yyyy/MM/dd");
		Date b = null;
		try {
			b = (Date) simpleDateFormat2.parse(date2);
			System.out.println(b);

			String reverse = (String) simpleDateFormat.format(b);
			System.out.println(reverse);

		} catch (ParseException e) {
			e.printStackTrace();
		}

		////////////////////////////////////////////////////////////////////////////////

		Random question1 = new Random();
		int n = question1.nextInt();
		System.out.println("Số random là: " + n);
		System.out.println("Câu 2:");
		
		Random question2 = new Random();
		float f = question2.nextInt();
		System.out.println("Số random là: " + f);
	}

}
