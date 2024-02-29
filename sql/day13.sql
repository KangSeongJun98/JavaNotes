/*
    계층형 쿼리
    오라클에서 지원하고있는 기능
    관계형 데이터베이스(RDB)의 데이터는 수평적인데이터로 구성돼있는데
    계층형쿼리를 사용해 수직적 구조로 표현할 수 있음
    메뉴, 부서, 권한등을 계층형 쿼리로 만들 수 있음
*/
SELECT department_id
     ,LPAD(' ', 3 * (LEVEL-1)) || department_name as 부서명
     ,LEVEL             --(계층)트리 내에 어떤 단계가 있는지 나타내는 정수값
     ,parent_id
FROM departments
START WITH parent_id IS NULL                    --시작조건
CONNECT BY PRIOR department_id = parent_id;     --구조가 어떻게 연결되는지

SELECT a.employee_id
      ,a.manager_id
      ,LPAD(' ', 3*(LEVEL-1)) || a.emp_name as 이름
      ,b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id
START WITH a.manager_id IS NULL
CONNECT BY PRIOR a.employee_id = a.manager_id
AND a.department_id = 30; -- 검색조건을 만들려면 계층형을 만들고 난 다음에 넣어야 함





INSERT INTO departments(
                        department_name
                      , department_id
                      , parent_id) 
VALUES('CHATBOT팀', 280,  230);

SELECT a.employee_id
      ,a.manager_id
      ,LPAD(' ', 3*(LEVEL-1)) || a.emp_name as 이름
      ,b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id
START WITH a.manager_id IS NULL
CONNECT BY PRIOR a.employee_id = a.manager_id
-- ORDER BY b.department_id
ORDER SIBLINGS BY b.department_id; -- 동일 조건 안에서 정렬하는 법 SIBLINGS
                                   -- 이렇게 안하면 트리 깨짐
                                   
                            
                            
/*
계층형 쿼리의 함수

*/

SELECT department_id
     ,LPAD(' ', 3 * (LEVEL-1)) || department_name as 부서명
     ,LEVEL             --(계층)트리 내에 어떤 단계가 있는지 나타내는 정수값
     ,parent_id
     ,CONNECT_BY_ROOT department_name as rootNm -- root row (최상위 부모)에 접근
     ,SYS_CONNECT_BY_PATH(department_name, '>') as pathNm
     ,CONNECT_BY_ISLEAF as leafNm -- 마지막 노드면 1, 자식있으면 0
FROM departments
START WITH parent_id IS NULL                    --시작조건
CONNECT BY PRIOR department_id = parent_id;     --구조가 어떻게 연결되는지
                                
CREATE TABLE test_info(
              이름 VARCHAR(100)  
             ,직책 VARCHAR(100)
             ,레벨 number
             ,부모레벨 number);

INSERT INTO test_info values('이사장', '사장', 1, NULL);
INSERT INTO test_info values('김부장', '부장', 2, 1);
INSERT INTO test_info values('서차장', '차장', 3, 2);
INSERT INTO test_info values('장과장', '과장', 4, 3);
INSERT INTO test_info values('이대리', '대리', 5, 4);
INSERT INTO test_info values('최사원', '사원', 6, 5);
INSERT INTO test_info values('강사원', '사원', 6, 5);
INSERT INTO test_info values('박과장', '과장', 14, 3);
INSERT INTO test_info values('김대리', '대리', 15, 14);
INSERT INTO test_info values('주사원', '사원', 16, 15);

SELECT 이름
      ,LPAD(' ', 3*(LEVEL-1)) || 직책 as 직책 
      ,LEVEL as 레벨
FROM test_info
START WITH 부모레벨 IS NULL
CONNECT BY PRIOR 레벨 = 부모레벨;

/*
 계층형 쿼리 응용 (샘플 데이터 생성)
 LEVEL은 가상 열로써 (CONNECT BY 절과 함께 사용)
*/

SELECT '2013'||LPAD(LEVEL,2,'0') as 년월
FROM dual
CONNECT BY LEVEL <=12;




SELECT a.년월
      ,NVL(b.대출합계,0)
FROM (SELECT '2013'||LPAD(LEVEL,2,'0') as 년월
      FROM dual
      CONNECT BY LEVEL <=12) a
      
     ,(
       SELECT period as 년월
      ,SUM(loan_jan_amt) as 대출합계
       FROM kor_loan_status
       WHERE period LIKE '%2013%'
       GROUP BY period) b
WHERE a.년월 = b.년월(+)
ORDER BY 1;


-- connect by level 사용
SELECT TO_CHAR(SYSDATE,'YYYY')||LPAD(LEVEL,2,'0') as 년월
FROM dual
CONNECT BY LEVEL <=12;


SELECT TO_CHAR(SYSDATE,'YYYY/MM')||'/'||LPAD(LEVEL,2,'0') as 일
FROM dual
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(SYSDATE),'dd');


SELECT NVL(b.년월,'합계')as 생일_월
      ,COUNT(a.년월) as 회원수
FROM(      
       SELECT TO_CHAR(mem_bir,'MM') as 년월
       FROM member) a
,
(SELECT LPAD(LEVEL,2,'0') as 년월
FROM dual
CONNECT BY LEVEL <=12) b
WHERE b.년월 = a.년월(+)
GROUP BY ROLLUP (b.년월)
ORDER BY 1;
