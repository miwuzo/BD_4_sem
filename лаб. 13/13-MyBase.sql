------------------------1
use Che_MyBase
go

Create procedure PpSUBJECT
As 
Begin
Declare @k int = ( select count(*) from ������������);
select [�������� ������������], [���� �����������] from ������������;
return @k; 
end;
go

Declare @k int = 0;
EXEC @k = PpSUBJECT;
Print '���������� ����� � �������������� ������ -------- ' +cast(@k as varchar(300));
go

drop Procedure PpSUBJECT


------------------------2 
-- UNIVER - Programmability - Stored...

Alter Procedure PpSUBJECT @p varchar(20), @c int output
As Begin

Declare @k int = (Select count(*) From ������������);
print '���������: @p = ' + @p + ',@c = ' + cast(@c as varchar(300));
select [�������� ������������], [���� �����������] from ������������ Where [�������� ������������] = @p;
Set @c = @@ROWCOUNT;
return @k;

end;

Declare @k int = 0, @p nvarchar(30), @r int = 0; 
Exec @k = PpSUBJECT   @p = N'����', @c = @r output;
print N'����� ���������� ��������� = ' + convert(nvarchar(3),@k);
print N'���������� ��������� ����������� ������� = ' + convert(nvarchar(3),@r);


------------------------3
alter procedure PpSUBJECT @p varchar(20)
as begin

declare @k int = (select count(*) from ������������);
select * from ������������ where [�������� ������������] = @p;

end;

Create table #SUB001
(
SUBJECT_NAME varchar(100),
SUBJECT_TYPE varchar(100),
DATAA date, 
KOLICH int,
PODRAZDELENIE varchar(100)
);

Insert #SUB001 EXEC PpSUBJECT @p = '����';
Select * from #SUB001


------------------------4
Create Procedure PpAUDITORIUM_INSERT
@a char(20), @n varchar(50),@u date, @c int, @t char(10)
As Begin 
try
Insert into ������������([�������� ������������], [��� ������������], [���� �����������], ����������, [������������� ���������])
values (@a, @n, @u, @c, @t)
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
Exec @rc = PpAUDITORIUM_INSERT @a = '�������������', @n = '���1', @u = '2000-01-01', @c = 75, @t = 'fvgrjn';
print '��� ������: ' + cast(@rc as varchar(3));
Select * From ������������;

------------------------5


Create Procedure pSUBJECT_REPORT @p char(10)
As
Declare @rc int = 0;
Declare @sub char(20), @allsub char(300) = '';
Declare zkSubject Cursor Global Dynamic 
For Select ���������� From ������������ Where [�������� ������������] = @p;
If not exists (Select ���������� From ������������ Where [�������� ������������] = @p)
Raiserror('������', 11, 1);
Else
Begin try
Open zkSubject;
   Fetch zkSubject into @sub;
   Print '��������';
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
   print '���: ' + error_procedure();
 return @rc;
End catch;

Declare @rc1 int;
Exec @rc1 = pSUBJECT_REPORT @p = '����';
print '����������: ' + cast(@rc1 as varchar(3));
deallocate zkSubject;

Drop Procedure pSUBJECT_REPORT;


------------------------6

create procedure PpAUDITORIUM_INSERTX  @a char(20), @n varchar(50),@u date, @c int, @t char(10), @d date, @t1 char(10), @t22 char(10), @t3 char(10), @t4 date
as                                            
declare 
@rc int = 1;
begin try
set transaction isolation level SERIALIZABLE
begin tran
insert into �������������([������� ��������������], ���, ��������, ���������, [���� ������ �� ������] )
VALUES (@t, @t1, @t22, @t3, @t4)
exec @rc = PpAUDITORIUM_INSERT @a, @n, @u, @c, @t;
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
exec @rc2 = PpAUDITORIUM_INSERTX  @a = '1�������������', @n = '���1', @u = '2000-01-01', @c = 75, @t = 'fvgrjn1', @d = '2000-01-01', @t1 = 'fvgrjn1',@t22 = 'fvgrjn1',@t3 = 'fvgrjn1', @t4 = '2000-02-02';
print N'��� ������: ' + CAST(@rc2 as varchar(3));


drop Procedure PpAUDITORIUM_INSERTX