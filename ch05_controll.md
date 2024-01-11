# Java 제어문
## 1-1.조건문 if
#### 주의사항   
* if 문의 조건은 항상 괄호 안에 작성해야 합니다.
* 조건이 참(true)일 때만 코드 블록이 실행됩니다.
* 코드 블록은 중괄호 {}로 묶어야 합니다.
### 예제

```
package ch05_controll;
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
    }
}
```
## 1-2.조건문 switch
switch 문은 변수의 값에 따라 다양한 경우(case)를 실행할 수 있도록 합니다.    
### 예제
```
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
```
## 2-1.반복문 for
for 문은 반복문으로, 조건이 참인 동안 코드 블록을 반복해서 실행합니다. 기본 구조는 다음과 같습니다.
```
for (초기화; 조건; 증감) {
    // 반복 실행될 코드
}
```   
* **초기화**: 반복문이 시작할 때 한 번 실행되며, 반복문의 제어 변수를 초기화합니다.   
* **조건**: 각 반복 전에 평가되며, 참일 경우 반복문이 계속 실행됩니다.   
* **증감**: 반복문의 끝에 도달할 때마다 실행되어 제어 변수를 갱신합니다.   
### 예제
```
package ch05_controll;

public class LoopFor {

	public static void main(String[] args) {
		for(int i=1; i<=10 ;i++) {
			System.out.println(i);
		}
		
		int sum = 0; 
		for(int i=1; i<=20; i++) {
			System.out.println(sum+=i);
		}
		int sum2 = 0;
		for(int i=21; i<=45; i++) {
			System.out.println(sum2+=i);
		}System.out.println("21~45를 더하면: "+sum2);
		
		int sum3 = 0;
		for(int i=1; i<=40; i++) {
			if(i%2 == 0) {
				sum3 += i;
			}
		}System.out.println("1부터 40까지 짝수만 더한 값: "+sum3);
		
		int sum4 = 0;
		for(int i=0; i<=40 ; i+=2) {
			sum4 += i;
		}System.out.println(sum4);
		
		int dan = 2;
		for(int i=1; i<10; i++) {
			System.out.println("2X"+i+"="+ (dan*i));
		}
		for(int i=2; i<10; i++) {
			System.out.println(i+"단");
			for(int j=1; j<10; j++) {
				System.out.println(i+"X"+j+"="+i*j);
			}
		} 
		
		String star = "";
		for(int i=0; i<=5; i++) {
			star +="*";
			System.out.println(star);
		}
		
		// break, continue
		
		int sum5 = 0;
		for(int i=0; i<9999; i++) {
			sum5 +=i;
			if(sum5>=100) {
				System.out.println("100이상이 되는 n: "+i);
				break;
			}
		}
		
		for(int i =1; i<=10; i++) {
			if(i%2==0) {
				continue;
			}
			System.out.println(i);
		}
		// 구구단 5단 8단 제외
		for(int i=2; i<10;i++) {
			if(i==5||i==8) continue;
			for(int j=1; j<10; j++) {
				System.out.println(i+"X"+j+"="+i*j);
			}
		}
	
		for(int i=1; i<=100; i++) {
			System.out.println("||||||");
			if(i%5 == 0) {
				System.out.println("---------");
				continue;
			}
		}
	}
}
```
## 2-2.반복문 while
* while 문은 조건문이 참인 동안 계속 while 문 안의 내용을 반복적으로 수행합니다.   
* break를 활용해 강제로 반복문에서 빠져나올 수 있습니다.
* break에 label을 활용하면 2개 이상의 반복문을 한 번에 빠져나올 수 있습니다.      
* continue를 해당 코드의 실행만 건너뛰게 할 수 있습니다.

## 2-2.반복문 do-while
* while문과 유사하지만 반드시 한 번은 실행된다는 차이점이 있습니다.

### 예제
```
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
```
