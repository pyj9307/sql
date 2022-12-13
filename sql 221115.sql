show grants for 'test1'@'localhost';
select*from employees.employees;


-- DB란 데이터를 저장을 하는 곳

-- 프론트엔드(HTML(뼈대)/CSS(디자인)/JS(이벤트)/REACT)/백엔드(JAVA/JSP(유지보수)/SPRING(최신기술,앱개발 등을 위해))/ANSI SQL

-- DB 큰 회사 프로그램 
-- ORACLE(리눅스가능)/MS SQL(기본적으로 WINDOW에서만 돌아감+MS서버 또 사야됨)/MY SQL(현재 오라클에 인수됨, 살짝 상업됨)/MARIA DB(MY SQL이랑 같음, 완전무료)
-- ANSI SQL 가능, 자체 SQL 있지만 쓰면 호환성이 부족
-- 서버는 365일 돌아야 함.

-- MYSQL 명령어
-- mysql 들어가기
-- cd 주소입력(C:\Program Files\MySQL\MySQL Server 8.0\bin)
-- MYSQL 접속 
-- mysql -u 계정명(root 관리자계정) -p (기본 로그인)
-- mysql -u 계정명 -h 서버주소 -p (다른 서버로 접속)
-- mysql -u 계정명 -h 서버주소 -p 포트번호 -p (다른 서버의 다른 포트로 접속)

-- 포트란? 인터넷 회선의 개념.

-- database 목록 확인
-- show database;

-- data table 목록 확인
-- show table;

-- 지정한 database 사용
-- use 데이터베이스명;

-- localhost 컴퓨터 자신을 뜻하는 DNS 주소(IP주소로 127.0.0.1)

-- % : mysql의 계정정보에서 host 부분에 %로 표시되어 있으면 모든 곳에서 접속이 가능

-- 사용자 생성
-- create user '계정명';
-- create user '계정명'@'접속주소'; (접속할 수 있는 ip주소를 제한하고 싶다면)
-- create user '계정명'@'접속주소' identified by '비밀번호'; (비번 만들려면 추가해야함)

-- 사용자 삭제
-- drop user '계정명';
-- drop user '계정명'@'접속주소';

-- sql 명령어들은 길어서 엔터치고 계속쳐도 가능. 마지막에 ; 세미콜론 붙여야 끝남.

-- 중간에 명령문 입력을 취소할 때 ctrl+c 누르면 끊김. 다시 입력 ㄱㄱ

-- 데이터베이스 추가
-- create database 데이터베이스명;
-- create database '데이터베이스명';
-- create database 데이터베이스명 default character set utf8;
-- create database '데이터베이스명' default character set utf8;

-- 문자셋이란?
-- 컴퓨터에서 문자를 표시하기 위한 코드표, 현재는 유니코드인 utf8 방식이 표준으로 사용되고 있으나
-- 예전 버전에는 문자셋이 기본이었기 때문에 utf8로 설정이 필요했음

-- 유니코드 방식 
-- UTF-8 한글자에 3 byte(가변형)
-- UTF-16 한글자에 4 byte(고정)
-- UTF-32 한글자에 5 byte(고정)

-- 데이터베이스 삭제
-- drop database 데이터베이스명;
-- 데이터베이스 사용 권한 확인

-- show grants for '계정명'@'접속주소';

-- 데이터베이스 사용 권한 설정
-- grant all privileges on 데이터베이스명.테이블명 to '계정명'@'접속주소';
-- grant all privileges on 데이터베이스명.*(전체테이블) to '계정명'@'접속주소';

-- 데이터베이스 사용 권한 삭제
-- revoke all on 데이터베이스명.테이블명 from '계정명'@'접속주소';

-- 명령어 즉시 적용
-- flush privileges;

-- 비밀번호 변경
-- alter user '계정명'@'접속주소' identified with mysql_native_password by '비밀번호';

-- sql 명령어
-- ddl : 데이터 정의어, 데이터베이스 관리자가 사용, 데이터 베이스를 설계 및 생성하는 언어, (creare/drop/alter)
-- dml : 데이터 조작어, 일반 사용자/프로그램 개발자가 사용, 데이터베이스에 실제데이터를 추가, 삭제, 수정, 조회하기 위해 사용하는 언어, (select/insert/update/delete)
-- dcl : 데이터 관리어, 데이터 베이스 관리자가 사용, 데이터 베이스 사용 권한 및 소용자 권란 제어하기 위해 사용하는 언어, (grant/revoke 등)

-- select : 데이터를 조회하기 위한 명령어, where 구문을 함께 사용하여 조회 시 필요한 조건을 추가하여 데이터를 조회함
-- 사용법1 : select 컬럼명1, 컬럼명2, ... from 테이블명;
-- 사용법2 : select 컬럼명1, 컬럼명2, ... from 테이블명 where 조건;
select *(컬럼명) from employees(테이블명);
select emp_no, first_name, last_name, gender from employees;

