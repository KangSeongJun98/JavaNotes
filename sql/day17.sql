/*
    PL/SQL 절차적 언어와 집합적 언어의 특징을 모두 가지고 있음.
    특정 기능을 처리하는 함수, 프로시져, 트리거 등을 만들 수 있음
    DB내부에 만들어져 일반 프로그래밍 언어보다 빠름
*/
--기본 단위는 블록이라고 하며 블록은 이름부, 선언부, 실행부(예외처리부)로 구성 됨 

SET SERVEROUTPUT ON;
--PL/SQL 실행 결과를 스크립트에 출력
--이거 아니면 보기-> DBMS출력에서 +버튼 눌러서 접속까지 해줘야함

DECLARE--                      <-- 익명블록
 vi_num NUMBER;                -- 변수 선언
BEGIN
 vi_num:=100;                  -- 값 할당
 DBMS_OUTPUT.PUT_LINE(vi_num); -- 프린트
 END;
 -- PL/sql 실행은 전체 블록을 잡은 뒤 실행해야 함.
 
 --실행부에는 DML문이 들어갈 수 있음
 DECLARE
    vs_emp_name VARCHAR2(80); -- number는 사이즈 안써도 됨
    vs_dep_name departments.department_name%TYPE; -- 테이블 컬럼의 타입을 가져와서 타입으로 지정
BEGIN
    SELECT a.emp_name, b.department_name       -- 셀렉트 절에서 가져온걸 
        INTO vs_emp_name, vs_dep_name          -- 변수에 저장
    FROM employees a, departments b
    WHERE a.department_id = b.department_id
    AND a.employee_id = 100;                   -- 하나의 변수에는 1개의 행 값만 할당 가능
    DBMS_OUTPUT.PUT_LINE(vs_emp_name || ':' || vs_dep_name);
END;

-- 선언이 필요 없다면 실행부만 실행 가능
BEGIN 
 DBMS_OUTPUT.PUT_LINE('3*3='|| 3*3);
END;


-- IF 문
DECLARE
    vn_num1 NUMBER := 5;
    vn_num2 NUMBER := :num; -- 바인드
BEGIN
    IF vn_num1 > vn_num2 THEN
        DBMS_OUTPUT.PUT_LINE('vn_num1 더 큼');
    ELSIF vn_num1 = vn_num2 THEN
        DBMS_OUTPUT.PUT_LINE('같음');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('vn_num2 더 큼');
    END IF; --end로 꼭 닫아줘야 함
END;
-- pl/sql에서 else는 생략이 안되는데 null 값 주면 됨



DECLARE
    vn_this_year VARCHAR2(4) := TO_CHAR(SYSDATE, 'YYYY');
    vn_max_hak_no NUMBER;
    vn_make_hak_no NUMBER;
BEGIN
-- 가장 큰 값 조회
-- 비교 및 번호 생성
   SELECT MAX(학번) 
   INTO vn_max_hak_no
   FROM 학생;
   DBMS_OUTPUT.PUT_LINE(vn_max_hak_no);
   
     IF vn_this_year = SUBSTR(vn_max_hak_no,1,4) THEN
        vn_make_hak_no := (vn_max_hak_no+1);
        DBMS_OUTPUT.PUT_LINE('년도 동일');
     ELSE
        vn_make_hak_no := vn_this_year ||'000001';
     END IF;
     
     DBMS_OUTPUT.PUT_LINE('생성번호:'||vn_make_hak_no);
     INSERT INTO 학생(학번, 이름, 전공) VALUES (vn_make_hak_no, :nm, :sub);
     COMMIT;
END;

select * from 학생;