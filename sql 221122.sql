-- sql 명령어
-- ddl : 데이터 정의어, 데이터베이스 관리자가 사용, 데이터 베이스를 설계 및 생성하는 언어, (creare/drop/alter)
-- dml : 데이터 조작어, 일반 사용자/프로그램 개발자가 사용, 데이터베이스에 실제데이터를 추가, 삭제, 수정, 조회하기 위해 사용하는 언어, (select/insert/update/delete)
-- dcl : 데이터 관리어, 데이터 베이스 관리자가 사용, 데이터 베이스 사용 권한 및 소용자 권란 제어하기 위해 사용하는 언어, (grant/revoke 등)

-- select : 데이터를 조회하기 위한 명령어, where 구문을 함께 사용하여 조회 시 필요한 조건을 추가하여 데이터를 조회함
-- 사용법1 : select 컬럼명1, 컬럼명2, ... from 테이블명;
-- 사용법2 : select 컬럼명1, 컬럼명2, ... from 테이블명 where 조건;
select * from employees;
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
insert into member (mem_name, mem_phone, mem_email, mem_addr, mem_gender)
values ('리사', '01023497650', 'risa@bitc.co.kr', '서울 어딘가', '여자');

-- update 데이터베이스에 저장되어 있는 데이터를 수정하는 명령어
-- 주의사항 : 조건식 부분을 생략하게 되면 해당 테이블의 모든 데이터를 수정
-- 사용법 : update 테이블명 set 컬럼명1 = 데이터1, 컬럼명2 = 데이터2,... where 조건식
update member set mem_email = 'ybj@bitc.co.kr', mem_phone = '0109873563' where idx = 5;
-- idx가 5인 조건의 데이터의 mem_email을 ybj@bitc.co.kr 로 mem_phone을 0109873563 로 변경.
update member set mem_addr = '부산 어딘가..';

-- delete 데이터베이스에 저장되어 있는 데이터를 삭제하는 명령어
-- 주의사항 : 조건식으리 생략할 경우 해당 테이블의 모든 데이터를 삭제
-- 사용법 : delete from 테이블명 where 조건식;
delete from member where idx = 2;
delete from member;
SELECT * FROM k404db.member;
-- null : 데이터 베이스에서 null은 완전희 비어있는 값, 빈 문지열과는 다른 것

insert into member (mem_name, mem_phone, mem_email, mem_addr, mem_gender) values ('아이유', '01034567890', 'iu@bitc.co.kr', '서울 어딘가에..', 'F'), ('유인나', '01098745621', '', '', 'F');
insert into member (mem_name, mem_phone) values ('유재석', '01038292770');

-- limit : mysql에서 출력하는 데이터를 제한하는 명령어, where 절에서 사용
-- 사용방법 : where 조건식 limit 툴력수
-- where limit 출력번호, 출력수
select * from employees;
select * from employees limit 10;
select * from employees limit 10, 10;
select * from employees where first_name = 'mario';
select * from employees where first_name = 'mario' limit 20;
select * from employees where first_name = 'mario' limit 20, 20;

-- mim()/MAX() : 지정한 컬럼의 최소값/최대값을 출력하는 함수, select 절에서 사용
-- 사용법 : select min(컬럼명) from 테이블명
select min(emp_no) from employees;
select max(emp_no) from employees;

select min(birth_date), max(hire_date) from employees;
select min(hire_date), max(birth_date) from employees;

-- count() : 지정된 기준과 일치하는 데이터 수를 출력, select 절에서 사용
-- 사용법 : select count(컬럼명) from 테이블명
select * from salaries;
select * from employees;

select emp_no, first_name, last_name, gender from employees
where birth_date < '1953-09-02';
select count(emp_no) as 'total' from employees where birth_date < '1953-09-02'
and first_name = 'marko' and gender = 'F';

-- avg() : 지정된 컬럼(숫자일 경우에만)의 평균값을 출력
-- 사용법 : select avg(컬럼명) from 테이블명
select * from salaries;
select * from salaries where emp_no = 10009;
select avg(salary) from salaries where emp_no = 10009;
-- sum() : 지정된 컬럼(숫자일 경우에만)의 촐합을 출력, select 절에서 사용
-- 사용법 : select sum(컬럼명) from 테이블명
select sum(salary) as 'total' from salaries where emp_no = 10009;

