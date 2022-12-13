-- INDEX : 테이블의 조회 속도를 높이기 위해서 일부 컬럼의 데이터만 빠르게 검색할 수 있도록 하는 자료구조
-- 인덱스 생성 : CREATE INDEX 인덱스이름 ON 테이블명 (컬럼명);

-- 인덱스 조회 : SHOW INDEX FROM 테이블명;
-- 인덱스 삭제 : ALTER TABLE 테이블명 DROP INDEX 인덱스명;

-- ALTER TABLE `employees`.`salaries` 
-- ADD INDEX `2` (`to_date` ASC, `from_date` ASC) VISIBLE;

-- salaries - 우클릭 Alter Table 누르고 Indexes확인해보면 PRIMARY에 emp_no, from_date가 체크되있음(INDEX가 걸려있다는 뜻)
SHOW INDEX FROM salaries;
SELECT * FROM employees.salaries;
SELECT * FROM salaries WHERE from_date > '1985-12-31';   -- 0.000초 걸림
SELECT * FROM salaries WHERE to_date > '1986-12-31';   -- 0.016초 걸림

SHOW INDEX FROM employees;

SELECT * FROM employees.employees;
SELECT first_name, last_name, gender, hire_date FROM employees WHERE first_name like '_____' OR last_name like '_____';

-- 트랜젝션 : 데이터베이스에 입력, 수정, 삭제 시 바로 데이터베이스에 적용하는 것이 아니라 특정 세이브 포인트를 설정해 두고 입력, 수정, 삭제를 진행 후 아무런 문제가 없을 경우 데이터베이스에 적용하고, 문제가 있을 경우 복구하는 기술
-- 트랜젝션 예외 : DDL명령어 (CREATE, DROP, ALTER, RENAME, TRUNCATE)는 트랜젝션의 ROLLBACK 대상이 아님
-- 사용법 : START TRANSACTION - 트랜젝션 사용 준비
-- COMMIT : 데이터베이스에 적용
-- ROLLBACK : 지정한 포인트의 상태로 데이터베이스 복구
-- SAVEPOINT 이름 : 지정한 포인트의 상태로 데이터베이스 복구
-- SET AUTOCOMMIT = 0/1 : 자동 COMMIT 사용 여부, 0 : OFF, 1 : ON
-- 우클릭 Alter Table 누르면 Engine이 InnoDB가 되어야 됨, 현재 mysql은 InnoDB 기본값, MyISAM은 옛날버전이라 트랜젝션이 안됨.

SELECT * FROM k404db.member;

INSERT INTO member (mem_name, mem_phone, mem_gender) VALUES ('유애나', '01012323230', 'F'); 
DELETE FROM member WHERE mem_name = '원빈';

START TRANSACTION; -- 트랜젝션 모드 실행

INSERT INTO member (mem_name, mem_phone) VALUES ('원빈', '01084368605'); 
SELECT * FROM member;
ROLLBACK; -- 실행 이전의 상태로 복구
-- 데이터베이스는 복구기능이 없음. 삭제하면 다시 되돌릴 수 없기 때문에 트랜젝션을 사용.

START TRANSACTION;
DELETE FROM member WHERE mem_gender = 'F';
SELECT * FROM member;
ROLLBACK;

START TRANSACTION;
INSERT INTO member (mem_name, mem_phone, mem_gender, mem_email, mem_addr) VALUES ('박영주', '01012323230', 'M', 'iy156@naver.com', '부산'); 
SELECT * FROM member;
COMMIT;



START TRANSACTION;
INSERT INTO member (mem_name, mem_phone, mem_gender, mem_email, mem_addr) VALUES ('오소리', '01012345670', 'F', 'orthory@naver.com', '서울'); 
SAVEPOINT AA;

INSERT INTO member (mem_name, mem_phone, mem_gender, mem_email, mem_addr) VALUES ('진석기', '01098931230', 'M', 'seoky@naver.com', '화성'); 
SAVEPOINT BB;

INSERT INTO member (mem_name, mem_phone, mem_gender, mem_email, mem_addr) VALUES ('진화기', '01092336230', 'F', 'hwaky@naver.com', '수원');
SAVEPOINT CC;

ROLLBACK TO CC;
ROLLBACK TO BB;
ROLLBACK TO AA;

COMMIT;
SELECT * FROM member;


START TRANSACTION;

CREATE TABLE test (idx int, p_mame varchar(45), p_code varchar(45), p_price varchar(45));
DROP TABLE test;

ROLLBACK; -- ROLLBACK이 안됨

-- 문제 1) member 테이블에 친구의 데이터를 2개 추가하고, 트랜젝션을 시작한 후 2개의 데이터를 다시 추가 후 세이브포인트(save1)를 설정, 처음 추가한 데이터를 수정 후 세이브포인트(save2) 설정, 추가한 모든 데이터 삭제 후 세이브포인트(save1)로 롤백 후 데이터를 확인하고 commit을 수행하세요.

SELECT * FROM member;

