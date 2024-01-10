package ch05_controll;

import java.util.Scanner;

public class Quiz01 {
	public static void main(String[] args) {
		System.out.println("홀 짝 판별기 (정수)");
		Scanner sc = new Scanner(System.in);
		int num = sc.nextInt();
		System.out.println((num%2 == 0)? ("짝수입니다."):("홀수입니다."));
		sc.close();
	}
}