-- like : 검색 패턴을 생성하는 명령어, 와일드카드 문자와 함께 사용하여 패턴 생성, where 절에서 사용
-- 사용법 : where 컬럼명 = like '검색패턴'
-- wild card :  문자열에서 하나 이상의 문자를 대체하는 문자, _, %가 존재
-- % : 0개 이상의 임의의 문자로 대체됨
-- _ : 1개의 임의의 문자로 대체됨, 문자의 수가 고정되어 있을 경우 사용
select * from employees where first_name = 'Elvis';
-- 검색어의 시작부분만 가지고 검색
select * from employees where first_name like 'El%';
-- 검색어의 끝부분만 가지고 검색
select * from employees where first_name like '%is';
-- 검색어의 중간 부분만 가지고 검색
select * from employees where first_name like '%rio%';
-- 검색어의 양끝 부분만 가지고 검색
select * from employees where first_name like 'm%o';

-- 검색어의 문자수가 5자인 것을 검색
select * from employees where first_name like '_____';
-- 검색어 중 시작글자가 m이고, 글자 수는 5자인 사람 검색
select * from employees where first_name like 'm____';
-- 검색어 중 끝글자가 i이고, 글자수는 5자인 사람 검색
select * from employees where first_name like '____i';
-- 검색어 중 시작글자가 l이고 끝 글자가 e이며 글자수가 5자인 사람 검색
select * from employees where first_name like 'l___e';

-- 검색어 글자수가 최소 5자 이상은 사람 검색
select * from employees where first_name like '%_____%';

-- 문제 1) 사원 테이블(employees)에서 이름(first_name)중 시작글자가 ma로 시작하는 사람 중 여성인 사람을 모두 검색하세요
select * from employees where first_name like 'ma%' and gender = 'F';
select * from employees where gender = 'F' and first_name like 'ma%';
-- 문제 2) 사원 테이블에서 성(last_name) 중 끝 글자가 do로 끝나고 글자수가 6자인 사람 중 남성을 모두 검색하세요
select * from employees where last_name like '____do' and gender = 'M';
select * from employees where gender = 'M' and last_name like '____do';

-- in : 검색에 대한 여러개의 데이터를 지정할 수 있는 명령어, 서버쿼리 사용을 위한 명령어, where 절에서 사용, or 명령어를 사용한 것과 동일한 효과
-- 사용법 where 컬럼명 in (데이터1, 데이터2,...)
-- where 컬럼명 in (select ...) -> 서브쿼리가 들어감
select * from employees where first_name = 'mario';
select * from employees where first_name = 'marko';
-- in을 사용하거나 or를 사용하거나 결과는 동일함
select * from employees where first_name in ('mario', 'marko');
select * from employees where first_name = 'mario' or first_name = 'marko';
-- in을 사용 시 like 사용할 수 없음, or 사용 시 like 사용 가능
select * from employees where first_name like 'mar%' or first_name like '%ko';

-- 문제 3) 사원 테이블에서 이름이 'mary', 'maria', 'jouko'이며, 성별이 여성이면서, 사번이 30000번 보다 빠른 사람을 모두 검색하세요.(in 사용)
select * from employees where emp_no < 30000 and gender = 'F' and first_name in ('mary', 'maria', 'jouko');
-- 문제 4) 사원 테이블에서 이름 중 시작 글자가 ma인 사람과 jo이며 성별이 여성인 사람을 모두 검색하세요. (or 사용)
select * from employees where emp_no < 30000 and gender = 'F' and first_name like 'ma___' or first_name like 'jo%';

-- between : 지정한 범위 내의 데이터를 출력할 때 사용, 시작값과 종료값 포함, where 절에서 사용, 범위 값은 숫자, 문자, 날짜로 사용 가능
-- 사용법 : where 컬럼명 between 시작값 and 종료값
select min(hire_date) from employees;
select max(hire_date) from employees;

