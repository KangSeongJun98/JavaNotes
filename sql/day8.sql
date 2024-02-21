-- INNER JOIN
SELECT * FROM 학생;

SELECT * FROM 수강내역;

SELECT 학생.이름 as 이름
      ,학생.평점
      ,학생.학번
      ,수강내역.수강내역번호
      ,수강내역.과목번호
      ,과목.과목이름
FROM 학생, 수강내역, 과목 --FROM 절에 오는 테이블은 주로 기준이 되는 걸로 한다 
WHERE 학생.학번 = 수강내역.학번
AND 수강내역.과목번호 = 과목.과목번호
AND 학생.이름 = '최숙경'; -- 검색조건을 만들 땐 데이터가 한 번에 많이 구분될만한 걸 위로 올리면 검색 빨리 된다.


--학생의 수강내역 건수를 조회하시오
SELECT 이름
      ,ROUND(평점,2) as 평점
      ,학생.학번
      ,COUNT(수강내역번호) as 수강내역건수
FROM 학생, 수강내역
WHERE 학생.학번 = 수강내역.학번
GROUP BY 이름, 평점, 학생.학번
ORDER BY 1;
-- GROUP BY절 하면 집계함수 제외한 모든 컬럼은 group by 안에 넣어야 함

/* outer join 외부조인 */
SELECT 이름
      ,ROUND(평점,2) as 평점
      ,학생.학번
      ,COUNT(수강내역번호) as 수강내역건수 -- *을 써버리면 null도 포함되기때문에 0이 아니라 1나옴
FROM 학생, 수강내역
WHERE 학생.학번 = 수강내역.학번(+) -- null값을 포함시키고 싶은 테이블에 (+)를 붙인다
GROUP BY 이름, 평점, 학생.학번
ORDER BY 1;


SELECT COUNT(*)
FROM 학생, 수강내역; --cross join (주의해야함 잘못된 조인)  
                     -- 9*17 = 153

SELECT COUNT(*)
FROM 학생, 수강내역
WHERE 학생.학번 = 수강내역.학번;


SELECT 학생.이름
      ,ROUND(평점,2) as 평점
      ,학생.학번
      ,COUNT(수강내역번호) as 수강건수 -- *을 써버리면 null도 포함되기때문에 0이 아니라 1나옴
      ,SUM(NVL(과목.학점,0)) as 총수강학점
FROM 학생, 수강내역, 과목
WHERE 학생.학번 = 수강내역.학번(+) -- null값을 포함시키고 싶은 테이블에 (+)를 붙인다
AND 수강내역.과목번호 = 과목.과목번호(+)
GROUP BY 이름, 평점, 학생.학번
ORDER BY 1;

SELECT * FROM member;
SELECT * FROM cart;
SELECT * FROM prod;

SELECT 
       a.mem_id                     as id
      ,a.mem_name                   as 이름
      ,COUNT(DISTINCT b.cart_no)    as 카트사용수 
      ,COUNT(DISTINCT b.cart_prod)  as 구매품목수
      ,NVL(SUM(b.cart_qty),0)       as 총구매상품수
      ,SUM(NVL(c.prod_sale*b.cart_qty, 0))||'원'  as 총구매금액
FROM member a
    ,cart b
    ,prod c
WHERE a.mem_id = b.cart_member(+)
AND b.cart_prod = c.prod_id(+)
AND a.mem_name = '김은대'
GROUP BY a.mem_id, a.mem_name;

SELECT * FROM employees;
SElECT * FROM jobs;

SELECT employee_id
      ,a.emp_name
      ,a.salary
      ,b.job_title
FROM employees a, jobs b
where a.job_id = b.job_id
AND a.salary >= 15000;


/*  subquery(쿼리안에 쿼리)
    1.스칼라 서브 쿼리(select 절)
    2.인라인 뷰(from 절)
    3.중첩쿼리 (where 절)
*/

-- 스칼라 서브쿼리는 단일 행 반환
-- 주의할 점은 메인 쿼리테이블의 행 건수만큼 조회하기때문에 (무거운 테이블을 사용하면 오래걸림)
-- 위와 같은 상황에서는 조인을 이용하는게 더 좋음

SELECT * FROM employees;
SELECT * FROM jobs;
SELECT * FROM departments;

SELECT a.emp_name
      ,a.department_id -- 부서 아이디 대신 부서명이 필요할 때
                       -- 부서 아이디는 부서 테이블의 pk(유니크함 단일행 반환)
     ,(SELECT department_name
       FROM departments
       WHERE departments.department_id = a.department_id) as dep_nm --반드시 단일행 반환에서만 사용 가능
    ,(SELECT job_title
      FROM jobs
      WHERE jobs.job_id = a.job_id) as job_title
FROM employees a;

--중첩 서브쿼리(where절)
--직원 중 salary 전체 평균보다 높은 직원을 출력하시오
SELECT AVG(salary)
FROM employees;

SELECT emp_name, salary
FROM employees
WHERE salary >= (SELECT AVG(salary)
                 FROM employees)
ORDER BY 2;

-- 두 개가 똑같음
SELECT emp_name, salary
FROM employees
WHERE salary >= 6461.831775700934579439252336448598130841
ORDER BY 2;

SELECT AVG(평점) FROM 학생;

-- 평점이 평균이상
SELECT 학번
      ,이름
      ,전공
      ,ROUND(평점, 2) as 평점
FROM 학생
WHERE 평점 >= (SELECT AVG(평점) FROM 학생);

-- 평점이 가장 높은 학생
SELECT 학번
      ,이름
      ,전공
      ,ROUND(평점, 2) as 평점
FROM 학생
WHERE 평점 = (SELECT MAX(평점) FROM 학생);

-- 수강 이력이 없는 학생의 이름을 출력
SELECT * FROM 학생;
SELECT * FROM 수강내역;

SELECT 이름
FROM 학생
WHERE 이름 NOT IN ( SELECT 학생.이름
                    FROM 학생, 수강내역
                    WHERE 학생.학번 = 수강내역.학번);
                    

SELECT 이름
FROM 학생
WHERE 학번 NOT IN ( SELECT 학번
                    FROM 수강내역);
                    
-- 동시에 2개 이상의 컬럼 값이 같은 껀을 조회
SELECT employee_id
      ,emp_name
      ,job_id
FROM employees
where (employee_id, job_id) IN (SELECT employee_id, job_id
                                FROM job_history);
-- 지역과 각 년도별 대출총잔액

DECODE(period LIKE '%2013%');

SELECT DECODE(period LIKE '%2013%', 2013, 2013) 
FROM kor_loan_status;

SELECT * FROM kor_loan_status;

SELECT NVL(region, '총합')
      ,SUM(CASE WHEN period LIKE '%2011%' THEN loan_jan_amt
        ELSE 0
       END) as amt_2011
       
      ,SUM(CASE WHEN period LIKE '%2012%' THEN loan_jan_amt
        ELSE 0
       END) as amt_2012
      ,SUM(CASE WHEN period LIKE '%2013%' THEN loan_jan_amt
        ELSE 0
       END) as amt_2013
FROM  kor_loan_status
GROUP BY ROLLUP(region);