use tempdb;
create table #EX5
(
	TKEY int, 
    ID int identity(1, 1),
    TF varchar(100)
);

set nocount on;
declare @iter int = 0;
while @iter < 15000
begin
	INSERT #EX5(TKEY, TF) values(floor(30000 * RAND()), replicate('строка ', 10));
	set @iter += 1;
end

create index #EX5_TKEY on #EX5(TKEY)

SELECT NAME [Индекс], AVG_FRAGMENTATION_IN_PERCENT [Фрагментация (%)]
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5'), NULL, NULL, NULL) SS
JOIN SYS.INDEXES II ON SS.OBJECT_ID = II.OBJECT_ID
AND SS.INDEX_ID = II.INDEX_ID WHERE NAME IS NOT NULL;

INSERT top(10000) #EX5(TKEY, TF) select TKEY, TF from #EX5;

-- фрагментация индекса равна 70%
SELECT NAME [Индекс], AVG_FRAGMENTATION_IN_PERCENT [Фрагментация (%)]
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5'), NULL, NULL, NULL) SS
JOIN SYS.INDEXES II ON SS.OBJECT_ID = II.OBJECT_ID
AND SS.INDEX_ID = II.INDEX_ID WHERE NAME IS NOT NULL;

-- реорганизация даст фрагментацию 0%
alter index #EX5_TKEY on #EX5 reorganize

-- перестройка же дает фрагментацию 0%
alter index  #EX5_TKEY on #EX5 rebuild with (online = off)

drop index #EX5_TKEY on #EX5

----------  Задание 6

create index #EX5_TKEY on #EX5(TKEY) with (fillfactor = 65)

set nocount on
declare @I int = 0
while @I < 15000
begin
	insert #EX5(TKEY, TF) 
	values (floor(30000 * rand()), replicate ('строка ', 10))
	set @I += 1
end

SELECT NAME [Индекс], AVG_FRAGMENTATION_IN_PERCENT [Фрагментация (%)]
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5'), NULL, NULL, NULL) SS
JOIN SYS.INDEXES II ON SS.OBJECT_ID = II.OBJECT_ID
AND SS.INDEX_ID = II.INDEX_ID WHERE NAME IS NOT NULL;

drop index #EX5_TKEY on #EX5
drop table #EX5

