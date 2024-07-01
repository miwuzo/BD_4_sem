USE [UNIVER]
GO

/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 14.04.2024 01:07:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER procedure [dbo].[PSUBJECT] @p varchar(20), @c int output
As 
Begin
Declare @k int = ( select count(*) from SUBJECT);
print 'параметры: @p = ' + @p + ',@c = ' + cast(@c as varchar(300));
select SUBJECT[Код], SUBJECT_NAME[Дисциплина], PULPIT[Кафедра] From SUBJECT Where PULPIT = @p;
Set @c = @@ROWCOUNT;
return @k;
end;
GO
