Use GameClass
Go

delete from CustomReports WHERE [id]=N'{A2D71DA5-35B9-43AD-A829-A765E0927F90}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F90}',N'Главный отчет',N'Отчет отображает итоговые суммы
---
Author: GameClass Software
support@gameclass.ru',N'set nocount on  
declare @sum money  
declare @dopsumma money  
declare @repair int  
declare @uncontrol int  
declare @uncontrolClub int  
declare @AccountsAdded money 
declare @AccountsReturned money 
declare @AccountsPayed money 
set @sum=0
set @repair=0
set @uncontrol=0
set @uncontrolClub=0
set @dopsumma=0
select @sum=sum(summa) from repDetails where (moment>=%TIME-START%) and (moment<=%TIME-STOP%) and idClients=0
select @repair=sum(length) from repRepair where (moment>=%TIME-START%) and (moment<=%TIME-STOP%)
select @uncontrol=sum(length)  from repUncontrol where (repUncontrol.start>=%TIME-START%) and (repUncontrol.stop<=%TIME-STOP%) 
select @uncontrolClub=sum(length) from repUncontrolClub where (repUncontrolClub.start>=%TIME-START%) and  (repUncontrolClub.stop<=%TIME-STOP%) 
select @dopsumma = sum(count*price) from [repServices] 
where (repServices.moment between %TIME-START% and %TIME-STOP%)

set @sum=isnull(@sum,0)  
set @repair=isnull(@repair,0)  
set @uncontrol=isnull(@uncontrol,0)  
set @uncontrolClub=isnull(@uncontrolClub,0)  
set @dopsumma=isnull(@dopsumma,0)

select @AccountsAdded= ISNULL(Sum(AH.summa),0) from AccountsHistory as AH 
 inner join users on (users.id=AH.operator)
 inner join usersgroup on (usersgroup.id=users.idUsersGroup)
where (AH.What=0)  
 and usersgroup.name=''Staff''
and (%TIME-START%<=AH.moment) and (AH.moment<=%TIME-STOP%)
 
select @AccountsReturned=ISNULL(Sum(AH.summa),0) from AccountsHistory as AH 
 inner join users on (users.id=AH.operator)
 inner join usersgroup on (usersgroup.id=users.idUsersGroup)
where (AH.What=1)  
 and usersgroup.name=''Staff''
and (%TIME-START%<=AH.moment) and (AH.moment<=%TIME-STOP%) 

select @AccountsPayed=ISNULL(sum(summa),0) from repDetails where (moment>=%TIME-START%)  and (moment<=%TIME-STOP%) and idClients<>0

CREATE TABLE #t (  
[id] [int] IDENTITY (1, 1) NOT NULL ,  
[name] [varchar] (255) COLLATE Cyrillic_General_CI_AS NULL ,  
[result] [varchar] (255) COLLATE Cyrillic_General_CI_AS NULL   
) ON [PRIMARY]  
INSERT INTO #t (name,result) VALUES (N''Итоговая прибыль'', CAST ( @sum+@dopsumma+@AccountsAdded-@AccountsReturned AS VARCHAR(255)) )  
INSERT INTO #t (name,result) VALUES (N''- - - -'', '''')
INSERT INTO #t (name,result) VALUES (N''За оплату компьютеров'', CAST ( @sum AS VARCHAR(255)) )  
INSERT INTO #t (name,result) VALUES (N''За оплату услуг'', CAST ( @dopsumma AS VARCHAR(255)) )  
INSERT INTO #t (name,result) VALUES (N''Добавлено на счета учетных записей'', CAST ( @AccountsAdded AS VARCHAR(255)))  
INSERT INTO #t (name,result) VALUES (N''Возвращено со счетов учетных записей'', CAST ( @AccountsReturned AS VARCHAR(255)))  
INSERT INTO #t (name,result) VALUES (N''- - - -'', '''')
INSERT INTO #t (name,result) VALUES (N''Проплачено со счетов учетных записей'', CAST ( @AccountsPayed AS VARCHAR(255))) 
INSERT INTO #t (name,result) VALUES (N''Потрачено на ремонт (минут)'', @repair)  
INSERT INTO #t (name,result) VALUES (N''Не было контроля компьютеров (минут)'', @uncontrol)  
INSERT INTO #t (name,result) VALUES (N''Не был запущен GameClass (минут)'', @uncontrolClub) 
SELECT name [Описание], result [Значение] FROM #t order by [id] asc  

