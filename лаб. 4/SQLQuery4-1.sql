select ������������.��������_������������, ������������.����_�����������, ��������.����_��������
from ������������ inner join ��������
on ������������.�����_������������ = ��������.���������_������������


select ������������.��������_������������, ������������.����_�����������, ��������.����_��������
from ������������ inner join ��������
on ������������.�����_������������ = ��������.���������_������������ and
   ������������.�����_������������ like '%1%'


select ������������.��������_������������, ������������.����_�����������, ��������.����_��������
from ������������, ��������
Where ������������.�����_������������ = ��������.���������_������������


select A1.��������_������������, A1.����_�����������, A2.����_��������
from ������������ as A1, �������� as A2
Where A1.�����_������������ = A2.���������_������������


select ������������.��������_������������, ��������.����_��������,
case
when (������������.���������� between 0 and 2) then '���������� ����� 2'
when (������������.���������� between 2 and 10) then '���������� �� 2 �� 10'
else '���������� ������ 10'
end �������_���������
from ������������ inner join ��������
on ������������.�����_������������ = ��������.���������_������������
                order by ��������.���������_������������



select isnull(��������.���������_������������, '**')[��������_�����������], ������������.����_�����������
from ������������ left outer join ��������
on ������������.�����_������������ = ��������.���������_������������


select *from �������� at FULL OUTER JOIN ������������ aa
        on aa.�����_������������ = at.���������_������������
		order by aa.�����_������������, at.���������_������������
		

select count(*) from �������� at FULL OUTER JOIN ������������ aa
       on aa.�����_������������ = at.���������_������������
	   where ���������� is NULL


select ������������.��������_������������, ������������.����_�����������, ��������.����_��������
from ������������ cross join ��������
where ������������.�����_������������ = ��������.���������_������������