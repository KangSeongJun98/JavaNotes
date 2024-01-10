package ch05_controll;
 /**
 * Class Name      : Conditional
 * Author          : SeongJun
 * Created Date    : 2024. 1. 4.
 * Version         : 1.0
 * Purpose         : 조건문
 * Desciption      :
 */

public class Conditional {
	
	static String subject = "조건문";
	
	public static void main(String[] args) {
		int price = 30000;
		int myMoney = 10000;
		if(myMoney < price) {
			System.out.println("잔액부족");
		}else System.out.println("결제 완료 \n 잔액:"+(myMoney-price));
		
		int score = 85;
		String grade ="";
		
		if(score >=90) grade="A";
		else if(score >=80) grade="B";
		else if(score >=70) grade="C";
		else grade="E";
		System.out.println(grade);
		
		
		Boolean flag = false;
		String msg="";
		if(flag) msg = "if문 1번째 조건식";
		else msg = "그 밖에";
		System.out.println(msg);
		
		
		//중첩 if 문
		//조건1: 이름은 1글자 이상 
		//조건2: 전화번호는 10 or 11 자리
		//조건3: 나이는 14세 이상
		String nm= "asd";
		String phone="0104479235";
		int age = 10;
		if(nm.length()>=1) {
			if(phone.length()==10 || phone.length()==11) {
				if(age >=14) {
					System.out.println("가입을 환영합니다.");
				}else msg=("나이정보 틀림.");
			}else msg=("휴대폰 길이가 틀림.");
		}else msg=("이름 길이가 틀림.");
		System.out.println(msg);
		
		int num = 1;
		switch(num) {
			case 0:
				System.out.println("수강등록");
				break;
			case 1:
				System.out.println("기초 프로그래밍");
				break;
			case 2:
				System.out.println("DB");
				break;
			default:
				System.out.println("취업 관련");
		}
	}
}
