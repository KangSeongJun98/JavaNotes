# Java Collection Framework
데이터를 저장하는 자료 구조와 데이터를 처리하는 알고리즘을 구조화하여 클래스로 구현해 놓은 것   
## 종류:   
### 1. List: 
* 순서대로 객체를 저장하는 구조, 
* 중복된 원소를 허용
* 원소에 접근하기 위해 인덱스 사용
* 대표적인 예로 ArrayList, LinkedList가 있습니다.

### 예시
```
//ArrayList(동적 배열 형태)
		ArrayList<String>students = new ArrayList<>();
		//ArrayList<String>students = new ArrayList<String>();
		ArrayList<Integer>intList = new ArrayList<>();
		
        intList.add(5);
		intList.add(10);
		System.out.println(intList);

		students.add("팽수");
		students.add("동길");
		System.out.println(students);

		for(String i:students) {
			System.out.println(i);
		}
``` 

### 2. Set: 
* 중복을 허용하지 않는 객체의 모음
* 원본의 순서는 보장하지 않음
* 대표적인 예로 HashSet, TreeSet가 있습니다.

### 예시
```
        //Set 중복 허용 안됨
		HashSet <String>stuSet = new HashSet<>();
		stuSet.add("팽수");
		stuSet.add("팽순");
		stuSet.add("팽수");
		System.out.println(stuSet);

		//.size()
		System.out.println(stuSet.size());

		//set은 순서 정보가 없음;
		//반복문 1
		for(String stu: stuSet) {
			System.out.println(stu);
		}
``` 

### 2. Map: 
* 키와 값의 쌍으로 이루어진 객체를 저장하는 구조
* 키는 중복될 수 없으며 각 키는 하나의 값을 가리킵니다.
* 벨류값으로는 배열도 들어갈 수 있습니다.
* 대표적인 예로 HashMap, TreeMap이 있습니다.

### 예시
```
        // key와 value 한쌍인 데이터를 저장
		HashMap<String, String> stuMap = new HashMap<>();
		// 제네릭의 첫번 째가 key의 타입 두번 째가 value타입
		stuMap.put("첫째", "길동");
		stuMap.put("둘째", "동길");
		stuMap.put("셋째", "홍길");
		//출력하는 순서는 보장하지 않음
		System.out.println(stuMap);

		HashMap<String, Integer> coinMap = new HashMap<>();
		coinMap.put("비트코인", 45000000);
		coinMap.put("이더리움", 10000000);
		System.out.println(coinMap);

		// .get("key")
		System.out.println(coinMap.get("비트코인"));
		System.out.println(stuMap.get("첫째"));
		// .size()

		System.out.println(stuMap.size());

		// .containsKey, containsValue
		System.out.println(stuMap.containsKey("둘째"));
		System.out.println(stuMap.containsValue("길동"));

		// .remove("키") 삭제
		stuMap.remove("셋째");
		System.out.println(stuMap);

		// .put 수정
		coinMap.put("비트코인", 20000000);
		System.out.println(coinMap);

		// ketSet 이용
		Set<String> keySet = stuMap.keySet();
		System.out.println(keySet);
		for (String key : keySet) {
			System.out.print(key +":");
			System.out.println(stuMap.get(key));
		}
``` 
## ArrayList, HashMap, HashSet의 메소드 비교

1. 배열에 요소 추가:   
* ArrayList: add()
* HashSet : add()
* HashMap: put(key, value)

2. 배열 요소 삭제:
* ArrayList: remove(index or object)
* HashMap: remove(key)
* HashSet : remove(object) //index가 없다.

3. 배열 요소 가져오기:
* ArrayList: get(index)
* HashMap: get(key)
* HashSet: 전체출력이나 for문 Iterator를 사용
#### HashSet 배열 요소 가져오기 예제
```

HashSet<Integer> set = new HashSet<Integer>(Arrays.asList(1,2,3));//HashSet생성

System.out.println(set); //전체출력 [1,2,3]
		
Iterator iter = set.iterator();	// Iterator 사용
while(iter.hasNext()) {//값이 있으면 true 없으면 false
    System.out.println(iter.next());
}
```

4. 배열 요소 수정하기:
* ArrayList: set(index)
* HashMap: put(key, value)   
  // key값은 하나이기때문에 추가와 수정 방법이 동일하다.
* HashSet: 따로 메소드가 없기 때문에 직접 필요 없는 요소를 삭제후 추가해야 한다.