select * from employees where hire_date between '1999-10-01' and '1999-10-10';
select * from employees where hire_date between '1999-10-01' and '1999-10-10' order by hire_date asc;

-- 비교연산자와 and 연산자를 사용하여 between과 동일한 결과를 얻을 수 있음
select * from employees where hire_date >= '1999-10-01' and hire_date <= '1999-10-10' order by hire_date asc;

-- 문제 5) 생일이 '1962-12-01' ~ '1962-12-15'인 사람 중 남자인 사람만 모두 검색하세요
select * from employees where gender = 'M' and birth_date between '1962-12-01' and '1962-12-15';

-- 문제 6) 입사일이 '1997-10-16' ~ '1997-10-30'인 사람 중 남자이며, 성의 글자수가 5자 이상인 사람만 모두 검색하세요(between 방식, 비교 연산자 방식 둘다 생성)
select * from employees where gender = 'M' and last_name like '%_____%' and hire_date between '1997-10-16' and '1997-10-30';
select * from employees where gender = 'M' and last_name like '%_____%' and hire_date >= '1997-10-16' and hire_date <= '1997-10-30';
-- 문자열로 범위 설정
select * from employees where first_name between 'maria' and 'mariz' order by first_name asc;

-- as : 테이블 및 컬럼명에 별칭을 부여하는 명령어, 테이블과 select 에서 사용, 해당 퀴리문에서만 효과가 있음, 컬럼명의 길이가 길어서 수정하고자 할 경우, 화면에 출력하고자 하는 컬럼명을 변경할 경우, join 사용 시 테이블명을 변경하고자 할 경우
-- 사용법 : select 컬럼명1 as '별칭1', 컬럼명2 as '별칭2',... from 테이블명
-- select 별칭테이블명.컴럼명1, 별칭테이블명.컬럼명2,... from 테이블명 as '별칭'
select emp_no as '사원번호', birth_date as '생년월일', first_name as '이름', last_name as '성', gender as '성별', hire_date as '입사일' from employees as a;

select a.emp_no, a.birth_date, a.first_name, a.last_name, a.gender, a.hire_date from employees as a;

-- join : 관련 있는 데이터를 가지고 있는 둘 이상의 테이블을 결합하기 위해 사용
-- inner join : 일반적인 join, inner는 생략 가능, 두 테이블에서 동일하게 가지고 있는 데이터들을 모아서 하나의 테이블인 것처럼 출럭(교집합)
-- left outter join : outter는 생략 가능, 두 테이블 중 왼쪽에 있는 테이블의 모든 내용을 출력하고, 오른쪽에 있는 테이블의 내용 중 왼쪽 테이블에 해당하는 내용을 출력(해당하는 내용이 없으면 null로 출력)
-- right outter join : outter는 생략 가능, 두 테이블 중 오른쪽에 있는 테이블의 모든 내용을 출력하고, 왼쪽에 있는 테이블의 내용 중 오른쪽 테이블에 해당하는 내용을 출력(해당하는 내용이 없으면 null로 출력)
-- cross join : 양쪽 테이블의 모든 내용을 출력
-- self join : 왼쪽 테이블 및 오른쪽 테이블을 하나의 테이블로 구성하여 결과를 출력하는 방식

-- 사용법 : select 테이블명1.컬럼명1, 테이블명1.컬럼명2,..., 테이블명2.컬럼명1, 테이블명2.컬럼명2,... from 테이블명1 join 테이블명2 on 테이블명1.통일한 데이터 컬럼명 = 테이블2.동일한 데이터 컬럼명 and 조건식
-- join으로 두 테이블의 모든 컬럼 출력(inner 생략)
select * from employees join salaries on employees.emp_no = salaries.emp_no;
-- 두 테이블에서 필요한 컬럼만 출력
select employees.emp_no, employees.birth_date, employees.first_name, employees.last_name, employees.gender, employees.hire_date, salaries.salary, salaries.from_date, salaries.to_date
from employees
join salaries
on employees.emp_no = salaries.emp_no;

-- as 명령어로 별칭을 사용한 join

