-----------1--------------
go
CREATE VIEW [�������������]
as select TEACHER [���],
TEACHER_NAME[��� �������������],
GENDER[���],
PULPIT[��� �������]
from TEACHER
go
select * from [�������������]

-----------2--------------
go
CREATE VIEW[���������� ������]
AS SELECT FACULTY.FACULTY_NAME[���������],
COUNT(*)[���������� ������] 
	FROM PULPIT join FACULTY 
	on PULPIT.FACULTY=FACULTY.FACULTY
	group by FACULTY.FACULTY_NAME
go
select * from [���������� ������]

-----------3--------------
go
CREATE VIEW [���������2]
AS SELECT AUDITORIUM[���],
AUDITORIUM.AUDITORIUM_TYPE[������������ ���������]
FROM AUDITORIUM 
WHERE AUDITORIUM.AUDITORIUM_TYPE like N'��%'
go
select * from [���������2]

insert ���������2 values ('291-4','��');
-----------4--------------
go
CREATE VIEW[����������_���������]
AS SELECT AUDITORIUM[���],
AUDITORIUM.AUDITORIUM_TYPE[������������ ���������]
FROM AUDITORIUM 
WHERE AUDITORIUM.AUDITORIUM_TYPE like N'��%' WITH CHECK OPTION
GO 
insert [����������_���������] values ('211-1','r��-�')

select * from [����������_���������]

-----------5--------------
go
CREATE VIEW[����������]
as select top 9 SUBJECT[���],SUBJECT_NAME[������������ ���������� ],PULPIT[PULPIT]
from SUBJECT order by [������������ ���������� ]
go
select * from [����������]

-----------6--------------
go
CREATE VIEW[���������� ������ � �����������] with SCHEMABINDING
AS SELECT f.FACULTY_NAME[���������],
COUNT(*)[���������� ������ � �����������] 
	FROM dbo.PULPIT p join dbo.FACULTY f
	on p.FACULTY=f.FACULTY
	group by f.FACULTY_NAME
go
select * from [���������� ������ � �����������]












UPDATE [���������� ������ � �����������] SET [���������] = 'W'
Delete [���������� ������]