/* 
    ��(view) 338p
    :�ϳ� �̻��� ���̺��� ������ ��ġ ���̺��� ��ó�� ����ϴ� ��ü
     ���� �����ʹ� �並 �����ϴ� ���̺� ��������� ���̺�ó�� ��밡��
     
     ������: 1. ���� ����ϴ� sql���� �Ź� �ۼ��� �ʿ� ���� ��� ��� ����
               2. ������ ���� ����(��õ ���̺��� ���� �� ����)
    
     �� Ư¡: (1) �ܼ� ��(���̺� 1���� ����)
              - �׷� �Լ� ��� �Ұ�
              - distinct ��� �Ұ�
              - insert/update/delete ��� ����
              
              (2) ���� ��(������ ���̺�)
              - �׷� �Լ� ��� ����
              - distinct ��� ����
              - insert/update/delete ��� �Ұ���
*/

CREATE OR REPLACE VIEW emp_dep AS --�� ����
SELECT a.employee_id 
      ,a.emp_name
      ,b.department_id
      ,b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id;
-- SYSTEM�������� JAVA������ view�� ���� �� �ִ� ���� �ο�
GRANT CREATE VIEW to java;

SELECT * FROM emp_dep;

-- java�������� emp_dep�� ��ȸ�� �� �ִ� ������ study�������� �ο�
GRANT SELECT ON emp_dep TO study;

--study �������� ��ȸ
SELECT * FROM java.emp_dep;  -- �ٸ� �������� ��ȸ�� ��� ������.���̺��[view��]


/* 
    ���Ǿ�(Syonim) ��ü 354p
    �ó���� ���Ǿ�� ������ ��ü ������ ������ �̸��� ���Ǿ ����� ��
    public synonim : ��� ����� ����
    private synonim : Ư�� ����ڸ� ����
    public �ó���� ���� �� ������ DBA ������ �ִ� ����ڸ� ����
    ������: 1. �������� ������(id)�� ���� �߿��� ������ ��������� ��Ī�� ����
              2. ���� ���Ǽ� ���� ���̺��� ������ ����Ǿ ��Ī���� ����� �ߴٸ� 
                 Java �ڵ带 ���� ���ص� ��
*/
-- �ó�� ���� ���� �ο�
GRANT CREATE SYNONYM TO java;
--java�������� ���Ǿ� ����
CREATE OR REPLACE SYNONYM mem FOR member; --default private �ó��
--java �������� study �������� mem�� ��ȸ�� �� �ִ� ���� �ο�
GRANT SELECT ON mem TO study;
--study �������� ��ȸ
SELECT * FROM java.mem;


--public synonym�� (DBA������ �ִ�) system ���������� ���� ����
CREATE OR REPLACE PUBLIC SYNONYM mem2 FOR java.member;
SELECT * FROM mem2;

-- �ó�� ����
DROP PUBLIC SYNONYM mem2;

/* ������ Sequence 348p: ��Ģ�� ���� �ڵ� ������ ��ȯ�ϴ� ��ü
   ����: pk�� ����� �÷��� ���� ���
         ex) �Խ����� �Խñ� ��ȣ
   ��������.CURRVAL ���� ������ �� (���ʿ��� �ȵ�)
   ��������.NEXTVAL ���� ������ �� (ó������ �������� ���� ��� nextval�� �� �� ����)
*/
CREATE SEQUENCE my_seq1
INCREMENT BY 1   -- ���� ����
START WITH   1   -- ���� ����
MINVALUE     1   -- �ּҰ�
MAXVALUE     999999999  -- �ִ밪
NOCYCLE      -- �ִ볪 �ּҿ� �����ϸ� �������� (����Ʈ:nocycle)
NOCACHE;     -- �޸𸮿� ������ ���� �̸� �Ҵ� �� �� �� ��(����Ʈ nocache)


-- ������ ����
DROP SEQUENCE my_seq1; --������ ������ ���������� ������ ���� ���ؼ��� ������ �ȵ�
                       --(INCREMENT BY �̷��͸� ���� �� �� ����)
                       --�����ϰ� �ٽ� ����°� ����

-- �ٸ� ���̺��� �� �� insert ������ my_seq1.NEXTVAL �� �κ��� ������ ��
SELECT my_seq1.NEXTVAL -- ��ȸ�� ������ ������
FROM dual;

SELECT my_seq1.CURRVAL
FROM dual;

CREATE TABLE tb_click(
    seq NUMBER PRIMARY KEY
   ,dt DATE DEFAULT SYSDATE);

INSERT INTO tb_click (seq ) values (my_seq1.NEXTVAL);
SELECT * FROM tb_click; -- ���� ���� ������ �˾Ƽ� 1�� ������

INSERT INTO tb_click (seq ) values ((SELECT MAX(NVL(SEQ,0)) +1
                                    FROM tb_click));
                                    
                                    
SELECT MAX(NVL(SEQ,0)) +1
FROM tb_click;

--�ּ� 1, �ִ� 99999999, 1000���� �����ؼ� 2�� �����ϴ� 
-- info_seq ������

CREATE SEQUENCE info_seq
INCREMENT BY 2
START WITH 1000
MINVALUE 1
MAXVALUE 99999999;

SELECT info_seq.NEXTVAL 
FROM dual;