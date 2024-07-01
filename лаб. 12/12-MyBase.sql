-----------------------------1
-----------------------------2

begin try
 begin tran
 insert ОБОРУДОВАНИЕ values (N'ee','','', '', '');
 insert ОБОРУДОВАНИЕ values (N'утюг','','', '', '');
   commit tran;
end try
begin catch
 print N'ошибка:'+case
 when error_number() = 2627 and patindex('%ОБОРУДОВАНИЕ_PK%', error_message()) >0
 then N'дублирование факультета'
 else N'неизвестная ошибка' + cast(error_number() as varchar(5)) + error_message()
 end;
 if @@TRANCOUNT>0 rollback tran;
end catch;


-----------------------------3
declare @point nvarchar(32);
begin try
 begin tran
   insert ОБОРУДОВАНИЕ values (N'w','w','2000-01-10', '1', 'w');
  set @point='p1'; save tran @point;
   insert ОБОРУДОВАНИЕ values (N'u','w','2000-01-10', '1', 'w');
 set @point='p2' ; save tran @point;
   insert ОБОРУДОВАНИЕ values (N'iуууууууу','w','2000-01-10', '1', 'w');
 commit tran;
end try

begin catch
print 'ошибка:' + case when error_number() = 2627 and patindex('%ОБОРУДОВАНИЕ_PK%', error_message()) > 0
then 'дублирование товара'
else 'неизвестная ошибка:' + cast(error_number() as varchar(5)) + error_message()
end
if @@trancount>0
 begin 
   print 'контрольная точка:'+@point;
   rollback tran @point;
   commit tran;
 end;
end catch;



-----------------------------4


-- A --
set transaction isolation level READ UNCOMMITTED 
begin transaction 
select @@SPID 'SID', 'insert' 'результат', * from ОБОРУДОВАНИЕ where [Название оборудования] = 'утюг2';
																	             
select @@SPID 'SID', 'update'  'результат',  [Название оборудования], Количество
from ОБОРУДОВАНИЕ   where  [Название оборудования] = 'утюг';
-------------------------- t1 ------------------
commit; 
-------------------------- t2 -----------------

-- B --	
begin transaction 
select @@SPID 'SID';
INSERT into ОБОРУДОВАНИЕ values('утюг 2','w','2000-01-10', '1', 'w');   
update ОБОРУДОВАНИЕ set Количество = '47' where [Название оборудования] = 'утюг';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
rollback;

delete ОБОРУДОВАНИЕ where [Название оборудования] = 'утюг';




-----------------------------5

-- A --
set transaction isolation level READ COMMITTED 
begin transaction 
select @@SPID 'SID', 'insert' 'результат', * from ОБОРУДОВАНИЕ where [Название оборудования] = 'утюг2';
																	             
select @@SPID 'SID', 'update'  'результат',  [Название оборудования], Количество
from ОБОРУДОВАНИЕ   where  [Название оборудования] = 'утюг';
-------------------------- t1 ------------------
commit; 
-------------------------- t2 -----------------

-- B --	
begin transaction 
select @@SPID 'SID';
INSERT into ОБОРУДОВАНИЕ values('утюг 2','w','2000-01-10', '1', 'w');   
update ОБОРУДОВАНИЕ set Количество = '47' where [Название оборудования] = 'утюг';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
rollback;


-----------------------------6

-- A --
set transaction isolation level REPEATABLE READ  
begin transaction 
select @@SPID 'SID', 'insert' 'результат', * from ОБОРУДОВАНИЕ where [Название оборудования] = 'утюг2';
																	             
select @@SPID 'SID', 'update'  'результат',  [Название оборудования], Количество
from ОБОРУДОВАНИЕ   where  [Название оборудования] = 'утюг';
-------------------------- t1 ------------------
commit; 
-------------------------- t2 -----------------

-- B --	
set transaction isolation level READ COMMITTED
begin transaction 
select @@SPID 'SID';
INSERT into ОБОРУДОВАНИЕ values('утюг 2','w','2000-01-10', '1', 'w');   
update ОБОРУДОВАНИЕ set Количество = '47' where [Название оборудования] = 'утюг';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
rollback;




-----------------------------7
-- A --
set transaction isolation level SERIALIZABLE 
begin transaction 
select @@SPID 'SID', 'insert' 'результат', * from ОБОРУДОВАНИЕ where [Название оборудования] = 'утюг2';
																	             
select @@SPID 'SID', 'update'  'результат',  [Название оборудования], Количество
from ОБОРУДОВАНИЕ   where  [Название оборудования] = 'утюг';
-------------------------- t1 ------------------
commit; 
-------------------------- t2 -----------------

-- B --	
set transaction isolation level READ COMMITTED
begin transaction 
select @@SPID 'SID';
INSERT into ОБОРУДОВАНИЕ values('утюг 2','w','2000-01-10', '1', 'w');   
update ОБОРУДОВАНИЕ set Количество = '47' where [Название оборудования] = 'утюг';
-------------------------- t1 --------------------
-------------------------- t2 --------------------
rollback;








-----------------------------8
select * from ОБОРУДОВАНИЕ

begin tran
update ОБОРУДОВАНИЕ set [Тип оборудования]='внеш' where [Название оборудования] = 'u'
	begin tran 
	update ОБОРУДОВАНИЕ set [Тип оборудования]='внут' where [Название оборудования] = 'u'
	commit;
select * from ОБОРУДОВАНИЕ
rollback
select * from ОБОРУДОВАНИЕ