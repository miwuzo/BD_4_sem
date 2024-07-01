----------------1-2------------------
select AUDITORIUM.AUDITORIUM_TYPE, max(AUDITORIUM_CAPACITY)[����], min(AUDITORIUM_CAPACITY)[���],avg(AUDITORIUM_CAPACITY)[�����],sum(AUDITORIUM_CAPACITY)[����],count(*)[����� �����]
from AUDITORIUM Group by AUDITORIUM_TYPE
-----------------3-------------------
use UNIVER
select *
	from (select case when NOTE BETWEEN 8 AND 10 then '8-10'
					  when NOTE BETWEEN 6 AND 7 then '6-7'
					  when NOTE BETWEEN 4 AND 5 then '4-5'
					  ELSE '-'
					  END [������], COUNT(*) [����������]
	from PROGRESS GROUP BY case
		when NOTE BETWEEN 8 AND 10 then '8-10'
		when NOTE BETWEEN 6 AND 7 then '6-7'
		when NOTE BETWEEN 4 AND 5 then '4-5' 
		ELSE '-'
		END ) AS T
			ORDER BY [������]desc

-----------------4-------------------
select  GROUPS.FACULTY, GROUPS.PROFESSION, GROUPS.IDGROUP,
	round(avg(cast(PROGRESS.NOTE as float(1))),2) as [�����] from FACULTY
inner join GROUPS on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
group by GROUPS.FACULTY, GROUPS.PROFESSION, GROUPS.IDGROUP
ORDER BY [�����]desc
-----------------5-------------------
select  GROUPS.FACULTY, GROUPS.PROFESSION, GROUPS.IDGROUP,
round(avg(cast(PROGRESS.NOTE as float(4))),2) as [�����] from FACULTY
inner join GROUPS on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where PROGRESS.SUBJECT = N'��' or PROGRESS.SUBJECT = N'����'
group by GROUPS.FACULTY, GROUPS.PROFESSION, GROUPS.IDGROUP
ORDER BY [�����]desc
-----------------6-------------------
select  GROUPS.FACULTY, GROUPS.PROFESSION, GROUPS.IDGROUP,
round(avg(cast(PROGRESS.NOTE as float(1))),2) as [avg_note] 
from FACULTY
inner join GROUPS on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where FACULTY.FACULTY = N'����'
group by GROUPS.FACULTY, GROUPS.PROFESSION, GROUPS.IDGROUP

-----------------7-------------------
select SUBJECT, count(NOTE)[���������� ������]
	from PROGRESS
	group by SUBJECT, 
	NOTE having PROGRESS.NOTE = 8 or PROGRESS.NOTE = 9  