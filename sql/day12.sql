/* 
    뷰(view) 338p
    :하나 이상의 테이블을 연결해 마치 테이블인 것처럼 사용하는 객체
     실제 데이터는 뷰를 구성하는 테이블에 담겨있지만 테이블처럼 사용가능
     
     사용목적: 1. 자주 사용하는 sql문을 매번 작성할 필요 없이 뷰로 사용 가능
               2. 데이터 보안 측면(원천 테이블을 감출 수 있음)
    
     뷰 특징: (1) 단순 뷰(테이블 1개로 생성)
              - 그룹 함수 사용 불가
              - distinct 사용 불가
              - insert/update/delete 사용 가능
              
              (2) 복합 뷰(여러개 테이블)
              - 그룹 함수 사용 가능
              - distinct 사용 가능
              - insert/update/delete 사용 불가능
*/

CREATE OR REPLACE VIEW emp_dep AS --뷰 생성
SELECT a.employee_id 
      ,a.emp_name
      ,b.department_id
      ,b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id;
-- SYSTEM계정에서 JAVA계정에 view를 만들 수 있는 권한 부여
GRANT CREATE VIEW to java;

SELECT * FROM emp_dep;

-- java계정에서 emp_dep를 조회할 수 있는 권한을 study계정에게 부여
GRANT SELECT ON emp_dep TO study;

--study 계정에서 조회
SELECT * FROM java.emp_dep;  -- 다른 계정에서 조회할 경우 계정명.테이블명[view명]


/* 
    동의어(Syonim) 객체 354p
    시노님은 동의어란 뜻으로 객체 각자의 고유한 이름에 동의어를 만드는 것
    public synonim : 모든 사용자 접근
    private synonim : 특정 사용자만 접근
    public 시노님의 생성 및 삭제는 DBA 권한이 있는 사용자만 가능
    사용목적: 1. 보안측면 계정명(id)와 같은 중요한 정보를 숨기기위해 별칭을 만듦
              2. 개발 편의성 실제 테이블의 정보가 변경되어도 별칭으로 사용을 했다면 
                 Java 코드를 수정 안해도 됨
*/
-- 시노님 생성 권한 부여
GRANT CREATE SYNONYM TO java;
--java계정에서 동의어 생성
CREATE OR REPLACE SYNONYM mem FOR member; --default private 시노님
--java 계정에서 study 계정에게 mem을 조회할 수 있는 권한 부여
GRANT SELECT ON mem TO study;
--study 계정에서 조회
SELECT * FROM java.mem;


--public synonym은 (DBA권한이 있는) system 계정에서만 생성 가능
CREATE OR REPLACE PUBLIC SYNONYM mem2 FOR java.member;
SELECT * FROM mem2;

-- 시노님 삭제
DROP PUBLIC SYNONYM mem2;

/* 시퀀스 Sequence 348p: 규칙에 따라 자동 순번을 반환하는 객체
   목적: pk로 사용할 컬럼이 없는 경우
         ex) 게시판의 게시글 번호
   시퀀스명.CURRVAL 현재 시퀀스 값 (최초에는 안됨)
   시퀀스명.NEXTVAL 다음 시퀀스 값 (처음으로 시퀀스를 만들 고는 nextval로 쓸 수 있음)
*/
CREATE SEQUENCE my_seq1
INCREMENT BY 1   -- 증감 숫자
START WITH   1   -- 시작 숫자
MINVALUE     1   -- 최소값
MAXVALUE     999999999  -- 최대값
NOCYCLE      -- 최대나 최소에 도달하면 생성중지 (디폴트:nocycle)
NOCACHE;     -- 메모리에 시퀀스 값을 미리 할당 할 지 말 지(디폴트 nocache)


-- 시퀀스 삭제
DROP SEQUENCE my_seq1; --시퀀스 수정이 가능하지만 증가된 값에 대해서는 수정이 안됨
                       --(INCREMENT BY 이런것만 수정 할 수 있음)
                       --삭제하고 다시 만드는게 편함

-- 다른 테이블에서 쓸 때 insert 구문에 my_seq1.NEXTVAL 이 부분을 넣으면 됨
SELECT my_seq1.NEXTVAL -- 조회할 때마다 증가됨
FROM dual;

SELECT my_seq1.CURRVAL
FROM dual;

CREATE TABLE tb_click(
    seq NUMBER PRIMARY KEY
   ,dt DATE DEFAULT SYSDATE);

INSERT INTO tb_click (seq ) values (my_seq1.NEXTVAL);
SELECT * FROM tb_click; -- 행을 넣을 때마다 알아서 1씩 증감됨

INSERT INTO tb_click (seq ) values ((SELECT MAX(NVL(SEQ,0)) +1
                                    FROM tb_click));
                                    
                                    
SELECT MAX(NVL(SEQ,0)) +1
FROM tb_click;

--최소 1, 최대 99999999, 1000부터 시작해서 2씩 증가하는 
-- info_seq 시퀀스

CREATE SEQUENCE info_seq
INCREMENT BY 2
START WITH 1000
MINVALUE 1
MAXVALUE 99999999;

SELECT info_seq.NEXTVAL 
FROM dual;