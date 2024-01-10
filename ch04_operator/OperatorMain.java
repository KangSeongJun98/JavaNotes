package ch04_operator;

import java.security.PublicKey;
import java.util.Scanner;

/**
 * Class Name      : OperatorMain
 * Author          : SeongJun
 * Created Date    : 2024. 1. 3.
 * Version         : 1.0
 * Purpose         : operator study
 * Desciption      : 기본 연산자 공부
 */

public class OperatorMain {

	public static void main(String[] args) {
		int num = 10;
		num++;
		System.out.println(num);
		num--;
		System.out.println(num);
		int a, b;
		a= num++;
		b= ++num;
		System.out.println("a:"+a+"\nb:"+b);
		System.out.println("\n==========산술 연산자========");
		int c = a * b;
		int d = a + b;
		System.out.println("c:"+c+ " d:"+d);
		System.out.println("나머지 값:" + (5%2));
		System.out.println("\n===========대입 연산자=========");
		num += 1;
		System.out.println(num);
		num *= 2;
		System.out.println(num);
		num /= 2;
		System.out.println(num);
		System.out.println("\n============ 비교 연산자 =============");
		System.out.println("a:"+a + " b:"+b);
		System.out.println(a>b);
		System.out.println(a<b);
		System.out.println(a>=b);
		System.out.println(a<=b);
		System.out.println(a!=b);
		System.out.println(a==b);
		System.out.println("\n============ 삼항 연산자 =============");
		System.out.println(a>b? a:b);
		String id1 = "nick";
		String check = (id1.equals("nick"))? "hi nick":"재입력";
		System.out.println(check);
		Scanner sc = new Scanner(System.in);
//		System.out.println("아이디를 입력해주세요(5글자 이상)");
//		System.out.println(">>>");
//		String id = sc.nextLine();
//		String id_check = id.length()>=5 ? "아이디가 확인됐습니다":"아이디가 너무 짧습니다.";
//		System.out.println(id_check);
//		System.out.println("성적을 입력해주세요");
//		System.out.println(">>>");
//		int grade = sc.nextInt();
//		System.out.println(grade>=60? "통과":"재시험");
		System.out.println("\n============ 논리 연산자 =============");
		System.out.println("아이디를 입력해주세요(8~14 길이 가능)");
		String id = sc.nextLine();
		System.out.println(id.length()>=8 && id.length()<=14 ? "환영합니다":"다시입력해주세요");
		
		System.out.println("성적을 입력해주세요");
		System.out.println(">>>");
		int score = sc.nextInt();
		System.out.println((score >= 90) ? ("A"):((score >= 80)?("b"):("c")));
	}
}

