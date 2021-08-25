import java.util.Scanner;

public class ScannerDemo {
	public static void main(String[] args) {
	 Scanner input = new Scanner(System.in);

	 System.out.println ("Enter your name: ");

	    // takes input from the keyboard
	    String name = input.nextLine();

	    // prints the name
	    System.out.println("My name is " + name);

	    // closes the scanner
	    input.close();
}
}