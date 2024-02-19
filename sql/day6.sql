/*
�����Լ�: ��� �����͸� Ư�� �׷����� ���� ���� 
�׷쿡���� ����, ���, �ִ밪, �ּҰ� ���� ���ϴ� �Լ�
*/
--count �ο� ���� ��ȯ�ϴ� �����Լ�
SELECT COUNT(*)                 --null����
    ,  COUNT(department_id)     -- default ALL
    ,  COUNT(ALL department_id) -- �ߺ� ����, null�� ����
    ,  COUNT(DISTINCT department_id) --�ߺ�����
    ,  COUNT(employee_id)
FROM employees;

SELECT COUNT(mem_id)
    ,  COUNT(*)
FROM member;

SELECT SUM(salary) as �հ�
      ,ROUND(AVG(salary),2) as ���
      ,MAX(salary) as �ִ�
      ,MIN(salary) as �ּ�
      ,COUNT(employee_id) as ������
   -- ,employee_id �����Լ� �� �� �ٸ� �÷� ����
FROM employees;

--group by
SELECT 
      department_id --group by���� �����°� �÷��� �߰��� �� ����
      ,SUM(salary) as �հ�
      ,ROUND(AVG(salary),2) as ���
      ,MAX(salary) as �ִ�
      ,MIN(salary) as �ּ�
      ,COUNT(employee_id) as ������
FROM employees
GROUP BY department_id;


-- where + group by
SELECT 
      department_id --group by���� �����°� �÷��� �߰��� �� ����
      ,SUM(salary) as �հ�
      ,ROUND(AVG(salary),2) as ���
      ,MAX(salary) as �ִ�
      ,MIN(salary) as �ּ�
      ,COUNT(employee_id) as ������
FROM employees
WHERE department_id IN(30,60,90)
GROUP BY department_id;

select * from member;

SELECT
        mem_job as ����
       ,COUNT(mem_id) as ȸ����
       ,SUM(mem_mileage) as �հ�
       ,ROUND(AVG(mem_mileage),2) as ���
       ,MIN(mem_mileage)  as �ּ�
       ,MAX(mem_mileage)  as �ִ�
FROM member
GROUP BY mem_job
ORDER BY AVG(mem_mileage) DESC;


DESC kor_loan_status;
SELECT 
       PERIOD
      ,SUM(LOAN_JAN_AMT) as ���ܾ�
FROM kor_loan_status
where PERIOD LIKE '%2013%'
GROUP BY PERIOD
ORDER BY PERIOD;

-- �Ⱓ��, ������ ���� �� �հ�
SELECT 
       REGION
      ,PERIOD
      ,SUM(LOAN_JAN_AMT) as ���ܾ�
FROM kor_loan_status
where PERIOD LIKE '%2013%'
GROUP BY PERIOD, REGION
ORDER BY 1;


SELECT 
       SUBSTR(period,1,4) as �⵵
      ,REGION
      ,SUM(LOAN_JAN_AMT) as ���ܾ�
FROM kor_loan_status
where region = '����'
GROUP BY SUBSTR(period,1,4), REGION
ORDER BY 1;


DESC employees

SELECT TO_CHAR(hire_date, 'YYYY') as �⵵
      ,COUNT(hire_date)           as ������
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY �⵵ ; 
-- select�� ���� ���� ����Ǳ� ������ ���� �������� ����Ǵ� order by���� as�� �̸��� �� �� ����


-- ���赥���Ϳ� ���ؼ� �˻� ������ ����Ϸ��� HAVING ���
SELECT TO_CHAR(hire_date, 'YYYY') as �⵵
      ,COUNT(*)           as ������
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
HAVING COUNT(*) >= 10
ORDER BY �⵵ ;

-- group by�� ������ ���谡 �Ǵµ� where �� group by �տ��� ���۵Ǳ� ������ ���� ����
-- �׷��� HAVING�� ��� ��

desc member

SELECT MEM_JOB 
      ,ROUND(avg(MEM_MILEAGE),2) as ���ϸ���
FROM MEMBER
GROUP BY MEM_JOB
HAVING avg(MEM_MILEAGE) >=3000
ORDER BY 2 DESC;

SELECT * FROM customers;

SELECT COUNT(cust_id) as ��üȸ����
      ,SUM(DECODE(cust_gender, 'F', 1, 0)) as ����
      ,SUM(DECODE(cust_gender, 'M', 1, 0)) as ����     
--    ,COUNT(DECODE(cust_gender, 'F','����')) as ����
--    ,COUNT(DECODE(cust_gender, 'M', '����')) as ����
FROM customers;