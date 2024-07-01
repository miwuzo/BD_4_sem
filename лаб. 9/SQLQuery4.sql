-----------1-------------
declare @a char = 'Y', 
        @b varchar(6)= 'Yana', 
		@c datetime=getdate(), 
		@d time, 
		@e int, 
		@f smallint, 
		@g tinyint, 
		@h numeric(12,5);
set @d='08.09.2004';
set @e=1;
select @f= 1, @g=1, @h = 3.1415692;
select @a a, @b b, @c c , @d d;
print 'e='+ cast(@e as varchar (10))
print 'f='+ cast(@f as varchar (10))
print 'g='+ cast(@g as varchar (10))
print 'h='+ cast(@h as varchar (10))

-----------2-------------
use UNIVER
declare @a1 int, @b1 int,@c1 int,@d1 int, @o int=(select cast(sum(AUDITORIUM.AUDITORIUM_CAPACITY)as int) from AUDITORIUM)


if @o>200
begin 
select @a1=(select cast(count(*)as int) from AUDITORIUM),
@b1=(select cast(avg(AUDITORIUM_CAPACITY) as numeric(8,3)) from AUDITORIUM)
set @c1= (select cast(count(*)as int )from AUDITORIUM where AUDITORIUM_CAPACITY<@b1)
set @d1= (@c1*100)/@b1
select  @a1 '���������� ���������', @b1 '������� �����������', @c1 '����� ���.< �� �����������', @d1 '%'
end
else print '������ ����� �����������:'+ cast(@o as varchar(4))

-----------3-------------
select 
@@ROWCOUNT '����� ������������ �����',
@@VERSION '������ SQL Server',
@@SPID '��������� ������������� ��������',
@@ERROR '��� ��������� ������', 
@@SERVERNAME '��� �������',
@@TRANCOUNT '������� ����������� ����������',
@@FETCH_STATUS '��������� ���������� �����',
@@NESTLEVEL '������� ����������� ������� ���������'


-----------4-------------
--1
declare @z numeric(6,3), @t int=3, @x int=3
if @t>@x 
begin 

set @z=power(sin(@t),2);
select @z 'z='
end
else if @t<@x 
begin
set @z=4*(@t+@x)
select  @z 'z='
end
else if @t=@x 
begin
set @z=1-exp(@X-2) ;
select @z 'z='
end

--2
DECLARE @FIO VARCHAR(30) = '������ ��� ����������';
DECLARE @F0 VARCHAR(30) = SUBSTRING(@FIO, 1, 1);
DECLARE @F1 VARCHAR(30) = SUBSTRING(@FIO, CHARINDEX(' ', @FIO) + 1, 1);
DECLARE @F2 VARCHAR(30) = UPPER(@F0) + '.' + UPPER(@F1) + '.' + UPPER(SUBSTRING(@FIO, CHARINDEX(' ', @FIO, CHARINDEX(' ', @FIO) + 1) + 1, 1)) + '.';
SELECT @F2 AS '���';
--3
declare 
@years int = year(getdate()),
@dec int = month(getdate()) + 1;
select STUDENT.NAME, BDAY , @years - year(bday) as N'�������'
from STUDENT
where month(BDAY) = @dec;

--4
DECLARE @groupNumber INT = 10;

SELECT PROGRESS.PDATE AS '���� ���������� ��������',
       CASE
           WHEN DATEPART(dw, PROGRESS.PDATE) = 1 THEN '�����������'
           WHEN DATEPART(dw, PROGRESS.PDATE) = 2 THEN '�������'
           WHEN DATEPART(dw, PROGRESS.PDATE) = 3 THEN '�����'
           WHEN DATEPART(dw, PROGRESS.PDATE) = 4 THEN '�������'
           WHEN DATEPART(dw, PROGRESS.PDATE) = 5 THEN '�������'
           WHEN DATEPART(dw, PROGRESS.PDATE) = 6 THEN '�������'
           WHEN DATEPART(dw, PROGRESS.PDATE) = 7 THEN '�����������'
       END AS '���� ������'
FROM GROUPS
INNER JOIN STUDENT ON STUDENT.IDGROUP = GROUPS.IDGROUP
INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
WHERE GROUPS.IDGROUP = @groupNumber;
-----------5-------------
declare @note int = (select NOTE from PROGRESS where IDSTUDENT='1005')
if @note>10
begin
select PROGRESS.SUBJECT ,PROGRESS.NOTE,PROGRESS.IDSTUDENT
from PROGRESS
end
else 
begin
select @note '������'
end

-----------6------------- 
select case when NOTE BETWEEN 8 AND 10 then '8-10'
					  when NOTE BETWEEN 6 AND 7 then '6-7'
					  when NOTE BETWEEN 4 AND 5 then '4-5'
					  ELSE '-'
					  END [������], COUNT(*) [����������]
	from PROGRESS GROUP BY case
		when NOTE BETWEEN 8 AND 10 then '8-10'
		when NOTE BETWEEN 6 AND 7 then '6-7'
		when NOTE BETWEEN 4 AND 5 then '4-5' 
		ELSE '-'
		END 

-----------7------------- 
create table #temporarytable32
(
tname varchar(10),
tnote int,
age int
)
declare @i int=0
while @i<10
begin
insert #temporarytable32(tname,tnote,age)
values ('Kate', floor(10*rand()), 19)
set @i=@i+1;
end


select * from #temporarytable32

-----------8------------- 
declare @xx int=1
print @xx+1
print @xx+2
return
print @xx+9

-----------9------------- 
use UNIVER
begin try
update dbo.GROUPS set YEAR_FIRST = 'year' where YEAR_FIRST = 2013
end try
begin catch
print error_number()
print ERROR_MESSAGE()
print ERROR_LINE()
print ERROR_PROCEDURE()
print ERROR_SEVERITY()
print ERROR_STATE()
end catch