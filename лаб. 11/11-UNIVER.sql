----------1-----------
use univer


declare Sub CURSOR for SELECT SUBJECT from SUBJECT
							where SUBJECT.PULPIT like '%����%';
							declare @tv char(20), @t char(300)='';
open Sub;
FETCH Sub into @tv;
print '������� �������� ���������:';
while @@fetch_status = 0
	begin 
	set @t = rtrim(@tv)+',' + @t; 
	FETCH Sub into @tv;
	end;
    print @t;
close Sub;

----------2-----------
use univer
--local
declare Faculty1 cursor local for select FACULTY.FACULTY, FACULTY_NAME from FACULTY;
declare @faculty char(3), @name char(50);
open Faculty1;
   fetch Faculty1 into @faculty, @name
   print '1.'+@faculty+ '- '+ @name;
go 
declare Faculty1 cursor local for select FACULTY.FACULTY, FACULTY_NAME from FACULTY;
open Faculty1;
  declare @faculty char(5), @name char(30);
  fetch Faculty1 into @faculty, @name
  print '2.'+@faculty+ '- '+ @name;


--global
declare Faculty cursor global 
for select FACULTY.FACULTY, FACULTY_NAME from FACULTY
declare @faculty char(3), @name char(50);
open Faculty;
     fetch Faculty into @faculty, @name
     print '1.'+@faculty+ '- '+ @name;
     go
declare @faculty char(3), @name char(50);
     fetch Faculty into @faculty, @name
     print '2.'+@faculty+ ' - '+ @name;
close Faculty;
deallocate Faculty;