select e.emp_no, e.birth_date, e.first_name, e.last_name, e.gender, e.hire_date, s.salary, s.from_date, s.to_date
from employees as e
join salaries as s
on e.emp_no = s.emp_no
and e.emp_no = 10009;

-- 문제 7) join을 사용하여 employees 테이블과 salaries 테이블을 합하고, 입사일이 1985년인 사람들을 검색하세요
select * 
from employees as a
join salaries as e
on a.emp_no = e.emp_no 
and hire_date between '1985-01-01' and '1985-12-31';

-- 문제 8) 사원 번호가 101010인 사람의 사원번호, 성, 이름, 성별, 급여, 해당 급여 시작일(from_date), 입사일을 모두 검색하세요
select a.emp_no, a.first_name, a.last_name, a.gender, s.salary, s.from_date, a.hire_date
from employees as a
join salaries as s
on a.emp_no = s.emp_no 
and a.emp_no = 101010;

-- 서버쿼리 사용법 : select 컬럼명1, 컬럼명2,... from 테이블명 where 조건컬럼명 in (select 조건컬럼명 from 서브테이블명 where 조건식)

-- 이름이 Christ Demos인 사람의 급여 정보
SELECT 
    emp_no, salary from_date, to_date
FROM
    salaries
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            last_name = 'Christ'
                AND first_name = 'Demos');

-- 2개 이상의 테이블을 join
select e.emp_no, e.birth_date, e.first_name, e. last_name, e. gender, e.hire_date, s.salary, s.from_date, s.to_date, t.title, t.from_date, t.to_date
from employees as e
join salaries as s
join titles as t
on e.emp_no = s.emp_no
and e.emp_no = t.emp_no;

-- 문제 9) 사원번호가 100100인 사람의 사원번호, 성, 이름, 직급, 급여 정보를 모두 검색하세요
select e.emp_no, e.last_name, e.first_name, t.title, s.salary
from employees as e
join salaries as s
join titles as t
on e.emp_no = s.emp_no
and e.emp_no = t.emp_no
where e.emp_no = 100100;
-- 문제 10) 사원번호가 100000인 사람의 사원번호, 성, 이름, 현재 직급, 현재 급여, 입사일, 현재급여 시작일(from_date)을 검색하세요
-- salaries 테이블의 to_date의 값이 9999-01-01이면 현재 재직 중
select e.emp_no, e.last_name, e.first_name, t.title, s.salary, e.hire_date, s.salary, t.to_date, s.from_date
from employees as e
join salaries as s
join titles as t
on e.emp_no = s.emp_no
and e.emp_no = t.emp_no
and e.emp_no = 100000 and s.to_date >= '2022-11-22';

-- view : 가상 테이블로 실제 데이터는 존재하지 않고 기존의 테이블 및 view의 데이터를 가져다가 사용하는 테이블, 보안과 편의성을 위해서 사용함, 데이터의 입력, 수정, 삭제가 어려움, view는 한번 생선되면 수정이 불가함
-- 생성 : create view 뷰이름 as select 쿼리문
-- 삭제 : drop view 뷰이름
-- 조희 : show create view 뷰이름

create view emp_copy as select * from employees limit 100;

create view emp_maria as select * from employees where first_name = 'maria' and gender = 'F';

select * from employees where first_name = 'maria' and gender = 'f';

-- 외부 사용자 (다른 업체 개발자)에게 특정 테이블 사용 권한 주기
-- 실제 테이블의 사용권한을 외부 사용자에게 주면 보안 관련 문제가 발생함
-- view를 생성하여 외부 사용자는 해당 정보가 들어있는 view에 대한 사용권한만 줌
-- 1. 관리자가 외부 사용자 id/pw 생성
-- 2. 외부 사용자에게 특정 view의 사용 권한 부여
-- 3. 외부 사용자로 접속 view 내용 확인


use mysql;
show tables;
select host, user, authentication_string from user;

create user 'test5'@'%' identified by 'k404';

show grants for 'test5'@'%';

grant all privileges on employees.emp_pyj to 'test5'@'%';


use mysql;
