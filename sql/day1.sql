-- SQL
-- DML (SELECT, INSERT, UPDATE, DELETE)
--       ��ȸ    ����    ����    ����
select * --*�� ��ü �÷��� �ǹ���
from employees;

select employee_id, emp_name from employees;

select * from employees where employee_id = 199;

/* table 
    1.�÷����� �ִ� ũ��� 30����Ʈ
    2.���̺�� �÷������δ� ���� ����� �� ����(������ �ȳ��µ� ���� ����)
    3.���̺�� �÷Ÿ����� ����,����,_,$,#dmf ����� �� ����(ù ���ڴ� �ݵ�� ����)
    4.�� ���̺� ����� �÷��� �ִ� 255��
*/

create table ex1_1(
-- �ϳ��� �÷��� �ϳ��� Ÿ�԰� ����� ����            
            col1 char(10)
            ,col2 varchar2(10) --���̺� ������ �÷��� ,�� ����       
);

-- INSERT ������ ����
INSERT INTO ex1_1(col1, col2) VALUES('abc','ABC');
SELECT * FROM ex1_1;

-- �ѱ��� �ѱ��ڿ� 3byte�� �� 12 > 10����Ʈ �Ѿ �����߻�
--INSERT INTO ex1_1(col1, col2) VALUES('�ȳ�','��������');
--SELECT * FROM ex1_1;

--���̺� ���� DROP 
DROP TABLE ex1_1;

SELECT emp_name     as nm   --AS(alias ��Ī) 
    , hire_date     hd      --�޸��� �������� �÷����� ���� �� �ڿ��� as ���̵� ��Ī ����
    , salary
    , department_id
FROM employees;

SELECT * 
FROM employees 
where salary>=10000;
--�˻� ���� ������
-- and / or ���
SELECT * 
FROM employees 
where salary>=10000 
AND    salary<=11000 ;

SELECT*
FROM employees
WHERE department_id =30
OR department_id = 60;

-- ���������� �ִٸ� order by ��� asc�� �������� desc�� �������� 
-- ����Ʈ�� ASC ��������
SELECT emp_name, department_id
FROM employees
WHERE department_id =30
OR department_id = 60
ORDER BY department_id DESC, emp_name ASC; 

-- ��Ģ���� ��밡��
SELECT emp_name
    , ROUND(salary/30,2)        as �ϴ�
    , salary                       ����
    , salary - salary*0.1          �Ǽ��ɾ�
    , salary * 12                  ����
FROM employees
ORDER BY 3 DESC;

-- �� ������
SELECT * FROM employees WHERE salary = 2600;  //���� java�� �ް�������
SELECT * FROM employees WHERE salary <> 2600; //���� �ʴ�
SELECT * FROM employees WHERE salary != 2600; //���� �ʴ� 
SELECT * FROM employees WHERE salary < 2600;  //�̸�
SELECT * FROM employees WHERE salary > 2600;  //�ʰ�
SELECT * FROM employees WHERE salary <= 2600; //����
SELECT * FROM employees WHERE salary >= 2600; //�̻�

DESC products;

SELECT PROD_NAME
    ,PROD_CATEGORY
    ,PROD_MIN_PRICE
FROM products
where PROD_MIN_PRICE >=30
and   PROD_MIN_PRICE <50
ORDER BY PROD_CATEGORY ASC, PROD_MIN_PRICE DESC;
