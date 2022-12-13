-- UNION : 둘 이상의 쿼리 결과 집합을 하나로 합하여 출력
-- 사용조건 : 컬럼의 수가 같아야 함, 각 컬럼의 데이터 타입이 같아야 함, 각 컬럼의 순서가 같아야 함
-- SELECT 컬럼명1-1, 컬럼명1-2, ... FROM 테이블명 WHERE 조건식
-- UNION
-- SELECT 컬럼명2-1, 컬럼명2-2, ... FROM 테이블명 WHERE 조건식
-- UNION 사용 시 첫번째 쿼리문의 결과와 두번째 쿼리문의 결과가 중복될 경우 중복을 제외하고 출력됨
-- UNION ALL : 유니온 사용 시 결과가 중복될 경우 중복을 제외하고 출력하는데 모든 결과를 출력하고 싶을 경우 사용
-- SELECT 컬럼명1-1, 컬럼명1-2, ... FROM 테이블명 WHERE 조건식
-- UNION ALL
-- SELECT 컬럼명2-1, 컬럼명2-2, ... FROM 테이블명 WHERE 조건식

SELECT * FROM employees;
-- 쿼리문을 두번 사용(나중에 합쳐야 함)
SELECT emp_no, first_name, last_name, gender FROM employees
WHERE emp_no BETWEEN 10101 AND 10200;

SELECT emp_no, first_name, last_name, gender FROM employees
WHERE emp_no BETWEEN 10501 AND 10600;

-- UNION을 쓰는 식(쿼리문을 합쳐준다)
SELECT emp_no, first_name, last_name, gender FROM employees
WHERE emp_no BETWEEN 10101 AND 10200
UNION
SELECT emp_no, first_name, last_name, gender FROM employees
WHERE emp_no BETWEEN 10501 AND 10600;

-- 데이터가 겹칠 때 중복된 데이터는 한번만 출력된다.
SELECT emp_no, first_name, last_name, gender FROM employees
WHERE emp_no BETWEEN 10101 AND 10200
UNION
SELECT emp_no, first_name, last_name, gender FROM employees
WHERE emp_no BETWEEN 10151 AND 10250;

-- 출력하는데 중복된 결과를 출력하고 싶을 경우 UNION ALL 사용
SELECT emp_no, first_name, last_name, gender FROM employees
WHERE emp_no BETWEEN 10101 AND 10200
UNION ALL
SELECT emp_no, first_name, last_name, gender FROM employees
WHERE emp_no BETWEEN 10151 AND 10250;

-- 문제 1) 이름이 'Deniz'인 사람과 Marc'인 사함의 사원번호, 생일, 성, 이름, 성별을 모두 출력하는 쿼리문을 작성하세요.
SELECT * FROM employees;

SELECT emp_no, birth_date, last_name, first_name, gender FROM employees
WHERE first_name = 'Deniz'
UNION
SELECT emp_no, birth_date, last_name, first_name, gender FROM employees
WHERE first_name = 'Marc';

-- 문제 2) 이름이 'Deniz'인 사람과 Marc'인 사함의 사원번호, 생일, 성, 이름, 성별을 모두 출력하는 쿼리문을 작성하세요.(IN 사용)
SELECT emp_no, birth_date, last_name, first_name, gender FROM employees
WHERE first_name IN('Deniz', 'Marc');  -- , 대신에 AND는 안되는지

-- OR 사용
SELECT emp_no, birth_date, last_name, first_name, gender FROM employees
WHERE first_name = 'Deniz' OR first_name = 'Marc';

-- GROUP BY
-- 동일한 값을 가진 결과를 묶어서 그룹화 함
-- GROUP BY는 집계함수 COUNT(), MAX(), MIN(), SUM(), AVG() 와 함께 자주 사용 됨
-- SELECT 컬럼명1, 컬럼명2, ... FROM 테이블명 WHERE 조건식
-- GROUP BY 컬럼명
-- ORDER BY 컬럼명

SELECT * FROM titles;

