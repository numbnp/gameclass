use GameClass
go

declare @dtBegin datetime
declare @dtEnd datetime
set @dtBegin = '2001-01-01'
set @dtEnd = '2006-01-01'
delete from Logs where moment between @dtBegin and @dtEnd
delete from JournalOp where moment between @dtBegin and @dtEnd
delete from Sessions where started between @dtBegin and @dtEnd
delete from SessionsAdd where Start between @dtBegin and @dtEnd
delete from SessionsAdd2 where moment between @dtBegin and @dtEnd
delete from UnControl where start between @dtBegin and @dtEnd
delete from Hardware where moment between @dtBegin and @dtEnd
delete from Services where moment between @dtBegin and @dtEnd
delete from _pm_jobs where dt between @dtBegin and @dtEnd
delete from _pm_messages where dt between @dtBegin and @dtEnd
go
