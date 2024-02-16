/*
    �������� trim
    ����:ltrim ������:rtrim ��������
*/

SELECT LTRIM(' ABC ') as ex1
    ,  RTRIM(' ABC ') as ex2
    ,  TRIM(' ABC ' ) as ex3
FROM dual;

/* 
     LPAD, RPAD �� ������ ä��� ���̸�ŭ ä��� ǥ����
     ���̰� �Ѿ�� �������� ©�� ���ڿ��� ��ȯ����
     (���, ���� ,ǥ��)
*/
SELECT LPAD(123, 5, '0') as ex1
      ,LPAD(1, 5, '0') as ex2
      ,LPAD(11235, 5, '0') as ex3
      ,LPAD(112352, 5, '0') as ex4  -- ����� ������ 2��° �Ű����� ����
      ,RPAD(2,5,'*') as ex5
FROM dual;

/* REPLACE, TRANSLATE ��ȯ */
SELECT REPLACE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?' ,'����', '�ʸ�') as ex1
    ,  TRANSLATE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '����', '�ʸ�') as ex2
    -- TRABSTATE �� �ܾ �ѱ��ھ� ��Ī�ؼ� �ѱ��ھ� �ٲ��� (���� ���� �ʴ´�)
FROM dual;


/* LENGTH ���ڿ� ����, LENGTHB ���ڿ� ũ��(byte)*/
SELECT LENGTH('abc1') as ex1  
    ,  LENGTHB('abc1') as ex2  --����, Ư������, ����� 1byte
    ,  LENGTH('�ؼ�1') as ex3
    ,  LENGTHB('�ؼ�1') as ex4 -- utf-8���� �ѱ� 3byte
FROM dual;


SELECT * FROM MEMBER;

SELECT mem_name
    ,  mem_mileage
    , CASE WHEN  mem_mileage <= 2500 THEN 'silver'
           WHEN  2500<mem_mileage  and mem_mileage <=5000 THEN 'gold' 
           WHEN  5000 <mem_mileage THEN 'vip'
      END as rating
    ,  mem_job
FROM MEMBER
WHERE MEM_JOB IN ('�ֺ�', 'ȸ���', '�ڿ���')
ORDER BY mem_mileage DESC;

-- TABLE ����
CREATE TABLE ex5_1(
    nm VARCHAR(100) NOT NULL
    ,point NUMBER(5)
    ,gender CHAR(1)
);

-- �÷��� ����
ALTER TABLE ex5_1 RENAME COLUMN point To user_point;
-- Ÿ�Լ���(Ÿ�� ������ ���̺� �����Ͱ� �ִٸ� �����ؾ� ��)
ALTER TABLE ex5_1 MODIFY gender VARCHAR(1);
-- �������� �߰�
ALTER TABLE ex5_1 ADD CONSTRAINT pk_ex5 PRIMARY KEY (nm);
-- �÷��߰�
ALTER TABLE ex5_1 ADD crate_dt DATE;
-- �÷�����
ALTER TABLE ex5_1 DROP COLUMN gender;


-- tb_info�� mbti �÷� �߰�
ALTER TABLE tb_info ADD mbti VARCHAR(4);

/*
���� �Լ�(�Ű����� ������)
ABS : ���밪, ROUND: �ݿø�, CEIL: �ø�, TRUNC: ����, SQRT: ������
MOD(m, n): m�� n���� ������ �� ������ ��ȯ
*/
SELECT ABS(-10)            as ex1
    ,  ABS(10)             as ex2
    ,  ROUND(10.5555)      as ex3 -- defalut �� �������� �ݿø�
    ,  ROUND(10.5555, 1)   as ex4 -- �Ҽ��� �� °�ڸ����� �ݿø�(�Ҽ��� ���ڸ����� ǥ���ϰڴ�)
    ,  TRUNC(10.5555, 1)   as ex5
    ,  MOD(4, 2)           as ex6
    ,  MOD(5, 2)           as ex7
FROM dual;

/*��¥ �Լ�*/
SELECT SYSDATE 
    ,  SYSTIMESTAMP