SELECT * FROM titles
GROUP BY title;

SELECT COUNT(emp_no), title, COUNT(from_date), COUNT(to_date) FROM titles
GROUP BY title;

-- 현재 근무 중인 사람만 출력
SELECT COUNT(emp_no), title, COUNT(from_date), COUNT(to_date) FROM titles
WHERE to_date > '2022-12-13'
GROUP BY title
ORDER BY title ASC;

-- 집계함수 없이 쓰면 뭐 잘 모르겠음;
SELECT emp_no, title, from_date, to_date FROM titles
GROUP BY title;
-- 집계함수 쓴 거랑 비교ㄱㄱ
SELECT MIN(emp_no), title, MIN(from_date), MIN(to_date) FROM titles
GROUP BY title;
-- 성별 당 몇명의 사원이 존재하는지 여부
SELECT COUNT(gender), gender FROM employees
GROUP BY gender;

-- 문제 3) 이름이 'mario'인 사람을 성별로 구분하여 총 몇명인지 출력하세요.
SELECT first_name, gender, COUNT(gender) AS cnt FROM employees
WHERE first_name = 'mario'
GROUP BY gender;

-- 문제 4) 이름이 'mario'이고, 현재 근무중인 사람을 직급에 따라 구분하여 출력하세요.
-- 내 답
SELECT COUNT(title), title, first_name
FROM employees as e
JOIN titles as t
ON e.emp_no = t.emp_no
WHERE first_name = 'mario' AND to_date > '2022-12-12'
GROUP BY title;

-- 선생님 답
SELECT e.first_name, t.title, COUNT(e.first_name) AS cnt
FROM employees AS e
JOIN titles AS t
ON e.emp_no = t.emp_no
AND e.first_name = 'mario' 
AND t.to_date >= '2022-12-13'
GROUP BY t.title;

-- HAVING : 집계 함수에 대해서 조건식을 적용하기 위해서 사용
-- 독립적으로 사용할 수 있지만 주로 GROUP BY와 함께 많이 사용함
-- SELECT 컬럼명1, 컬럼명2, ... 집계함수1, 집계함수2, ... FROM 테이블명
-- WHERE 조건식
-- GROUP BY 컬럼명
-- HAVING BY 집계함수 조건

SELECT * FROM salaries;


SELECT emp_no, salary, to_date, MAX(salary) AS SALMAX
 FROM salaries 
WHERE emp_no IN(10009, 10013, 10273)
GROUP BY emp_no

HAVING AVG(salary) > 60000;

-- EXISTS : IN 명령어와 비슷한 형태의 서브 쿼리를 실행하는 명령어
-- IN은 서브 쿼리가 먼저 동작하고 메인 쿼리의 SELECT가 동작하는 형태
-- EXISTS는 메인 쿼리의 SELECT가 먼저 동작, IN보다 성능이 좋음
-- 한 테이블이 다른 테이블과 외래키로 묶여있는 관계일 경우 사용, 두 테이블 간의 결과 중 지정한 값이 존재하는지 여부를 확인할 때 사용

SELECT * FROM salaries WHERE to_date <= '1985-03-31';

SELECT * FROM employees WHERE emp_no 
IN ( SELECT emp_no FROM salaries WHERE to_date <= '1985-03-31' );

SELECT * FROM employees WHERE EXISTS
( SELECT * FROM salaries WHERE salaries.emp_no = employees.emp_no AND to_date <= '1985-03-31' );

SELECT * 
FROM employees AS e
JOIN salaries AS s
ON e.emp_no = s.emp_no
WHERE s.to_date <= '1985-03-31';

-- ANY : 주로 서브쿼리에서 사용하는 연산자, 조건을 만족하는 데이터가 하나라도 있으면 출력
-- 결과를 boolean 형으로 출력, 하위 쿼리의 조건이 연산이 true면 조건이 true임
-- SELECT 컬럼명1-1, 컬럼명1-2, ... FROM 테이블명
-- WHERE 조건식
-- ANY ( SELECT 컬럼명 2-1, 2-2, ... FROM 테이블명 WHERE 조건식 );

