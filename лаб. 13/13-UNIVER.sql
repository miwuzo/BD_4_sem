------------------------1
use Univer
go

Create procedure PSUBJECT
As 
Begin
Declare @k int = ( select count(*) from SUBJECT);
select SUBJECT[���], SUBJECT_NAME[����������], PULPIT[�������] from SUBJECT;
return @k; 
end;
go

Declare @k int = 0;
EXEC @k = PSUBJECT;
Print '���������� ����� � �������������� ������ -------- ' +cast(@k as varchar(300));
go

drop Procedure PSUBJECT


------------------------2 
-- UNIVER - Programmability - Stored...

Alter Procedure PSUBJECT @p varchar(20), @c int output
As Begin

Declare @k int = (Select count(*) From SUBJECT);
print '���������: @p = ' + @p + ',@c = ' + cast(@c as varchar(300));
select SUBJECT[���], SUBJECT_NAME[����������], PULPIT[�������] From SUBJECT Where PULPIT = @p;
Set @c = @@ROWCOUNT;
return @k;

end;

Declare @k int = 0, @p nvarchar(30), @r int = 0; 
Exec @k = PSUBJECT   @p = N'����', @c = @r output;
print N'����� ���������� ��������� = ' + convert(nvarchar(3),@k);
print N'���������� ��������� ����������� ������� = ' + convert(nvarchar(3),@r);


------------------------3
alter procedure PSUBJECT @p varchar(20)
as begin

declare @k int = (select count(*) from subject);
select * from subject where pulpit = @p;

end;

Create table #SUB1
(
SUBJECT CHAR(10),
SUBJECT_NAME varchar(100),
PULPIT char(20)
);

Insert #SUB1 EXEC PSUBJECT @p = '����';
Select * from #SUB1


------------------------4
Create Procedure PAUDITORIUM_INSERT1
@a char(20), @n varchar(50), @c int, @t char(10)
As Begin 
try
Insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
values (@a, @n, @c, @t)
end try
Begin catch

print '����� ������: ' + cast(error_number() as varchar(6));
print '���������: ' + error_message();
print '�������: ' + cast(error_severity() as varchar(6));
print '�����: ' + cast(error_state() as varchar(8));
print '����� ������: ' + cast(error_line() as varchar(8));
If error_procedure() is not null
print '��� ���������: ' + error_procedure();
return -1;

end catch; 

Declare @rc char; 
Exec @rc = PAUDITORIUM_INSERT1 @a = '459-2', @n = '420-3', @c = 75, @t = '��-�';
print '��� ������: ' + cast(@rc as varchar(3));
Select * From AUDITORIUM;

------------------------5


Create Procedure SUBJECT_REPORT @p char(10)
As
Declare @rc int = 0;
Declare @sub char(20), @allsub char(300) = '';
Declare zkSubject Cursor Global Dynamic 
For Select SUBJECT From SUBJECT Where PULPIT = @p;
If not exists (Select SUBJECT From SUBJECT Where PULPIT = @p)
Raiserror('������', 11, 1);
Else
Begin try
Open zkSubject;
   Fetch zkSubject into @sub;
   Print '����������';
   While @@FETCH_STATUS = 0
   
   Begin
     set @allsub = rtrim(@sub) + ',' + @allsub;
     set @rc = @rc + 1;
     Fetch zkSubject into @sub;
   end;
   print @allsub;
Close zkSubject;
Return @rc;
end try
Begin catch
 print '������ � ����������'
 If error_procedure() is not null
   print '��� ���������: ' + error_procedure();
 return @rc;
End catch;

Declare @rc1 int;
Exec @rc1 = SUBJECT_REPORT @p = '����';
print '���������� ���������: ' + cast(@rc1 as varchar(3));
deallocate zkSubject;

Drop Procedure SUBJECT_REPORT;


------------------------6

create procedure PAUDITORIUM_INSERTX1 @a char(20), @n varchar(50), @c int, @t char(10), @tn nvarchar(50)
as                                            
declare 
@rc int = 1;
begin try
set transaction isolation level SERIALIZABLE
begin tran
insert into AUDITORIUM_TYPE( AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
VALUES (@t, @tn)
exec @rc = PAUDITORIUM_INSERT @a, @n, @c, @t;
commit tran;
return @rc;
end try
	begin catch
		print N'����� ������: ' + cast(error_number() as varchar(6));
		print N'���������: ' + error_message()
		print N'�������: ' + cast(error_severity() as varchar(6));
		print N'�����: ' + cast(error_state() as varchar(8));
		print N'����� ������: ' + cast(error_line() as varchar(8));
		if ERROR_PROCEDURE() is not null
		print N'��� ���������:' + error_procedure();
		if @@TRANCOUNT > 0 rollback;
		return -1;
		end catch;

		
declare @rc2 int;                   
exec @rc2 = PAUDITORIUM_INSERTX1  @a = '4-9   ', @n = '4-9 ', @c = 90, @t = '�', @tn = N'�����������';
print N'��� ������: ' + CAST(@rc2 as varchar(3));


