-----------1--------------
go
CREATE VIEW [������������ 1]
as select  ������������.[�������� ������������]
from ������������
go
select * from [������������ 1]

-----------2--------------
go
CREATE VIEW [������������ 2]
AS
SELECT ������������.[�������� ������������], ��������.��������, ��������.[����� ��������], COUNT(*) AS [����������]
FROM ������������
JOIN �������� ON ������������.[�������� ������������] = ��������.��������
GROUP BY ������������.[�������� ������������], ��������.��������, ��������.[����� ��������]
go
select * from [������������ 2]

-----------3--------------
go
CREATE VIEW [������������ 3]
as select  ������������.[�������� ������������]
from ������������
WHERE ������������.[�������� ������������] like N'����%'
go
select * from [������������ 3]

insert [������������ 3] values ('���� ��');
select * from [������������ 3]

-----------4--------------
go
CREATE VIEW [������������ 4]
as select  ������������.[�������� ������������]
from ������������
WHERE ������������.[�������� ������������] like N'����%' WITH CHECK OPTION
GO 
insert [������������ 4] values ('211-1')

select * from [������������ 4]

-----------5--------------
go
CREATE VIEW [������������ 5]
as select top 9 ������������.[�������� ������������]
from ������������ order by [�������� ������������]
go
select * from [������������ 5]

-----------6--------------
go
CREATE VIEW [������������ 6] with SCHEMABINDING
AS
SELECT o.[�������� ������������], s.��������, s.[����� ��������], 
COUNT(*) AS [����������]
FROM dbo.������������ o JOIN dbo.�������� s ON o.[�������� ������������] = s.��������
GROUP BY o.[�������� ������������], s.��������, s.[����� ��������]
go
select * from [������������ 6]