SELECT emp_no, first_name, last_name, gender, hire_date FROM employees WHERE hire_date = '1985-01-02';

SELECT emp_no, first_name, last_name, gender FROM employees
WHERE emp_no = ANY ( SELECT emp_no FROM employees WHERE emp_no IN(10009, 10010, 10011) );

-- ALL : 결과로 boolean 값을 반환
-- 모든 하위 쿼리의 조건을 만족할 경우 TRUE를 반환
-- SELECT 컬럼명1-1, 컬럼명1-2, ... FROM 테이블명
-- WHERE 조건식
-- ALL ( SELECT 컬럼명 2-1, 2-2, ... FROM 테이블명 WHERE 조건식 );

SELECT emp_no, first_name, last_name, gender FROM employees
WHERE emp_no = ALL ( SELECT emp_no FROM employees WHERE emp_no IN(10009, 10010, 10011) );

-- INSERT SELECT : 서브쿼리로 존재하는 SELECT 문을 실행하여 조회된 결과를 다른 테이블에 INSERT 하는 것
-- INSERT INTO 컬럼명1-1, 컬럼명 1-2, ... FROM 테이블명
-- SELECT 컬럼명2-1, 컬럼명2-2, ... FROM 테이블명 WHERE 조건식

SELECT * FROM board;

SELECT * FROM board2;

INSERT INTO board2 (board_title, board_content, board_create_id, board_create_dt)
SELECT title, content, user_id, create_dt FROM board WHERE idx <= 6;

-- LEFT JOIN (LEFT OUTER JOIN)
-- 2개의 테이블을 join하여 출력할 경우 왼쪽의 테이블을 기준으로 결과를 출력하는 방식
-- 왼쪽의 테이블의 모든 내용을 출력하고, 오른쪽의 테이블은 왼쪽 테이블과 일치하는 데이터만 출력
-- 오른쪽 테이블의 내용이 없을 경우는 NULL로 표시됨
-- SELECT 컬럼명1, 컬럼명2, ... FROM 테이블명1
-- LEFT JOIN 테이블명2
-- ON 테이블명1.동일한 데이터의 컬럼명 = 테이블명2.동일한 데이터의 컬럼명
-- AND 조건식

INSERT INTO board (title, content, user_id, create_dt)
VALUES ('테스트 제목1', '테스트 컨텐츠1', 'test1', NOW()),
('테스트 제목2', '테스트 컨텐츠2', 'test1', NOW()),
('테스트 제목3', '테스트 컨텐츠3', 'test1', NOW()),
('테스트 제목4', '테스트 컨텐츠4', 'test2', NOW()),
('테스트 제목5', '테스트 컨텐츠5', 'test2', NOW()),
('테스트 제목6', '테스트 컨텐츠6', 'test2', NOW()),
('테스트 제목7', '테스트 컨텐츠7', 'test3', NOW()),
('테스트 제목8', '테스트 컨텐츠8', 'test4', NOW()),
('테스트 제목9', '테스트 컨텐츠9', 'test5', NOW());

SELECT * FROM board;

SELECT * FROM reply;

INSERT INTO reply ( board_idx, content, nick, create_dt)
VALUES (1, '댓글1-1', 'test2', NOW()),
(1, '댓글1-2', 'test3', NOW()),
(1, '댓글1-3', 'test3', NOW());

INSERT INTO reply ( board_idx, content, nick, create_dt)
VALUES (2, '댓글2-1', '테스터1', NOW()),
(2, '댓글2-2', '테스터2', NOW()),
(2, '댓글2-3', '테스터3', NOW());

INSERT INTO reply ( board_idx, content, nick, create_dt)
VALUES (3, '댓글3-1', '테스터1', NOW()),
(3, '댓글3-2', '테스터2', NOW());

