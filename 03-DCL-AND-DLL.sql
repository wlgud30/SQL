CREATE USER C##KJH IDENTIFIED BY 1234;  --유저생성
--ORACLE :사용자생성 ->동일이름의 스키마 생성
--그렇지만 권한은 생성되지않음
--
DROP USER C##KJH;            --유저삭제
DROP USER C##KJH CASCADE;    --연결된 객체도 모두 삭제

--사용자 정보 확인
--user_users : 현재 사용자 관련 정보
--all_users : db의 모든 사용자 정보
--dba_users : 모든 사용자의 상세 정보(DBA Only)
--현재 사용자 확인
SELECT * FROM user_users;
SELECT * FROM ALL_USERS;

--로그인 권한 부여
GRANT create session TO C##KJH; --C##KJH 에게 세션생성(로그인) 권한 부여
GRANT connect, resource TO C##KJH; --접속과 자원 접근 롤 부여
--GRANT connect, resources TO C##KJH;

--oracle 12버전 이후
--일반계정을 구분하기 위해서 일반계정 앞에는 C##(접두어)사용
--실제 데이터가 저장될 테이블 스페이스를 마련해 줘야 한다. -USERS 테이블 스페이스에 공간을 할당해줘야한다
--BUT,C##없이 계정을 생성하는 방법
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER KJH IDENTIFIED BY 1234;
--사용자 데이터 저장을 위한 테이블 스페이스 부여
ALTER USER C##KJH DEFAULT TABLESPACE USERS     --C##KJH의 기본 테이블 스페이스를 users로 잡아준다.
    QUOTA unlimited ON users;       --저장공간 한도를 unlimited로 부여
--ROLE 의 삭제
DROP ROLE dbuser;
--ROLE 의 생성
CREATE ROLE dbuser; --dbuser 이란 역할을 만들어 여러개의 권한을 담을 수 있다.
GRANT create session TO dbuser;    --dbuser역할에 table에 접속할 수 있는 권한을 부여
GRANT RESOURCE TO dbuser;    --dbuser 역할에 자원 생성 권한을 부여

--ROLE을 GRANT 하면 내부에 있는 개별 Privilege(권한)이 모두 부여
GRANT dbuser TO KJH;    --kjh사용자에게 dbuser 역할을 부여
--권한 회수 REVOKE
REVOKE dbuser FROM KJH; --KJH사용자에게 dbuser 역할을 회수
--계정 삭제
DROP USER kjh CASCADE;
--현재 사용자에게 부여된 ROLE 확인
--사용자 계정으로 로그인
SHOW USER;
SELECT * FROM user_role_privs;

--CONNECT 역할에는 어떤 권한이 포함되어 있는가?
DESC role_sys_privs;
SELECT * FROM role_sys_privs WHERE role = 'CONNECT';    --CONNECT 롤이 포함하고 있는 권한
SELECT * FROM role_sys_privs WHERE role = 'RESOURCE';   --RESOURCE 롤이 포함하고 있는 권한

--System 계정으로 진행
--HR 계정의 employees 테이블의 조회 권한을 C##KJH에게 부여하고 싶다면
GRANT SELECT ON hr.employees TO C##KJH;
--사용자 계정으로 진행
SELECT * FROM hr.employees;