if object_id(''tempdb..#t'') is not null  
DROP TABLE #t
',5,0)
GO

delete from CustomReports WHERE [id]=N'{A2D71DA5-35B9-43AD-A829-A765E0927F91}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F91}',N'Детальный отчет',N'Отчет отображает все сеансы 
--- 
Author: GameClass Software 
support@gameclass.ru',N'
select 
 number as [Компьютер],
 ipaddress as [ip-Адрес],
 name as [Тариф],
 start as [Начало],
 stop as [Конец],
 moment as [Время],
 summa as [Сумма],
 length as [Минут],
 operator as [Оператор],
 description as [Комментарий],
 printed as [Напечатано],
 traffic as [Трафик],
 minpenalty as [Штраф],
 AccountName as [Учетная_запись]
from [repDetails]  
where ([moment]  >= %TIME-START%) and ([moment]<=%TIME-STOP%)',2,1)
GO

delete from CustomReports WHERE [id]=N'{A2D71DA5-35B9-43AD-A829-A765E0927F92}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F92}',N'Журнал операторов',N'Отчет показывает суммы, сданные операторами в своих сменах 
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select 
 operator as [Оператор],
 moment as [Дата],
 summa as [Сумма],
 comment as [Комментарий]
from [repJournalOp] 
where ([repJournalOp].[moment] between %TIME-START% and %TIME-STOP%)
',2,2)
GO

delete from CustomReports WHERE [id]=N'{A2D71DA5-35B9-43AD-A829-A765E0927F93}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F93}',N'Не работал GameClass',N'Отчет показывает интервали времени, в течение которых GameClass не был запущен. В эти моменты клуб не контролировался полностью 
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select 
 start as [Начало],
 stop as [Конец],
 length as [Минут] 
from [repUncontrolClub] 
where  
([repUncontrolClub].[start] >= %TIME-START%) and  
([repUncontrolClub].[stop]  <= %TIME-STOP%)
',2,3)
GO

delete from CustomReports WHERE [id]=N'{A2D71DA5-35B9-43AD-A829-A765E0927F94}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F94}',N'Не было контроля',N'Отчет показывает интервалы времени, в течение которых не было контроля клиентских компьютеров 
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select 
 number as [Компьютер],
 ipaddress as [ip-Адрес],
 start as [Начало],
 stop as [Конец],
 length as [Минут] 
from [repUncontrol] 
where  
([repUncontrol].[start] >= %TIME-START%) and  
([repUncontrol].[stop]  <= %TIME-STOP%)
',2,4)
GO

delete from CustomReports WHERE [id]=N'{A2D71DA5-35B9-43AD-A829-A765E0927F95}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F95}',N'Отчет по ремонту',N'Отчет показывает интервалы времени, во время которых был применен ремонт с длительностью более минуты 
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select
 number as [Компьютер],
 ipaddress as [ip-Адрес],
 start as [Начало],
 stop as [Конец],
 length as [Минут],
 operator as [Оператор],
 description as [Комментарий]
from [repRepair] 
where  
([repRepair].[moment] >= %TIME-START%) and  
([repRepair].[moment] <= %TIME-STOP%)
',2,5)
GO

delete from CustomReports WHERE [id]=N'{A2D71DA5-35B9-43AD-A829-A765E0927F96}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F96}',N'Отчет по услугам',N'Отчет показывает информацию о проданных услугах 
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select
 moment as [Время],
 name as [Услуга],
 price as [Стоимость_за_штуку],
 count as [Количество],
 summa as [Сумма],
 operator as [Оператор] 
from [repServices] 
where ([repServices].[moment] between %TIME-START% and %TIME-STOP%)
',2,6)
GO

delete from CustomReports WHERE [id]=N'{A2D71DA5-35B9-43AD-A829-A765E0927F98}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F98}',N'Важные сообщения',N'Сообщения системы
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select  
[Logs].[moment] as [Время],  
[Logs].[message] as [Сообщение],  
[Users].[name] as [Пользователь]
from [Logs] 
inner join [Users] 
on ([Logs].[operator] = [Users].[id]) 
where (moment>=%TIME-START%) and (moment<=%TIME-STOP%)
order by [Logs].[moment] desc
',2,7)
GO

delete from CustomReports WHERE [id]=N'{A2D71DA5-35B9-43AD-A829-A765E0927F99}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F99}',N'Accounts-общий',N'Отчет по учетным записям 
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select   
name [Имя],  
balance [Баланс],  
zeroBalance [Нулевой баланс],  
summary [Накоплено],  
isprivileged [Привелигированный],  
privilegedDiscount [Скидка],  
isblocked [Заблокирован],  
isenabled [Отключен]  
from accounts where 
id>0 and 
isdeleted<>1
',2,8)
GO

delete from CustomReports WHERE [id]=N'{96F54B6F-73F4-454E-92D7-0BAF9B790A81}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{96F54B6F-73F4-454E-92D7-0BAF9B790A81}',N'Accounts-Пополнение',N'Отчет по учетным записям - пополнение баланса по дням
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select 
 CONVERT(varchar(10),AccountsHistory.[moment],111) as [Дата],
 Accounts.[name] as [Имя учетной записи],
 SUM(AccountsHistory.[summa]) as [Сумма] 
from AccountsHistory
inner join Accounts on (AccountsHistory.[idAccounts] = Accounts.[id])
where ([moment]  >= %TIME-START%) and ([moment]<=%TIME-STOP%)
 and AccountsHistory.[what]=0
GROUP BY
 Accounts.[name],
 CONVERT(varchar(10),AccountsHistory.[moment],111)
order by [Дата] desc
',1,9)
GO

delete from CustomReports WHERE [id]=N'{1DCFE0B6-D2BC-4701-B8FB-1919F8151126}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{1DCFE0B6-D2BC-4701-B8FB-1919F8151126}',N'Accounts-Уменьшение',N'Отчет по учетным записям - уменьшение баланса по дням
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select 
 CONVERT(varchar(10),AccountsHistory.[moment],111) as [Дата],
 Accounts.[name] as [Имя учетной записи],
 SUM(AccountsHistory.[summa]) as [Сумма] 
from AccountsHistory
inner join Accounts on (AccountsHistory.[idAccounts] = Accounts.[id])
where ([moment]  >= %TIME-START%) and ([moment]<=%TIME-STOP%)
 and AccountsHistory.[what]=1
GROUP BY
 Accounts.[name],
 CONVERT(varchar(10),AccountsHistory.[moment],111)
order by [Дата] desc
',1,10)
GO

delete from CustomReports WHERE [id]=N'{8F965200-16ED-4778-B184-00F2D5ADD611}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{8F965200-16ED-4778-B184-00F2D5ADD611}',N'Accounts-Потрачено',N'Отчет по учетным записям - пополнение баланса по дням
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select 
 CONVERT(varchar(10),AccountsHistory.[moment],111) as [Дата],
 Accounts.[name] as [Имя учетной записи],
 SUM(AccountsHistory.[summa]) as [Сумма] 
from AccountsHistory
inner join Accounts on (AccountsHistory.[idAccounts] = Accounts.[id])
where ([moment]  >= %TIME-START%) and ([moment]<=%TIME-STOP%)
 and AccountsHistory.[what]=2
GROUP BY
 Accounts.[name],
 CONVERT(varchar(10),AccountsHistory.[moment],111)
order by [Дата] desc
',1,11)
GO

delete from CustomReports WHERE [id]=N'{8237ACEC-878E-462D-9133-64AEF9CCC5BB}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{8237ACEC-878E-462D-9133-64AEF9CCC5BB}',N'По принтеру',N'Отчет по принтеру (модуль GCPrinterControl)
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select
 dt as [Время],
 printer as [Принтер],
 ip as [ip-Адрес],
 doc as [Имя_документа],
 pbytes as [Байт],
 ppages as [Страниц],
 copies as [Копий],
 status as [Статус]
from Jobs 
where ([dt] between %TIME-START% and %TIME-STOP%)
',1,12)
GO

delete from CustomReports WHERE [id]=N'{B01CF09E-03EA-4F28-AD89-EE75B328BAE2}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{B01CF09E-03EA-4F28-AD89-EE75B328BAE2}',N'Загруженность',N'Отчет показывает сколько времени в процентах компьютер приносил доход. Время с тарифом "ремонт" считается как будто компьютер простаивал.
---
Author: GameClass Software 
support@gameclass.ru
',N'select 
 computers.number as [Компьютер],
 cast(sum(DATEDIFF(minute, SessionsAdd.[Start], SessionsAdd.[Stop]))/Cast(DATEDIFF(minute, %TIME-START%, %TIME-STOP%)as float)*100 as int) as [Загруженность_в_процентах]
from SessionsAdd
inner join computers on (computers.[id] = SessionsAdd.[idComp])
where
 (SessionsAdd.[idTarif] <> 0) and
 (SessionsAdd.[Start] > %TIME-START%) and
 (SessionsAdd.[Start] < %TIME-STOP%)
group by
  computers.number
',1,13)
GO

delete from CustomReports WHERE [id]=N'{EB16E075-68DC-47A3-B2F6-8AA183B63258}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{EB16E075-68DC-47A3-B2F6-8AA183B63258}',N'Распред. по компьют.',N'Распределение прибыли по компьютерам
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select 
 computers.number as [Компьютер],
 repDetails.ipaddress as [ip-Адрес], 
 sum(repDetails.summa) as [Сумма]
from repDetails
inner join computers on (computers.[ipaddress] = repDetails.[ipaddress])
where ([moment]  >= %TIME-START%) and ([moment]<=%TIME-STOP%)
group by computers.number,repDetails.ipaddress
order by [Сумма] desc
',3,14)
GO

delete from CustomReports WHERE [id]=N'{5C49890F-6393-4F28-8E6E-ACBA49C99650}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{5C49890F-6393-4F28-8E6E-ACBA49C99650}',N'Распред. по операт.',N'Отчет показывает распределение доходов по месяцам по всем операторам. Отчет основывается на записях в журнале операторов.
---
Author: GameClass Software 
support@gameclass.ru
',N'set nocount on

CREATE TABLE #t (  
[id] [int] NOT NULL ,  
[name] [varchar] (25) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]  

