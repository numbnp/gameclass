Use GameClass
Go

if exists(select * from master..syslogins where name='BUILTIN\Administrators')
	exec sp_denylogin 'BUILTIN\Administrators'
GO

if exists(select * from master..syslogins where name='BUILTIN\јдминистраторы')
	exec sp_denylogin 'BUILTIN\јдминистраторы'
GO

ALTER TABLE [dbo].[Tarifs] ADD
	SpeedLimitInKB int NOT NULL CONSTRAINT DF_Tarifs_SpeedLimitInKB DEFAULT 0,
	PluginGroupName nvarchar(50) NOT NULL CONSTRAINT DF_Tarifs_PluginGroupName DEFAULT ''
GO

ALTER TABLE [dbo].[TarifsVariants] ADD
	FreePacket bit NOT NULL CONSTRAINT DF_TarifsVariants_FreePacket DEFAULT 0
GO


ALTER PROCEDURE TarifsAdd
@name nvarchar(100),
@internet int,
@calctraffic int,
@roundtime int,
@roundmoney money,
@idGroup int,
@BytesInMB int,
@SpeedLimitInKB int,
@PluginGroupName nvarchar(50)
  
AS 

set nocount on

declare @priorityshow int

if (exists (select * from Tarifs where [name]=@name and [isdelete]=0))
begin
  raiserror 50000 'Tarif with these name already exist!'
  return 50000
end

select @priorityshow=max([priorityshow])+1 from Tarifs where [isdelete]=0

insert into Tarifs ([name], [internet], [calctraffic], [roundtime], [roundmoney],
  [priorityshow], [idGroup], [BytesInMB], [SpeedLimitInKB], [PluginGroupName])
  values (@name, @internet, @calctraffic, @roundtime, @roundmoney, 
  @priorityshow, @idGroup, @BytesInMB, @SpeedLimitInKB, @PluginGroupName)

exec TarifsVariantsAdd 
  @idTarifs = @@identity, 
  @name=N'default',
  @start='0:00:00',
  @stop='0:00:00',
  @cost=1,
  @ispacket=0,
  @daysofweek=N'1234567',
  @FreePacket=0
GO

ALTER PROCEDURE TarifsUpdate
@idTarif int,
@name nvarchar(100),
@internet int,
@calctraffic int,
@roundtime int,
@roundmoney money,
@idGroup int,
@BytesInMB int,
@SpeedLimitInKB int,
@PluginGroupName nvarchar(50)
  
AS 

set nocount on

if (exists(select * from Tarifs where ([name]=@name) and [id]<>@idTarif and [isdelete]=0))
begin
  raiserror 50000 'Tarif with these name already exist!'
  return 50000
end

update Tarifs set [name]=@name ,[internet]=@internet ,[calctraffic]=@calctraffic ,[roundtime]=@roundtime ,
         [roundmoney]=@roundmoney, [idGroup]=@idGroup, [BytesInMB]=@BytesInMB,
    [SpeedLimitInKB]=@SpeedLimitInKB, [PluginGroupName]=@PluginGroupName
    where [id]=@idTarif
GO

ALTER PROCEDURE TarifsVariantsAdd
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
@TrafficSeparatePayment bit =0,
@FreePacket bit =0
  
AS 

set nocount on

insert into TarifsVariants ([idTarifs], [name], [start], [stop],[ispacket], [cost], [daysofweek], [condition],
        [TrafficLimit],[TrafficCost],[TrafficSeparatePayment], [FreePacket])
    values (@idTarifs, @name, @start, @stop, @ispacket, @cost, @daysofweek, @condition, 
        @TrafficLimit,@TrafficCost,@TrafficSeparatePayment, @FreePacket)
GO

ALTER PROCEDURE TarifsVariantsSelect
@idTarifs int
  
AS 
select [id], [name], [start], [stop], [cost], [ispacket], [daysofweek], [condition],[TrafficLimit],[TrafficCost],[TrafficSeparatePayment],[FreePacket]
    from TarifsVariants where [idTarifs]=@idTarifs
GO

ALTER PROCEDURE TarifsVariantsUpdate
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
@TrafficSeparatePayment bit,
@FreePacket bit 
  
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
  [TrafficSeparatePayment] = @TrafficSeparatePayment,
  [FreePacket] = @FreePacket
  where [id] = @idVariants
