package ch07_array;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Scanner;
import java.util.concurrent.locks.AbstractOwnableSynchronizer;

/**
 * Class Name : ArrayMain Author : SeongJun Created Date : 2024. 1. 9. Version :
 * 1.0 Purpose : array study Desciption : array선언 및 사용법
 */
public class ArrayMain {

	public static void main(String[] args) throws NoSuchAlgorithmException {
		String samjang = "삼장";
		String goku = "오공";
		String saojeong = "사오정";
		String palgye = "저팔계";

		String[] seoyugi = new String[4];
		System.out.println(seoyugi.length);
		System.out.println(seoyugi[0]); // 처음 생성된 배열에는 default 값이 있음
		// 참조 타입 (String, Object..):null로 기본값 (주소값)
		// 기본 타입(int, boolean...): 숫자면 0, bool이면 falese (리터럴 값 그 자체)

		int numbers[] = new int[3];
		System.out.println(numbers[0]);
		boolean bools[] = new boolean[3];
		System.out.println(bools[0]);

		seoyugi[0] = samjang;
		seoyugi[1] = goku;
		seoyugi[2] = saojeong;
		seoyugi[3] = palgye;
		System.out.println(seoyugi);
		for (int i = 0; i < seoyugi.length; i++) {
			seoyugi[i] = "서유기 " + seoyugi[i];
		}
		printArr(seoyugi);
		for (int i = 0; i < seoyugi.length; i++) {
			if (seoyugi[i].contains("오공")) {
				seoyugi[i] = seoyugi[i].replace("서유기", "드래곤볼");
			}
		}
		printArr(seoyugi);

		String[] students = { "팽수", "길동", "동길", "길수" };
		printArr(students);
		String subjects = "JAVA, DB, JSP, HTML";
		String[] subArr = subjects.split(",");
		printArr(subArr);
		// 문자열 양쪽 공백 제거
		for (int i = 0; i < subArr.length; i++) {
			subArr[i] = subArr[i].trim();
		}
		printArr(subArr);

		// 배열의 복사
		// 1.단순하게 주소값만 복사(바로가기 느낌 한 쪽을 수정하면 다른 쪽도 같이 바뀜)
		String[] sinSeoyugi = seoyugi;
		printArr(sinSeoyugi);
		sinSeoyugi[0] = "강호동";
		printArr(seoyugi);
		printArr(sinSeoyugi);

		// 2.동일한 밸류값을 같는 새로운 배열 생성(복사)
		String newSeoyugi[] = seoyugi.clone();
		printArr(newSeoyugi);
		newSeoyugi[0] = "은지원";
		printArr(newSeoyugi);
		printArr(sinSeoyugi);

		// @앞은 객체 타입
		// @뒤에 붙은 건 hashCode를 16진수로 나타낸것
		System.out.println(seoyugi);
		System.out.println(seoyugi.hashCode());
		// 숫자를 16진수로 변환
		System.out.println(Integer.toHexString(seoyugi.hashCode()));

		// 해쉬(hash)란 임의의 길이를 가진 데이터를 고정된 길이를 가진 데이터로 맵핑한 것
		// 이 과정에서 원본데이터를 키(key) 매핑하는 과정을 (hashing)
		// 결과물로 나온 데이터를 해쉬값(Hash value)
		// 이렇게 데이터를 해싱하는 함수를 해시함수(Hash function)이라고 함.
		String pw = "1234";
		String encode = encrypt(pw);
		System.out.println(encode);
		Scanner sc = new Scanner(System.in);
		while (true) {
			System.out.println("암호를 입력하세요");
			System.out.print(">>>");
			String msg = sc.nextLine();
			String userPW = encrypt(msg);
			if (userPW.equals(encode)) {
				System.out.println("로그인 완료");
				break;
			} else {
				System.out.println("다른 비밀번호");
			}
		}
		int [] oneD = {1,2,3};//일차원 배열
		System.out.println(oneD[1]);
		int [][] twoD = {{1,2,3}, {4,5,6}, {7,8,9}};//다차원 배열
		System.out.println(twoD[0][1]);
		int [][][] threeD = { {{1,2,3}, {4,5,6}, {7,8,9}}, {{10,11,12}, {13,14}}};
		System.out.println(threeD[0][0][1]);
		System.out.println(threeD[1][1][0]);
	
		for(int i=0; i<twoD.length; i++) {
			for(int j=0; j<twoD[i].length; j++) {
				System.out.println(twoD[i][j]);
			}
		}
	}

	public static void printArr(String[] strArr) {
		for (int i = 0; i < strArr.length; i++) {
			if (i == strArr.length - 1) {
				System.out.println(strArr[i]);
				break;
			}
			System.out.print(strArr[i] + ",");
		}
	}

	// 해쉬 암호화
	public static String encrypt(String text) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256"); // 암호화 기법 중 대표방법
		md.update(text.getBytes());
		return bytesToHex(md.digest());

	}

	public static void printArr(int[] strArr) {
		for (int i = 0; i < strArr.length; i++) {
			if (i == strArr.length - 1) {
				System.out.println(strArr[i]);
				break;
			}
			System.out.print(strArr[i] + ",");
		}
	}
	
	public static String bytesToHex(byte[] bytes) {
		StringBuffer builder = new StringBuffer();
		for (byte b : bytes) {
			builder.append(String.format("%02x", b));
		}
		return builder.toString();
	}
}