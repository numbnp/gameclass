Use GameClass
Go

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
        WHERE ((SA.[start]<=@now) OR (S.[status]=0)) AND (@now<SA.[stop]) AND (SA2.[ActionType] <> 3) --чтоб не считать деньги за траф в сумме
        GROUP BY S.[id], S.[idClients], S.[traffic], S.[printed], S.[postpay], S.[started], S.[payed], S.[description], SA.[id], 
            SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], S.[minpenalty], SA.[whole], S.[state], S.[status], S.[TrafficAdded]
END
GO

GRANT  EXECUTE  ON [dbo].[SessionsSelect]  TO [public]
GO

update Registry set [value]=N'3.75b' where [key]=N'BaseVersion'
GO
