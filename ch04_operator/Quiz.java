package ch04_operator;

import java.util.Scanner;

public class Quiz {
	public static void main(String[] args) {
		//@있을 때 사용가능 없을 경우 이메일 형식이 아니라고 리턴
		Scanner sc = new Scanner(System.in);
		System.out.println("아이디를 입력해주세요(이메일 형식)");
		System.out.println(">>>");
		String id = sc.nextLine();
		System.out.println(id.indexOf("@")!=-1 ? "사용가능":"다시 입력해주세요");
	}
}
