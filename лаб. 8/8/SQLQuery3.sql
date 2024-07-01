-----------1--------------
go
CREATE VIEW [Преподаватель]
as select TEACHER [код],
TEACHER_NAME[имя преподавателя],
GENDER[пол],
PULPIT[код кафедры]
from TEACHER
go
select * from [Преподаватель]

-----------2--------------
go
CREATE VIEW[Количество кафедр]
AS SELECT FACULTY.FACULTY_NAME[факультет],
COUNT(*)[Количество кафедр] 
	FROM PULPIT join FACULTY 
	on PULPIT.FACULTY=FACULTY.FACULTY
	group by FACULTY.FACULTY_NAME
go
select * from [Количество кафедр]

-----------3--------------
go
CREATE VIEW [Аудитории2]
AS SELECT AUDITORIUM[код],
AUDITORIUM.AUDITORIUM_TYPE[наименование аудитории]
FROM AUDITORIUM 
WHERE AUDITORIUM.AUDITORIUM_TYPE like N'ЛК%'
go
select * from [Аудитории2]

insert Аудитории2 values ('291-4','ЛК');
-----------4--------------
go
CREATE VIEW[Лекционные_аудитории]
AS SELECT AUDITORIUM[код],
AUDITORIUM.AUDITORIUM_TYPE[наименование аудитории]
FROM AUDITORIUM 
WHERE AUDITORIUM.AUDITORIUM_TYPE like N'ЛК%' WITH CHECK OPTION
GO 
insert [Лекционные_аудитории] values ('211-1','rЛК-К')

select * from [Лекционные_аудитории]

-----------5--------------
go
CREATE VIEW[Дисциплины]
as select top 9 SUBJECT[код],SUBJECT_NAME[наименование дисциплины ],PULPIT[PULPIT]
from SUBJECT order by [наименование дисциплины ]
go
select * from [Дисциплины]

-----------6--------------
go
CREATE VIEW[Количество кафедр с запрещением] with SCHEMABINDING
AS SELECT f.FACULTY_NAME[факультет],
COUNT(*)[Количество кафедр с запрещением] 
	FROM dbo.PULPIT p join dbo.FACULTY f
	on p.FACULTY=f.FACULTY
	group by f.FACULTY_NAME
go
select * from [Количество кафедр с запрещением]












UPDATE [Количество кафедр с запрещением] SET [факультет] = 'W'
Delete [Количество кафедр]