INSERT INTO #t (id, name) VALUES (1, N''Январь'')
INSERT INTO #t (id, name) VALUES (2, N''Февраль'')
INSERT INTO #t (id, name) VALUES (3, N''Март'')
INSERT INTO #t (id, name) VALUES (4, N''Апрель'')
INSERT INTO #t (id, name) VALUES (5, N''Май'')
INSERT INTO #t (id, name) VALUES (6, N''Июнь'')
INSERT INTO #t (id, name) VALUES (7, N''Июль'')
INSERT INTO #t (id, name) VALUES (8, N''Август'')
INSERT INTO #t (id, name) VALUES (9, N''Сентябрь'')
INSERT INTO #t (id, name) VALUES (10, N''Октябрь'')
INSERT INTO #t (id, name) VALUES (11, N''Ноябрь'')
INSERT INTO #t (id, name) VALUES (12, N''Декабрь'')

select 
 #t.Name as [Месяц], 
 sum(JournalOp.summa) as [Сумма], 
 users.name as [Оператор]
from JournalOp
inner join users on (JournalOp.operator = users.[id])
inner join #t on (#t.[id] =  DATEPART(month, JournalOp.moment))
GROUP BY #t.Name, DATEPART(month, JournalOp.moment), users.name
order by DATEPART(month, JournalOp.moment) asc

if object_id(''tempdb..#t'') is not null  
DROP TABLE #t
',1,15)
GO

delete from CustomReports WHERE [id]=N'{47E8B179-48CA-4567-9598-1F4C3F5890B7}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{47E8B179-48CA-4567-9598-1F4C3F5890B7}',N'Распред. по тарифам',N'Распределение прибыли по тарифам
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select Tarifs.[name] as [Тариф], sum(Sessions.[payed]) as [Сумма] from Sessions
 inner join SessionsAdd on (Sessions.[id] = SessionsAdd.[idSessions])
 inner join Tarifs on (SessionsAdd.[idTarif] = Tarifs.[id])
where
 sessions.[started] > %TIME-START% and
 sessions.[started] < %TIME-STOP%
 group by Tarifs.[name]
',1,16)
GO

delete from CustomReports WHERE [id]=N'{1A3BA6E3-A4D5-4CAE-A082-5FAFC469A3D1}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{1A3BA6E3-A4D5-4CAE-A082-5FAFC469A3D1}',N'Распред. по месяцам',N'Прибыль клуба по месяцам. Рекомендуется поверх этого отчета применять фильтрацию за текущий год.
--- 
Author: GameClass Software 
support@gameclass.ru
',N'set nocount on

CREATE TABLE #t (  
[id] [int] NOT NULL ,  
[name] [varchar] (25) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]  

INSERT INTO #t (id, name) VALUES (1, N''Январь'')
INSERT INTO #t (id, name) VALUES (2, N''Февраль'')
INSERT INTO #t (id, name) VALUES (3, N''Март'')
INSERT INTO #t (id, name) VALUES (4, N''Апрель'')
INSERT INTO #t (id, name) VALUES (5, N''Май'')
INSERT INTO #t (id, name) VALUES (6, N''Июнь'')
INSERT INTO #t (id, name) VALUES (7, N''Июль'')
INSERT INTO #t (id, name) VALUES (8, N''Август'')
INSERT INTO #t (id, name) VALUES (9, N''Сентябрь'')
INSERT INTO #t (id, name) VALUES (10, N''Октябрь'')
INSERT INTO #t (id, name) VALUES (11, N''Ноябрь'')
INSERT INTO #t (id, name) VALUES (12, N''Декабрь'')

select 
 #t.Name as [Месяц], 
 SUM([summa]) as [Сумма] 
from [repDetails] 
inner join #t on (#t.[id] =  DATEPART(month, [moment]))
GROUP BY #t.Name, DATEPART(month, [moment])
order by DATEPART(month, [moment]) asc

