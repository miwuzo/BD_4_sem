--4 задание, неподтвержденное чтения для 5
BEGIN TRANSACTION 
SELECT @@SPID 'SID';
INSERT INTO SUBJECT VALUES('СТПИ','Современные технологии программирования в  интернете','ИСиТ');   
UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = '15' WHERE AUDITORIUM_NAME='301-1';	
-------------------------- t1 --------------------
-------------------------- t2 --------------------
WAITFOR DELAY '00:00:05';
INSERT INTO AUDITORIUM VALUES('511-1', 'ЛБ-К', 60, '511-1');
WAITFOR DELAY '00:00:05';
rollback;

DELETE SUBJECT WHERE SUBJECT = 'СТПИ';


DELETE AUDITORIUM WHERE AUDITORIUM_NAME='511-1';
--работа фантомного и неповторяющегося чтения
BEGIN TRANSACTION 
SELECT @@SPID 'SID';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
WAITFOR DELAY '00:00:05';
INSERT INTO AUDITORIUM VALUES('511-1', 'ЛБ-К', 60, '511-1');
UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = '55' WHERE AUDITORIUM_NAME='324-1';	
COMMIT;

SELECT * FROM AUDITORIUM






--6
DELETE AUDITORIUM WHERE AUDITORIUM_NAME='511-1';
--не работа неповторяющегося чтения
BEGIN TRANSACTION 
SELECT @@SPID 'SID';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
WAITFOR DELAY '00:00:05';
UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = '59' WHERE AUDITORIUM_NAME='324-1';	
COMMIT;
SELECT * FROM AUDITORIUM


DELETE AUDITORIUM WHERE AUDITORIUM_NAME='511-1';
--работа фантомного чтения
BEGIN TRANSACTION 
SELECT @@SPID 'SID';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
WAITFOR DELAY '00:00:05';
INSERT INTO AUDITORIUM VALUES('511-2', 'ЛБ-К', 60, '511-1');
UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = '50' WHERE AUDITORIUM_NAME='324-1';	
COMMIT;

DELETE SUBJECT WHERE SUBJECT = 'СТПИ';
--не работа неподтвежденного чтения
BEGIN TRANSACTION 
SELECT @@SPID 'SID';
INSERT INTO SUBJECT VALUES('СТПИ','Современные технологии программирования в  интернете','ИСиТ');   
UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = '15' WHERE AUDITORIUM_NAME='301-1';	
-------------------------- t1 --------------------
-------------------------- t2 --------------------
WAITFOR DELAY '00:00:05';
rollback;






--7
--не работа неподтвежденного чтения
BEGIN TRANSACTION 
SELECT @@SPID 'SID';
INSERT INTO SUBJECT VALUES('СТПИ','Современные технологии программирования в  интернете','ИСиТ');   
UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = '15' WHERE AUDITORIUM_NAME='301-1';	
-------------------------- t1 --------------------
-------------------------- t2 --------------------
WAITFOR DELAY '00:00:05';
rollback;


DELETE AUDITORIUM WHERE AUDITORIUM_NAME='511-1';
--не работа неповторяющегося чтения
BEGIN TRANSACTION 
SELECT @@SPID 'SID';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
WAITFOR DELAY '00:00:05';
UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = '55' WHERE AUDITORIUM_NAME='324-1';	
COMMIT;

DELETE AUDITORIUM WHERE AUDITORIUM_NAME='511-1';
--не работа фантомного чтения
BEGIN TRANSACTION 
SELECT @@SPID 'SID';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
WAITFOR DELAY '00:00:05';
INSERT INTO AUDITORIUM VALUES('511-1', 'ЛБ-К', 60, '511-1');
UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = '50' WHERE AUDITORIUM_NAME='324-1';	
COMMIT;
