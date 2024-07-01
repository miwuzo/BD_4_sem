------------1-------------
create function COUNT_STUDENTS( @faculty varchar(20) ) returns int
as begin declare @rc int = 0;
set @rc = (Select count(*)
From FACULTY Inner Join GROUPS
On FACULTY.FACULTY = GROUPS.FACULTY 
Inner Join STUDENT
On GROUPS.IDGROUP = STUDENT.IDGROUP
Where FACULTY.FACULTY = @faculty);
return @rc
end;
go

declare  @faculty int = dbo.COUNT_STUDENTS('ТОВ');
print 'Кол-во студентов= ' + cast(@faculty as varchar(4));
select  dbo.COUNT_STUDENTS('ТОВ')
select FACULTY.FACULTY, dbo.COUNT_STUDENTS(FACULTY.FACULTY) from FACULTY
go


alter function COUNT_STUDENTS( @faculty varchar(20), @prof varchar(20) = null) returns int
as begin declare @rc int = 0;
set @rc = (select count(*) from STUDENT inner join GROUPS
on STUDENT.IDGROUP = GROUPS.IDGROUP inner join FACULTY
on GROUPS.FACULTY = FACULTY.FACULTY
where FACULTY.FACULTY = @faculty and GROUPS.PROFESSION = @prof);
return @rc
end;
go

select  dbo.COUNT_STUDENTS('ТОВ','1-48 01 05')
select FACULTY.FACULTY,GROUPS.PROFESSION from FACULTY join  GROUPS on GROUPS.FACULTY = FACULTY.FACULTY
 go

 DROP function COUNT_STUDENTS
------------2-------------

create function FSUBJECTS1 (@p VARCHAR(20))
returns VARCHAR(300)
as begin 
declare  @s char(20);
declare @a varchar(300) = 'Дисциплины: ';
declare CSUBJECTS cursor local
for select S.SUBJECT from SUBJECT S  where S.PULPIT = @p;
open CSUBJECTS;
fetch CSUBJECTS into @s;
while @@FETCH_STATUS = 0
begin set @a = @a  + RTRIM(@s)+ ',';
fetch CSUBJECTS into @s;
end;
return @a;
end;
go

select PULPIT,dbo.FSUBJECTS1(PULPIT) from PULPIT 
go

------------3-------------

create function FFACPUL(@facult varchar(20), @pulp varchar(30)) returns table 
as
return 
select f.FACULTY, p.PULPIT from FACULTY f
inner join PULPIT p on f.FACULTY= p.FACULTY 
where f.FACULTY = isnull(@facult,f.FACULTY)
and p.PULPIT = isnull(@pulp, p.PULPIT);

go
select * from dbo.FFACPUL(null, null)
select * from dbo.FFACPUL('ИТ', null)
select * from dbo.FFACPUL(null, 'ЛВ')
select * from dbo.FFACPUL('ЛХФ', 'ЛВ')


go

---------------4-----------------

create function FCTEACHER(@pulp as varchar(20)) returns int
as
begin
declare @c int =  (select count(*) from TEACHER 
inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT where TEACHER.PULPIT = isnull(@pulp,TEACHER.PULPIT))
return @c
end
go


select PULPIT.PULPIT, dbo.FCTEACHER(PULPIT)[Кол-во преподователей] from PULPIT
select dbo.FCTEACHER(null)[Всего преподователей]

---------------6----------------

drop function FACULTY_REPORT;
go
create function COUNT_PULPIT(@faculty nvarchar(20)) returns int as
begin
declare @count int;
set @count = (select count(*) from PULPIT where FACULTY = @faculty);
return @count;
end;

go
CREATE function COUNT_GROUPS(@faculty nvarchar(20)) returns int as
begin
declare @count int;
set @count = (select count(*) from GROUPS where FACULTY = @faculty);
return @count;
end;

go
CREATE function COUNT_PROFESSION(@faculty nvarchar(20)) returns int as
begin
	declare @count int;
	set @count = (select count(*) from GROUPS where FACULTY = @faculty);
	return @count;
end;
go


CREATE function FACULTY_REPORTS(@c int) returns @fr table
([Факультет] nvarchar(50), [Кол-во кафедр] int, [Кол-во групп] int, [Кол-во судентов] int, [Кол-во специальностей] int)
as begin
	declare cc cursor static for
	select FACULTY from FACULTY where dbo.COUNT_STUDENTS(FACULTY) > @c; ---ИЗ ПЕРВОГО ЗАДАНИЯ

	declare @f nvarchar(30);
	
	open cc;
	fetch cc into @f;
	while @@FETCH_STATUS = 0
	begIN
		insert @fr values (@f, dbo.COUNT_PULPIT(@f),dbo.COUNT_GROUPS(@f), dbo.COUNT_STUDENTS(@f),
		dbo.COUNT_PROFESSION(@f));
		fetch cc into @f;
	end;
	return;
end;
go
select * from dbo.FACULTY_REPORTS(0);

go