if object_id(''tempdb..#t'') is not null  
DROP TABLE #t
',3,17)
GO

delete from CustomReports WHERE [id]=N'{86435B62-4D59-4917-8AE2-92AB7E089B6E}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{86435B62-4D59-4917-8AE2-92AB7E089B6E}',N'Распр. по дням недел',N'Прибыль клуба по дням недели. Позволяет детальнее проработать тарифы и просто любопытная информация :)
--- 
Author: GameClass Software 
support@gameclass.ru
',N'set nocount on

CREATE TABLE #t (  
[id] [int] NOT NULL ,  
[name] [varchar] (25) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]  

INSERT INTO #t (id, name) VALUES (1, N''Понедельник'')
INSERT INTO #t (id, name) VALUES (2, N''Вторник'')
INSERT INTO #t (id, name) VALUES (3, N''Среда'')
INSERT INTO #t (id, name) VALUES (4, N''Четверг'')
INSERT INTO #t (id, name) VALUES (5, N''Пятница'')
INSERT INTO #t (id, name) VALUES (6, N''Суббота'')
INSERT INTO #t (id, name) VALUES (7, N''Воскресенье'')

select 
 #t.name as [День недели], 
 SUM([summa]) as [Сумма]
from [repDetails]
inner join #t on (#t.id = DATEPART(dw, [moment]) )
where ([moment]  >= %TIME-START%) and ([moment]<=%TIME-STOP%)
GROUP BY #t.name, DATEPART(dw, [moment])
ORDER BY DATEPART(dw, [moment]) asc

if object_id(''tempdb..#t'') is not null  
DROP TABLE #t  
',3,18)
GO

delete from CustomReports WHERE [id]=N'{9839CD7E-F706-4B9C-9EA0-4376D48B0E78}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{9839CD7E-F706-4B9C-9EA0-4376D48B0E78}',N'Распредел. по дням',N'Суммарная прибыль за каждый день
--- 
Author: GameClass Software 
support@gameclass.ru
',N'select 
 CONVERT(varchar(10),[moment],111) as [Дата],
 SUM([summa]) as [Сумма] 
from [repDetails] 
where ([moment]  >= %TIME-START%) and ([moment]<=%TIME-STOP%)
GROUP BY 
 CONVERT(varchar(10),[moment],111)
order by [Дата] desc
',2,19)
GO

delete from CustomReports WHERE [id]=N'{0B6F02F5-5F7C-494B-B106-075488D6351F}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{0B6F02F5-5F7C-494B-B106-075488D6351F}',N'Распредел. по часам',N'Прибыль клуба по часам
--- 
Author: GameClass Software 
support@gameclass.ru
',N'set nocount on

CREATE TABLE #t (  
[id] [int] NOT NULL ,  
[name] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]  

INSERT INTO #t (id, name) VALUES (0, N''00:00'')
INSERT INTO #t (id, name) VALUES (1, N''01:00'')
INSERT INTO #t (id, name) VALUES (2, N''02:00'')
INSERT INTO #t (id, name) VALUES (3, N''03:00'')
INSERT INTO #t (id, name) VALUES (4, N''04:00'')
INSERT INTO #t (id, name) VALUES (5, N''05:00'')
INSERT INTO #t (id, name) VALUES (6, N''06:00'')
INSERT INTO #t (id, name) VALUES (7, N''07:00'')
INSERT INTO #t (id, name) VALUES (8, N''08:00'')
INSERT INTO #t (id, name) VALUES (9, N''09:00'')
INSERT INTO #t (id, name) VALUES (10, N''10:00'')
INSERT INTO #t (id, name) VALUES (11, N''11:00'')
INSERT INTO #t (id, name) VALUES (12, N''12:00'')
INSERT INTO #t (id, name) VALUES (13, N''13:00'')
INSERT INTO #t (id, name) VALUES (14, N''14:00'')
INSERT INTO #t (id, name) VALUES (15, N''15:00'')
INSERT INTO #t (id, name) VALUES (16, N''16:00'')
INSERT INTO #t (id, name) VALUES (17, N''17:00'')
INSERT INTO #t (id, name) VALUES (18, N''18:00'')
INSERT INTO #t (id, name) VALUES (19, N''19:00'')
INSERT INTO #t (id, name) VALUES (20, N''20:00'')
INSERT INTO #t (id, name) VALUES (21, N''21:00'')
INSERT INTO #t (id, name) VALUES (22, N''22:00'')
INSERT INTO #t (id, name) VALUES (23, N''23:00'')

select #t.name as [Час суток],  SUM([summa]) as [Сумма] from [repDetails] 
inner join #t on (#t.[id] = DATEPART(hour, [moment]))
where ([moment]  >= %TIME-START%) and ([moment]<=%TIME-STOP%)
GROUP BY #t.name
order by  [Час суток]

