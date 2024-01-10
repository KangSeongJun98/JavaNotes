package ch06_method;

/**
 * Class Name      : MethodMain
 * Author          : SeongJun
 * Created Date    : 2024. 1. 8.
 * Version         : 1.0
 * Purpose         : Method study
 * Desciption      : java의 함수 method
 */
public class MethodMain {
	public static void main(String[] args) {
		System.out.println("1~50까지 합:"+sum(1,50));
		System.out.println("1~100까지 합:"+sum(1,100));
		System.out.println("30~60까지 합:"+sum(30, 60));
		printsum(50, 100);
		print("print메소드");
		print(3);
		System.out.println(num(10));
		System.out.println(num(-10));
	}
	
	public static int sum(int from, int to) {
		int sumNum = 0;
		for(int i =from; i<= to; i++) {
			sumNum += i;
		}return sumNum;
	}
	
	public static void printsum(int from, int to) {
		int sumNum = 0;
		for(int i =from; i<= to; i++) {
			sumNum += i;
		}System.out.println(from+"부터"+to+"까지의 합: "+sumNum);		
	}
	
	public static void print(String msg) {
		System.out.println(msg);
	}
	
	//오버로딩
	public static void print(int msg) {
		System.out.println(msg);
	}
	
	
	public static int num(int msg) {
//		int absoluteValue = 0; 
//		if(msg <0) {
//			absoluteValue = msg*-1;
//		}else absoluteValue = msg;
//		return absoluteValue;
//	}
		if(msg <0) {
			msg *= -1;
		}return msg;
		
	}
}
