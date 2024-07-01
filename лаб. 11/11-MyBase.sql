----------1-----------
use Che_MyBase


declare Sub CURSOR for SELECT [�������� ������������] from ������������;
							declare @tv char(20), @t char(300)='';
open Sub;
FETCH Sub into @tv;
print '�������� ���������:';
while @@fetch_status = 0
	begin 
	set @t = rtrim(@tv)+',' + @t; 
	FETCH Sub into @tv;
	end;
    print @t;
close Sub;

----------2-----------
use Che_MyBase
--local
declare Faculty1 cursor local for select ������������.[��� ������������], [�������� ������������] from ������������;
declare @faculty char(3), @name char(50);
open Faculty1;
   fetch Faculty1 into @faculty, @name
   print '1.'+@faculty+ '- '+ @name;
go 
declare Faculty1 cursor local for select ������������.[��� ������������], [�������� ������������] from ������������;
open Faculty1;
  declare @faculty char(5), @name char(30);
  fetch Faculty1 into @faculty, @name
  print '2.'+@faculty+ '- '+ @name;


--global
declare Faculty cursor global 
for select ������������.[��� ������������], [�������� ������������] from ������������;
declare @faculty char(3), @name char(50);
open Faculty;
     fetch Faculty into @faculty, @name
     print '1.'+@faculty+ '- '+ @name;
     go
declare @faculty char(3), @name char(50);
     fetch Faculty into @faculty, @name
     print '2.'+ ' - '+ @name;
close Faculty;
deallocate Faculty;

----------3-----------
--STATIC  
DECLARE @PUL CHAR(10), @GEN CHAR(20), @NAME CHAR(30);
DECLARE TEACHERS CURSOR LOCAL STATIC FOR SELECT [�������� ������������],[������������� ���������], ������������.[��� ������������] FROM [������������];
OPEN TEACHERS
      PRINT '���������� �����: '+CAST(@@CURSOR_ROWS AS VARCHAR(5));
      
      INSERT INTO ������������ ([���� �����������], [�������� ������������],[������������� ���������], ������������.[��� ������������], ���������� )
      VALUES ('1000-01-10','����������2222', '����', '���', 100);
      
      FETCH TEACHERS INTO @PUL, @GEN, @NAME;
      WHILE @@FETCH_STATUS=0
      BEGIN
      PRINT @PUL+' '+@GEN+' '+@NAME;
      FETCH TEACHERS INTO @PUL, @GEN, @NAME;
      END 
CLOSE TEACHERS
DELETE [������������] WHERE ������������.[���� �����������] = '1000-01-01';


   --DYNAMIC             
DECLARE @PUL CHAR(10), @GEN CHAR(20), @NAME CHAR(30);
DECLARE TEACHERS CURSOR LOCAL DYNAMIC FOR SELECT [�������� ������������],[������������� ���������], ������������.[��� ������������] FROM [������������];
OPEN TEACHERS
      PRINT '���������� �����: '+CAST(@@CURSOR_ROWS AS VARCHAR(5));
      
      INSERT INTO ������������ ([���� �����������], [�������� ������������],[������������� ���������], ������������.[��� ������������], ���������� )
      VALUES ('1000-01-10','�����2', '����', '���', 100);
      
      FETCH TEACHERS INTO @PUL, @GEN, @NAME;
      WHILE @@FETCH_STATUS=0
      BEGIN
      PRINT @PUL+' '+@GEN+' '+@NAME;
      FETCH TEACHERS INTO @PUL, @GEN, @NAME;
      END 
CLOSE TEACHERS
DELETE [������������] WHERE ������������.[���� �����������] = '1000-01-01';


----------4-----------

DECLARE @tc int = 0, @fk nchar(10), @fk_full nchar(55);
declare PRIMER1 cursor local dynamic SCROLL
for 
select ROW_NUMBER() over (order by ������������.[�������� ������������]) N,������������.[�������� ������������], ������������.[������������� ���������] FROM [������������];
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
							FOR SELECT a.[�������� ������������], a.[��� ������������], a.���������� FROM ������������ a FOR UPDATE;
OPEN CurA;
	FETCH CurA INTO @aud, @a_type, @cap;
	PRINT 'Selected row for update: ' + rtrim(@aud) + ', ' + rtrim(@a_type) + ', ' + convert(nvarchar(5), @cap) + '.';
	UPDATE ������������ SET ���������� = ���������� + 1 WHERE CURRENT OF CurA;
	select ���������� from ������������;
	FETCH CurA INTO @aud, @a_type, @cap;
	PRINT 'Selected row for delete: ' + rtrim(@aud) + ', ' + rtrim(@a_type) + ', ' + convert(nvarchar(5), @cap) + '.';
	DELETE ������������ WHERE CURRENT OF CurA;
CLOSE CurA;
DEALLOCATE CurA;
   
----------6-----------
--1
DECLARE @NOTE INT, @NAME NVARCHAR(50), @FACULTY NVARCHAR(20);
DECLARE BAD CURSOR DYNAMIC GLOBAL FOR
SELECT ����������, [�������� ������������], [��� ������������]
FROM ������������
OPEN BAD
      FETCH BAD INTO @NOTE, @NAME, @FACULTY
      WHILE @@FETCH_STATUS = 0
      BEGIN
      PRINT '�����' + CAST(@NOTE AS NVARCHAR(10)) + ' - ' + @NAME + ' - ' + @FACULTY
      FETCH BAD INTO @NOTE, @NAME, @FACULTY

IF @NOTE <2
DELETE ������������ WHERE CURRENT OF BAD
END
CLOSE BAD

--2

DECLARE TASK6 CURSOR GLOBAL DYNAMIC FOR SELECT [�������� ������������], [��� ������������], ����������
FROM ������������ FOR UPDATE
DECLARE @SUBJECT6 NVARCHAR(10), @IDSTUDENT6 NVARCHAR(10), @NOTE6 INT
OPEN TASK6
      FETCH TASK6 INTO @SUBJECT6, @IDSTUDENT6, @NOTE6
      WHILE @@FETCH_STATUS = 0
      BEGIN
      PRINT @SUBJECT6 + ' ' +CAST(@IDSTUDENT6 AS NVARCHAR(10)) + ' ' + CAST(@NOTE6 AS NVARCHAR(20)) 
      IF @IDSTUDENT6 = '���1' UPDATE ������������ SET ���������� = ���������� + 1 WHERE CURRENT OF TASK6
      FETCH TASK6 INTO @SUBJECT6, @IDSTUDENT6, @NOTE6
      END
CLOSE TASK6
DEALLOCATE TASK6
SELECT [�������� ������������], [��� ������������], ���������� FROM ������������
GO





