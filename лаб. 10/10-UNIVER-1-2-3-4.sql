------------1--------------
use UNIVER
exec SP_HELPINDEX 'AUDITORIUM'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PROGRESS'
exec sp_helpindex 'PULPIT'

CREATE table #EXPLRE1
(	TIND int,
	TFIELD varchar(20)
);

SET nocount on; 
DECLARE @i int=0
WHILE @i<1000
begin
Insert #EXPLRE1(TIND, TFIELD)
values(floor(20000*rand()),REPLICATE(N'строка', 1));
If(@i%100=0) print @i;
set @i=@i+1;
end;

SELECT * FROM #EXPLRE1 where TIND between 1500 and 2500 order by TIND 

checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш

CREATE clustered index #EXPLRE_CL on #EXPLRE1(TIND asc) -- кластеризованый класс

-------------2---------------

CREATE table #EX
(
TKEY int, 
CC int identity(1, 1),
TF varchar(100)
);

  set nocount on;           
  declare @iN int = 0;
  while   @iN < 10000   
  begin
       INSERT #EX(TKEY, TF) values(floor(30000*RAND()), replicate('строка ', 10));
        set @iN = @iN + 1; 
  end;
  SELECT * from #EX

  CREATE index #EX_NONCLU on #EX(TKEY, CC)
    SELECT * from #EX order by  TKEY, CC
	SELECT * from  #EX where  TKEY = 556 and  CC > 3

-------------3---------------
CREATE table #EX3
(
TKEY int, 
CC int identity(1, 1),
TF varchar(100)
);

  set nocount on;           
  declare @iN3 int = 0;
  while   @iN3 < 1000   
  begin
       INSERT #EX3(TKEY, TF) values(floor(30000*RAND()), replicate('строка ', 10));
        set @iN3 = @iN3 + 1; 
  end;
  SELECT * from #EX3

CREATE  index #EX_TKEY_X on #EX3(TKEY) INCLUDE (CC)
SELECT CC from #EX3 where TKEY>15000 


-------------4---------------

CREATE table #EX4
(
TKEY int, 
CC int identity(1, 1),
TF varchar(100)
);

  set nocount on;           
  declare @iN4 int = 0;
  while   @iN4 < 1000   
  begin
       INSERT #EX4(TKEY, TF) values(floor(30000*RAND()), replicate('строка ', 10));
        set @iN4 = @iN4 + 1; 
  end;
  SELECT * from #EX4

  CREATE  index #EX_WHERE on #EX4(TKEY) where (TKEY>=15000 and 
 TKEY < 20000);  
 select TKEY from #EX4 where TKEY between 5000 and 19999
 SELECT TKEY from  #EX4 where TKEY between 15000 and 17000