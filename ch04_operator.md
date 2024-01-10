# Java 연산자
1 **증감 연산자**:    
변수의 값을 1 증가시키거나 감소시킵니다. 변수의 앞이나 뒤에 위치할 수 있으며 연산자의 위치에 따라 결과 값이 달라질 수 있습니다.   
### 예제
```
int num = 10;
		num++;
		System.out.println(num);
		num--;
		System.out.println(num);
		int a, b;
		a= num++;
		b= ++num;
		System.out.println("a:"+a+"\nb:"+b);
```
2 **비교 연산자**:    
두 개의 값을 비교하여 true 또는 false를 반환합니다. 주로 ==, !=, >, <, >=, <= 등이 있습니다.  
### 예제
```
System.out.println("a:"+a + " b:"+b);
		System.out.println(a>b);
		System.out.println(a<b);
		System.out.println(a>=b);
		System.out.println(a<=b);
		System.out.println(a!=b);
		System.out.println(a==b);
```
3 **삼항 연산자**   
조건식을 평가하여 두 개의 결과 중 하나를 반환합니다. 형식은 조건식 ? 값1 : 값2입니다. 조건식이 참이면 값1을, 거짓이면 값2를 반환합니다.
### 예제
```
System.out.println(a>b? a:b);
		String id1 = "nick";
		String check = (id1.equals("nick"))? "hi nick":"재입력";
		System.out.println(check);
		Scanner sc = new Scanner(System.in);
```
3-1 **조건식 3개 이상의 삼항연산자**   
삼항연산자의 형식에서 거짓일 때의 반환값에 해당하는 부분에 삼항연산자를 다시 입력하면 3개 이상의 조건식을 가지는 삼항연산자를 만들 수 있습니다.
### 예제
```
(score >= 90) ? ("A"):((score >= 80)?("b"):("c"))
```
4 **논리연산자**   
논리 연산자는 boolean 값(참/거짓)을 기반으로 한 연산을 수행합니다. 주로 &&(논리곱), ||(논리합), !(부정) 연산자가 있습니다.
### 예제
```
String id = sc.nextLine();
		System.out.println(id.length()>=8 && id.length()<=14 ? "환영합니다":"다시입력해주세요");
```
