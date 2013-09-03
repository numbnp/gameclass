USE GameClass
GO

/* -----------------------------------------------------------------------------
                  Изменение Select-процедур для скрытия полей sync и guid
----------------------------------------------------------------------------- */
ALTER PROCEDURE AccountsSelect
  @id INT = NULL

AS 
BEGIN
  SELECT [id], [name], [password], email, phone, photo, seccodes, 
      isenabled, isblocked, isprivileged, isdeleted, privilegedDiscount, 
      zeroBalance, balance, summary, address, memo, PeriodOfValidity, 
      ExpirationDate, assigntarif, userlevel, force_tariff, referal, username, 
      uname, uotch, hardcode ,ignorehardcode  FROM Accounts 
      WHERE ([isdeleted] = 0) AND ((Accounts.[id] = @id) OR (@id IS NULL))
      ORDER BY [id]
END
GO

ALTER PROCEDURE AccountsHistorySelect
@idAccount int = 0

AS

if (@idAccount = 0) 
  select [id], idAccounts, moment, what, summa, comment, operator 
      from AccountsHistory order by [id]
else
  select top 10 [id], idAccounts, moment, what, summa, comment, operator
      from AccountsHistory where [idAccounts] = @idAccount order by [moment] DESC
GO



/* -----------------------------------------------------------------------------
                  Новые процедуры и функции
----------------------------------------------------------------------------- */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsSelectUnsynchronized]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsSelectUnsynchronized]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsInsertUnsynchronized]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsInsertUnsynchronized]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsUpdateUnsynchronized]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsUpdateUnsynchronized]
GO


CREATE PROCEDURE AccountsSelectUnsynchronized
@idSyncServer int

AS
BEGIN
  SELECT guid, [name], [password], email, phone, photo, seccodes, 
      isenabled, isblocked, isprivileged, isdeleted, privilegedDiscount, 
      zeroBalance, balance, summary, address, memo, updated, PeriodOfValidity, 
	ExpirationDate, assigntarif, userlevel, force_tariff, referal, username, 
	uname, uotch, hardcode ,ignorehardcode  FROM Accounts 
      WHERE (sync & CAST(POWER(2.0, @idSyncServer - 1) AS bigint)) = 0
      AND [id] <> 0
      ORDER BY [id]
END
GO

CREATE PROCEDURE AccountsInsertUnsynchronized
@guid uniqueidentifier,
@name nvarchar(50),  
@password nvarchar(50),  
@email nvarchar(80),  
@phone nvarchar(50),  
@photo image,  
@seccodes nvarchar(80),  
@isenabled int,  
@isblocked int,  
@isprivileged int,  
@isdeleted int,  
@privilegedDiscount int,  
@zeroBalance money,  
@balance money,  
@summary money,  
@address nvarchar(300),  
@memo nvarchar(2000),
@PeriodOfValidity int,
@ExpirationDate datetime,
@assigntarif int,
@userlevel int,
@force_tariff int,
@referal int,
@username nvarchar(80),
@uname  nvarchar(80),
@uotch nvarchar(80),
@hardcode nvarchar(50), 
@ignorehardcode int 

AS 
BEGIN
  IF NOT EXISTS (SELECT * FROM Accounts WHERE [guid] = @guid)
    INSERT INTO [Accounts]
        ([guid], [name], [password], [email], [phone], [photo], [seccodes], 
        [isenabled], [isblocked], [isprivileged], [isdeleted], [privilegedDiscount], 
        [zeroBalance], [balance], [summary], [address], [memo], [sync], [PeriodOfValidity], 
	[ExpirationDate], [assigntarif], [userlevel], [force_tariff], [referal], [username], 
	[uname], [uotch], [hardcode], [ignorehardcode])
        VALUES(@guid, @name, @password, @email, @phone, @photo, @seccodes,
        @isenabled, @isblocked, @isprivileged, @isdeleted, @privilegedDiscount,
        @zeroBalance, @balance, @summary, @address, @memo, 9223372036854775807,
	@PeriodOfValidity, @ExpirationDate, @assigntarif, @userlevel, @force_tariff, @referal, 
	@username, @uname, @uotch, @hardcode, @ignorehardcode)

END
GO

/* Update не меняет поле balance */
CREATE PROCEDURE AccountsUpdateUnsynchronized
@guid uniqueidentifier,
@name nvarchar(50),  
@password nvarchar(50),  
@email nvarchar(80),  
@phone nvarchar(50),  
@photo image,  
@seccodes nvarchar(80),  
@isenabled int,  
@isblocked int,  
@isprivileged int,  
@isdeleted int,  
@privilegedDiscount int,  
@zeroBalance money,  
@summary money,  
@address nvarchar(300),  
@memo nvarchar(2000),
@updated datetime,
@PeriodOfValidity int,
@ExpirationDate datetime,
@assigntarif int,
@userlevel int,
@force_tariff int,
@referal int,
@username nvarchar(80),
@uname  nvarchar(80),
@uotch nvarchar(80),
@hardcode nvarchar(50), 
@ignorehardcode int 

AS 
BEGIN
  IF NOT EXISTS (SELECT * FROM Accounts WHERE [guid] = @guid)
    INSERT INTO [Accounts]
        ([guid], [name], [password], [email], [phone], [photo], [seccodes], 
        [isenabled], [isblocked], [isprivileged], [isdeleted], [privilegedDiscount], 
        [zeroBalance], [balance], [summary], [address], [memo], [sync], [PeriodOfValidity], 
	[ExpirationDate], [assigntarif], [userlevel], [force_tariff], [referal], [username], 
	[uname], [uotch], [hardcode], [ignorehardcode])
        VALUES(@guid, @name, @password, @email, @phone, @photo, @seccodes,
        @isenabled, @isblocked, @isprivileged, @isdeleted, @privilegedDiscount,
        @zeroBalance, 0.00, @summary, @address, @memo, 9223372036854775807,
	@PeriodOfValidity, @ExpirationDate, @assigntarif, @userlevel, @force_tariff, @referal, 
	@username, @uname, @uotch, @hardcode, @ignorehardcode)
  ELSE
    UPDATE [Accounts] SET
        [name] = @name, [password] = @password, [email] = @email, [phone] = @phone,
        [photo] = @photo, [seccodes] = @seccodes, [isenabled] = @isenabled, 
        [isblocked] = @isblocked, [isprivileged] = @isprivileged, [isdeleted] = @isdeleted,
        [privilegedDiscount] = @privilegedDiscount, [zeroBalance] = @zeroBalance,
        [summary] = @summary, [address] = @address, [memo] = @memo, 
	[sync] = 9223372036854775807, [updated] = @updated, [PeriodOfValidity] = @PeriodOfValidity, [ExpirationDate] = @ExpirationDate,
	[assigntarif] = @assigntarif, [userlevel] = @userlevel, [force_tariff] = @force_tariff, [referal] = @referal, [username] = @username, 
	[uname] = @uname, [uotch] = @uotch, [hardcode] = @hardcode, [ignorehardcode] = @ignorehardcode 
        WHERE [guid] = @guid AND [updated] <= @updated
END
GO



GRANT EXEC ON [AccountsSelectUnsynchronized] TO [gcsync]
GO

GRANT EXEC ON [AccountsInsertUnsynchronized] TO [gcsync]
GO

GRANT EXEC ON [AccountsUpdateUnsynchronized] TO [gcsync]
GO

/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value] = '1.0.5', [Public] = 0 WHERE [key]='SyncOptions\Version'
GO

