-----------1--------------
select PULPIT.PULPIT_NAME, FACULTY.FACULTY
from PULPIT,FACULTY
where FACULTY.FACULTY=PULPIT.FACULTY
and FACULTY.FACULTY in (select PROFESSION.FACULTY from PROFESSION
where (PROFESSION_NAME like N'%����������%'or PROFESSION_NAME like N'%����������%' ))

-----------2--------------
select PULPIT.PULPIT_NAME, FACULTY.FACULTY
from PULPIT inner join FACULTY
on FACULTY.FACULTY=PULPIT.FACULTY
and FACULTY.FACULTY in (select PROFESSION.FACULTY from PROFESSION
where (PROFESSION_NAME like N'%����������%'or PROFESSION_NAME like N'%����������%' ))

-----------3--------------
select PULPIT.PULPIT_NAME, FACULTY.FACULTY
from PULPIT inner join FACULTY
on FACULTY.FACULTY=PULPIT.FACULTY
inner join PROFESSION
on FACULTY.FACULTY=PROFESSION.FACULTY
where (PROFESSION_NAME like N'%����������%'or PROFESSION_NAME like N'%����������%' )
-----------4--------------
select AUDITORIUM, AUDITORIUM_CAPACITY
from AUDITORIUM a
where AUDITORIUM_CAPACITY =(select top(1)AUDITORIUM_CAPACITY FROM AUDITORIUM aa 
where aa.AUDITORIUM_TYPE=a.AUDITORIUM_TYPE order by AUDITORIUM_CAPACITY desc) 
order by AUDITORIUM_CAPACITY desc
-----------5--------------
select FACULTY
from FACULTY
where not exists(select * from PULPIT
where PULPIT.FACULTY=FACULTY.FACULTY)
-----------6--------------
select top 1
(select avg(NOTE) from PROGRESS 
where SUBJECT like '%����%')[����],
(select avg(NOTE) from PROGRESS 
where SUBJECT like '%��%')[��],
(select avg(NOTE) from PROGRESS 
where SUBJECT like '%����%')[����]
from PROGRESS 
-----------7--------------
select NOTE,SUBJECT from PROGRESS
where NOTE>=all(select NOTE from PROGRESS
where SUBJECT like '%����%')
-----------8--------------
select NOTE,SUBJECT from PROGRESS
where NOTE>=any(select NOTE from PROGRESS
where SUBJECT like '%����%')