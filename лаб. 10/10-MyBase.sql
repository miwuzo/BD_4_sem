use tempdb
use Che_MyBase
/* 1 */
exec sp_helpindex '������������'
exec sp_helpindex '��������'
exec sp_helpindex '�������������' 

CREATE INDEX #inde�1 on ������������(���������� asc);
DROP INDEX #index1 on ������������
--
SELECT * FROM ������������ where ���������� between 1 and 20 order by ����������;
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* 2 */
CREATE INDEX #index2 on ������������(����������, [�������� ������������]);
--DROP INDEX #index2 on ������_��������
--
SELECT * FROM ������������ where ���������� between 1 and 20 order by ����������;
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* 3 */
CREATE INDEX #index3 on ������������(����������) INCLUDE([�������� ������������])
--DROP INDEX #index3 on ������_��������
--
SELECT * FROM ������������ where ���������� between 1 and 20 order by ����������;
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* 4 */
CREATE INDEX #index4 on ������������(����������) where(���������� >= 1 and ���������� <= 20)
--DROP INDEX #index4 on ������_��������
--
SELECT * FROM ������������ where ���������� between 150 and 2000 order by ����������;
checkpoint;  
DBCC DROPCLEANBUFFERS;