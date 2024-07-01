CREATE TABLE TR_AUDIT
(
ID int identity,--номер
STMT nvarchar(20)--DML_оператор
check (STMT in('INS','DEL','UPD')),
TRANAME nvarchar(50),--имя триггера
CC nvarchar(300)--комментарий
)


drop table TR_AUDIT

-------------1---------------
CREATE TRIGGER TR_TEACHER_INS ON TEACHER AFTER INSERT
AS
DECLARE @teacher nvarchar(20), @nme nvarchar(100), @gender nvarchar(1), @pulp nvarchar(100), @res nvarchar(300)
print N'Операция вставки';
set @teacher = (select TEACHER from INSERTED);
set @nme = (select TEACHER_NAME from INSERTED);
set @gender = (select GENDER from INSERTED);
set @pulp = (select PULPIT from INSERTED);
set @res = @teacher + ' ' + @nme + ' '+ @gender + ' ' + @pulp;
INSERT INTO TR_AUDIT(STMT,TRANAME,CC)
values('INS','TR_TEACHER_INS', @res);
return;

INSERT INTO TEACHER values(N'СВХ', N'Смелов Владислав Владимирович', N'м', N'ИСиТ');
SELECT * FROM TR_AUDIT

-------------2---------------

CREATE TRIGGER TR_TEACHER_DEL ON TEACHER AFTER DELETE
AS
DECLARE @teacher nvarchar(20), @nme nvarchar(100), @gender nvarchar(1), @pulp nvarchar(100), @res nvarchar(300)
SET @teacher = (SELECT TEACHER FROM deleted);
SET @nme = (SELECT TEACHER_NAME FROM deleted);
SET @gender = (SELECT GENDER FROM deleted);
SET @pulp = (SELECT PULPIT FROM deleted);
SET @res = @teacher + ' ' + @nme + ' ' + @gender + ' ' + @pulp;
INSERT INTO TR_AUDIT(STMT, TRANAME, CC)
VALUES ('DEL', 'TR_TEACHER_DEL', @res);


DELETE FROM TEACHER WHERE TEACHER = N'СВХ';
SELECT * FROM TR_AUDIT;

-------------3---------------

alter TRIGGER TR_TEACHER_UPD ON TEACHER AFTER UPDATE
AS
DECLARE @teacher nvarchar(20), @nme nvarchar(100), @gender nvarchar(1), @pulp nvarchar(100), @res nvarchar(300), @res1 nvarchar(300)
print N'Операция обновления';
set @teacher = (select TEACHER from deleted);
set @nme= (select TEACHER_NAME from DELETED);
set @gender= (select GENDER from DELETED);
set @pulp = (select PULPIT from DELETED);
set @res = @teacher + ' '+ @nme + ' '+ @gender + ' ' + @pulp;

INSERT INTO TR_AUDIT(STMT, TRANAME, CC)
values('UPD', 'TR_TEACHER_UPD', @res);
return;

UPDATE TEACHER SET GENDER = N'ж' WHERE TEACHER=N'ИИИ'
SELECT * FROM TR_AUDIT;

-------------4---------------
CREATE TRIGGER TR_TEACH ON TEACHER AFTER INSERT, DELETE, UPDATE
AS
DECLARE @teacher nvarchar(20), @nme nvarchar(100), @gender nvarchar(1), @pulp nvarchar(100), @res nvarchar(300)

