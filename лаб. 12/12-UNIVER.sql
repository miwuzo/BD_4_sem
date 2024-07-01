----------------------------1
use UNIVER
set nocount on
if exists( select * from SYS.objects where OBJECT_ID = object_id (N'DBO.X'))
drop table X;

declare @c int, @flag char = 'c';
SET IMPLICIT_TRANSACTIONS ON
Create table X(K int);
Insert X values (1), (2), (3);
set @c = (select count(*) from X);
print '���������� ����� � ������� X:' + cast (@c as varchar(2));
if @flag = 'c' commit;
else rollback ;
SET IMPLICIT_TRANSACTIONS OFF

if exists (select * from SYS.objects where OBJECT_ID = object_id(N'DBO.X'))
print '������� � ����';
else print '������� � ���';

select * from X;


-----------------------------2

begin try
 begin tran
 insert AUDITORIUM values (N'1-1000', N'��', 1, N'1-1');
 insert AUDITORIUM values (N'1-1000', N'��', N'��', N'1-1');
   commit tran;
end try
begin catch
 print N'������:'+case
 when error_number() = 2627 and patindex('%AUDITORIUM_PK%', error_message()) >0
 then N'������������ ����������'
 else N'����������� ������' + cast(error_number() as varchar(5)) + error_message()
 end;
 if @@TRANCOUNT>0 rollback tran;
end catch;


-----------------------------3
declare @point nvarchar(32);
begin try
 begin tran
   insert AUDITORIUM values (N'2-7000000', N'��', 1, N'1-1');
  set @point='p1'; save tran @point;
   insert AUDITORIUM values (N'2-6', N'��', 1, N'1-1');
  set @point='p2' ; save tran @point;
   insert AUDITORIUM values (N'1-5', N'��', 1, N'1-1');
 commit tran;
end try

begin catch
print '������:' + case when error_number() = 2627 and patindex('%AUDITORIUM_PK%', error_message()) > 0
then '������������'
else '����������� ������:' + cast(error_number() as varchar(5)) + error_message()
end
if @@trancount>0
 begin 
   print '����������� �����:'+@point;
   rollback tran @point;
--   commit tran;
 end;
end catch;



-----------------------------4


-- A --
set transaction isolation level READ UNCOMMITTED 
begin transaction 
select @@SPID 'SID', 'insert AUDITORIUM' '���������', * from SUBJECT where SUBJECT = '��';
																	             
select @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM   where  AUDITORIUM_NAME='301-1';
-------------------------- t1 ------------------
select @@SPID 'SID', 'insert AUDITORIUM' '���������', * from SUBJECT where SUBJECT = '��';
																	             
select @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM   where  AUDITORIUM_NAME='301-1';
commit; 
-------------------------- t2 -----------------

-- B --	
begin transaction 
select @@SPID 'SID';
INSERT into SUBJECT values('��','�����������������','��');   
update AUDITORIUM set AUDITORIUM_CAPACITY = '47' where AUDITORIUM_NAME='301-1';	
-------------------------- t1 --------------------
-------------------------- t2 --------------------

rollback;

delete SUBJECT where SUBJECT = '��';




-----------------------------5

-- A ---
set transaction isolation level READ COMMITTED 
begin transaction 
select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY = '33';
-------------------------- t1 ------------------ 
-------------------------- t2 -----------------
select @@SPID 'SID', 'update AUDITORIUM'  '��������',  AUDITORIUM_NAME, 
       AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM   where  AUDITORIUM_NAME='301-1';
commit; 

--- B ---	
begin transaction 	
-------------------------- t1 --------------------
update AUDITORIUM set AUDITORIUM_CAPACITY = '33' where AUDITORIUM_NAME='301-1';	

commit; 
-------------------------- t2 --------------------	




-----------------------------6
-- A ---
set transaction isolation level REPEATABLE READ
begin transaction 

select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY = '34';
-------------------------- t1 ------------------ 
-------------------------- t2 -----------------
select @@SPID 'SID', 'update AUDITORIUM'  '��������',  AUDITORIUM_NAME, 
       AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM   where  AUDITORIUM_NAME='301-1';
commit; 

--- B ---	
set transaction isolation level READ COMMITTED 
begin transaction
-------------------------- t1 --------------------
update AUDITORIUM set AUDITORIUM_CAPACITY = '34' where AUDITORIUM_NAME='301-1';	
insert AUDITORIUM values (N'1-3', N'��', 1, N'1-1');

commit; 
-------------------------- t2 --------------------	





-----------------------------7
-- A ---
set transaction isolation level SERIALIZABLE 
begin transaction 

select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY = '35';
-------------------------- t1 ------------------ 
-------------------------- t2 -----------------
select @@SPID 'SID', 'update AUDITORIUM'  '��������',  AUDITORIUM_NAME, 
       AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM   where  AUDITORIUM_NAME='1-0';
commit; 

--- B ---	
set transaction isolation level READ COMMITTED 
begin transaction
-------------------------- t1 --------------------
update AUDITORIUM set AUDITORIUM_CAPACITY = '35' where AUDITORIUM_NAME='301-1';	
insert AUDITORIUM values (N'1-0', N'��', 1, N'1-0');

commit; 
-------------------------- t2 --------------------	







-----------------------------8
select * from PULPIT

begin tran
update PULPIT set PULPIT_NAME = '��������� ��������' where PULPIT.FACULTY = '��'
	begin tran 
	update PULPIT set PULPIT_NAME = '���' where PULPIT.FACULTY = '��'
	commit;
	select * from PULPIT
rollback
select * from PULPIT