INSERT INTO reply ( board_idx, content, nick, create_dt)
VALUES (4, '댓글4-1', '테스터1', NOW()),
(4, '댓글4-2', '테스터2', NOW()),
(4, '댓글4-3', '테스터3', NOW());

INSERT INTO reply ( board_idx, content, nick, create_dt)
VALUES (6, '댓글6-1', '테스터1', NOW()),
(6, '댓글6-2', '테스터2', NOW()),
(6, '댓글6-3', '테스터3', NOW());

-- 일반적인 INNER JOIN
SELECT b.idx, b.title, b.content, b.user_id, r.idx, r.content, r.nick
FROM board AS b
INNER JOIN reply AS r
ON b.idx = r.board_idx;

-- LEFT JOIN
SELECT b.idx, b.title, b.content, b.user_id, b.create_dt, r.idx, r.content, r.nick
FROM board AS b
LEFT JOIN reply AS r
ON b.idx = r.board_idx;

-- RIGHT JOIN
SELECT b.idx, b.title, b.content, b.user_id, b.create_dt, r.idx, r.content, r.nick
FROM board AS b
RIGHT JOIN reply AS r
ON b.idx = r.board_idx;

-- CROSS JOIN : ON부분이 없다.
SELECT b.idx, b.title, b.content, b.user_id, b.create_dt, r.idx, r.content, r.nick
FROM board AS b
CROSS JOIN reply AS r
WHERE b.idx = 9;

SELECT * FROM board;
SELECT * FROM reply;

-- SELF JOIN
-- 하나의 테이블을 가지고 서로 JOIN을 진행하는 것
-- 하나의 테이블로 JOIN을 진행하기 때문에 반드시 별명을 사용해야 함
-- 주로 사용하는 용도는 하나의 테이블 내에서 어떠한 연산을 진행할 경우 사용
-- SELECT a.컬럼명1, a.컬럼명2, ... b.컬럼명1, b.컬럼명2, ...
-- FROM 테이블명 AS a
-- JOIN 테이블명 AS b
-- WHERE 조건식

SELECT a.emp_no, b.emp_no, a.title, a.from_date, a.to_date
FROM titles AS a
JOIN titles AS b
WHERE a.emp_no <> b.emp_no;
-- <>, !=는 같지않을 때 참을 반환함
SELECT a.emp_no AS emp_no, MAX(b.salary) - MIN(a.salary) AS salary
FROM salaries AS a, salaries AS b  -- FROM salaries AS a JOIN salaries AS b 결과 똑같음
WHERE a.emp_no != b.emp_no
AND a.emp_no = 10009;

-- 사원 번호가 10101번인 사원의 전체 급여에서 사원 번호가 20202번인 사원의 전체 급여를 뺸 금액을 출력하는 쿼리문을 작성하세요(self join 사용)
SELECT a.emp_no AS emp_no_A, b.emp_no AS emp_no_B, SUM(a.salary) - SUM(b.salary) AS salary
FROM salaries AS a, salaries AS b 
WHERE a.emp_no = 10101
AND b.emp_no = 20202;

-- mysql 전용 함수
-- ABS(숫자) : 절대값 출력
-- MOD(분자, 분모) : 분자를 분모로 나눈 나머지 값을 출력(java의 % 연산자와 같음)
-- ROUND(숫자, 자리수) : 지정한 숫자를 소수점 이하 자리수에서 반올림
-- FLOOR(숫자) : 소수점 내림
-- CRILING(숫자) : 소수점 올림
-- TRUNCATE(숫자, 자리수) : 숫자 중 지정한 소수점 이하 자리수에서 버림

-- GREATEST(숫자1, 숫자2, 숫자3, ...) : 주어진 숫자 중 가장 큰 수 출력
-- LEAST(숫자1, 숫자2, 숫자3, ...) : 주어진 숫자 중 가장 작은 수 출력

-- POW(X, Y) : 제곱, X의 Y승

-- ROUND(RAND() * 100, 0) : 0 ~ 100사이의 랜덤한 숫자 출력