DECLARE @ins int = (select count(*) from inserted), @del int = (select count(*) from deleted);
if @ins > 0 and @del = 0
begin
print N'Событие добавление';
set @teacher=(select TEACHER from INSERTED);
set @nme=(select TEACHER_NAME from INSERTED);
set @gender=(select GENDER from INSERTED);
set @pulp=(select PULPIT from INSERTED);
set @res = @teacher + ' '+ @nme + ' '+ @gender + ' ' + @pulp;
insert into TR_AUDIT(STMT,TRANAME,CC)
values('INS','TR_TEACHER_INS',@res);
end;
else if @ins = 0 and @del > 0
begin
print N'Операция удаления'
set @teacher=(select TEACHER from deleted);
set @nme=(select TEACHER_NAME from deleted);
set @gender=(select GENDER from deleted);
set @pulp=(select PULPIT from deleted);
set @res = @teacher + ' '+ @nme + ' '+ @gender + ' ' + @pulp;
insert into TR_AUDIT(STMT,TRANAME,CC)
values('DEL','TR_TEACHER_DEL', @res);
end;
else if @ins > 0 and @del > 0
begin
print N'Операция обновления';
set @teacher = (select TEACHER from INSERTED);
set @nme= (select TEACHER_NAME from INSERTED);
set @gender= (select GENDER from INSERTED);
set @pulp= (select PULPIT from INSERTED);
set @res = @teacher + ' '+ @nme + ' '+ @gender + ' ' + @pulp;
set @teacher = (select TEACHER from deleted);
set @nme= (select TEACHER_NAME from DELETED);
set @gender= (select GENDER from DELETED);
set @pulp = (select PULPIT from DELETED);
set @res = @teacher + ' '+ @nme + ' '+ @gender + ' ' + @pulp;
insert into TR_AUDIT(STMT, TRANAME, CC)
values('UPD', 'TR_TEACHER_UPD', @res);
end;
return;


UPDATE TEACHER SET GENDER = N'ж' WHERE TEACHER=N'ИИИ'
DELETE FROM TEACHER WHERE TEACHER = N'ИИИ';
INSERT INTO TEACHER values(N'ИИИ', N'Иванов Иван Иванович', N'м', N'ИСиТ');
SELECT * FROM TR_AUDIT;

-------------5---------------

insert into TEACHER values('ЧЯР','Чёрнанс Яу РУслвкси','ж','ИСиТ');
update TEACHER set TEACHER.GENDER = 'ж12' where TEACHER like 'ЧЯР'

-------------6---------------

create trigger TR_TEACHER_DEL1 on TEACHER after Delete 
as print 'TR_TEACHER_DELETE_1';
RETURN ;
go
create trigger TR_TEACHER_DEL2 on TEACHER after Delete 
as print 'TR_TEACHER_DELETE_2';
RETURN ;
go
create trigger TR_TEACHER_DEL3 on TEACHER after Delete 
as print 'TR_TEACHER_DELETE_3';
RETURN ;
go

select t.name, e.type_desc 
from sys.triggers  t join  sys.trigger_events e  
on t.object_id = e.object_id  
where OBJECT_NAME(t.parent_id) = 'TEACHER' and 
e.type_desc = 'Delete';  

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2', 
 @order = 'Last', @stmttype = 'Delete';

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', 
 @order = 'First', @stmttype = 'Delete';
 go

 -------------7---------------
create or alter trigger Aud_Tran on AUDITORIUM AFTER INSERT, DELETE, UPDATE 
as declare @c int = (select sum(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM);
if(@c > 60)
begin 
raiserror('Общая вместительность не может быть > 60', 10 ,1);
rollback;
end
return;
update AUDITORIUM set AUDITORIUM_CAPACITY = 150 where AUDITORIUM.AUDITORIUM='413-1'

 -------------8---------------

CREATE TRIGGER Tov_INSTEAD_OF ON FACULTY INSTEAD OF DELETE
AS
raiserror(N'Удаление запрещено',10,1);
return;

DELETE FROM FACULTY WHERE FACULTY=N'ФИТ';



-- Получ  DML-тр
DECLARE @triggerName NVARCHAR(MAX)
DECLARE trigger_cursor CURSOR FOR
    SELECT t.name
    FROM sys.triggers t
    INNER JOIN sys.trigger_events te ON t.object_id = te.object_id
    WHERE te.type_desc LIKE '%DELETE%'

OPEN trigger_cursor
FETCH NEXT FROM trigger_cursor INTO @triggerName

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Уд
    EXEC('DROP TRIGGER [' + @triggerName + ']')
    FETCH NEXT FROM trigger_cursor INTO @triggerName
END

CLOSE trigger_cursor
DEALLOCATE trigger_cursor



 -------------9---------------
 create  trigger DDL_TEACHER on database 
for DDL_DATABASE_LEVEL_EVENTS  as   
declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
if @t1 = 'TEACHER' 
begin
     print 'Тип события: '+@t;
     print 'Имя объекта: '+@t1;
     print 'Тип объекта: '+@t2;
     raiserror( N'операции с таблицей TEACHER запрещены', 16, 1);  
     rollback;    
 end;
 alter table TEACHER Drop Column TEACHER_NAME