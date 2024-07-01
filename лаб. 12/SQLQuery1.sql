-- A ---
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'insert AUDITORIUM' 'результат', * FROM SUBJECT 
	                                                                WHERE SUBJECT = 'СТПИ';
																	
SELECT @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='301-1';

SELECT @@SPID 'SID', 'select AUDITORIUM' 'результат', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

WAITFOR DELAY '00:00:05';
SELECT @@SPID 'SID', 'select AUDITORIUM' 'результат', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

COMMIT; 
-------------------------- t2 -----------------


delete SUBJECT where SUBJECT = 'СТПИ';
SELECT * FROM SUBJECT
SELECT * FROM AUDITORIUM




----5

--неподтвержденное чтение
-- A ---
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'insert AUDITORIUM' 'результат', * FROM SUBJECT 
	                                                                WHERE SUBJECT = 'СТПИ';
																	
SELECT @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='301-1';

SELECT @@SPID 'SID', 'select AUDITORIUM' 'результат', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

WAITFOR DELAY '00:00:05';
COMMIT; 

--работа фантомного и неповторяющегося чтения
-- A ---
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
-------------------------- t1 ------------------

SELECT @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';
SELECT @@SPID 'SID', 'select AUDITORIUM' 'результат', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

WAITFOR DELAY '00:00:05';
SELECT @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';
SELECT @@SPID 'SID', 'select AUDITORIUM' 'результат', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;
COMMIT;






---6
--не работа неповторяющегося чтения
-- A ---
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
-------------------------- t1 ------------------

SELECT @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';

WAITFOR DELAY '00:00:10';
SELECT @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';
COMMIT;

--работа фантомного чтения
-- A ---
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'select AUDITORIUM' 'результат', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

WAITFOR DELAY '00:00:05';
SELECT @@SPID 'SID', 'select AUDITORIUM' 'результат', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;
COMMIT;


--не работа неподтвержденного чтение
-- A ---
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'insert AUDITORIUM' 'результат', * FROM SUBJECT 
	                                                                WHERE SUBJECT = 'СТПИ';
																	
SELECT @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='301-1';

COMMIT;





--7
--не работа неподтвержденного чтение
-- A ---
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'insert AUDITORIUM' 'результат', * FROM SUBJECT 
	                                                                WHERE SUBJECT = 'СТПИ';
																	
SELECT @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='301-1';

COMMIT;


--не работа неповторяющегося чтения
-- A ---
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
-------------------------- t1 ------------------

SELECT @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';

WAITFOR DELAY '00:00:05';
SELECT @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_NAME='324-1';
COMMIT;


--не работа фантомного чтения
-- A ---
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
-------------------------- t1 ------------------
SELECT @@SPID 'SID', 'select AUDITORIUM' 'результат', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;

WAITFOR DELAY '00:00:05';
SELECT @@SPID 'SID', 'select AUDITORIUM' 'результат', AUDITORIUM_NAME, 
						AUDITORIUM_TYPE,AUDITORIUM_CAPACITY FROM AUDITORIUM   WHERE  AUDITORIUM_CAPACITY=60;
COMMIT;




































--8
delete SUBJECT where SUBJECT = 'СТПИ';

begin tran
		INSERT into SUBJECT values('СТПИ','Современные технологии программирования в  интернете','ИСиТ');   ;
		begin tran
		update SUBJECT set SUBJECT_NAME='СТПИ' where SUBJECT='СТПИ';
		commit  
		if @@TRANCOUNT > 0 rollback;
select count(*) 'amount' from SUBJECT where SUBJECT='СТПИ'

