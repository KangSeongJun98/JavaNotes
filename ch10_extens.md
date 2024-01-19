# Java 상속(Inheritance)
## 정의 및 목적
* 상속은 Java에서 중요한 객체지향 프로그래밍의 개념 중 하나   
* 상속을 통해 한 클래스가 다른 클래스의 속성 및 메소드를 상속받을 수 있습니다.   
* 이를 통해 코드의 재사용성을 높이고, 유지 보수를 용이하게 만듭니다.   
## 자식 코드 예시
```java
package ch10_extends_interface;

public class Child extends Parent {

	public Child() {
		super();
	}

	public Child(String name, int age) {
		super(name, age);
	}

	@Override
	public String toString() {
		return super.toString();
	}

	@Override
	public void sayHello() {
		System.out.println("자식입니다.");
	}

}
```
* **super**를 통해 부모의 필드에 접근할 수 있음.   
* 부모의 sayHello()메소드를 재정의(**오버라이딩**) 함


## 부모 코드 예시
```java
package ch10_extends_interface;

public class Parent {
	private String name;
	private int age;
	
	public Parent(String name, int age) {
		// 부모 클래스의 기본 생성자 .   
		super(); // <- object클래스를 상속받기에 디폴트로 생성됨 (여기선 생략가능)   
		this.name = name;
		this.age = age;
	}
	
	public Parent() {}

	//오버 라이딩-> object클래스의  toStirng 메소드를 재정의해서 사용
	@Override
	public String toString() {
		return "Parent [name=" + name + ", age=" + age + "]";
	}

    //캡슐화
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
	
	public void sayHello() {
		System.out.println("부모입니다.");
	}

}
```
## 사용 예시
```java
package ch10_extends_interface;

public class SimpleMain {
	public static void main(String[] args) {
		Parent papa = new Parent("팽수아빠",60);
		System.out.println(papa.getName());
		papa.sayHello();
		
		Child baby = new Child("팽수",10); //childe class 는 name 필드가 없음
		System.out.println(baby.getName());
		baby.sayHello();
	}
}
```
* 오버라이딩으로 인해 sayHello()의 결과값이 다르게 나옴   

# Java 추상 클래스(Abstract Class)의 개념
### 정의 및 목적
* **추상 클래스**는 하나 이상의 **추상 메소드**를 포함하며, 자체로는 인스턴스화될 수 없는 클래스   
* 추상 클래스는 상속을 통해 그 기능을 확장하는 데 사용   
* 추상 클래스는 일반 메소드와 필드 뿐만 아니라 추상 메소드(구현되지 않은 메소드)를 포함할 수 있습니다.

### 주의점
* 자체적으로는 객체를 생성하지 못하고 상속을 통해서만 가능
* 하위 클래스는 추상메소드를 반드시 사용해야한다.
* 추상메소드를 정의할 때는 대괄호("{ }") 가 필요없다.
* 추상 클래스는 일반 클래스처럼 생성자를 가질 수 있으며,    이는 하위 클래스 생성자에서 호출될 수 있다.

### 문법
```java
abstract class ClassName {
    // abstract methods and fields
}
```

### 추상클래스 예시
```java
package ch10_extends_interface.ramen;

//추상클래스
public abstract class Ramen {
	String name;
	int price;
	public Ramen(String name, int pirce) {
		this.name = name;
		this.price = price;
	}
	public abstract void printRecipe(); // 
}

```
### 상속받은 하위 클래스 예시
```java
package ch10_extends_interface.ramen;

public class SinRamen extends Ramen {

	public SinRamen(String name, int pirce) {
		super(name, pirce);
		
	}

	@Override
	public void printRecipe() {
		System.out.println("끓는 물에 면과 스프를 넣고 3분후에 드세요");
		System.out.println("물은 550ml");
		
	}
}

```
### 실행 예시
```java
package ch10_extends_interface.ramen;

public class RamenMain {
	public static void main(String[] args) {
		SinRamen sin = new SinRamen("신라면", 1100);
		sin.printRecipe();

		JjaPpagheti jjpa = new JjaPpagheti("짜파게티", 1200);
		jjpa.printRecipe();

		// Ramen r = new Ramen("신라면", 1100); 추상클래스는 그 자체로 객체 생성 못함
	}
}

```

