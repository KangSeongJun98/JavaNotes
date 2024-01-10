# java 프로그래밍 언어 기초
## 프로그래밍이란?
* **프로그램(Program)** : 컴퓨터나 다른 전자 장치가 특정 작업을 수행하기 위한 명령들의 집합.   
* **프로그래밍(Programming)**: 프로그램은 프로그래밍 언어로 작성되며, 컴퓨터 하드웨어가 이해할 수 있는 기계어로 변환되어 실행됨.   
## 프로그래밍 패러다임
* **절차 지향 프로그래밍**: 문제를 연속적인 단계로 해결 (예: C, Pascal)      
* **이벤트 지향 프로그래밍**: 사용자 동작에 따라 흐름 결정 (예: JavaScript)   
* **객체 지향 프로그래밍(OOP)**: 데이터와 메서드를 캡슐화한 객체 중심 (예: Java)
## Java의 주요 특징
* **플랫폼 독립성**: Java의 가장 큰 특징 중 하나는 "한 번 작성하면 어디서나 실행된다(Write Once, Run Anywhere - WORA)"는 개념입니다. Java 애플리케이션은 Java 가상 머신(JVM) 위에서 실행되며, 이는 다양한 운영 체제에서 동일하게 작동합니다. 이는 프로그램이 특정 시스템에 구속되지 않도록 하는 데 중점을 두었습니다.   

* **객체 지향 프로그래밍**: Java는 객체 지향 프로그래밍 언어입니다. 이는 코드의 재사용성, 모듈성, 유지 보수성을 증진시키는 것을 목표로 합니다. 클래스와 객체를 사용하여 더욱 체계적이고 유연한 프로그래밍이 가능합니다.   

* **보안**: Java는 원격 소스에서 실행되는 코드에 대한 보안을 중시합니다. JVM은 코드를 실행하기 전에 여러 가지 보안 검사를 수행하여 시스템의 안전을 유지합니다.

* **네트워크 지향**: Java는 인터넷과 네트워크 애플리케이션 개발에 강력한 지원을 제공합니다. 초기에 Java는 웹 애플리케이션과 더 넓은 네트워크 환경에서의 사용을 염두에 두고 개발되었습니다.

* **성능**: 처음에는 인터프리터 언어로 인식되어 성능이 느리다는 인식이 있었지만, JIT(Just-In-Time) 컴파일러의 도입과 여러 최적화 기법을 통해 성능이 크게 향상되었습니다.

* **멀티스레딩**: Java는 내장된 멀티스레딩 기능을 지원하여, 효율적인 동시성과 병렬 처리가 가능합니다.

* **메모리 관리**: 자동 메모리 관리 및 가비지 컬렉션 기능은 메모리 누수와 같은 문제를 최소화하고 프로그래머의 부담을 줄입니다.

* **요약**: C++와 유사, 객체 지향 프로그래밍에 중점, 메모리 관리 및 보안을 추상화, 코드의 재사용성과 확장성, 복잡성 관리

Java의 이러한 특징들은 넓은 범위의 애플리케이션 개발, 특히 대규모 엔터프라이즈 시스템, 모바일 애플리케이션, 임베디드 시스템, 클라우드 기반 서비스 등에 적합하게 만들어짐.

## 실습
+ Hello.java
```
public class Hello {
	// 라인 주석
	/* 전체 주석 */
	/* alt + 위 아래  (라인이동)
	   ctrl + d       (라인삭제) */
	public static void main(String[] args) {
		System.out.print("Hello World");
	}
}
```
+ variableMain.java
```
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
```
+ VariableName.java
```
package ch02_variable;

public class VariableName {

	public static void main(String[] args) {
		int todayIsHappy = 0;
		System.out.print(todayIsHappy);
		
		byte byteVar = 1;
		short shortVar = 2;
		int intVar = 3;
		long longVar = 30000000L; // long은 ㅣ붙음
		
		// 정수이면서 문자에 해당
		char charVar = 44032; //'가'와 같음
		char ga = '가';
		
		float floatVar = 3.14f; // float 은 f 붙인다.
		double doubleVar = 3.14;
		
		boolean boolVar = false;	
		
		String strToday = "오늘은 1월 2 일";
	}
}
```