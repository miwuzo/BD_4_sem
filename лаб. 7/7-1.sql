use UNIVER
-------------1---------------
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by rollup (PROGRESS.SUBJECT, GROUPS.PROFESSION)

-------------2---------------
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by cube (PROGRESS.SUBJECT, GROUPS.PROFESSION)

-------------3---------------
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
union
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
                        ---
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
union all
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION

-------------4---------------
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
INTERSECT
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION


-------------5---------------
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
EXCEPT 
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
