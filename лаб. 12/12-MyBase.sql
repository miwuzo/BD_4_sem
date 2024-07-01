-----------------------------1
-----------------------------2

begin try
 begin tran
 insert ������������ values (N'ee','','', '', '');
 insert ������������ values (N'����','','', '', '');
   commit tran;
end try
begin catch
 print N'������:'+case
 when error_number() = 2627 and patindex('%������������_PK%', error_message()) >0
 then N'������������ ����������'
 else N'����������� ������' + cast(error_number() as varchar(5)) + error_message()
 end;
 if @@TRANCOUNT>0 rollback tran;
end catch;


-----------------------------3
declare @point nvarchar(32);
begin try
 begin tran
   insert ������������ values (N'w','w','2000-01-10', '1', 'w');
  set @point='p1'; save tran @point;
   insert ������������ values (N'u','w','2000-01-10', '1', 'w');
 set @point='p2' ; save tran @point;
   insert ������������ values (N'i��������','w','2000-01-10', '1', 'w');
 commit tran;
end try

begin catch
print '������:' + case when error_number() = 2627 and patindex('%������������_PK%', error_message()) > 0
then '������������ ������'
else '����������� ������:' + cast(error_number() as varchar(5)) + error_message()
end
if @@trancount>0
 begin 
   print '����������� �����:'+@point;
   rollback tran @point;
   commit tran;
 end;
end catch;



-----------------------------4


-- A --
set transaction isolation level READ UNCOMMITTED 
begin transaction 
select @@SPID 'SID', 'insert' '���������', * from ������������ where [�������� ������������] = '����2';
																	             
select @@SPID 'SID', 'update'  '���������',  [�������� ������������], ����������
from ������������   where  [�������� ������������] = '����';
-------------------------- t1 ------------------
commit; 
-------------------------- t2 -----------------

-- B --	
begin transaction 
select @@SPID 'SID';
INSERT into ������������ values('���� 2','w','2000-01-10', '1', 'w');   
update ������������ set ���������� = '47' where [�������� ������������] = '����';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
rollback;

delete ������������ where [�������� ������������] = '����';




-----------------------------5

-- A --
set transaction isolation level READ COMMITTED 
begin transaction 
select @@SPID 'SID', 'insert' '���������', * from ������������ where [�������� ������������] = '����2';
																	             
select @@SPID 'SID', 'update'  '���������',  [�������� ������������], ����������
from ������������   where  [�������� ������������] = '����';
-------------------------- t1 ------------------
commit; 
-------------------------- t2 -----------------

-- B --	
begin transaction 
select @@SPID 'SID';
INSERT into ������������ values('���� 2','w','2000-01-10', '1', 'w');   
update ������������ set ���������� = '47' where [�������� ������������] = '����';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
rollback;


-----------------------------6

-- A --
set transaction isolation level REPEATABLE READ  
begin transaction 
select @@SPID 'SID', 'insert' '���������', * from ������������ where [�������� ������������] = '����2';
																	             
select @@SPID 'SID', 'update'  '���������',  [�������� ������������], ����������
from ������������   where  [�������� ������������] = '����';
-------------------------- t1 ------------------
commit; 
-------------------------- t2 -----------------

-- B --	
set transaction isolation level READ COMMITTED
begin transaction 
select @@SPID 'SID';
INSERT into ������������ values('���� 2','w','2000-01-10', '1', 'w');   
update ������������ set ���������� = '47' where [�������� ������������] = '����';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
rollback;




-----------------------------7
-- A --
set transaction isolation level SERIALIZABLE 
begin transaction 
select @@SPID 'SID', 'insert' '���������', * from ������������ where [�������� ������������] = '����2';
																	             
select @@SPID 'SID', 'update'  '���������',  [�������� ������������], ����������
from ������������   where  [�������� ������������] = '����';
-------------------------- t1 ------------------
commit; 
-------------------------- t2 -----------------

-- B --	
set transaction isolation level READ COMMITTED
begin transaction 
select @@SPID 'SID';
INSERT into ������������ values('���� 2','w','2000-01-10', '1', 'w');   
update ������������ set ���������� = '47' where [�������� ������������] = '����';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
rollback;








-----------------------------8
select * from ������������

begin tran
update ������������ set [��� ������������]='����' where [�������� ������������] = 'u'
	begin tran 
	update ������������ set [��� ������������]='����' where [�������� ������������] = 'u'
	commit;
select * from ������������
rollback
select * from ������������