package ch02_variable;

public class variableMain {

	public static void main(String[] args) {
		final double MATH_PI = 3.14;
		String fruits = "Apple, Banana, Cherry";
		System.out.println(fruits);
		System.out.println("길이: "+fruits.length());
		System.out.println("3번째 글자: " + fruits.charAt(3));
		System.out.println("바나나의 시작 인덱스:"+ fruits.indexOf("Banana"));
		System.out.println("문자열 자르기: "+ fruits.substring(0, 5));
		System.out.println("문자열 자르기:"+ fruits.substring(6));
		System.out.println("문자열 바꾸기:"+ fruits.replace("Cherry", "Chamwui"));
		System.out.println(fruits.replace(",", "/"));		
		String email = "leeapgil@gmail.com";
		System.out.println(email.indexOf("@"));
		System.out.println("앞:"+email.substring(0,8) + "\n뒤:"+email.substring(9));
	}
}