if object_id(''tempdb..#t'') is not null  
DROP TABLE #t  
',3,20)
GO

delete from CustomReports WHERE [id]=N'{7BDFF479-9DB4-4B13-A7C7-647F1E5C3077}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{7BDFF479-9DB4-4B13-A7C7-647F1E5C3077}',N'Hardware',N'История по оборудованию на компьютерах. Пользуйтесь фильтрацией
--- 
Author: NodaSoft
support@nodasoft.com
',N'select 
 Computers.number as [Компьютер],
 HardwareType.name as [Тип_оборудования],
 Hardware.hw_value as [Какое_оборудование],
 Hardware.moment as [Время],
 users.name as [Оператор],
 Hardware.comment as [Последнее_событие]
from Hardware 
inner join HardwareType on (HardwareType.id = Hardware.hw_id)
inner join Users on (Hardware.operator = users.id)
inner join Computers on (Hardware.idComputers = Computers.id)
',1,21)
GO

delete from CustomReports WHERE [id]=N'{4AF76843-EAFA-4FBD-A10F-42E7D788C3DD}'
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) 
VALUES(N'{4AF76843-EAFA-4FBD-A10F-42E7D788C3DD}',N'Сегментирование',N'Отчет показывает распределение количество сеансов по суммам
--- 
Author: NodaSoft
support@nodasoft.com
',N'set nocount on  
declare @count int
set @count = 0  

if object_id(''tempdb..#t'') is not null  
DROP TABLE #t  
CREATE TABLE #t (  
[id] [int] IDENTITY (1, 1) NOT NULL ,  
[name] [varchar] (255) COLLATE Cyrillic_General_CI_AS NULL ,  
[result] [int]
) ON [PRIMARY]

select @count=count(id) from Sessions where payed>0 and payed<=5 and %TIME-START%<=started and started<%TIME-STOP%
INSERT INTO #t (name,result) VALUES (N''От 0 до 5 рублей'', @count )  

select @count=count(id) from Sessions where payed>5 and payed<=10 and %TIME-START%<=started and started<%TIME-STOP%
INSERT INTO #t (name,result) VALUES (N''От 5 до 10 рублей'', @count )  

select @count=count(id) from Sessions where payed>10 and payed<=20 and %TIME-START%<=started and started<%TIME-STOP%
INSERT INTO #t (name,result) VALUES (N''От 10 до 20 рублей'', @count )

select @count=count(id) from Sessions where payed>20 and payed<=40 and %TIME-START%<=started and started<%TIME-STOP%
INSERT INTO #t (name,result) VALUES (N''От 20 до 40 рублей'', @count )  

select @count=count(id) from Sessions where payed>40 and payed<=70 and %TIME-START%<=started and started<%TIME-STOP%
INSERT INTO #t (name,result) VALUES (N''От 40 до 70 рублей'', @count )  

select @count=count(id) from Sessions where payed>70 and %TIME-START%<=started and started<%TIME-STOP%
INSERT INTO #t (name,result) VALUES (N''Более 70 рублей'', @count )  

INSERT INTO #t (name,result) VALUES (N''------------------'', 0 )

select @count=count(id) from Sessions where payed>0 and %TIME-START%<=started and started<%TIME-STOP%
INSERT INTO #t (name,result) VALUES (N''Итого сеансов'', @count )  

SELECT name [Оплата сеанса], result [Сумма] FROM #t order by [id] asc  
',1,22)
GO

ALTER TABLE dbo.TarifsVariants ADD
	TrafficCost money NOT NULL CONSTRAINT DF_TarifsVariants_TrafficCost DEFAULT 1,
	TrafficSeparatePayment bit NOT NULL CONSTRAINT DF_TarifsVariants_TrafficSeparatePayment DEFAULT 0
GO

ALTER TABLE dbo.Tarifs ADD
	BytesInMB int NOT NULL CONSTRAINT DF_Tarifs_BytesInMB DEFAULT 1048576
GO

declare @TrafficCost money
set @TrafficCost=1 
select @TrafficCost=CONVERT(money,[Value]) from Registry where [Key]='TrafficCost'
update TarifsVariants set [TrafficCost]=@TrafficCost
GO

declare @BytesInMB money
set @BytesInMB=1048576
select @BytesInMB=CONVERT(int,[Value]) from Registry where [Key]='TrafficByteInMB'
update Tarifs set [BytesInMB]=@BytesInMB
GO

ALTER TABLE dbo.Sessions ADD
	status int NOT NULL CONSTRAINT DF_Sessions_status DEFAULT 2
GO

ALTER TABLE dbo.Sessions
	DROP CONSTRAINT DF_Sessions_status
GO

ALTER TABLE dbo.Sessions ADD CONSTRAINT
	DF_Sessions_status DEFAULT 0 FOR status
GO

ALTER TABLE dbo.Sessions ADD
	TrafficAdded int NOT NULL CONSTRAINT DF_Sessions_TrafficAdded DEFAULT 0
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsGo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsGo]
GO

CREATE PROCEDURE SessionsSave
@idClients int, 
@idComp int,
@idTarif int,
@postpay int,
@traffic int,
@printed int,
@payed money,
@descript nvarchar(100),
@start datetime,
@stop datetime,
@summa money,
@whole int,
@minpenalty int,
@state int,
@status int
AS 

set nocount on

declare @idSessions int
declare @idSessionsAdd int

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

insert into Sessions ([idClients], [traffic], [printed], [postpay], [started], [payed], [description], [operator], [minpenalty], [state], [status])
    values ( @idClients, @traffic, @printed, @postpay, @start, @payed, @descript, @idMe, @minpenalty, @state, @status)
select @idSessions = @@IDENTITY -- get id of last inserted record

if (@idClients <> 0) 
begin
  update Accounts set [balance]=[balance] - @payed where [id] = @idClients
  update Accounts set [summary]=[summary] + @payed where [id] = @idClients
end
 
insert into SessionsAdd ([idSessions], [idComp], [idTarif], [Start], [Stop], [whole],  [operator])
    values (@idSessions, @idComp, @idTarif, @start, @stop, @whole, @idMe)
select @idSessionsAdd = @@IDENTITY -- get id of last inserted record

insert into SessionsAdd2 ([idSessionsAdd], [ActionType], [moment], [summa])
   values (@idSessionsAdd, 0, @start, @summa)

select @idSessions as idSessions, @idSessionsAdd as idSessionsAdd
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsSelect]
GO

CREATE PROCEDURE SessionsSelect
@now datetime
AS 
BEGIN
    SET NOCOUNT ON
    SELECT S.[id] idSessions, S.[idClients], S.[traffic], S.[printed], S.[postpay], S.[started], S.[payed], S.[description],
            SA.[id] idSessionsAdd, SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], S.[minpenalty], SA.[whole], 
            sum(SA2.[summa]) summa, S.[state], S.[status], S.[TrafficAdded]
        FROM Sessions AS S
        INNER JOIN SessionsAdd AS SA ON (S.[id] = SA.[idSessions])
        INNER JOIN SessionsAdd2 AS SA2 ON (SA.[id] = SA2.[idSessionsAdd])
        WHERE (SA.[start]<=@now) AND (@now<SA.[stop]) AND (SA2.[ActionType] <> 3) --чтоб не считать деньги за траф в сумме
        GROUP BY S.[id], S.[idClients], S.[traffic], S.[printed], S.[postpay], S.[started], S.[payed], S.[description], SA.[id], 
            SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], S.[minpenalty], SA.[whole], S.[state], S.[status], S.[TrafficAdded]
END
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsStopIt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsStopIt]
GO

CREATE PROCEDURE SessionsStopIt
@idSessionsAdd int,
@newstop datetime,
@summa money,
@autostop int = 0
AS 

