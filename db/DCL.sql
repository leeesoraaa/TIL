--DCL: 데이터 제어어
-- 데이터베이스의 일관성과 무결성을 유지하고, 동시에 여러 시스템이 병행 수행이 가능하도록 제어하며 접근권한을 부여하거나 해제하는 명령어
--트랜잭션: 데이터베이스에 접속하여 sql 명령어를 수행하는 일련의 과정, 명령이 실행되는 단위

-- commit: 트랜잭션의 수행이 정상적으로 완료되었음을 알려주는 것으로 그 결과가 DB에 반영된다.
-- rollback: 트랜잭션을 수행하는 도중에 문제가 발생하여 트랜잭션 처리를 멈추고 원래 상태로 되돌려 놓은 것
-- grant: 권한부여
-- revoke: 권한 해제

--department  테이블을 활용하여 dept 테이블을 생성하고, 구조와 내용을 복사하시오.
drop table dept;
create table dept as select * from department; --drop 과 create 같은 DDL은 auto commit(db 결과가 자동으로 영구저장된 상태)
select * from dept;
delete from dept; -- DML은 auto commit이 되지 않음
rollback; -- 영구 저장 된 create 단계로 돌아감

-- 부서번호가 10번이 부서정보를 삭제한 후 db에 반영하는 쿼리문을 기술하시오.
delete from dept where dno=10;
commit;
rollback;



