Use master;
CREATE database �_MyBase;

use �_MyBase
CREATE table ������������(
�����_������������ nvarchar(20) primary key,
��������_������������ nvarchar(20),
���_������������ nvarchar(20),
����_����������� date,
���������� int,
�������������_��������� nvarchar(20)
);

CREATE table �������������(
�����_�������������� nvarchar(20) primary key, 
�������_�������������� nvarchar(20),
��� nvarchar(20),
�������� nvarchar(20),
��������� nvarchar(20),
����_������_��_������ date
);

Create table �������� (
�����_�������� nvarchar(20) primary key,
���������_������������ nvarchar(20) foreign key references ������������(�����_������������),
�������_�������� nvarchar(50),
�������������_��������� nvarchar(20) foreign key references �������������(�����_��������������),
����_�������� date
);

ALTER Table ������������� ADD ����_�������� date;
Alter table ������������� ADD ��� nchar(1) default '�' check(��� in('�','�'));
Alter table ������������� DROP Column ����_��������;
Alter table ������������� DROP Column ���;

Insert into ������������ (�����_������������, ��������_������������, ���_������������, ����_�����������, ����������, �������������_���������)
			Values('������������1', '�������1', '���1', '2001-1-1', 1,'�������������1'),
			      ('������������2', '�������2', '���2', '2002-2-2', 2,'�������������2');

Insert into ������������� (�����_��������������, �������_��������������, 
                           ���, ��������, ���������, ����_������_��_������)
			Values('�������������1','�������1','���1','��������1','���������1','2011-1-11'),
		          ('�������������2','�������2','���2','��������2','���������2','2022-2-22');

Insert into �������� (�����_��������, ���������_������������,
                      �������_��������, �������������_���������, ����_��������)
			Values('��������1','������������1','�������1','�������������1','2024-2-22'),
			      ('��������2','������������2','�������2','�������������2','2024-2-22');

Select * from �������������;
Select ���, ��������� from �������������;
Select count(*) from �������������;
UPDATE ������������ set ����������=10;
Select ���������� from ������������;




use master
go
create database �e_MyBase
on primary
(name = N'��_MyBase_mdf',filename = N'D:\BD2\��_MyBase_mdf.mdf',
size = 10240Kb, maxsize = UNLIMITED, filegrowth = 1024Kb),
(name = N'��_MyBase_ndf', filename = N'D:\BD2\��_MyBase_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'��_MyBase_fg1_1', filename = N'D:\BD2\��_MyBase_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'��_MyBase_fg1_2', filename = N'D:\BD2\��_MyBase_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'��_MyBase_fg1_3', filename = N'D:\BD2\��_MyBase_fgq-3.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
(name = N'��_MyBase_log', filename = N'D:\BD2\��_MyBase_log.ldf',
size = 10240Kb, maxsize = 2048Gb, filegrowth = 10%)
go

create TABLE ������������ 
          (     
            �����_������������ nvarchar(20) primary key,
            ��������_������������ nvarchar(20),
            ���_������������ nvarchar(20),
            ����_����������� date,
            ���������� int,
            �������������_��������� nvarchar(20)                              
          ) on FG1; 
CREATE TABLE �������������(
            �����_�������������� nvarchar(20) primary key, 
            �������_�������������� nvarchar(20),
            ��� nvarchar(20),
            �������� nvarchar(20),
            ��������� nvarchar(20),
            ����_������_��_������ date                             
          ) on FG1; 
CREATE TABLE �������� (
            �����_�������� nvarchar(20) primary key,
            ���������_������������ nvarchar(20) foreign key references ������������(�����_������������),
            �������_�������� nvarchar(50),
            �������������_��������� nvarchar(20) foreign key references �������������(�����_��������������),
            ����_�������� date                         
          ) on FG1; 
