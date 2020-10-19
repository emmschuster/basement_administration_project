package test;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Test {
    public static void main(String[] args) {
        System.out.println("soggse");
        Scanner scan = null;
        try {
            scan = new Scanner(new File("C:\\Users\\Emma Mango Jango\\Desktop\\HTL5\\SWP-Rubner\\password.txt"));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        while (scan.hasNext()) {
            System.out.println(scan.nextLine());
        }
        scan.close();
    }
}
