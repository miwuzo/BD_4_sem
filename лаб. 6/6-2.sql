----------------1-2------------------
select ������������.[��� ������������], max(����������)[����], min(����������)[���],avg(����������)[�����],sum(����������)[����],count(*)[����� �����]
from ������������ Group by [��� ������������]
-----------------3-------------------
select *
	from (select case when ���������� BETWEEN 5 AND 10 then '5-10'
					  when ���������� BETWEEN 2 AND 4 then '2-4'
					  when ���������� BETWEEN 1 AND 2 then '1-2'
					  ELSE '-'
					  END [������ ����������], COUNT(*) [����������]
	from ������������ GROUP BY case
		when ���������� BETWEEN 5 AND 10 then '5-10'
		when ���������� BETWEEN 2 AND 4 then '2-4'
		when ���������� BETWEEN 1 AND 2 then '1-2' 
		ELSE '-'
		END ) AS T
			ORDER BY [������ ����������]desc

-----------------4-------------------
select  ��������.��������, ������������.����������,
	round(avg(cast(������������.���������� as float(1))),2) as [�����] from ��������
inner join ������������ on ������������.[�������� ������������] = ��������.��������
group by ��������.��������, ������������.����������
ORDER BY [�����]desc
-----------------5-6-------------------
select  ��������.��������, ������������.����������,
	round(avg(cast(������������.���������� as float(1))),2) as [�����] from ��������
inner join ������������ on ������������.[�������� ������������] = ��������.��������
where ������������.[�������� ������������] = N'����'
group by ��������.��������, ������������.����������
ORDER BY [�����]desc

-------------7-----------------------
select [�������� ������������], count(����������)[���������� ��������� = 3 ��� 4]
	from ������������
	group by [�������� ������������], 
	���������� having ������������.���������� = 3 or ������������.���������� = 4  