GO

CREATE TABLE dbo.Process
	(
	id int NOT NULL IDENTITY (1, 1),
	idComputer int NOT NULL,
	[Name] varchar(50) NOT NULL,
	ExeFile varchar(250) NOT NULL,
	StartTime datetime, 	
	StopTime datetime 
	)  ON [PRIMARY]
GO

ALTER TABLE dbo.Process ADD CONSTRAINT
	PK_Process PRIMARY KEY CLUSTERED 
	(
	id
	) ON [PRIMARY]
GO

CREATE PROCEDURE ProcessAdd
  @ProcessStarted bit,
  @IdComputer int,
  @Name varchar(250),
  @ExeFile varchar(250),
  @Moment datetime
  
AS 
  set nocount on

	declare @id int

  if (@ProcessStarted=1)
  begin
    insert into Process ([idComputer], [Name], [ExeFile], [StartTime], [StopTime])
        values (@IdComputer, @Name, @ExeFile, @Moment, NULL)
  end else begin
		select top 1 @id=[id] from Process 
				where [StopTime] is null 
				and [idComputer]=@IdComputer
				and [ExeFile]=@ExeFile
				and ([id] > IDENT_CURRENT('Process')-100) 
				order by id desc
    if @id is null
    begin
      insert into Process ([idComputer], [Name], [ExeFile], [StartTime], [StopTime])
          values (@IdComputer, @Name, @ExeFile, NULL, @Moment )
    end else begin
			update Process set [StopTime]=@Moment where [id]=@id
    end		
  end
GO

GRANT EXECUTE ON [dbo].[ProcessAdd] TO [public]
GO

ALTER TABLE dbo.Hardware ADD
	FullInfo varchar(500) NOT NULL CONSTRAINT DF_Hardware_FullInfo DEFAULT ''
GO

ALTER PROCEDURE HardwareInsert
@idComputers int,
@hardware nvarchar(50),
@value nvarchar(500),
@moment datetime,
@comment nvarchar(200),
@FullInfo varchar(500)
  
AS 

declare @idHardware int
declare @idOperator int
set @idHardware = 0
declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)


/* €®ютх®†хь эрышҐшх ™ш€р цхыхчр */
select @idHardware=[id]  from HardwareType where [name]=@hardware
if (@idHardware = 0) begin
  insert into HardwareType ([name]) values (@hardware)
  select @idHardware = @@identity
end

update Hardware set histored=1 where [idComputers]=@idComputers and [hw_id] = @idHardware
insert into Hardware ([idComputers], [hw_id], [hw_value], [moment], [operator], [histored], [comment], [FullInfo])
  values (@idComputers, @idHardware, @value, @moment, @idMe, 0, @comment, @FullInfo)
GO


ALTER PROCEDURE HardwareSelect
@idComputers int,
@histored int=1
  
AS 

select 
  hw.[id],
  c.[number],
  hwt.[name],
  hw.[hw_value],
  hw.[moment],
  hw.[comment],
  u.[name] operator,
	hw.[FullInfo],
	hw.histored 
from hardware as hw
inner join HardwareType as hwt on (hw.[hw_id] = hwt.[id])
inner join Computers as C on (hw.[idComputers] = C.[id])
inner join Users as U on (hw.[operator] = U.[id])
-- conditions
where C.[number] = @idComputers and hw.[histored]<>@histored and hw.[hw_value]<>N''
order by hw.[moment]

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[gcrem]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	ALTER TABLE [dbo].[gcrem] ADD
		[DetectedMoment] [datetime] NULL
END
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[gcrem]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	UPDATE dbo.gcrem Set DetectedMoment=moment 	
	UPDATE dbo.gcrem Set moment='01 jan 1900 0:00:00'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[gcrem] (
		[moment] [datetime] NULL,
		DetectedMoment [datetime] NULL 
	) ON [PRIMARY]
	INSERT dbo.gcrem VALUES ('01 jan 1900 0:00:00', NULL)
END
GO

update Registry set [value]=N'3.82' where [key]=N'BaseVersion'
GO