set nocount on

declare @postpay int
declare @idSessions int
declare @idSessionsAdd2 int
declare @payed money
declare @idAccount int

select @idSessions=[idSessions] from SessionsAdd where [id]=@idSessionsAdd
select @payed=[payed] from Sessions where [id]=@idSessions
select @idAccount=[idClients] from Sessions where [id]=@idSessions
select @postpay=[postpay] from Sessions where [id]=@idSessions
select top 1 @idSessionsAdd2=[id] from SessionsAdd2 where [idSessionsAdd]=@idSessionsAdd order by [id] desc

update SessionsAdd set [stop] = @newstop where [id] = @idSessionsAdd
update Sessions set [payed]=@summa where [id]=@idSessions  
if ( @postpay = 0 ) -- была предоплата
begin
   -- добавляем новую запись в SessionsAdd2, ActionType = 2 
   if ((@summa - @payed)<>0) begin
     insert into SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])   values (@idSessionsAdd, 2,  (@summa - @payed), @newstop)   
     -- снимаем со счета клиента
     if (@idAccount <> 0) 
     begin
       update Accounts set [balance]=[balance] + (@payed - @summa) where [id] = @idAccount
       update Accounts set [summary]=[summary] - (@payed - @summa) where [id] = @idAccount
       insert into AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])  values  (@idAccount, @newstop, 2, @summa, N'',0)
     end
   end
   -- если клиент остался должен, то 
   if ((@autostop=1) and (@summa - @payed > 0)) update Sessions Set [toResolve]=1 where [id]=@idSessions
end
else -- не было предоплаты
begin
   update SessionsAdd2 set [summa]=[summa]-@payed+@summa, [moment]=@newstop where [id]=@idSessionsAdd2
   if (@autostop=1)  update Sessions Set [toResolve]=1 where [id]=@idSessions  
end
-- в любом случае сбрасываем флажок "постоплата", потому что уже все оплачено
--if (@autostop=0) 
update Sessions set [postpay]=0, [status]=2 where [id]=@idSessions
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsUpdate]
GO

CREATE PROCEDURE SessionsUpdate
@idSessions int,
@traffic int,
@printed int,
@idSessionsAdd int,
@newstop datetime,
@newstatus int
AS 

set nocount on

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

if (exists (select * from Sessions where [id] = @idSessions))
begin
  update Sessions Set [traffic] = [traffic] + @traffic, [printed] = [printed] + @printed, [operator] = @idMe, [status]=@newstatus where [id] = @idSessions
  update SessionsAdd Set [stop]=@newstop where [id]=@idSessionsAdd
end
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsReadUncontrolState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsReadUncontrolState]
GO


CREATE PROCEDURE SessionsReadUncontrolState
@now datetime  
AS   

set nocount on

declare @idClub int
select @idClub=[id] from Computers where [ipaddress]='Club'

if (exists(select U.[idComputers] from Uncontrol as U where U.[start]<=@now and @now<U.[stop] and U.[idComputers]=@idClub))
  select [id] idComputers from Computers where ipaddress<>'Club' and [isdelete]=0
else
  select U.[idComputers] from Uncontrol as U where U.[start]<=@now and @now<U.[stop] and U.[idComputers]<>@idClub
GO

INSERT INTO [functions]([id],[name]) VALUES(28,N'fnManualRemoteInstall')
go

INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(28,2)
go

INSERT INTO [functions]([id],[name]) VALUES(29,N'fnReserveActivate')
go

INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(29,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(29,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(29,3)
go

INSERT INTO [functions]([id],[name]) VALUES(30,N'fnReserveCancel')
go

INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(30,2)
go


GRANT  EXECUTE  ON [dbo].[SessionsSave]  TO [public]
GO
GRANT  EXECUTE  ON [dbo].[SessionsSelect]  TO [public]
GO
GRANT  EXECUTE  ON [dbo].[SessionsStopIt]  TO [public]
GO
GRANT  EXECUTE  ON [dbo].[SessionsUpdate]  TO [public]
GO
GRANT  EXECUTE  ON [dbo].[SessionsReadUncontrolState]  TO [public]
GO

ALTER TABLE [dbo].[Errors] ADD
  [isdelete][tinyint] NOT NULL DEFAULT (0),
  [comment][varchar] (4000) COLLATE Cyrillic_General_CI_AS NOT NULL DEFAULT ('')
GO

ALTER TABLE [dbo].[Information] ADD 
  [isdelete][tinyint] NOT NULL DEFAULT (0),
  [comment][varchar] (4000) COLLATE Cyrillic_General_CI_AS NOT NULL DEFAULT ('')
GO

ALTER TABLE [dbo].[Jobs] ADD
  [format][varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL DEFAULT (''),
  [iscolor][tinyint] NOT NULL DEFAULT (0),
  [isdelete][tinyint] NOT NULL DEFAULT (0),
  [comment][varchar] (4000) COLLATE Cyrillic_General_CI_AS NOT NULL DEFAULT ('')
GO

ALTER TABLE [dbo].[Warnings] ADD 
  [isdelete][tinyint] NOT NULL DEFAULT (0),
  [comment][varchar] (4000) COLLATE Cyrillic_General_CI_AS NOT NULL DEFAULT ('')
GO

IF NOT EXISTS (SELECT 1 FROM master.dbo.syslogins 
   WHERE name = N'gcbackupoperator')
BEGIN
  if exists (select * from dbo.sysobjects where id = object_id(N'[tempdb]..[#msver]') )
	  drop table #msver

  DECLARE @MSSQLVERSION int
  SELECT @MSSQLVERSION=CAST(REPLACE(LEFT(CAST(SERVERPROPERTY('ProductVersion')AS VARCHAR(20)),2),'.','') as INT);
  if (@MSSQLVERSION=0)
  BEGIN
	CREATE TABLE #msver ([Index] INT PRIMARY KEY, [Name] VARCHAR(200), Internal_Value INT, Character_Value VARCHAR(200)) 
	INSERT INTO #msver EXEC master..xp_msver ProductVersion 
	SELECT @MSSQLVERSION=CAST(LEFT(Character_Value,1) AS INT) FROM #msver 
	DROP TABLE #msver 
  END

  IF (@MSSQLVERSION = 8) BEGIN
  exec master.dbo.sp_addlogin N'gcbackupoperator'
  exec master.dbo.sp_password @new='j4hhf6kd', @loginame='gcbackupoperator'
  END

  IF (@MSSQLVERSION = 9) BEGIN
    exec sp_executesql N'CREATE LOGIN gcbackupoperator WITH PASSWORD = ''j4hhf6kd'' ,CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF'
  END

  IF (@MSSQLVERSION = 10) BEGIN
    exec sp_executesql N'CREATE LOGIN gcbackupoperator WITH PASSWORD = ''j4hhf6kd'' ,CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF'
  END


  exec sp_adduser 'gcbackupoperator', 'gcbackupoperator', 'db_backupoperator'
END
GO

ALTER TABLE [dbo].[CustomReports] ALTER COLUMN [name] [varchar] (20) COLLATE Cyrillic_General_CI_AS NOT NULL 
ALTER TABLE [dbo].[CustomReports] ALTER COLUMN [description] [varchar] (500) COLLATE Cyrillic_General_CI_AS NOT NULL 
ALTER TABLE [dbo].[CustomReports] ALTER COLUMN [sqlcode] [varchar] (7000) COLLATE Cyrillic_General_CI_AS NOT NULL 
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReportsImport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CustomReportsImport]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReportsAdd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CustomReportsAdd]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReportsDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CustomReportsDelete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReportsSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CustomReportsSelect]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReportsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CustomReportsUpdate]
GO

