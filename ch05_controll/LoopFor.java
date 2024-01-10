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
