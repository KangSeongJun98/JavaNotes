# Java API:
프로그램 개발에 자주 사용되는 클래스 및 인터페이스의 모음을 말하며 API는 라이브러리라고도 부른다. 

## 특징:
1. 표준 라이브러리
* 기본 데이터 구조, 네트워킹, 파일 시스템 접근, 그래픽 사용자 인터페이스 구성 등을 위한 클래스와 인터페이스 제공.  
2. 객체 지향 디자인
* 코드의 재사용성과 유지 관리 용이.
3. 플랫폼 독립성
* Java 가상 머신(JVM)이 설치된 모든 시스템에서 실행 가능.
4. 확장성 및 유연성
* 다양한 유형의 응용 프로그램 개발 지원.
5. 풍부한 라이브러리
* 수학 함수, 날짜 및 시간 처리, I/O 처리, 네트워킹, XML 파싱 등 지원.
6. 보안 및 강력한 에러 처리
* 안정적이고 신뢰할 수 있는 소프트웨어 개발 가능.

## Java 표준 라이브러리
### 1. Math 클래스:
* Math 클래스는 기본적인 수학 연산과 관련된 메소드를 제공     
* 모든 메소드는 정적(static)이므로, 객체 생성 없이 직접 사용 가능   

### 2. Random 클래스:
* Random 클래스는 난수를 생성하는 데 사용   
* 객체를 생성하여 다양한 타입의 난수를 얻을 수 있습니다.

```java
package ch11_java_api;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Random;
import java.util.Set;

public class ApiMath {

	public static void main(String[] args) {
		// Math
		// 수학에서 사용되는 여러가지 함수들을 메서드로 제공하는 클래스
		final double PI = 3.141592;
		// 반올림 round
		long roundPI = Math.round(PI);
		System.out.println(roundPI);
		// 소수 넷째 자리에서 반올림
		double fourPI = (Math.round(PI * 1000)) / 1000.0;
		System.out.println(fourPI);
		// 올림 ceil
		double ceilPI = Math.ceil(PI);
		System.out.println(ceilPI);
		// 내림 floor
		double floorPI = Math.floor(PI);
		System.out.println(floorPI);
		// 절대값 abs
		int minus = -10;
		System.out.println(Math.abs(minus));
		// 제곱 3의 4제곱 pow
		double powVal = Math.pow(3, 4);
		System.out.println(powVal);
		// 제곱근(루트)
		System.out.println(Math.sqrt(4));
		// 랜덤 숫자(난수) 생성
		// 0 ~ 1 사이 실수 리턴 (0포함, 1포함하지 않음)
//		for (int i = 0; i < 100; i++) {
//			System.out.println(Math.random());
//			System.out.println(randomCard());
//		}
		// 1 ~ 45
		int lotto = (int) (Math.random() * 45) + 1;
		System.out.println(lotto);
		// 10 ~ 20 랜덤숫자
		int ranNum = (int) (Math.random() * 11) + 10;
		System.out.println(ranNum);

		ArrayList<String> classMateList = 
				new ArrayList<>(Arrays.asList("강성준", "권보성", "권유빈", "김기찬", "김대영", "김동우", "김동현","김명기", "김영주", "김유정", "김은혜", "김휘건", "나항진", "문성민", "박진기", "백현진", "오정연", "유하영", "이예진", "이용빈", "정유진"));
		
		HashMap<String, String> result = randomGame(classMateList);
		Set<String> keySet = result.keySet();
		for(String key:keySet) {
			System.out.println(key + "님은 " + result.get(key));
		}
	}

	public static String randomCard() {
		String result = null;
		// Random은 class로도 존재함.
		Random random = new Random();
		// 1 ~ 100 사이의 정수
		int num = random.nextInt(100) + 1;
		// 10% 확률 당첨
		if (num <= 10) {
			result = "당첨";
		} else {
			result = "꽝";
		}
		return result;
	}
	public static HashMap<String, String> randomGame(ArrayList<String> arr){
		HashMap<String, String> resultMap = new HashMap<>();
		// input으로 입력받은 arr만큼 
		for(int i = 0; i <arr.size(); i ++) {
			// key:학생이름 , value:당첨or꽝
			resultMap.put(arr.get(i), randomCard());
		}
		return resultMap;
	}

}

```

### 3. Date 클래스:
* 날짜와 시간을 표현하는 데 사용.
* 현재 시간으로 Date 객체를 생성하거나, 
* 특정 시간을 설정할 수 있습니다.

### 4. Calendar 클래스:
* 날짜와 시간을 조작하는 데 사용   
* Date 클래스보다 더 유연하고 세밀한 날짜/시간 조작 가능   

### 5.SimpleDateFormat 클래스:
* 날짜와 시간을 원하는 형식으로 포맷팅하는 데 사용   
* 다양한 패턴 문자를 사용하여 날짜 및 시간 형식을 지정할 수 있습니다.   