CREATE PROCEDURE CustomReportsAdd
@name varchar(20),
@description varchar(500),
@sqlcode varchar(7000),
@tabindex int,
@version int
  
AS 

set nocount on

declare @id as uniqueidentifier

if (exists(select * from CustomReports where [name]=@name or [sqlcode]=@sqlcode) )
begin
  raiserror 50000 'CustomReports with these name or SQL-code already exist!'
  return 50000
end
else begin
 set @id = newid()
  insert into CustomReports ([id], [name], [description], [sqlcode], [tabindex], [version]) values (@id, @name, @description, @sqlcode, @tabindex, @version)
end
GO

CREATE PROCEDURE CustomReportsDelete
@idReport uniqueidentifier
  
AS 

if (not exists(select * from CustomReports where [id]=@idReport))
begin
  raiserror 50000 'This report not exists'
  return 50000
end
else
 delete from CustomReports where [id]=@idReport
GO

CREATE PROCEDURE CustomReportsSelect
  
AS 

set nocount on

select * from CustomReports order by tabindex
GO

CREATE PROCEDURE CustomReportsUpdate
@idReport uniqueidentifier,
@name varchar(20),
@description varchar(500),
@sqlcode varchar(7000),
@tabindex int,
@version int
  
AS 

set nocount on

if (exists(select * from CustomReports where ([name]=@name or [sqlcode]=@sqlcode) and [id]<>@idReport))
begin
  raiserror 50000 'CustomReports with these name or SQL-code already exist!'
  return 50000
end
else
  update CustomReports set [name]=@name, [description]=@description, [sqlcode]=@sqlcode, [tabindex]=@tabindex, [version]=@version where [id]=@idReport
GO

CREATE PROCEDURE CustomReportsImport
@id uniqueidentifier,
@name varchar(20),
@description varchar(500),
@sqlcode varchar(7000),
@tabindex int,
@version int
  
AS 

set nocount on

if (exists(select * from CustomReports where [name]=@name or [sqlcode]=@sqlcode) )
begin
  raiserror 50000 'CustomReports with these name or SQL-code already exist!'
  return 50000
end
else begin
  insert into CustomReports ([id], [name], [description], [sqlcode], [tabindex], [version]) values (@id, @name, @description, @sqlcode, @tabindex, @version)
end

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportCurrent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ReportCurrent]
GO

CREATE PROCEDURE ReportCurrent
@NewShiftPoint datetime
  
AS 

set nocount on

declare @LastShiftPoint datetime
declare @ServiceSumma money
declare @printed int
declare @traffic int
declare @AccountsAdded money
declare @AccountsReturned money
declare @AccountsPayed money

-- тут нужно получить момент последнего завершения смены
if exists (select * from JournalOp)  
 select top 1 @LastShiftPoint=[moment] from JournalOp where [moment]<=@NewShiftPoint order by [moment] desc
else
 select top 1 @LastShiftPoint=SA.[start] from SessionsAdd as SA order by SA.[start]

if (@LastShiftPoint is NULL) 
begin
  select top 1 @LastShiftPoint = S.[moment] from Services as S order by [moment] desc
end

set @LastShiftPoint=ISNULL(@LastShiftPoint,@NewShiftPoint)
-- получим дату последнего отчета оператора (предыдущего оператора) 

-- подсчет доп.расходов (услуг)
select @ServiceSumma=ISNULL(sum(RS.[summa]),0) from repServices as RS
  where (@LastShiftPoint<=RS.[moment]) and (RS.[moment]<=@NewShiftPoint)

-- подсчет трафика и распечатанных страниц
select @traffic =  ISNULL(Sum(s.[traffic]),0), @printed =  ISNULL(Sum(s.[printed]),0) from sessions as S
  inner join SessionsAdd as SA on (SA.[idSessions] = S.[id])
  where (S.[postpay]=0)
  and (@LastShiftPoint<=SA.[start]) and (SA.[start]<=@NewShiftPoint)

-- подсчет денег для аккаунтов
-- добавлено
select @AccountsAdded= ISNULL(Sum(AH.summa),0) from AccountsHistory as AH
 inner join users on (users.id=AH.operator)
 inner join usersgroup on (usersgroup.id=users.idUsersGroup)
where (AH.What=0)  
 and usersgroup.name='Staff'
 and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint)
-- возвращено
select @AccountsReturned =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH
 inner join users on (users.id=AH.operator)
 inner join usersgroup on (usersgroup.id=users.idUsersGroup)
  where (AH.[What]=1)
  and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint)
-- проплачено
select @AccountsPayed =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH
 inner join users on (users.id=AH.operator)
 inner join usersgroup on (usersgroup.id=users.idUsersGroup)
  where (AH.[What]=2)
  and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint)