INSERT INTO member (mem_name, mem_phone, mem_gender, mem_email, mem_addr) VALUES ('진화기', '01092336230', 'F', 'hwaky@naver.com', '수원');
INSERT INTO member (mem_name, mem_phone, mem_gender, mem_email, mem_addr) VALUES ('구자철', '01092162310', 'F', 'jckoo@naver.com', '구미');

START TRANSACTION;
INSERT INTO member (mem_name, mem_phone, mem_gender, mem_email, mem_addr) VALUES ('손흥민', '01023231230', 'M', 'hmson@naver.com', '부산');
INSERT INTO member (mem_name, mem_phone, mem_gender, mem_email, mem_addr) VALUES ('이승우', '01092232610', 'M', 'swlee@naver.com', '부산');
SAVEPOINT save1;

-- UPDATE member SET (mem_name=, mem_phone, mem_gender, mem_email, mem_addr) = ('손흥민', '01023231230', 'M', 'hmson@naver.com', '부산') WHERE idx = 25;

UPDATE member SET mem_name='김국진', mem_phone='01067812350', mem_gender='M', mem_email='kjkim@naver.com', mem_addr='부산' WHERE idx = 27;
UPDATE member SET mem_name='김용만', mem_phone='01023345230', mem_gender='F', mem_email='ymkim@naver.com', mem_addr='서울' WHERE idx = 28;
SAVEPOINT save2;

DELETE FROM member WHERE idx > '24';

ROLLBACK TO save2;
ROLLBACK TO save1;
ROLLBACK;

COMMIT;

SET AUTOCOMMIT =0;

SELECT @@AUTOCOMMIT;
-- AUTOCOMMIT 상태 보는 명령어


SELECT * FROM k404db.user;
INSERT INTO user (name) VALUES ('진양철'), ('진도준');

INSERT INTO user (name) VALUES ('진영기'), ('진동기'), ('진화영'), ('진윤기');

DELETE FROM user WHERE id = 4;

UPDATE user SET name = '진도진' WHERE id = 9;
SELECT * FROM k404db.user;

-- 문제 2) 게시판용(board) 테이블과 댓글(reply) 테이블을 생성하고 게시판 글을 삭제 시 해당하는 게시글을 댓글과 함께 삭제하는 트리거를 작성하세요.
-- board : idx(int, pk, ai), title(varchar(45), not null), content(varchar(500)), user_id(varchar(45), not null), create_dt(datetime, not null), hit_cnt(int, default = 0,not null), deleted_yn(char(1), dafault = 'N', not null))
-- reply : idx(int, pk, ai), board_idx(int, not null), content(varchar(200), not null), nick(varchar(45), not null), create_dt(datetime, not null)



-- 트리거 : 데이터베이스의 테이블에 어떠한 신호가 전달되었을 때 미리 정해진 활동이 자동적으로 실행되는 것, INSERT, UPDATE, DELETE 와 같은 DML이 실행되었을 경우 지정한 데이터베이스 테이블의 수행 내용을 자동으로 실행, 로그를 남길 때, 글을 삭제 시 댓글도 같이 삭제하기 위해 사용

-- 해당 명령에 따라 BEFORE/AFTER로 나누어짐
-- BEFORE : 특정 명령어가 실행되기 이전에 먼저 실행
-- AFTER : 특정 명령어가 실행된 후 실행
-- NEW : 가상 변수, INSERT/UPDATE 에서 사용 가능, 신규 데이터, UPDATE 시 변경된 이후의 데이터
-- OLD : 가상 변수, UPDATE/DELETE 에서 사용 가능, 기존 데이터, UPDATE 시 변경되기 전의 데이터

-- 사용법 : 
-- DELMITTER //
-- CREATE TRIGGER 트리거이름 
-- 		BEFORE/AFTER INSERT/UPDATE/DELETE 
-- 		ON 테이블명 
-- 		FOR EACH ROW 
-- BEGIN 
-- 		트리거 동작 시 수행할 쿼리문 
-- END
-- // DELIMITER;

-- 프로시져 : 전용 함수를 생성해서 해당 함수를 실행 시 지정되어 있는 쿼리문을 동작시키는 명령어
-- 사용법 : DELIMITER //
-- CREATE PROCEDURE 프로시져명
-- BEGIN
-- 실행항 쿼리
-- END
-- // DELIMITER;

-- DELIMITER : 프로시저, 트리거에서 사용, 지정한 문자를 만나기 전까지 실행을 보류, 프로시저 및 트리거 생성 시 내부에 ; 기호가 있으면 프로시저 및 트리거가 완료되지 않기 때문에 종료 문잘르 변경
-- IN : 프로시저를 호출하기 위한 정보로 함수의 매개변수에 해당함
-- DECLARE : 프로시저 내부에서 변수를 선언할 때 사용
-- SET : 프로시저 내부에서 변수에 값을 설정할 때 사용

-- IF THEN END, IF ELSE THEN IF END : 프로시저 내부에서 if문 사용
-- 시용법 : 
-- IF socre >= 95 THEN
-- 		SET level = 'A+';
-- END IF;

-- IF socre >= 90 THEN
-- 		SET level = 'A
-- ELSE
-- IF socre >= 80 THEN
-- 		SET level = 'B';
-- END IF;

-- CALL 프로시저명(매개변수) : 프로시저 호출하기