FROM dual;
-- ADD_MONTHS(��¥, 1) ������
-- LAST DAY: ��������, NEXT_DAY(��¥, '����') ���� ���� �ش����
SELECT ADD_MONTHS(SYSDATE, 1)      as ex1
    ,  ADD_MONTHS(SYSDATE, -1)     as ex2
    ,  LAST_DAY(SYSDATE)           as ex3
    ,  NEXT_DAY(SYSDATE,'������')  as ex4
    ,  NEXT_DAY(SYSDATE,'�����')  as ex5 -- ������ ������̸� ������ ����Ϸ�
FROM dual;

SELECT SYSDATE -1 -- <-- 1day ���� ���� 
    ,  ADD_MONTHS(SYSDATE, 1) - ADD_MONTHS(SYSDATE, -1) -- ��¥������ ���� ����
FROM dual;

-- �̹����� ��ĥ ���Ҵ���
SELECT 'd-day:'||(LAST_DAY(SYSDATE)- SYSDATE)||'��' as DDAY
FROM dual;

--DECODE ǥ����--
SELECT        cust_name
            , cust_gender
            -- (���ǽ�, ����1 , true�϶� ��ȯ��, false�϶� ��ȯ��
            , DECODE(cust_gender, 'M', '����', '����') as gender
            -- (���ǽ�, ����1, true, ����2, true, else)
            , DECODE(cust_gender, 'M', '����', 'F', '����', '?') as gender
FROM customers;

SELECT mem_name
    ,  mem_regno2
    ,  DECODE(SUBSTR(mem_regno2, 1, 1), 1, '����','����') as gender
FROM MEMBER;



/*  Ÿ�� ��ȯ �Լ� 
    TO_CHAR: ���������� 
    TO_DATE: ��¥������
    TO_NUMBER: ����������
*/
SELECT TO_CHAR(123456,'999,999,999') as ex1
    ,  TO_CHAR(SYSDATE, 'YYYY-MM-DD') as ex2
    ,  TO_CHAR(SYSDATE, 'YYYYMMDD') as ex3
    ,  TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') as ex4
    ,  TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS') as ex5
    ,  TO_CHAR(SYSDATE, 'day') as ex6
    ,  TO_CHAR(SYSDATE, 'YYYY') as ex7
    ,  TO_CHAR(SYSDATE, 'YY') as ex8
    ,  TO_CHAR(SYSDATE, 'dd') as ex9
    ,  TO_CHAR(SYSDATE, 'd') as ex10 --������ �ǹ��� ��~������� 1~7�� ǥ��
FROM dual;

SELECT TO_DATE('231229', 'YYMMDD')  as ex1
    ,  TO_DATE('2023 12 29 09:10:00', 'YYYY MM DD HH24:MI:SS') as ex2
    ,  TO_DATE('25', 'YY') as ex3
    ,  TO_DATE('45', 'YY') as ex4
    -- RR�� ���⸦ �ڵ����� ����
    -- 50 -> 1950
    -- 49 -> 2049(Y2K 2000�� ����)�� ���� ����å���� ���Ե�.
    ,  TO_DATE('50', 'RR') as ex5
FROM dual;

CREATE TABLE ex5_2(
        title VARCHAR(100)
     ,  d_day DATE
);
INSERT INTO ex5_2 VALUES('������', '20240614');
INSERT INTO ex5_2 VALUES('������', '2024.06.14');
INSERT INTO ex5_2 VALUES('������', '2024/06/24');
INSERT INTO ex5_2 VALUES('������', TO_DATE('2024 06 07 09', 'YYYY MM DD HH24'));
SELECT * FROM ex5_2;


CREATE TABLE ex5_3(
     seq1 VARCHAR(100)
    ,seq2 NUMBER
);
INSERT INTO ex5_3 VALUES('1234','1234');
INSERT INTO ex5_3 VALUES('99','99');
INSERT INTO ex5_3 VALUES('123456','123456');

SELECT * 
FROM ex5_3 
ORDER BY TO_NUMBER(seq1) DESC;

SELECT mem_name
    ,  mem_bir
    ,  TO_NUMBER( TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(mem_bir,'YYYY') )||'��'  as ����
FROM member
ORDER BY ���� DESC;

SELECT DISTINCT
    cust_name
    ,cust_year_of_birth
    ,TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth)||'��' AS ����
    ,CASE 
        WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth) BETWEEN 31 AND 39 THEN '30��'
        WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth) BETWEEN 40 AND 49 THEN '40��'
        WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth) BETWEEN 50 AND 59 THEN '50��'
        ELSE '��Ÿ'
    END AS ���ɴ�
FROM customers
