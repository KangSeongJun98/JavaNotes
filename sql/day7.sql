SELECT * FROM kor_loan_status;
SELECT gubun
      ,sum(loan_jan_amt) as �հ�
FROM kor_loan_status
group by ROLLUP(gubun); -- �Ѱ���� ������


SELECT * FROM member;
SELECT mem_job
      ,SUM(mem_mileage)
FROM member
GROUP BY ROLLUP(mem_job);

SELECT period
      ,gubun
      ,SUM(loan_jan_amt) as �հ�
FROM kor_loan_status
where period LIKE '%2013%'
GROUP BY ROLLUP(period, gubun); --�÷��� �ϳ� �þ�� �Ұ谡 �ϳ� �� �þ(�̰ͱ��� �� �Ⱦ�)


SELECT gubun
      ,period
      ,SUM(loan_jan_amt) as �հ�
FROM kor_loan_status
where period LIKE '%2013%'
GROUP BY ROLLUP(gubun, period); --�Ű����� ��ġ �ٲٸ� ���п� ���� �Ұ谡 ��

--grouping_id      
SELECT * FROM employees;
SELECT DEPARTMENT_ID 
      ,GROUPING_ID(department_id)as �׷� --group rollup�� ����� �κ�
      ,COUNT(*) as ������ --count �� �� �÷����� ������ null���� üũ ������
FROM employees
GROUP BY ROLLUP(DEPARTMENT_ID);

SELECT CASE WHEN DEPARTMENT_ID is NULL AND GROUPING_ID(DEPARTMENT_ID) =0 THEN '�μ�����'
             WHEN DEPARTMENT_ID is NULL AND GROUPING_ID(DEPARTMENT_ID) =1 THEN '�Ѱ�'
             ELSE TO_CHAR(DEPARTMENT_ID)
             END AS �μ�
      ,COUNT(*) as ������ --count �� �� �÷����� ������ null���� üũ ������
FROM employees
GROUP BY ROLLUP(DEPARTMENT_ID);


--������ �̹� ������ commission_pct��ŭ �߰������Ϸ��� �� ��
--����, �߰��ݾ�, �ջ�ݾ�

--NVL(����, ���氪) ������ null�� ��� ���氪���� ��ü
SELECT emp_name
      ,salary as ����
      ,commission_pct as ��
      -- null * salary �ϸ� null�� ������ ������ null�ϰ�� 0���� ��ü�ϴ� NVL ���
      ,salary + (salary*NVL(commission_pct,0)) as �ջ�ݾ�
FROM employees;

SELECT*FROM member;

SELECT NVL(mem_job, '�� ��') --ROLLUP�� �ϸ� ���պκ��� null �����ϱ� �װ� NVL�� ������
      ,count(*) as ȸ����
      ,SUM(mem_mileage) as ���ϸ���
FROM member
where MEM_ADD1 LIKE '%����%'
GROUP BY ROLLUP(mem_job);


-- ���� UNION (������), UNION ALL ��ü����, MINUS ������, INTERSECT ������
-- ��ȸ����� �÷����� Ÿ���� ���ٸ� ���� ���� ����(������ �������� ����)
-- �ೢ���� �����̱� ������ SELECT ������ �޶����鼭 Ÿ�Ե� �ٲ�� �Ǹ� ���� �ȵ�
SELECT goods
FROM exp_goods_asia
where country = '�ѱ�'
UNION  -- �ߺ��� �����ϰ� ������
--UNION ALL --�ߺ����� �� ������
--MINUS --������
--INTERSECT -- ������
SELECT goods
FROM exp_goods_asia
where country = '�Ϻ�';

SELECT seq,goods
FROM exp_goods_asia
where country ='�ѱ�'
UNION  
SELECT 1,'hi' -- �÷� �������� �� Ÿ�԰� �˻��� �÷��� ������ ���߸� �ȴ�
FROM dual;

SELECT mem_job
      ,SUM(mem_mileage)
FROM member
GROUP BY mem_job
UNION
SELECT '�հ�'
      ,SUM(mem_mileage)
FROM member
ORDER BY 2 asc;



--JOIN

SELECT * FROM member where mem_name='Ź����';

SELECT * FROM cart WHERE cart_member='n001';

--INNER JOIN(��������) (���� ���� �̶�� ��)
SELECT member.mem_id
      ,member.mem_name
      ,cart.cart_member
      ,cart.cart_prod
      ,cart.cart_qty
FROM member, cart
where member.mem_id = cart.cart_member
AND member.mem_name = '������';
                       -- Ź���� �ϸ� �ȳ��� mem_id���� �ִµ� cart_member���� ���

SELECT member.mem_id
      ,member.mem_name
      ,NVL(SUM(cart.cart_qty),0)
FROM member, cart
where member.mem_id = cart.cart_member(+) -- �ܺ�����(OUTER JOIN)
AND member.mem_name = 'Ź����'
GROUP BY member.mem_id
      ,member.mem_name;
      
      
SELECT a.mem_id
      ,a.mem_name
      ,b.cart_member
      ,b.cart_qty as ��ǰ���ż�
FROM member a, cart b
where a.mem_id = b.cart_member(+); -- �ܺ�����(OUTER JOIN)
--AND a.mem_name = 'Ź����';




SELECT employees.emp_name
      ,employees.department_id
FROM employees;
SELECT departments.department_id
      ,departments.department_name
FROM departments;

SELECT a.emp_name
      ,b.department_name
FROM employees a, departments b  --���̺� ��Ī
WHERE a.department_id = b.department_id;


SELECT emp_name                  -- �� ���̺� ���ʿ��� �ִ� �÷��� ���̺���� ���� �ʾƵ� ��
      ,department_name
      ,a.department_id           -- �� ���̺� ������ �÷����� �ִٸ� ��� �� ���� ������� ��
FROM employees a, departments b  -- ���̺� ��Ī
WHERE a.department_id = b.department_id;

--employees, jobs ���̺��� �̿��Ͽ� ������ ������ ���
SELECT * FROM employees;
SELECT * FROM jobs;

SELECT  a.employee_id
       ,a.emp_name
       ,a.salary
       ,b.job_title
FROM employees a, jobs b
WHERE a.job_id = b.job_id
ORDER BY 1;

