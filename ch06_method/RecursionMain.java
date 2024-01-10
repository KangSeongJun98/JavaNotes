package ch06_method;

public class RecursionMain {
	public static void main(String[] args) {
		func(5);
		System.out.println(factorial(10));
		System.out.println(recFactorial(15));
		grade("강성준",90,80,75);
	}

	public static void func(int num) {
		// 재귀함수는 멈추는게 중요 잘못하면 무한 루프
		if (num == 0) {
			return;
		} else {
			System.out.println("hi");
			func(num - 1);
		}
	}

	public static long factorial(int num) {
		long sum = 1;
		for (int i = 1; i <= num; i++) {
			sum *= i;
		}
		return sum;
	}

	public static long recFactorial(int num) {
		if (num == 1) {
			return 1;
		}
		return num * recFactorial(num - 1);
	}

	// 이름, 국어점수, 수학점수, 영어점수를 입력받아
	// 평균과 등급을 출력하는 메소드
	public static void grade(String name, int kor, int math, int eng) {
		String grade = "";
		float average = (kor + math + eng)/3f;
		if (average >= 90) {
			grade = "A";
		} else if (average >= 80) {
			grade = "B";
		} else if (average >= 70) {
			grade = "C";

		}
		System.out.println("============학생카드============");
		System.out.println("이름: "+name);
		System.out.println("국어: "+kor);
		System.out.println("영어: "+eng);
		System.out.println("수학: "+math);
		System.out.printf("%s님의 평균은 %.2f로 등급은 %s입니다.", name, average, grade);
	}
}