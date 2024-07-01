-- A ---
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'insert AUDITORIUM' '���������', * FROM SUBJECT 
	                                                                WHERE SUBJECT = '����';
																	
SELECT @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='301-1';

SELECT @@SPID 'SID', 'select AUDITORIUM' '���������', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

WAITFOR DELAY '00:00:05';
SELECT @@SPID 'SID', 'select AUDITORIUM' '���������', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

COMMIT; 
-------------------------- t2 -----------------


delete SUBJECT where SUBJECT = '����';
SELECT * FROM SUBJECT
SELECT * FROM AUDITORIUM




----5

--���������������� ������
-- A ---
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'insert AUDITORIUM' '���������', * FROM SUBJECT 
	                                                                WHERE SUBJECT = '����';
																	
SELECT @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='301-1';

SELECT @@SPID 'SID', 'select AUDITORIUM' '���������', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

WAITFOR DELAY '00:00:05';
COMMIT; 

--������ ���������� � ���������������� ������
-- A ---
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
-------------------------- t1 ------------------

SELECT @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';
SELECT @@SPID 'SID', 'select AUDITORIUM' '���������', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

WAITFOR DELAY '00:00:05';
SELECT @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';
SELECT @@SPID 'SID', 'select AUDITORIUM' '���������', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;
COMMIT;






---6
--�� ������ ���������������� ������
-- A ---
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
-------------------------- t1 ------------------

SELECT @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';

WAITFOR DELAY '00:00:10';
SELECT @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';
COMMIT;

--������ ���������� ������
-- A ---
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'select AUDITORIUM' '���������', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

WAITFOR DELAY '00:00:05';
SELECT @@SPID 'SID', 'select AUDITORIUM' '���������', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;
COMMIT;


--�� ������ ����������������� ������
-- A ---
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'insert AUDITORIUM' '���������', * FROM SUBJECT 
	                                                                WHERE SUBJECT = '����';
																	
SELECT @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='301-1';

COMMIT;





--7
--�� ������ ����������������� ������
-- A ---
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'insert AUDITORIUM' '���������', * FROM SUBJECT 
	                                                                WHERE SUBJECT = '����';
																	
SELECT @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='301-1';

COMMIT;


--�� ������ ���������������� ������
-- A ---
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
-------------------------- t1 ------------------

SELECT @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';

WAITFOR DELAY '00:00:05';
SELECT @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';
COMMIT;


--�� ������ ���������� ������
-- A ---
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'select AUDITORIUM' '���������', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

WAITFOR DELAY '00:00:05';
SELECT @@SPID 'SID', 'select AUDITORIUM' '���������', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;
COMMIT;




































--8
delete SUBJECT where SUBJECT = '����';

begin tran
		INSERT into SUBJECT values('����','����������� ���������� ���������������� �  ���������','����');   ;
		begin tran
		update SUBJECT set SUBJECT_NAME='����' where SUBJECT='����';
		commit  
		if @@TRANCOUNT > 0 rollback;
select count(*) 'amount' from SUBJECT where SUBJECT='����'

