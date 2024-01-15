# Java 배열 (Array)
## 정의 및 특징:    
* 같은 타입의 변수들로 이루어진 유한 집합   
* 배열을 구성하는 각각의 값을 배열 요소(element)라고 한다.   
* 배열에서의 위치를 가리키는 숫자는 인덱스(index)라고 하며 이를 통해 각 요소에 접근한다.
* 배열에서 요소의 값은 바꿀 수 있지만 전체 사이즈는 변경 할 수 없다.
## 배열 선언과 초기화:
```
int[] myArray;        // 배열 선언
myArray = new int[5]; // 배열 초기화, 5개의 정수를 저장할 수 있음   
```

* 선언과 동시에 초기화
```
int [] arr = new int[3];
```
## 얕은 복사 (Shallow Copy)와 깊은 복사 (Deep Copy)   
### 얇은 복사:
* 단순하게 주소값만 복사하는 것    
* 바로가기를 만드는 것과 유사하며 한 쪽을 수정하면 다른 쪽도 같이 바뀐다.
```
String [] sinSeoyugi  = seoyugi;

		printArr(sinSeoyugi);
		sinSeoyugi[0] = "강호동";
		printArr(seoyugi);
		printArr(sinSeoyugi);
```

### 깊은 복사:
* clone 메소드를 사용
* 객체의 실제 값을 새로운 메모리에 복사한다.   
* 원본과 복사본이 완전히 독립적입니다. 
```
//  동일한 크기의 배열[원래배열.length]을  새로 만들어서 for문으로 값을 추가하는 것과 같음

		String newSeoyugi[] = seoyugi.clone();
		printArr(newSeoyugi);
		newSeoyugi[0]= "은지원";
		printArr(newSeoyugi);
		printArr(sinSeoyugi);
	} 
```  

## 다차원 배열
### 예시
```
int [] oneD = {1,2,3};//일차원 배열
		System.out.println(oneD[1]);

		int [][] twoD = {{1,2,3}, {4,5,6}, {7,8,9}};
		System.out.println(twoD[0][1]);

		int [][][] threeD = { {{1,2,3}, {4,5,6}, {7,8,9}}, {{10,11,12}, {13,14}}};
		System.out.println(threeD[0][0][1]);
		System.out.println(threeD[1][1][0]);
	
		for(int i=0; i<twoD.length; i++) {
			for(int j=0; j<twoD[i].length; j++) {
				System.out.println(twoD[i][j]);
			}
		}
```