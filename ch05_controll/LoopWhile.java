package ch05_controll;

import java.util.Scanner;

public class LoopWhile {

	public static void main(String[] args) {
		int i = 1;
		while (i <= 10) {
			System.out.println(i);
			i++;
		}
		int j = 1;
		while (true) {
			System.out.println(j);
			j++;
			if (j == 10) {
				break;
			}
		}

		Scanner sc = new Scanner(System.in);
//		boolean flag = true;
//		while(flag) {
//			System.out.println("=================");
//			System.out.println("이름을 입력하세요(종료 q)");
//			System.out.println(">>>>");
//			String nm = sc.nextLine();
//			if(nm.equals("q")) {
//				flag= false;
//				System.out.println("종료하겠습니다.");
//			}else {
//				System.out.println(nm+"님 환영합니다.");
//			}
//			System.out.println("=================");	
//		}
//		
		// do-while문
		// 최소 한 번 실행
		boolean isRun = false;
		do {
			System.out.println("hi");
		} while (isRun);
		{
		}

		// 반복문 Label 활용
		int x = 0;
		outerLoop: while (x < 5) {
			int y=0;
			while(y<5) {
				if(x*y>6) {
					System.out.println("breaking !");
					System.out.println("X:"+x+" Y:"+y);
					break outerLoop; //내부 반복문만 중단되어 다시 메인루프는 진행됨
				}y++;
			}x++;
		}
		
		
		int x1 = 2;
		int y1 = 1;
		while(x1<10) {
			// int y1 =1; 이렇게 안에다가 넣어도 자동을 초기화 됨
			while (y1<10) {
				System.out.println(x1+"X"+y1+"="+(x1*y1));
				y1++;
			}	
			y1=1;
			x1++;
		}
	}
}
