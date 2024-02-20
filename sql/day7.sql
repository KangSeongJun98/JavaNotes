SELECT * FROM kor_loan_status;
SELECT gubun
      ,sum(loan_jan_amt) as 합계
FROM kor_loan_status
group by ROLLUP(gubun); -- 총계까지 보여줌


SELECT * FROM member;
SELECT mem_job
      ,SUM(mem_mileage)
FROM member
GROUP BY ROLLUP(mem_job);

SELECT period
      ,gubun
      ,SUM(loan_jan_amt) as 합계
FROM kor_loan_status
where period LIKE '%2013%'
GROUP BY ROLLUP(period, gubun); --컬럼이 하나 늘어나면 소계가 하나 더 늘어남(이것까진 잘 안씀)


SELECT gubun
      ,period
      ,SUM(loan_jan_amt) as 합계
FROM kor_loan_status
where period LIKE '%2013%'
GROUP BY ROLLUP(gubun, period); --매개변수 위치 바꾸면 구분에 대한 소계가 됨

--grouping_id      
SELECT * FROM employees;
SELECT DEPARTMENT_ID 
      ,GROUPING_ID(department_id)as 그룹 --group rollup이 적용된 부분
      ,COUNT(*) as 직원수 --count 할 때 컬럼명을 넣으면 null값은 체크 안해줌
FROM employees
GROUP BY ROLLUP(DEPARTMENT_ID);

SELECT CASE WHEN DEPARTMENT_ID is NULL AND GROUPING_ID(DEPARTMENT_ID) =0 THEN '부서없음'
             WHEN DEPARTMENT_ID is NULL AND GROUPING_ID(DEPARTMENT_ID) =1 THEN '총계'
             ELSE TO_CHAR(DEPARTMENT_ID)
             END AS 부서
      ,COUNT(*) as 직원수 --count 할 때 컬럼명을 넣으면 null값은 체크 안해줌
FROM employees
GROUP BY ROLLUP(DEPARTMENT_ID);


--직원별 이번 월급을 commission_pct만큼 추가지급하려고 할 때
--월급, 추가금액, 합산금액

--NVL(대상건, 변경값) 대상건이 null일 경우 변경값으로 대체
SELECT emp_name
      ,salary as 월급
      ,commission_pct as 상여
      -- null * salary 하면 null이 나오기 때문에 null일경우 0으로 대체하는 NVL 사용
      ,salary + (salary*NVL(commission_pct,0)) as 합산금액
FROM employees;

SELECT*FROM member;

SELECT NVL(mem_job, '합 계') --ROLLUP을 하면 총합부분은 null 나오니까 그걸 NVL로 값설정
      ,count(*) as 회원수
      ,SUM(mem_mileage) as 마일리지
FROM member
where MEM_ADD1 LIKE '%대전%'
GROUP BY ROLLUP(mem_job);


-- 집합 UNION (합집합), UNION ALL 전체집합, MINUS 차집합, INTERSECT 교집합
-- 조회결과의 컬럼수와 타입이 같다면 집합 적용 가능(정렬은 마지막만 가능)
-- 행끼리의 결합이기 때문에 SELECT 순서가 달라지면서 타입도 바뀌게 되면 실행 안됨
SELECT goods
FROM exp_goods_asia
where country = '한국'
UNION  -- 중복을 제거하고 보여줌
--UNION ALL --중복까지 다 보여줌
--MINUS --차집합
--INTERSECT -- 교집합
SELECT goods
FROM exp_goods_asia
where country = '일본';

SELECT seq,goods
FROM exp_goods_asia
where country ='한국'
UNION  
SELECT 1,'hi' -- 컬럼 여러개일 땐 타입과 검색할 컬럼의 갯수만 맞추면 된다
FROM dual;

SELECT mem_job
      ,SUM(mem_mileage)
FROM member
GROUP BY mem_job
UNION
SELECT '합계'
      ,SUM(mem_mileage)
FROM member
ORDER BY 2 asc;



--JOIN

SELECT * FROM member where mem_name='탁원재';

SELECT * FROM cart WHERE cart_member='n001';

--INNER JOIN(내부조인) (동등 조인 이라고도 함)
SELECT member.mem_id
      ,member.mem_name
      ,cart.cart_member
      ,cart.cart_prod
      ,cart.cart_qty
FROM member, cart
where member.mem_id = cart.cart_member
AND member.mem_name = '김은대';
                       -- 탁원재 하면 안나옴 mem_id에는 있는데 cart_member에는 없어서

SELECT member.mem_id
      ,member.mem_name
      ,NVL(SUM(cart.cart_qty),0)
FROM member, cart
where member.mem_id = cart.cart_member(+) -- 외부조인(OUTER JOIN)
AND member.mem_name = '탁원재'
GROUP BY member.mem_id
      ,member.mem_name;
      
      
SELECT a.mem_id
      ,a.mem_name
      ,b.cart_member
      ,b.cart_qty as 상품구매수
FROM member a, cart b
where a.mem_id = b.cart_member(+); -- 외부조인(OUTER JOIN)
--AND a.mem_name = '탁원재';




SELECT employees.emp_name
      ,employees.department_id
FROM employees;
SELECT departments.department_id
      ,departments.department_name
FROM departments;

SELECT a.emp_name
      ,b.department_name
FROM employees a, departments b  --테이블 별칭
WHERE a.department_id = b.department_id;


SELECT emp_name                  -- 각 테이블 한쪽에만 있는 컬럼은 테이블명을 쓰지 않아도 됨
      ,department_name
      ,a.department_id           -- 두 테이블에 동일한 컬럼명이 있다면 어느 한 쪽을 정해줘야 함
FROM employees a, departments b  -- 테이블 별칭
WHERE a.department_id = b.department_id;

--employees, jobs 테이블을 이용하여 직원의 직무를 출력
SELECT * FROM employees;
SELECT * FROM jobs;

SELECT  a.employee_id
       ,a.emp_name
       ,a.salary
       ,b.job_title
FROM employees a, jobs b
WHERE a.job_id = b.job_id
ORDER BY 1;

