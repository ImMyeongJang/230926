--day09_DCL.sql
-------------------------------------------------
DDL ����: CREATE, ALTER, DROP, RENAME
DML ����: UPDATE,INSERT,DELETE
DCL ����: GRANT,REVOKE
DATA RETRIEVAL : SELECT
TRANSACTION CONTROL : COMMIT, ROLLBACK, SAVEPOINT
-------------------------------------------------
# DCL ����: GRANT,REVOKE

[1] �ý��� ���� �ο� ����(Syntax)

GRANT [system_privilege| role] TO [user|role|PUBLIC]
[WITH ADMIN OPTION]

 - system_privilege : �ο��� �ý��� ������ �̸�
 - role : �ο��� �����ͺ��̽� ������ �̸�
 - user, role : �ο��� ����� �̸��� �ٸ� ������ ���̽� ���� �̸�
 - PUBLIC : �ý��� ����, �Ǵ� �����ͺ��̽�
         ������ ��� ����ڿ��� �ο��� �� �ֽ��ϴ�.
 - WITH ADMIN OPTION : ������ �ο� ���� ����ڵ� 
        �ο� ���� ������ �ٸ� ����� �Ǵ� ���ҷ� 
           �ο��� �� �ְ� �Ǹ�, 
	   ���� ����ڰ� WITH ADMIN OPTION�� 
	   ���� ������ �ο� �޴´ٸ�
           �ο��� ������ �� ����ڿ� ���� ���� 
	   �Ǵ� ���� �� �� �ֽ��ϴ�. 
---------------------------------------------
�ó�����.
 1. DBA������ ���� SYSTEM���� ����
 conn system/oracle
 show user;
 2. ���ο� ����ڸ� ���� MILLER USER�� �����ϰ� ��� ����
 create user miller
 identified by miller;
 
 3. MILLER�� ���� �õ�  -> ���� ����
 conn miller/miller => ���� �߻�
 
 4. SYSTEM���� �����Ͽ� MILLER���� CREATE SESSION ���� �ο�
 conn system/oracle
 grant create session to miller;
  
 5. MILLER�� ���� �õ� --> ����
 conn miller/miller
 show user
 6. TEST ���̺� �����ϱ� --> ���� ����
 create table test(
 no number);
 
 7. SYSTEM���� ���� �� ���̺� ���� ���� �ο�
 conn system/oracle
 grant create table to miller;
 
 8. �ٽ� ���̺� ������ ���ڵ� insert
 conn miller/miller
create table test(
 no number);
  => no privileges on tablespace 'SYSTEM'
  
SELECT USERNAME, DEFAULT_TABLESPACE FROM DBA_USERS
WHERE USERNAME='MILLER';
    
 9. tablespace�� ���� ���� �����̶�� ����
 conn system/oracle
 alter user miller quota 2M on system;
 
 10 miller�� �����Ͽ� �ٽ� test ���̺��� �����ϰ� �����͸� insert�Ѵ�
 create table test(
 no number);
 insert into test values(100);
 commit;
 ------------------------------------------------------
 # ���� ȸ��
REVOKE [system_privilege| role] FROM [user|role|PUBLIC] 
 
 �ó�����
 0. conn system/oracle
 
 revoke connect, resource from scott;
 
 conn scott/tiger==>����
 
 conn system/oracle
 create session������ scott���� �ּ���
grant create session to scott;
 
 storm user�� �����ϼ���
create user storm
identified by storm;

grant create session to storm;



 1. DBA�� STORM���� WITH ADMIN OPTION�� ����Ͽ� 
 CREATE TABLE �ý��� ������ �ο� �մϴ�. 
 
 grant create table to storm with admin option;

2. STORM�� ���̺��� ���� �մϴ�. 
conn storm/storm
create table msg(no number);==> tablespace����

storm���� 2m �Ҵ�
conn system/oracle
alter user storm quota 2m on system

conn storm/storm
create table msg(no number);

3. STORM�� CREATE TABLE �ý��� ������ 
   SCOTT���� �ο� �մϴ�. 
   grant create table to scott;

    conn system/oracle
    alter user scott quota unlimited on system;
4. SCOTT�� ���̺��� ���� �մϴ�. 
    conn scott/tiger
    create table msg(no number);

5. DBA�� STORM���� �ο��� 
   CREATE TABLE �ý��� ������ ��� �մϴ�.
   
   conn system/oracle
   
   revoke create table from storm;
   
   conn storm/storm
   
   create table dummy(no number);=> error�߻�
6. scott�� ���̺� ���������� ?
    conn scott/tiger

    create table mytable(no number);
    ==> scott�� ������ ȸ������ ����
-------------------------------------------------------------------------   
   
   #[2] ��ü ����
   -����(Syntax)
  GRANT object_privilege [column] ON object
  TO {user[,user] | role |PUBLIC]
  [WITH GRANT OPTION]

 - object_privilege : �ο��� ��ü ������ �̸�

 - object : ��ü��

 - user, role : �ο��� ����� �̸��� �ٸ� ������ ���̽� ���� �̸�

 - PUBLIC : ������ ����, �Ǵ� �����ͺ��̽� ������ ��� ����ڿ��� �ο��� �� �ֽ��ϴ�.

 - WITH GRANT OPTION : ������ �ο� ���� ����ڵ� �ο� ���� ������ �ٸ� ����� �Ǵ� ���ҷ� 
                      �ο��� �� �ְ� �˴ϴ�. Object ���� �ο� ����
 ---------------------------------------------------------------------  
   # ROLE
   
   [1] ROLE ����        : CREATE ROLE ���̸�
   [2] ROLE�� ���Ѻο�   : GRANT ����1, ����2  TO ���̸�
   [3] ROLE�� �ٸ� ����� �Ǵ� �ٸ� ROLE���� �ο�
        GRANT ���̸� TO ����|�ٸ���
   
   ROLE�����ϱ�
   ���̸�: MGR
   ��������: CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SYNONYM
   MGR���� STORM���� �ο��ϼ���
   
   CONN SYSTEM/oracle
   
   create role mgr;
   
   grant create session, create table, create view, create synonym to mgr;
   
   
   grant mgr to storm;
   
   
   
   
   
   
   
   
   
   
 
 
 