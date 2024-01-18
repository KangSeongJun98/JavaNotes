# Class 
* Java의 클래스는 객체 지향 프로그래밍의 핵심 구성 요소입니다.   
클래스는 객체의 설계도와 같으며, 객체의 상태를 나타내는 필드(변수)와 행동을 나타내는 메소드(함수)로 구성
### 구성요소
* 필드(Fields): 객체의 상태를 저장하는 변수   
* 메소드(Methods): 객체의 행동을 정의하는 함수   
* 생성자(Constructor): 객체를 생성할 때 초기화하는 특별한 메소드  

### 클래스 정의
 ```java
public class Student {
	//1. 필드 변수 선언
	// 캡슐화 적용(외부에서 변경 불가능)
	private String name;
	private int kor;
	private int math;
	private int eng;
	private double avg;
	
	//생성자: 모든 class에 생성자가 있음
	//아래와 같이 ()매개변수가 없는 생성자는 new Student로 생성 할 수 있음.
	
	public Student() {
	}
	//매개변수가 있는 생성자 new Student("팽수") 와 같이 인스턴스화 할 수 있음.
	public Student (String nm) {
		this.name = nm;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name; //this.name과 같음
	}
	public void check() {
		System.out.println(this.name +" 출석!");
	}
	//Shift +alt + s
	// 생성자 or setter, getter or toString
	// toString 하면 클래스의 매개변수 뭐나오는지 다 return해줌
	
	public int getKor() {
		return kor;
	}
	public void setKor(int kor) {
		this.kor = kor;
		setAvg();
	}
	public int getMath() {
		return math;
	}
	public void setMath(int math) {
		this.math = math;
		setAvg();
	}
	public int getEng() {
		return eng;
	}
	public void setEng(int eng) {
		this.eng = eng;
		setAvg();
	}
	
	
	
	@Override
	public String toString() {
		return "Student [name=" + name + ", kor=" + kor + ", math=" + math + ", eng=" + eng + ", avg=" + avg + "]";
	}
	
	//generate using fields 하는 부분 누르면 생성됨
	public Student(String name, int kor, int math, int eng) {
		this.name = name;
		this.kor = kor;
		this.math = math;
		this.eng = eng;
		setAvg();
	}
	private void setAvg() {
		avg = UtilClass.weRound((this.kor+this.math+this.eng)/3.0, 1);
	}
	public double getAvg() {
		return avg;
	}
}
```
### 해석

##### 필드 변수 선언

* private String nam : 학생의 이름을 저장하는 변수.
* private int kor, math, eng: 국어, 수학, 영어 각 과목의 점수를 저장하는 변수.
* private double avg: 학생의 평균 점수를 저장하는 변수.

#### 생성자

- **기본 생성자:**
  ```java
  public Student() {}
- **매개변수가 있는 생성자:**
  ```java
  public Student(String nm) {}
  ```
#### Setter와 Getter 메서드:
캡슐화를 통해 클래스 내부의 데이터(필드)를 외부로부터 숨기고, 해당 데이터에 접근하는 메소드를 제공하는 방법으로 이를 통해 데이터 보호 및 추상화가 가능

* **setName(String name)**: 이름을 설정하는 메서드.   
* **getName()**: 이름을 반환하는 메서드.   
* **setKor(int kor)** , **setMath(int math)**, **setEng(int eng)**: 각 과목의 점수를 설정하는 메서드.   
* **getKor()**, **getMath()**, **getEng()**: 각 과목의 점수를 반환하는 메서드.   
* **setAvg()**: 평균 점수를 설정하는 메서드.   
* **getAvg()**: 평균 점수를 반환하는 메서드.      

####  기타 메서드
* **check()**: 출석 메시지를 출력하는 메서드.   
* **toString()**: 객체의 문자열 표현을 반환하는 메서드. 이는 주로 객체를 출력할 때 유용하게 사용   


### Singleton Pattern
#### 1. 설명
싱글톤 패턴은 클래스의 인스턴스가 오직 하나만 생성되도록 보장하는 디자인 패턴   
이를 통해 전역적으로 접근 가능한 단일 인스턴스를 제공   

#### 2. 구현 방법
생성자를 private으로 선언하여 외부에서의 인스턴스 생성을 차단      
클래스 내부에 static private 인스턴스를 유지   
public static 메소드를 통해 인스턴스에 접근할 수 있도록 합니다.   
#### 예시 
```java
public class Singleton {
    private static Singleton instance = new Singleton();

    private Singleton() {}

    public static Singleton getInstance() {
        return instance;
    }
}
```

### Interfaces
#### 1. 설명
인터페이스는 메소드의 시그니처만을 정의하는 추상 타입    
이를 구현하는 클래스는 인터페이스에 정의된 모든 메소드를 구현해야 한다.     

#### 2. 구현 방법
interface 키워드를 사용하여 인터페이스를 선언   
클래스에서 implements 키워드를 사용하여 인터페이스를 구현   

#### 3. 인터페이스와 추상클래스의  차이점
* 인터페이스만 다중 상속이 가능하며 추상클래스는 단일 상속만 가능하다
* 인터페이스는 이를 구현하는 클래스에서 모든 메소드를 구현해야하는 반면
* 추상클래스는 추상메소드만을 반드시 구현하고 일반 메소드는 구현할 수 있다.
```java
interface Vehicle {
    void drive();
}

public class Car implements Vehicle {
    @Override
    public void drive() {
        System.out.println("Car is driving");
    }
}
```
