use tempdb
use Che_MyBase
/* 1 */
exec sp_helpindex 'ОБОРУДОВАНИЕ'
exec sp_helpindex 'СПИСАНИЯ'
exec sp_helpindex 'ОТВЕТСТВЕННЫЙ' 

CREATE INDEX #indeх1 on ОБОРУДОВАНИЕ(Количество asc);
DROP INDEX #index1 on ОБОРУДОВАНИЕ
--
SELECT * FROM ОБОРУДОВАНИЕ where Количество between 1 and 20 order by Количество;
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* 2 */
CREATE INDEX #index2 on ОБОРУДОВАНИЕ(Количество, [Название оборудования]);
--DROP INDEX #index2 on Выдача_кредитов
--
SELECT * FROM ОБОРУДОВАНИЕ where Количество between 1 and 20 order by Количество;
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* 3 */
CREATE INDEX #index3 on ОБОРУДОВАНИЕ(Количество) INCLUDE([Название оборудования])
--DROP INDEX #index3 on Выдача_кредитов
--
SELECT * FROM ОБОРУДОВАНИЕ where Количество between 1 and 20 order by Количество;
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* 4 */
CREATE INDEX #index4 on ОБОРУДОВАНИЕ(Количество) where(Количество >= 1 and Количество <= 20)
--DROP INDEX #index4 on Выдача_кредитов
--
SELECT * FROM ОБОРУДОВАНИЕ where Количество between 150 and 2000 order by Количество;
checkpoint;  
DBCC DROPCLEANBUFFERS;