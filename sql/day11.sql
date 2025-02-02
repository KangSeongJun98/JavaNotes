/* 
    정규 표현식 (Regular Expression)
    oracle 10g부터 사용 가능   REGEXP_   <- 로 시작하는 함수
    .(dot) or []는 문자열에서 1글자를 의미함
    ^는 시작 $는 끝을 뜻 함
    [^] 는(대괄호 안에 ^) not 의미
    
    반복시퀀스
    *: 0개 이상,  +: 1개 이상, ?: 0~1개
    {n}: n번, {n,}n번 이상 {n,m} n번 이상 m번 이하
    
    REGEXP_LIKE: 정규식 패턴 검색
*/
SELECT *
FROM member
WHERE REGEXP_LIKE(mem_comtel, '^..-'); -- 시작해서 두글자 뒤에 -(하이픈) 나오는 패턴 

SELECT *
FROM member
WHERE REGEXP_LIKE(MEM_MAIL, '^[a-zA-Z]{3,5}@');

--한글 띄어쓰기 숫자 패턴 추출
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '[가-힣] [0-9]');

-- 한글로 끝나는 패턴
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '[가-힣]$');

--한글만 포함된 패턴
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '^[가-힣]+$');

--한글이 아예 없는 패턴
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '^[^가-힣]+$');

-- |:또는, (): 패턴그룹
-- j로 시작하며 ,세 번째 문자가 m or n 직원의 이름 조회
SELECT emp_name
FROM employees
WHERE REGEXP_LIKE (emp_name,'^(J|j).(n|m)');


-- REGEXP_SUBSTR 정규식 패턴과 일치하는 문자열 반환
-- 이메일 @를 기준으로 앞과 뒤를 출력
SELECT mem_mail
      ,REGEXP_SUBSTR(mem_mail, '[^@]+' ,1 ,1) as 아이디
      ,REGEXP_SUBSTR(mem_mail, '[^@]+' ,1 ,2) as 도메인
FROM member;

SELECT REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 1) as ex1
      ,REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 2) as ex2
      ,REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 3) as ex3
FROM dual;


SELECT   mem_add1
        ,REGEXP_SUBSTR(mem_add1, '[^ ]+',1, 1) -- 매개변수 3,4번의 default가 1,1 임
FROM member;

--REGEXP_REPLACE 대상 문자열에서 정규 표현식을 적용하여 다른 패턴으로 대체
--Ellen Hildi smith - > Smith, Ellen Hildi
SELECT REGEXP_REPLACE('Ellen Hildi Smith', '(.*) (.*) (.*)','\3, \1 \2')
FROM dual;

-- 공백 2자리 이상을 찾아서 1자리로 대체
SELECT REGEXP_REPLACE('Joe               Smith   Hi', '( ){2,}',' ' )
FROM dual;

-- 대전의 주소들을 모두 '대전'으로 출력하시오
SELECT   mem_add1
        ,REGEXP_REPLACE(mem_add1,'(^대전시|^대전광역시) (.*)', '대전 \2' )
FROM member
WHERE mem_add1 LIKE '%대전%'
AND mem_id != 'p001';

--전화번호 뒷자리에서 동일한 번호가 반복되는 사원을 조회
--펄 표기법 \w = [a-zA-Z0-9] , \d = [0-9]
SELECT emp_name, phone_number
FROM employees
WHERE REGEXP_LIKE(phone_number, '(\d\d)\1$'); --\1은 첫번째 캡처 그룹을 다시 참조
                                              --즉 이전에 매칭된 두자리 숫자와
                                              --정확히 일치하는 두자리 숫자를 의미함
                                              
                                              
                                              