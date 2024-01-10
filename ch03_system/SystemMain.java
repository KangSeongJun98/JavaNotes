package ch03_system;

import java.util.Scanner;

public class SystemMain {

	public static void main(String[] args) {
		System.out.print("Hello World ");
		System.out.print("Hello World \n");
		System.out.println("Hello World");
		System.out.println("중간에 \n넣으면 개행");
		System.out.println("중간에 \t 넣으면 탭");
		System.out.println("큰따옴표 쓰려면 \"이런식\"");
		System.out.printf("원주율은 %.2f \n", 3.141592);
		System.out.printf("%d 명이 %s를 듣고 있습니다.", 21, "java수업");
		System.out.println("==========표준입력=========");
		Scanner sc = new Scanner(System.in);
		System.out.println("이름을 입력해주세요");
		System.out.println(">>> ");
		String nm = sc.nextLine();
		System.out.println(nm+"님 환영합니다.");
		System.out.println("나이를 입력해주세요");
		System.out.println(">>> ");
		//int age = Integer.parseInt(sc.nextLine());
		int age = sc.nextInt();
		System.out.println(nm+"님의 나이는"+ age+"살입니다.");
		sc.close();
	}
}
