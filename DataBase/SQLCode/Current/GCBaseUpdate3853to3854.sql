USE GameClass
GO

/* -----------------------------------------------------------------------------
                               Чистим AutoUpdate
----------------------------------------------------------------------------- */


DELETE FROM [GameClass].[dbo].[AutoUpdate] WHERE 1=1;
GO

/* -----------------------------------------------------------------------------
                               Правим тригер
----------------------------------------------------------------------------- */

DROP TRIGGER AccountsAutoUPDATE;
GO

CREATE TRIGGER AccountsAutoUPDATE ON [dbo].[Accounts] 

FOR INSERT, UPDATE, DELETE 
AS
BEGIN
  DECLARE @idI INT
  DECLARE @idD INT
  DECLARE @idAction INT
  DECLARE @idRecord INT
  DECLARE @isdeleted INT

  DECLARE @flag INT
  DECLARE @idActionOld INT
  DECLARE @idTableOld INT
  DECLARE @idRecordOld INT

  DECLARE IDcursor CURSOR FOR SELECT I.id AS [idI], D.id AS [idD], 
    I.isdeleted FROM INSERTED AS I
    FULL OUTER JOIN DELETED AS D ON I.id = D.id
  OPEN IDcursor
  FETCH NEXT FROM IDcursor INTO @idI, @idD, @isdeleted

  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF NOT(@idI IS NULL) AND (@idD IS NULL) 
      SET @idAction = 1 --Insert
    IF (@idI IS NULL) AND NOT(@idD IS NULL) 
      SET @idAction = 2 --Delete
    IF NOT(@idI IS NULL) AND NOT(@idD IS NULL) 
      BEGIN 
        IF @isdeleted = 0
          SET @idAction = 3 --Update
        ELSE
          SET @idAction = 2 --Delete
      END
	SET @idRecord = ISNULL(@idI,@idD)

	IF @idAction = 2
	BEGIN
		SELECT @flag=count([id]) FROM [GameClass].[dbo].[AutoUpdate] WHERE 
			(idTable=1) AND (idAction=2) AND (idRecord=@idRecord)
		IF @flag >0
			DELETE FROM [GameClass].[dbo].[AutoUpdate] WHERE (idTable=1) AND (idAction=2) AND (idRecord=@idRecord)
		ELSE
			INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(1/*Accounts*/, @idAction, @idRecord)
	END

	IF @idAction <> 2
			INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(1/*Accounts*/, @idAction, @idRecord)

    FETCH NEXT FROM IDcursor INTO @idI, @idD, @isdeleted
  END

  CLOSE IDcursor
  DEALLOCATE IDcursor
END
GO


/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value]='3.85.4' WHERE [key]='BaseVersion'
GO


