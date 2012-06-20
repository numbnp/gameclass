Use GameClass
Go

CREATE PROCEDURE UsageDateSelect

AS
BEGIN

set nocount on

declare @dtMin datetime
declare @dtMax datetime
declare @dtMoment datetime

set @dtMin = getdate()
set @dtMax = getdate()

select top 1 @dtMoment = moment from AccountsHistory order by moment asc
if @dtMoment < @dtMin set @dtMin = @dtMoment
select top 1 @dtMoment = moment from AccountsHistory order by moment desc
if @dtMoment > @dtMax set @dtMax = @dtMoment
select top 1 @dtMoment = moment from Hardware order by moment asc
if @dtMoment < @dtMin set @dtMin = @dtMoment
select top 1 @dtMoment = moment from Hardware order by moment desc
if @dtMoment > @dtMax set @dtMax = @dtMoment
select top 1 @dtMoment = moment from JournalOp order by moment asc
if @dtMoment < @dtMin set @dtMin = @dtMoment
select top 1 @dtMoment = moment from JournalOp order by moment desc
if @dtMoment > @dtMax set @dtMax = @dtMoment
select top 1 @dtMoment = moment from SessionsAdd2 order by moment asc
if @dtMoment < @dtMin set @dtMin = @dtMoment
select top 1 @dtMoment = moment from SessionsAdd2 order by moment desc
if @dtMoment > @dtMax set @dtMax = @dtMoment

select @dtMin as dateMin, @dtMax as dateMax
END
GO

GRANT  EXECUTE  ON [dbo].[UsageDateSelect]  TO [public]
GO

update Registry set [value]=N'3.79' where [key]=N'BaseVersion'
GO
