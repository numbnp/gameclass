USE GameClass
GO

/* -----------------------------------------------------------------------------
                 Триггер для Accounts сбрасывающий sync при Update
----------------------------------------------------------------------------- */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsUpdateTrigger]') 
    AND OBJECTPROPERTY(id, N'IsTrigger') = 1)
  DROP TRIGGER [dbo].[AccountsUpdateTrigger]
GO

CREATE TRIGGER AccountsUpdateTrigger ON [dbo].[Accounts]
FOR UPDATE
AS
BEGIN
  
  DECLARE @idI INT
  DECLARE @idD INT
  DECLARE @syncI bigint
  DECLARE @syncD bigint

  DECLARE AUcursor CURSOR FOR SELECT I.id AS [idI], D.id AS [idD], 
    I.sync AS [syncI], D.sync AS [syncD] FROM INSERTED AS I
    FULL OUTER JOIN DELETED AS D ON I.id = D.id
  OPEN AUcursor
  FETCH NEXT FROM AUcursor INTO @idI, @idD, @syncI, @syncD  

  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF NOT ((@idD IS NOT NULL) AND (@syncI <> @syncD)) AND (@syncI <> 0)
      UPDATE Accounts SET [updated] = GETDATE(), [sync] = 0 WHERE [id] = @idI
    FETCH NEXT FROM AUcursor INTO @idI, @idD, @syncI, @syncD  
  END

  CLOSE AUcursor
  DEALLOCATE AUcursor
END
GO

/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value] = '1.0.1', [Public] = 0 WHERE [key]='SyncOptions\Version'
GO

