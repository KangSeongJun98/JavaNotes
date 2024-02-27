/* 
    ���� ǥ���� (Regular Expression)
    oracle 10g���� ��� ����   REGEXP_   <- �� �����ϴ� �Լ�
    .(dot) or []�� ���ڿ����� 1���ڸ� �ǹ���
    ^�� ���� $�� ���� �� ��
    [^] ��(���ȣ �ȿ� ^) not �ǹ�
    
    �ݺ�������
    *: 0�� �̻�,  +: 1�� �̻�, ?: 0~1��
    {n}: n��, {n,}n�� �̻� {n,m} n�� �̻� m�� ����
    
    REGEXP_LIKE: ���Խ� ���� �˻�
*/
SELECT *
FROM member
WHERE REGEXP_LIKE(mem_comtel, '^..-'); -- �����ؼ� �α��� �ڿ� -(������) ������ ���� 

SELECT *
FROM member
WHERE REGEXP_LIKE(MEM_MAIL, '^[a-zA-Z]{3,5}@');

--�ѱ� ���� ���� ���� ����
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '[��-�R] [0-9]');

-- �ѱ۷� ������ ����
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '[��-�R]$');

--�ѱ۸� ���Ե� ����
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '^[��-�R]+$');

--�ѱ��� �ƿ� ���� ����
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '^[^��-�R]+$');

-- |:�Ǵ�, (): ���ϱ׷�
-- j�� �����ϸ� ,�� ��° ���ڰ� m or n ������ �̸� ��ȸ
SELECT emp_name
FROM employees
WHERE REGEXP_LIKE (emp_name,'^(J|j).(n|m)');


-- REGEXP_SUBSTR ���Խ� ���ϰ� ��ġ�ϴ� ���ڿ� ��ȯ
-- �̸��� @�� �������� �հ� �ڸ� ���
SELECT mem_mail
      ,REGEXP_SUBSTR(mem_mail, '[^@]+' ,1 ,1) as ���̵�
      ,REGEXP_SUBSTR(mem_mail, '[^@]+' ,1 ,2) as ������
FROM member;

SELECT REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 1) as ex1
      ,REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 2) as ex2
      ,REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 3) as ex3
FROM dual;


SELECT   mem_add1
        ,REGEXP_SUBSTR(mem_add1, '[^ ]+',1, 1) -- �Ű����� 3,4���� default�� 1,1 ��
FROM member;

--REGEXP_REPLACE ��� ���ڿ����� ���� ǥ������ �����Ͽ� �ٸ� �������� ��ü
--Ellen Hildi smith - > Smith, Ellen Hildi
SELECT REGEXP_REPLACE('Ellen Hildi Smith', '(.*) (.*) (.*)','\3, \1 \2')
FROM dual;

-- ���� 2�ڸ� �̻��� ã�Ƽ� 1�ڸ��� ��ü
SELECT REGEXP_REPLACE('Joe               Smith   Hi', '( ){2,}',' ' )
FROM dual;

-- ������ �ּҵ��� ��� '����'���� ����Ͻÿ�
SELECT   mem_add1
        ,REGEXP_REPLACE(mem_add1,'(^������|^����������) (.*)', '���� \2' )
FROM member
WHERE mem_add1 LIKE '%����%'
AND mem_id != 'p001';

--��ȭ��ȣ ���ڸ����� ������ ��ȣ�� �ݺ��Ǵ� ����� ��ȸ
--�� ǥ��� \w = [a-zA-Z0-9] , \d = [0-9]
SELECT emp_name, phone_number
FROM employees
WHERE REGEXP_LIKE(phone_number, '(\d\d)\1$'); --\1�� ù��° ĸó �׷��� �ٽ� ����
                                              --�� ������ ��Ī�� ���ڸ� ���ڿ�
                                              --��Ȯ�� ��ġ�ϴ� ���ڸ� ���ڸ� �ǹ���
                                              
                                              
                                              