```java
package ch11_java_api;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

public class ApiDate {
	public static void main(String[] args) {
		// 1.Date 클래스
		// 1970년 1월 1일 자정(UTC) 이후 시간을 밀리초 단위로 표현
		// import할 때 util꺼를 가져와야함
		// 안에 내용 없으면 현재시간 자바스크립트와 유사
		Date dateToday = new Date();
		System.out.println(dateToday);
		// 원하는 포멧형태로 만들 수 있음. 단 yyyy <- 같은 고정 표현을 사용해서
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy년 MM월 DD일 HH시 mm분 ss초");
		String strToday = sdf1.format(dateToday);
		System.out.println(strToday);

		// 2024-01-17을 출력
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-DD");
		String strToday2 = sdf2.format(dateToday);
		System.out.println(strToday2);

		// 뉴욕시간
		SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.US);
		TimeZone timezone = TimeZone.getTimeZone("America/New_York");
		sdf3.setTimeZone(timezone);
		String newYork = sdf3.format(dateToday);
		System.out.println(newYork);

		String strDinner = "2024-01-18 18:10:00";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-DD HH:mm:ss");
		Date dinner = null;
		
		try {
			dinner = sdf.parse(strDinner);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			System.out.println(dinner);
		}
		
		System.out.println(dateToday.getTime());
		System.out.println(dinner.getTime());
		long diffMillsec = dinner.getTime() - dateToday.getTime();
		System.out.println(diffMillsec+"밀리초 남음");
		System.out.println(diffMillsec/1000+"초 남음");
		System.out.println(diffMillsec/1000/60 +"분 남음");
		System.out.println(diffMillsec/1000/60/60+"시간 남음");
		
		//Calendar 클래스 (YEAR, MONTH.. 같은 필드를 제공) 날짜 계산 조작 유용함.
		//1일 뒤 한달 뒤와 같은
		Calendar calToday = Calendar.getInstance();
		System.out.println(calToday.getTime());
		System.out.println(calToday.get(Calendar.YEAR));
		System.out.println(calToday.get(Calendar.MONTH)+1);
		System.out.println(calToday.get(Calendar.DATE));
		System.out.println(calToday.get(Calendar.HOUR_OF_DAY));
		
		//3일뒤
		calToday.add(Calendar.DATE, 3);
		System.out.println(sdf.format(calToday.getTime()));
		
		//10일전
		calToday.add(Calendar.DATE, -10);
		System.out.println(sdf.format(calToday.getTime()));
		
		//5개월 뒤
		calToday.add(Calendar.MONTH, 5);
		System.out.println(sdf.format(calToday.getTime()));
		
		//달력 만들기
		Calendar calendar = Calendar.getInstance();
		int year = 2024;
		int month = 1;
		calendar.set(year, month-1, 1); //해당 월 1일 날짜
		// 해당 월 마지막 일자
		int lastDay = calendar.getActualMaximum(calendar.DAY_OF_MONTH);
		System.out.println(lastDay);
		
		//해당 월의 시작 요일
		// 1:일요일, 2.월요일...
		// 1월 1일이 월요일이여서 시작일의 요일 값은 2가 나옴
		int startDay = calendar.get(calendar.DAY_OF_WEEK);
		System.out.println(startDay);
		System.out.println(year+"년"+ month+"월 달력");
		System.out.println("일\t월\t화\t수\t목\t금\t토");
		int current = 1;
		for(int i =1 ; i<=42; i++) {
			if(i < startDay) {
				System.out.print("\t");
			}else {
				System.out.printf("%d\t",current);
				current++;
				if(current>lastDay) {
					break;
				}
			}
			if(i %7 ==0) {
				System.out.println(" ");
			}
		}
		workingCalendar(2024,2);
		workingCalendar(2024,3);
	}
	
	
	public static void workingCalendar(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month-1, 1); //해당 월 1일 날짜
		// 해당 월 마지막 일자
		int lastDay = calendar.getActualMaximum(calendar.DAY_OF_MONTH);
		int startDay = calendar.get(calendar.DAY_OF_WEEK);
//		System.out.println(startDay);
		System.out.println(" \n");
		System.out.println(year+"년"+ month+"월 달력");
		System.out.println("일\t월\t화\t수\t목\t금\t토");
		int current = 1;
		for(int i =1 ; i<=42; i++) {
			if(i < startDay) {
				System.out.print("\t");
			}else {
				System.out.printf("%d\t",current);
				current++;
				if(current>lastDay) {
					break;
				}
			}
			if(i %7 ==0) {
				System.out.println(" ");
			}
		}
	}
}

```
### 5. StringBuffer 클래스:
* 문자열 내용 수정이 가능한(가변) 클래스로 문자열 수정이 빈번하게 일어나는 경우 사용됩니다.    
* 문자열을 위한 버퍼를 두고 관리하기 때문에 문자열 수정이 가능하며
* 이 버퍼는 문자열의 길이가 변함에 따라 자동 조절됩니다. 
* 사용자는 객체 생성 시에 버퍼 크기를 지정하여 생성할 수도 있습니다. 

```java
package ch11_java_api;

public class ApiStringBuffer {
	public static void main(String[] args) {
		
		
		String a = "길동";
		System.out.println(a.hashCode());
		a = "팽수";
		System.out.println(a.hashCode());
		// java에서 불변 (immutable) 가변 (mutable)
		// 불변 변수는 한 번 초기화되면 그 주소 값이 변경되지않음.
		// 그래서 내용물이 바뀌면 주소값도 바뀌는 것
		// 이로 인해 String 비교할 때 equals 쓰는 것
		// String은 불변
		
		// 가변 변수는 선언된 후에도 그 값이 변경될 수 있음
		// int , ArrayList.. 가변 변수
		
		// 이렇다보니 String 변수의 값을 계속 수정하게 되면
		// 메모리 영역에 매번 새로운 String객체가 만들어지고 
		// 그로인해 가비지컬렉터(메모리관리)에서 할 일이 많아짐 (비효율적)
		// 그래서 변경이 많은 경우라면 StringBuffer 클래스를 사용
		
		StringBuffer strBuffer = new StringBuffer();
		strBuffer.append("hi");
		System.out.println(strBuffer);
		strBuffer.append("hello");
		System.out.println(strBuffer);
		
		//문자열 가져오기
		String str = strBuffer.toString();
		System.out.println(str);
		
		
	}
}

```