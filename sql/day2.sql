/* ���� ������ Ÿ��(number)
    number(p,s) p�� �Ҽ����� �������� ��� ��ȿ���� �ڸ����� �ǹ���.
                s�� �Ҽ��� �ڸ����� �ǹ��� (����Ʈ 0)
                s�� 2�̸� �Ҽ��� 2�ڸ����� �ݿø�
                s�� ������ �Ҽ��� ���� ���� �ڸ�����ŭ �ݿø�
*/

CREATE TABLE ex2_1(
    num1 NUMBER(3)        -- ������ 3�ڸ�
    ,num2 NUMBER(3,2)     -- ���� 1�ڸ� �Ҽ��� 2�ڸ�
    ,num3 NUMBER(5,-2)    -- �����ڸ����� �ݿø� (�� 7�ڸ�)
    ,num NUMBER --38
    );
    
INSERT INTO ex2_1 (num1) VALUES(0.7898);
INSERT INTO ex2_1 (num1) VALUES(99.5);
INSERT INTO ex2_1 (num1) VALUES(1004); --����
SELECT * FROM ex2_1; --select �غ��� �ݿø� �ؼ� 3�ڸ������� ���� �� (�Ѿ�� ����)

INSERT INTO ex2_1(num2) VALUES(0.7898);
INSERT INTO ex2_1(num2) VALUES(1.2345);
INSERT INTO ex2_1(num2) VALUES(9.9945); 
INSERT INTO ex2_1(num2) VALUES(9.9995); -- ���� (�ݿø��ϸ� ���� ���ڸ��� �Ŵϱ�)
INSERT INTO ex2_1(num2) VALUES(32);     -- ����
INSERT INTO ex2_1(num3) VALUES(12345.2345);
INSERT INTO ex2_1(num3) VALUES(1234569.2345);
INSERT INTO ex2_1(num3) VALUES(12345699.2345); --���� 7�ڸ� ����

INSERT INTO ex2_1(num) VALUES(12345699.2345); --����Ʈ�� ���� ���� ��
SELECT * FROM ex2_1;



/* 
    ��¥ ������ Ÿ��(date ����Ͻú���, timestamp ����Ͻú��� �и���)
*/

CREATE TABLE ex2_2(
    date1 DATE
    ,date2 TIMESTAMP
);
-- sysdate ����ð�
INSERT INTO ex2_2(date1, date2) VALUES (SYSDATE, SYSTIMESTAMP);
-- date�� ��¹��� �����ϸ� �������� ���������� ���� �ú��� ���� ���� ������
SELECT * FROM ex2_2;


/*
    ��������
    NOT NULL:           NULL ��� ���� 
    UNIQUE:             �ߺ� ��� ����     
    CHECK:              Ư�� �����͸� �����(üũ �̿ܿ��� ��� ����)
    PRIMARY KEY(�⺻Ű):�ϳ��� ���̺� 1���� ���� ����
                        �ϳ��� ���� �����ϴ� �ĺ��� Ű���̶�� �ϸ� PK��� ��
                        PK�� UNIQUE �̸鼭 NOT NULL��
    FOREIGN KEY �ܷ�Ű: �ٸ� ���̺��� PK�� �����ϴ� Ű
    
*/

CREATE TABLE ex2_3(
    mem_id VARCHAR(100) NOT NULL UNIQUE
    ,mem_nm VARCHAR(100)
    ,mem_email VARCHAR(100)     NOT NULL
    ,CONSTRAINT uq_ex2_3 UNIQUE(mem_email) -- ���������� �̸��� �����ϰ� ���� ��
);

INSERT INTO ex2_3 (mem_id, mem_email)
VALUES ('a001', 'a001@gmail.com');

INSERT INTO ex2_3 (mem_id, mem_email)
VALUES ('a001', 'a002@gmail.com'); --id�� ����ũ���� �����߻�

SELECT*FROM ex2_3;
SELECT * FROM user_constraints; -- ���������� �̸��� �� �� ������

SELECT * FROM user_constraints 
WHERE constraint_name LIKE '%EX%';

-- check ��������

CREATE TABLE ex2_4(
    nm VARCHAR2(100)
    ,age NUMBER  CHECK(age BETWEEN 1 AND 150)
    ,gender VARCHAR2(1)
    ,CONSTRAINT ck_ex2_4_age CHECK (age BETWEEN 1 AND 150)
    ,CONSTRAINT ck_ex2_4_gender CHECK(gender IN ('F','M'))
);

INSERT INTO ex2_4 VALUES('�ؼ�', 100, 'F'); 
INSERT INTO ex2_4 VALUES('�浿', 151, 'F'); -- age üũ���� ����
INSERT INTO ex2_4 VALUES('����', 10, 'A');  -- gender üũ���� ����

SELECT * FROM ex2_4;

/*
    primary key �� �� ���̺� 1���� ������ �� ������
    �Ѱ��� pk�� (���� �÷��� �����) ����Ű�� ���� ���� 1~n
    
    foreign key�� �����ϴ� ���̺��� �÷��� pk�� ���ǵǾ� �־����.
*/

CREATE TABLE dep(
    deptno NUMBER(3) PRIMARY KEY
    ,depnm VARCHAR(20)
    ,dep_floor NUMBER(5)
    );

CREATE TABLE emp(
    empno NUMBER(5)
    ,empnm VARCHAR(20)
    ,title VARCHAR(20)
    ,dno NUMBER(3) CONSTRAINT emp_fk REFERENCES dep(deptno) 
    -- fk ����� ��
    -- dep ���̺��� deptno���̺��� �����ϰڴ�. 
    -- �̷��� �����Ϸ��� �����Ϸ��� ���̺��� �÷��� pk�����ϰ� 
    -- Ÿ���� ���ƾ� �ϰ�
    -- �������־�� ��
    );
   
    
 INSERT INTO dep VALUES(1, '����', 8);   
 INSERT INTO dep VALUES(2, '��ȹ', 10);
 INSERT INTO dep VALUES(3, '����', 9);
 INSERT INTO EMP VALUES(100, '��â��', '�븮', 2); --EMP���� �� ������ ���� �߻� 2��� ���� ����
 INSERT INTO EMP VALUES(200, '�ڿ���', '����', 3);
 INSERT INTO EMP VALUES(300, '�̼���', '����', 1);
 
 SELECT * FROM emp;
 SELECT * FROM dep; 
 
 SELECT emp.empnm
        ,dep.depnm
        ,dep.dep_floor --  dep<-- ���̺��.�÷���
 FROM emp,dep
 WHERE emp.dno = dep.deptno -- pk fk�� �̿��Ͽ� ���踦 �ξ� �����͸� ������
 AND empnm = '��â��';

-- table, column�� �ڸ�Ʈ �ۼ�(�ش� �÷��� �� �ǹ��ϴ���)
 COMMENT ON TABLE dep IS '�μ����̺�';
 COMMENT ON COLUMN dep.deptno IS '�μ���ȣ';
 COMMENT ON COLUMN dep.depnm IS '�μ���';
 
 SELECT *
 FROM all_tab_comments
 WHERE OWNER = 'JAVA';