select * from salaries;
select * from titles;

-- distinct : select 구문의 컬럼명과 함께 사용하는 명령어로 중복되는 데이터를 제거
select distinct title from titles;

-- where : 데이터 베이스에서 데이터를 조회할 때 조건을 추가하는 명령어, 조건에 만족하는 데이터만 출력함, select/update/delete 에서 사용됨
-- 사용법 : select 컬럼명1, 컬럼명2, === from 테이블명 where 검색조건;
-- update 테이블멸 set 컬럼명1, 컬럼명2, ... where 검색조건;
-- delete from 테이블명 where 검색조건;
select * from employees where first_name = 'mario';
select * from employees where gender = 'f';

-- and/or : where 구문을 사용하여 검색한 조건에 추가 조건을 사용하고자 할 경우 사용, and는 조건이 추가될 때마다 검색 정확도가 올라감, or는 조건이 추가될 때마다 검색되는 데이터의 양이 늘어남, where 구문의 추가하여 사용함
-- select 컬럼명1, 컬럼명2, ... from 테이블명 where 조건1 and 조건2 and 조건3 ...;
-- select 컬럼명1, 컬럼명2, ... from 테이블명 where 조건1 or 조건2 or 조건3 ...;
select*from employees where gender = 'm';
select*from employees where gender = 'm' and emp_no < 20000;
select*from employees where gender = 'm' and emp_no < 20000 and first_name = 'mario';

select*from employees where gender = 'm';
select*from employees where gender = 'm' or emp_no < 20000;
select*from employees where gender = 'm' or emp_no < 20000 or first_name = 'mario';

-- not : 검색 조건에 부합하지 않는 데이터를 출력
-- 사용법 : select 컬럼명1, 컬럼명2, ... from 테이블명 where not gender = 'm';
select * from employees where gender = 'm';
select * from employees where not gender = 'm';

-- order by : 지정한 컬럼을 기준으로 데이터를 정렬하여 출력, asc(오름차순), desc(내림차순), where 구문 마지막에 입력, 정렬할 컬럼은 여러개를 지정할 수 있음, 왼쪽부터 순차적으로 적용, 3개 이상 사용 시 원하는 형태로 정렬되지 않을 수 있음
-- 사용법 : select 컬럼명1, 컬럼명2, ... from 테이블명 where 검색조건 order by 컬럼명 asc/desc(정렬방식)

select * from employees;
select * from employees order by first_name asc;
select * from employees order by first_name desc;
select * from employees order by first_name desc, last_name asc;
select * from employees order by first_name desc, last_name asc, hire_date desc;

-- PK 기본 키, NN과 UQ가 자도으로 적용 됨, table 내에서 데이터를 구분하는 유일한 값(중복을 허용하지 않음)
-- NN(Not Null) 데이터가 없으면 오류가 남(빈 데이터를 지원하지 않음)
-- AI(Auto Increase) 자동 값 증가, INT(숫자 데이터)데이터 타입만 증가 됨, 문자는 안됨
-- UQ(Unique) 유일한 값, 중복을 허용하지 않지만 빈 칸은 가능

-- insert 데이터베이스에 데이터를 추가하는 명령어, 데이터 입력 시 컬럼의 순서는 상관없음(사용자가 입력한 컬럼 순서에 맞는 데이터만 입력하면 됨), ai/default로 설정된 데이터는 입력 시 컬럼을 생략해도 됨, not null로 설정된 부분만 정확하게 데이터를 입력하면 됨, unique로 설정된 키는 중복되는 데이터를 입력하면 안됨
-- 사용법1 : insert into 테이블몀 (컬럼명1, 컬럼명2, ...) values (데이터1, 데이터2, ...);
-- 사용법2 : insert into 테이블몀 (컬럼명1, 컬럼명2, ...) values (데이터1-1, 데이터1-2, ...), (데이터2-1, 데이터2-2, ...), ...;
insert into member (idx, mem_name, mem_phone, mem_email, mem_addr, mem_gender) values (1, '아이유', '01012345678', 'iu@bitc.co.kr', '부산광역시 부산진구 중앙대로', 'M');
insert into member (idx, mem_name, mem_phone, mem_email, mem_addr, mem_gender) values (2, '유인나', '01098765432', 'inna@bitc@co.kr', '부산진구 중앙대로', ''),
(3, '유재석', '01045672158', 'yjs@bitc@co.kr', '부산진구 전포대로', 'M'),
(4, '유아인', '01023647854', 'you@bitc@co.kr', '부산', 'M');
insert into member (mem_phone, mem_addr, mem_name, idx) values ('01078451236', '서울', '유병재', '5');

-- update 데이터베이스에 저장되어 있는 데이터를 수정하는 명령어

-- delete 데이터베이스에 저장되어 있는 데이터를 삭제하는 명령어