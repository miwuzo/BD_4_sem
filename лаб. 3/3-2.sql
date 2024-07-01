Use master;
CREATE database Ч_MyBase;

use Ч_MyBase
CREATE table ОБОРУДОВАНИЕ(
Номер_оборудования nvarchar(20) primary key,
Название_оборудования nvarchar(20),
Тип_оборудования nvarchar(20),
Дата_поступления date,
Количество int,
Подразделение_установки nvarchar(20)
);

CREATE table ОТВЕТСТВЕННЫЙ(
Номер_ответственного nvarchar(20) primary key, 
Фамилия_ответственного nvarchar(20),
Имя nvarchar(20),
Отчество nvarchar(20),
Должность nvarchar(20),
Дата_приема_на_работу date
);

Create table СПИСАНИЯ (
Номер_списания nvarchar(20) primary key,
Списанное_оборудование nvarchar(20) foreign key references ОБОРУДОВАНИЕ(Номер_оборудования),
Причина_списания nvarchar(50),
Ответственный_сотрудник nvarchar(20) foreign key references ОТВЕТСТВЕННЫЙ(Номер_ответственного),
Дата_списания date
);

ALTER Table ОТВЕТСТВЕННЫЙ ADD Дата_рождения date;
Alter table ОТВЕТСТВЕННЫЙ ADD Пол nchar(1) default 'м' check(Пол in('м','ж'));
Alter table ОТВЕТСТВЕННЫЙ DROP Column Дата_рождения;
Alter table ОТВЕТСТВЕННЫЙ DROP Column Пол;

Insert into ОБОРУДОВАНИЕ (Номер_оборудования, Название_оборудования, Тип_оборудования, Дата_поступления, Количество, Подразделение_установки)
			Values('оборудование1', 'предмет1', 'тип1', '2001-1-1', 1,'подразделение1'),
			      ('оборудование2', 'предмет2', 'тип2', '2002-2-2', 2,'подразделение2');

Insert into ОТВЕТСТВЕННЫЙ (Номер_ответственного, Фамилия_ответственного, 
                           Имя, Отчество, Должность, Дата_приема_на_работу)
			Values('ответственный1','фамилия1','имя1','отчество1','должность1','2011-1-11'),
		          ('ответственный2','фамилия2','имя2','отчество2','должность2','2022-2-22');

Insert into СПИСАНИЯ (Номер_списания, Списанное_оборудование,
                      Причина_списания, Ответственный_сотрудник, Дата_списания)
			Values('списание1','оборудование1','причина1','ответственный1','2024-2-22'),
			      ('списание2','оборудование2','причина2','ответственный2','2024-2-22');

Select * from ОТВЕТСТВЕННЫЙ;
Select Имя, Должность from ОТВЕТСТВЕННЫЙ;
Select count(*) from ОТВЕТСТВЕННЫЙ;
UPDATE ОБОРУДОВАНИЕ set Количество=10;
Select Количество from ОБОРУДОВАНИЕ;




use master
go
create database Чe_MyBase
on primary
(name = N'Че_MyBase_mdf',filename = N'D:\BD2\Че_MyBase_mdf.mdf',
size = 10240Kb, maxsize = UNLIMITED, filegrowth = 1024Kb),
(name = N'Че_MyBase_ndf', filename = N'D:\BD2\Че_MyBase_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'Че_MyBase_fg1_1', filename = N'D:\BD2\Че_MyBase_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'Че_MyBase_fg1_2', filename = N'D:\BD2\Че_MyBase_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'Че_MyBase_fg1_3', filename = N'D:\BD2\Че_MyBase_fgq-3.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
(name = N'Че_MyBase_log', filename = N'D:\BD2\Че_MyBase_log.ldf',
size = 10240Kb, maxsize = 2048Gb, filegrowth = 10%)
go

create TABLE ОБОРУДОВАНИЕ 
          (     
            Номер_оборудования nvarchar(20) primary key,
            Название_оборудования nvarchar(20),
            Тип_оборудования nvarchar(20),
            Дата_поступления date,
            Количество int,
            Подразделение_установки nvarchar(20)                              
          ) on FG1; 
CREATE TABLE ОТВЕТСТВЕННЫЙ(
            Номер_ответственного nvarchar(20) primary key, 
            Фамилия_ответственного nvarchar(20),
            Имя nvarchar(20),
            Отчество nvarchar(20),
            Должность nvarchar(20),
            Дата_приема_на_работу date                             
          ) on FG1; 
CREATE TABLE СПИСАНИЯ (
            Номер_списания nvarchar(20) primary key,
            Списанное_оборудование nvarchar(20) foreign key references ОБОРУДОВАНИЕ(Номер_оборудования),
            Причина_списания nvarchar(50),
            Ответственный_сотрудник nvarchar(20) foreign key references ОТВЕТСТВЕННЫЙ(Номер_ответственного),
            Дата_списания date                         
          ) on FG1; 
