# Java의 메소드와 함수의 차이점 및 접근 제한자와 기본 사용법
## Java에서의 메소드 개념
Java에서 메소드(method) 는 특정 작업을 수행하는 코드 블록입니다. 클래스 내에 정의되며, 다른 코드에서 호출되어 실행될 수 있습니다. 메소드는 코드의 재사용성, 가독성 및 조직화에 도움이 됩니다.
## 함수와의 차이점
함수와 유사하지만 java는 객체지향 언어이므로 모든 함수는 클래스의 일부에 존재하는 **메소드**입니다. 

## 접근 제한자
접근 제한자는 클래스, 변수, 메소드 또는 생성자에 대한 접근을 제어하는 키워드입니다. Java에는 네 가지 주요 접근 제한자가 있습니다

1. **public**: 어디서든 접근 가능합니다.   
2. **protected**: 같은 패키지 내부, 또는 서브 클래스에서 접근 가능합니다.   
3. **default**(선언되지 않음): 같은 패키지 내에서만 접근 가능합니다.   
4. **private**: 같은 클래스 내에서만 접근 가능합니다.

## 메소드 사용 예제
```
package ch06_method;

public class RecursionMain {
	public static void main(String[] args) {
		func(5);
		System.out.println(factorial(10));
		System.out.println(recFactorial(15));
		grade("강성준",90,80,75);
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

```
### 특이 사항
* 원래라면 해당 메소드가 정의된 클래스의 인스턴스를 생성한 후 인스턴스를 통해 메소드를 호출해야합니다.   

* 하지만 위의 코드의 경우 메소드에 static 키워드를 사용함으로써 객체 생성 없이 메소드를 사용하였습니다.

## 재귀함수
재귀함수는 자기 자신을 호출하여 문제를 해결하는 함수입니다. 재귀는 많은 알고리즘에서 유용하지만, 주의 깊게 사용해야 합니다.    
### 재귀함수 사용법
1. 기본 단계(Base Case): 재귀 호출이 멈추는 조건을 정의합니다. 이는 무한 루프에 빠지지 않도록 합니다.   
2. 재귀 단계(Recursi   ve Case): 문제를 더 작은 문제로 나누고 자기 자신을 다시 호출합니다.

### 예시: 펙토리얼 계산
```
public static void func(int num) {
		// 재귀함수는 멈추는게 중요 잘못하면 무한 루프
		if (num == 0) {
			return;
		} else {
			System.out.println("hi");
			func(num - 1);
		}
	}
```
## 주의사항
1. 무한 재귀 방지: 항상 기본 단계를 정의하여 재귀 호출이 종료될 수 있도록 해야 합니다.   
2. 스택 오버플로우: 재귀 호출이 너무 많이 발생하면 스택 오버플로우가 발생할 수 있습니다. 따라서 재귀 깊이에 주의해야 합니다.   
3. 성능 고려: 일부 경우에는 반복문이 재귀보다 효율적일 수 있으므로, 성능을 고려하여 적절한 접근 방식을 선택해야 합니다.

