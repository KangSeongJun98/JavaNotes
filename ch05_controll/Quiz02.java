package ch05_controll;

import java.util.Scanner;

public class Quiz02 {
	public static void main(String[] args) {
//		메뉴 입력받아 가격 출력
//		아아 or 아이스아메리카노 3000
//		라떼 4500
//		에스프레소 2500
// 		입력메뉴 000은 000원입니다.
//		없는 메뉴이면 저희 매장에는 없는 메뉴입니다.
		int salePrice = 0;
		System.out.println("메뉴를 선택해주세요");
		System.out.println(">>>");
		Scanner sc = new Scanner(System.in);
		String menu = sc.nextLine();
			switch (menu) {
			case "아아":
			case "아이스아메리카노":
				System.out.println(menu+"는 3000원입니다.");
				break;

			case "라떼":
				System.out.println(menu+"는 4500원입니다.");
				break;

			case "에스프레소":
				System.out.println(menu+"는 2500원입니다.");
				break;

			default:
				System.out.println(menu+"는 저희 매장에는 없는 메뉴입니다.");
				break;
			}
		}
	}
