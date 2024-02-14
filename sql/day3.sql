/* DML: INSERT ������ ���� */
--1. �⺻���� �÷��� ���
CREATE TABLE  ex3_1 (
     col1 VARCHAR(100)
    ,col2 NUMBER
    ,col3 DATE
);

INSERT INTO ex3_1(col1, col2, col3)
VALUES ('NICK', 10, SYSDATE);

--���ڿ� Ÿ���� '' ���ڴ� ������ �׳� ������ '' ���̴� �͵� ��
-- Ư�� �ɷ��� ������ ���� ������ �÷��� �ۼ�
INSERT INTO ex3_1(col1, col2)
VALUES('judy', 9);

INSERT INTO ex3_1(col1, col2)
VALUES('jack', '20');
--���̺� �ִ� ��ü �÷��� ���ؼ� ������ ���� �Ƚᵵ ��
INSERT INTO ex3_1 VALUES ('�ؼ�',10,SYSDATE);

-- INSERT INTO ~ SELECT ��ȸ����� ����
INSERT INTO ex3_1 (col1, col2)
SELECT emp_name, employee_id
FROM employees;

INSERT INTO ex3_1 (col1, col2)
SELECT nm, team
FROM tb_info;

-- DML: UPDATE ������ ����
UPDATE ex3_1
SET col2 = 20           -- �����ϰ����ϴ� �÷��� ������
    ,col3 = SYSDATE     -- �����ؾ��ϴ� �÷��� �������� ,�� �߰�
WHERE col1 = 'judy';    -- �����Ǿ����� �࿡���� ����(������ ��� ���� ���� ��)

UPDATE tb_info
SET hobby = '�� ��Ű��'
WHERE nm = '������';

SELECT* FROM tb_info;
SELECT* FROM ex3_1;

-- DML: DELETE ������ ����
DELETE ex3_1;       -- ��ü ������ ����

DELETE ex3_1        
where col1= 'judy'; --Ư�� ������ ����

DELETE dep 
where deptno = 3;   -- dep�� emp���� �����ϰ� ������ 

DELETE emp
where empno =  200; -- emp�� ���� �����ϰ� �� �θ���  dep�� �����ؾ� ��

DELETE dep;

DROP TABLE dep CASCADE CONSTRAINTS; -- �������ǵ� ���� �� ���̺��� ����(�� �Ⱦ�)

-- �ǻ� �÷� 
-- ���̺��� ������ �ִ°�ó�� ���
SELECT ROWNUM AS rnum
    ,pc_no
    , nm
    , hobby
FROM tb_info
WHERE ROWNUM <=10;


--�ߺ� ����
SELECT DISTINCT cust_gender
FROM customers;
-- ǥ���� (���̺� Ư�� �������� ǥ���� �ٲٰ� ���� �� ���)
SELECT cust_name
        , CASE WHEN cust_gender= 'M' THEN '����'
               WHEN cust_gender= 'F' THEN '����'
           ELSE '?'
         END as gender
FROM customers;

-- salary 10000�̻� ��׿���, �������� ����
SELECT emp_name
    , salary
    , CASE WHEN salary >= 10000 THEN '��׿���'
        ELSE '����'
    END as salary
FROM employees;


-- NULL ���ǽİ� �����ǽ� (AND, OR, NOT)
SELECT *
FROM departments
WHERE parent_id IS NULL; 
// null���� where ���ǽ� �� �� =null �� �ƴ϶� IS NULL�� ��ȸ�ؾ���
// NULL ���� �ƴѰ� ��ȸ�Ϸ��� IS NOT NULL



--IN ���ǽ� (������ or �� �ʿ��� ��)
-- 30, 60, 80�� �μ� ��ȸ
SELECT emp_name, department_id
FROM employees
WHERE department_id IN (30,60,80);



--LIKE �˻� ���ڿ� ���� �˻�
-- ���ڿ� �˻����� ���� ���� ��� ��
SELECT *
FROM tb_info
WHERE nm LIKE '%��%'; -- %�� ������ �� ���� ���� �����°�
                      -- %�� �̸� �������� ���� ����
                      -- ��% �̸� ������ �����ϴ� 
                      
SELECT *
FROM tb_info
WHERE email LIKE '%94%';