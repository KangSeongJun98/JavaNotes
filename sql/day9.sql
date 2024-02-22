/* 서브 쿼리 
    2. 인라인 뷰(FROM 절)
    SELECT 문의 질의 결과를 마치 테이블 처럼 사용*/
SELECT * 
FROM(   SELECT 학생.학번
       ,학생.이름
       ,학생.전공
       ,COUNT(수강내역.수강내역번호) as 수강내역건수
        FROM 학생, 수강내역
        where 학생.학번 = 수강내역.학번(+)
        GROUP BY 학생.학번, 학생.이름, 학생.전공
        ORDER BY 4 DESC) a --FROM 절에 오는 select 문 은 테이블처럼 사용이 가능
WHERE ROWNUM =1;


SELECT * 
FROM(SELECT ROWNUM as runm
      , a.* -- a테이블 전체컬럼
      FROM( SELECT ROWNUM as subRnum, mem_id, mem_name 
            FROM member
            WHERE mem_name LIKE '%%'
            ORDER BY mem_name
            ) a
            
        ) --where절을 쓰기 위해 한 번 더 감싼것
          --where rownum을 쓰려고 하니까 
WHERE runm BETWEEN 1 AND 10;
--rownum은 select를 쓸 때마다 생성됨

--학생들 중 평점이 높은 상위 5명

SELECT * 
FROM(
    SELECT 이름,평점
    FROM 학생
    ORDER BY 2 DESC
    )
WHERE ROWNUM <= 5;
-- order by가 가장 마지막에 실행되기 때문에 
-- 바로 where rownum 을 써버리면 정렬이 안된 상태의 테이블이 나옴


-- 5등만 조회
-- rownum을 하나의 컬럼으로 만들어 줘야 함
SELECT *
FROM( SELECT   ROWNUM as rnum
               ,a.* 
        FROM(
             SELECT 이름,평점
             FROM 학생
             ORDER BY 2 DESC
             ) a
    )
WHERE rnum = 5;

-- 학생들의 경영학에서 평점이 가장 높은 학생의 정보를 출력
SELECT * FROM 학생;

SELECT  *   
FROM(   SELECT 이름,전공,평점 
        FROM 학생
        where 전공 = '경영학'
        ORDER BY 3 DESC)
WHERE ROWNUM <=1;



-- 학생들의 '전공별' '평점'이 '가장높은' 학생의 정보
SELECT *
FROM 학생
WHERE(전공, 평점) IN (SELECT 전공, MAX(평점)
                      FROM 학생
                      GROUP BY 전공);


-- 2000년도 판매(금액) 왕 출력 (sales, employees)
-- 판매 관련 컬럼 amount_sold, quantity_sold(판매갯수), sales_data
-- 스칼라서브쿼리와 인라인뷰 사용

SELECT * FROM employees;
SELECT * FROM sales;


SELECT *
FROM( SELECT emp_name as 이름
      ,a.employee_id as 사번
      ,TO_CHAR(SUM(amount_sold),'999,999,999.99') as 판매금액
      ,COUNT(quantity_sold) as 판매수량
      FROM employees a, sales b
      WHERE a.employee_id = b.employee_id
      AND TO_CHAR(sales_date, 'YYYY') = 2000
      GROUP BY emp_name, a.employee_id
      ORDER BY SUM(amount_sold) DESC )
WHERE ROWNUM <=1;