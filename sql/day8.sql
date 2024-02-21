-- INNER JOIN
SELECT * FROM �л�;

SELECT * FROM ��������;

SELECT �л�.�̸� as �̸�
      ,�л�.����
      ,�л�.�й�
      ,��������.����������ȣ
      ,��������.�����ȣ
      ,����.�����̸�
FROM �л�, ��������, ���� --FROM ���� ���� ���̺��� �ַ� ������ �Ǵ� �ɷ� �Ѵ� 
WHERE �л�.�й� = ��������.�й�
AND ��������.�����ȣ = ����.�����ȣ
AND �л�.�̸� = '�ּ���'; -- �˻������� ���� �� �����Ͱ� �� ���� ���� ���еɸ��� �� ���� �ø��� �˻� ���� �ȴ�.


--�л��� �������� �Ǽ��� ��ȸ�Ͻÿ�
SELECT �̸�
      ,ROUND(����,2) as ����
      ,�л�.�й�
      ,COUNT(����������ȣ) as ���������Ǽ�
FROM �л�, ��������
WHERE �л�.�й� = ��������.�й�
GROUP BY �̸�, ����, �л�.�й�
ORDER BY 1;
-- GROUP BY�� �ϸ� �����Լ� ������ ��� �÷��� group by �ȿ� �־�� ��

/* outer join �ܺ����� */
SELECT �̸�
      ,ROUND(����,2) as ����
      ,�л�.�й�
      ,COUNT(����������ȣ) as ���������Ǽ� -- *�� ������� null�� ���ԵǱ⶧���� 0�� �ƴ϶� 1����
FROM �л�, ��������
WHERE �л�.�й� = ��������.�й�(+) -- null���� ���Խ�Ű�� ���� ���̺� (+)�� ���δ�
GROUP BY �̸�, ����, �л�.�й�
ORDER BY 1;


SELECT COUNT(*)
FROM �л�, ��������; --cross join (�����ؾ��� �߸��� ����)  
                     -- 9*17 = 153

SELECT COUNT(*)
FROM �л�, ��������
WHERE �л�.�й� = ��������.�й�;


SELECT �л�.�̸�
      ,ROUND(����,2) as ����
      ,�л�.�й�
      ,COUNT(����������ȣ) as �����Ǽ� -- *�� ������� null�� ���ԵǱ⶧���� 0�� �ƴ϶� 1����
      ,SUM(NVL(����.����,0)) as �Ѽ�������
FROM �л�, ��������, ����
WHERE �л�.�й� = ��������.�й�(+) -- null���� ���Խ�Ű�� ���� ���̺� (+)�� ���δ�
AND ��������.�����ȣ = ����.�����ȣ(+)
GROUP BY �̸�, ����, �л�.�й�
ORDER BY 1;

SELECT * FROM member;
SELECT * FROM cart;
SELECT * FROM prod;

SELECT 
       a.mem_id                     as id
      ,a.mem_name                   as �̸�
      ,COUNT(DISTINCT b.cart_no)    as īƮ���� 
      ,COUNT(DISTINCT b.cart_prod)  as ����ǰ���
      ,NVL(SUM(b.cart_qty),0)       as �ѱ��Ż�ǰ��
      ,SUM(NVL(c.prod_sale*b.cart_qty, 0))||'��'  as �ѱ��űݾ�
FROM member a
    ,cart b
    ,prod c
WHERE a.mem_id = b.cart_member(+)
AND b.cart_prod = c.prod_id(+)
AND a.mem_name = '������'
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


/*  subquery(�����ȿ� ����)
    1.��Į�� ���� ����(select ��)
    2.�ζ��� ��(from ��)
    3.��ø���� (where ��)
*/

-- ��Į�� ���������� ���� �� ��ȯ
-- ������ ���� ���� �������̺��� �� �Ǽ���ŭ ��ȸ�ϱ⶧���� (���ſ� ���̺��� ����ϸ� �����ɸ�)
-- ���� ���� ��Ȳ������ ������ �̿��ϴ°� �� ����

SELECT * FROM employees;
SELECT * FROM jobs;
SELECT * FROM departments;

SELECT a.emp_name
      ,a.department_id -- �μ� ���̵� ��� �μ����� �ʿ��� ��
                       -- �μ� ���̵�� �μ� ���̺��� pk(����ũ�� ������ ��ȯ)
     ,(SELECT department_name
       FROM departments
       WHERE departments.department_id = a.department_id) as dep_nm --�ݵ�� ������ ��ȯ������ ��� ����
    ,(SELECT job_title
      FROM jobs
      WHERE jobs.job_id = a.job_id) as job_title
FROM employees a;

--��ø ��������(where��)
--���� �� salary ��ü ��պ��� ���� ������ ����Ͻÿ�
SELECT AVG(salary)
FROM employees;

SELECT emp_name, salary
FROM employees
WHERE salary >= (SELECT AVG(salary)
                 FROM employees)
ORDER BY 2;

-- �� ���� �Ȱ���
SELECT emp_name, salary
FROM employees
WHERE salary >= 6461.831775700934579439252336448598130841
ORDER BY 2;

SELECT AVG(����) FROM �л�;

-- ������ ����̻�
SELECT �й�
      ,�̸�
      ,����
      ,ROUND(����, 2) as ����
FROM �л�
WHERE ���� >= (SELECT AVG(����) FROM �л�);

-- ������ ���� ���� �л�
SELECT �й�
      ,�̸�
      ,����
      ,ROUND(����, 2) as ����
FROM �л�
WHERE ���� = (SELECT MAX(����) FROM �л�);

-- ���� �̷��� ���� �л��� �̸��� ���
SELECT * FROM �л�;
SELECT * FROM ��������;

SELECT �̸�
FROM �л�
WHERE �̸� NOT IN ( SELECT �л�.�̸�
                    FROM �л�, ��������
                    WHERE �л�.�й� = ��������.�й�);
                    

SELECT �̸�
FROM �л�
WHERE �й� NOT IN ( SELECT �й�
                    FROM ��������);
                    
-- ���ÿ� 2�� �̻��� �÷� ���� ���� ���� ��ȸ
SELECT employee_id
      ,emp_name
      ,job_id
FROM employees
where (employee_id, job_id) IN (SELECT employee_id, job_id
                                FROM job_history);
-- ������ �� �⵵�� �������ܾ�

DECODE(period LIKE '%2013%');

SELECT DECODE(period LIKE '%2013%', 2013, 2013) 
FROM kor_loan_status;

SELECT * FROM kor_loan_status;

SELECT NVL(region, '����')
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