select ISNULL(sum(SA2.[summa]),0) as time, @ServiceSumma as service, @traffic as traffic, @printed as printed, 
  @AccountsAdded as AccountsAdded,  @AccountsPayed as AccountsPayed, @AccountsReturned as AccountsReturned, @LastShiftPoint as LastShiftPoint from sessions as S
  inner join SessionsAdd as SA on (SA.[idSessions] = S.[id])
  inner join SessionsAdd2 as SA2 on (SA.[id] = SA2.[idSessionsAdd])
  where (S.[postpay]=0)
  and (@LastShiftPoint<=SA2.[moment]) and (SA2.[moment]<=@NewShiftPoint)
  and S.[idClients]=0
GO

GRANT  EXECUTE  ON [dbo].[ReportCurrent]  TO [public]
GO

INSERT INTO [functions]([id],[name]) VALUES(31,N'fnAccountsChangeMoney')
go

INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(31,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(31,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(31,3)
go

INSERT INTO [functions]([id],[name]) VALUES(32,N'fnSessionTrafficPayment')
go

INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(32,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(32,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(32,3)
go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsVariantsAdd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsVariantsAdd]
GO

CREATE PROCEDURE TarifsVariantsAdd
@idTarifs int, 
@name nvarchar(50),
@start datetime,
@stop datetime,
@cost money,
@ispacket int = 0,
@daysofweek nvarchar(7),
@condition nvarchar(50) = N'',
@TrafficLimit int = 1000,
@TrafficCost money = 1,
@TrafficSeparatePayment bit =0
  
AS 

set nocount on

insert into TarifsVariants ([idTarifs], [name], [start], [stop],[ispacket], [cost], [daysofweek], [condition],
        [TrafficLimit],[TrafficCost],[TrafficSeparatePayment])
    values (@idTarifs, @name, @start, @stop, @ispacket, @cost, @daysofweek, @condition, 
        @TrafficLimit,@TrafficCost,@TrafficSeparatePayment)
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsVariantsSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsVariantsSelect]
GO

CREATE PROCEDURE TarifsVariantsSelect
@idTarifs int
  
AS 
select [id], [name], [start], [stop], [cost], [ispacket], [daysofweek], [condition],[TrafficLimit],[TrafficCost],[TrafficSeparatePayment]
    from TarifsVariants where [idTarifs]=@idTarifs
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsVariantsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsVariantsUpdate]
GO

CREATE PROCEDURE TarifsVariantsUpdate
@idVariants int,
@name nvarchar(50),
@start datetime,
@stop datetime,
@cost money,
@ispacket int,
@daysofweek nvarchar(7),
@condition nvarchar(50),
@TrafficLimit int,
@TrafficCost money,
@TrafficSeparatePayment bit
  
AS 

set nocount on

update TarifsVariants set 
  [name]=@name, 
  [start]=@start, 
  [stop]=@stop, 
  [cost]=@cost, 
  [ispacket] = @ispacket,
  [daysofweek]=@daysofweek,
  [condition] = @condition,
  [TrafficLimit] = @TrafficLimit,
  [TrafficCost] = @TrafficCost,
  [TrafficSeparatePayment] = @TrafficSeparatePayment
  where [id] = @idVariants
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsAdd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsAdd]
GO

CREATE PROCEDURE TarifsAdd
@name nvarchar(100),
@internet int,
@calctraffic int,
@roundtime int,
@roundmoney money,
@idGroup int,
@BytesInMB int
  
AS 

set nocount on

declare @priorityshow int

if (exists (select * from Tarifs where [name]=@name and [isdelete]=0))
begin
  raiserror 50000 'Tarif with these name already exist!'
  return 50000
end

select @priorityshow=max([priorityshow])+1 from Tarifs where [isdelete]=0

insert into Tarifs ([name], [internet], [calctraffic], [roundtime], [roundmoney], [priorityshow], [idGroup], [BytesInMB])
  values (@name, @internet, @calctraffic, @roundtime, @roundmoney, @priorityshow, @idGroup, @BytesInMB)

exec TarifsVariantsAdd 
  @idTarifs = @@identity, 
  @name=N'default',
  @start='0:00:00',
  @stop='0:00:00',
  @cost=1,
  @ispacket=0,
  @daysofweek=N'1234567'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsSelect]
GO

CREATE PROCEDURE TarifsSelect
@idGroup int 
  
AS 
set nocount on
if @idGroup=-1
  select * from Tarifs  where [isdelete]=0 order by [priorityshow] asc
else
  select * from Tarifs  where [isdelete]=0 and [idGroup]=@idGroup order by [priorityshow] asc
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsUpdate]
GO

CREATE PROCEDURE TarifsUpdate
@idTarif int,
@name nvarchar(100),
@internet int,
@calctraffic int,
@roundtime int,
@roundmoney money,
@idGroup int,
@BytesInMB int
  
AS 

set nocount on

if (exists(select * from Tarifs where ([name]=@name) and [id]<>@idTarif and [isdelete]=0))
begin
  raiserror 50000 'Tarif with these name already exist!'
  return 50000
end

update Tarifs set [name]=@name ,[internet]=@internet ,[calctraffic]=@calctraffic ,[roundtime]=@roundtime ,
         [roundmoney]=@roundmoney, [idGroup]=@idGroup, [BytesInMB]=@BytesInMB
    where [id]=@idTarif
GO



GRANT  EXECUTE  ON [dbo].[TarifsVariantsSelect]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[TarifsSelect]  TO [public]
GO

CREATE PROCEDURE SessionsTrafficPayment
@IdSessions int,
@TrafficAdded int,
@Summa money,
@Moment datetime
  
AS 
BEGIN
    SET NOCOUNT ON
    -- добавляем новую запись в SessionsAdd2, ActionType = 3 (добавить денег за трафик)
    INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])
        VALUES (@IdSessions, 3, @Summa, @Moment)
    -- увеличиваем доплаченный трафик
    UPDATE Sessions SET [TrafficAdded] = [TrafficAdded] + @TrafficAdded 
        WHERE [id]=@idSessions
END
GO

GRANT  EXECUTE  ON [dbo].[SessionsTrafficPayment]  TO [public]
GO


update Registry set [value]=N'3.75' where [key]=N'BaseVersion'
GO