----------3-----------
--STATIC  
DECLARE @PUL CHAR(10), @GEN CHAR(2), @NAME CHAR(30);
DECLARE TEACHERS CURSOR LOCAL STATIC FOR SELECT PULPIT,
GENDER, TEACHER_NAME FROM TEACHER WHERE PULPIT='����';
OPEN TEACHERS
      PRINT '���������� �����: '+CAST(@@CURSOR_ROWS AS VARCHAR(5));
      
      INSERT INTO TEACHER  (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
      VALUES ('���','�� ������ ��111��', '�', '����');
      
      FETCH TEACHERS INTO @PUL, @GEN, @NAME;
      WHILE @@FETCH_STATUS=0
      BEGIN
      PRINT @PUL+' '+@GEN+' '+@NAME;
      FETCH TEACHERS INTO @PUL, @GEN, @NAME;
      END 
CLOSE TEACHERS
DELETE TEACHER WHERE TEACHER = '���';


   --DYNAMIC             
   
DECLARE @PUL1 CHAR(10), @GEN1 CHAR(2), @NAME1 CHAR(30);
DECLARE TEACHERS CURSOR LOCAL DYNAMIC FOR SELECT PULPIT,
GENDER, TEACHER_NAME FROM TEACHER WHERE PULPIT='����';
OPEN TEACHERS
    PRINT '���������� �����: '+CAST(@@CURSOR_ROWS AS VARCHAR(5));
    
    INSERT INTO TEACHER  (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
     VALUES ('���','�� ������ ����', '�', '����');
    
    FETCH TEACHERS INTO @PUL1, @GEN1, @NAME1;
    WHILE @@FETCH_STATUS=0
    BEGIN
    PRINT @PUL1+' '+@GEN1+' '+@NAME1;
    FETCH TEACHERS INTO @PUL1, @GEN1, @NAME1;
  END
CLOSE TEACHERS
DELETE TEACHER WHERE TEACHER = '���';

----------4-----------

DECLARE @tc int = 0, @fk nchar(10), @fk_full nchar(55);
declare PRIMER1 cursor local dynamic SCROLL
for 
select ROW_NUMBER() over (order by FACULTY) N,
FACULTY.FACULTY, FACULTY.FACULTY_NAME
FROM FACULTY;
OPEN PRIMER1;
FETCH last from PRIMER1 into @tc, @fk, @fk_full;
print N'��������� ������ : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH first from PRIMER1 into @tc, @fk, @fk_full;
print N'������ ������ : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH next from PRIMER1 into @tc, @fk, @fk_full;
print N'��������� ������ : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH prior from PRIMER1 into @tc, @fk, @fk_full;
print N'���������� ������ : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH ABSOLUTE 4 from PRIMER1 into @tc, @fk, @fk_full;
print N'��������� ������ : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH absolute -4 from PRIMER1 into @tc, @fk, @fk_full;
print N'��������� ������ � ����� : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH relative 2 from PRIMER1 into @tc, @fk, @fk_full;
print N'������ ������ ������ �� �������: ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH relative -2 from PRIMER1 into @tc, @fk, @fk_full;
print N'������ ������ ����� �� �������: ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
   
----------5-----------
DECLARE @aud nvarchar(10), @a_type nvarchar(10), @cap int;
DECLARE CurA CURSOR local DYNAMIC 
							FOR SELECT a.AUDITORIUM, a.AUDITORIUM_TYPE, a.AUDITORIUM_CAPACITY FROM AUDITORIUM a FOR UPDATE;
OPEN CurA;
	FETCH CurA INTO @aud, @a_type, @cap;
	PRINT 'Selected row for update: ' + rtrim(@aud) + ', ' + rtrim(@a_type) + ', ' + convert(nvarchar(5), @cap) + '.';
	UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = AUDITORIUM_CAPACITY + 1 WHERE CURRENT OF CurA;
	select AUDITORIUM_CAPACITY from AUDITORIUM;
	FETCH CurA INTO @aud, @a_type, @cap;
	PRINT 'Selected row for delete: ' + rtrim(@aud) + ', ' + rtrim(@a_type) + ', ' + convert(nvarchar(5), @cap) + '.';
	DELETE AUDITORIUM WHERE CURRENT OF CurA;
CLOSE CurA;
DEALLOCATE CurA;
   
----------6-----------
--1
DECLARE @NOTE INT, @NAME NVARCHAR(50), @FACULTY NVARCHAR(20);
DECLARE BAD1 CURSOR DYNAMIC GLOBAL FOR
SELECT PROGRESS.NOTE, STUDENT.NAME, GROUPS.FACULTY
FROM PROGRESS 
INNER JOIN STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
INNER JOIN GROUPS ON STUDENT.IDGROUP = GROUPS.IDGROUP
OPEN BAD1
      FETCH BAD1 INTO @NOTE, @NAME, @FACULTY
      WHILE @@FETCH_STATUS = 0
      BEGIN
      PRINT '������ ' + CAST(@NOTE AS NVARCHAR(10)) + ' - ' + @NAME + ' - ' + @FACULTY
      FETCH BAD1 INTO @NOTE, @NAME, @FACULTY

IF @NOTE <5
DELETE PROGRESS WHERE CURRENT OF BAD1
END
CLOSE BAD1

--2

DECLARE TASK6 CURSOR GLOBAL DYNAMIC FOR SELECT SUBJECT, IDSTUDENT, NOTE
FROM PROGRESS FOR UPDATE
DECLARE @SUBJECT6 NVARCHAR(10), @IDSTUDENT6 INT, @NOTE6 INT
OPEN TASK6
      FETCH TASK6 INTO @SUBJECT6, @IDSTUDENT6, @NOTE6
      WHILE @@FETCH_STATUS = 0
      BEGIN
      PRINT @SUBJECT6 + ' ' +CAST(@IDSTUDENT6 AS NVARCHAR(10)) + ' ' + CAST(@NOTE6 AS NVARCHAR(20)) 
      IF @IDSTUDENT6 = 1006 UPDATE PROGRESS SET NOTE = NOTE + 1 WHERE CURRENT OF TASK6
      FETCH TASK6 INTO @SUBJECT6, @IDSTUDENT6, @NOTE6
      END
CLOSE TASK6
DEALLOCATE TASK6
SELECT SUBJECT[�������], IDSTUDENT[ID ��������], NOTE[������] FROM PROGRESS
GO





