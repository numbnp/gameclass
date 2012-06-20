USE GameClass
GO


/* -----------------------------------------------------------------------------
           Измения для сеансов: отдельная плата за трафик, услуги и т.д.
		процедуры SessionsSelect
----------------------------------------------------------------------------- */
ALTER PROCEDURE SessionsSelect
  @id int = NULL,
  @dt datetime

AS 
BEGIN
    SET NOCOUNT ON
    SELECT SS.idSessions, idSessionsAdd, SS.idComp, SS.idClients, SS.started, SS.start, SS.stop, 
            SS.idTarif, SS.whole, SS.postpay, SS.description,
            SS.CommonPay, SS.SeparateTrafficPay, SS.PrintCost, SS.ServiceCost, SS.AdditionalMinutes, 
            SUM(SA.[Traffic]) SummaryTraffic, SUM(SA.[TrafficCost]) SummaryTrafficCost, SUM(SA.[SeparateTrafficCost]) SummarySeparateTrafficCost,
            SS.CurrentTraffic, SS.CurrentTrafficCost, SS.CurrentSeparateTrafficCost,
            SS.CurrentCommonPay, 
            SS.state, SS.status FROM
    (SELECT S.[id] idSessions, SA.[id] idSessionsAdd, SA.[idComp], S.[idClients], S.[started], SA.[start], SA.[stop], 
            SA.[idTarif], SA.[whole], S.[postpay], S.[description],
            S.[CommonPay], S.[SeparateTrafficPay], S.[PrintCost], S.[ServiceCost], 
            S.[AdditionalMinutes], 
            SUM(SA.[Traffic]) SummaryTraffic, SUM(SA.[TrafficCost]) SummaryTrafficCost, SUM(SA.[SeparateTrafficCost]) SummarySeparateTrafficCost,
            SA.[Traffic] CurrentTraffic, SA.[TrafficCost] CurrentTrafficCost, SA.[SeparateTrafficCost] CurrentSeparateTrafficCost,
            ISNULL(SUM(SA2Common.[summa]), 0) CurrentCommonPay,
            S.[state], S.[status]
        FROM Sessions AS S
        INNER JOIN SessionsAdd AS SA ON (S.[id] = SA.[idSessions])
        LEFT OUTER JOIN SessionsAdd2 AS SA2Common 
            ON (SA.[id] = SA2Common.[idSessionsAdd]) AND (SA2Common.[ActionType] <> 3)
        WHERE (((SA.[start]<=@dt) OR (S.[status]=0)) AND (@dt<SA.[stop]) AND (@id IS NULL)) OR (SA.[idSessions] = @id)
        GROUP BY S.[id], S.[idClients], S.[postpay], S.[started], S.[CommonPay], S.[SeparateTrafficPay], S.[PrintCost], S.[ServiceCost], 
            S.[description], SA.[id], SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], S.[AdditionalMinutes], 
            SA.[whole], SA.[Traffic], SA.[TrafficCost], SA.[SeparateTrafficCost], S.[state], S.[status]
        ) SS
        INNER JOIN SessionsAdd AS SA ON (SA.[idSessions] = SS.[idSessions])
        GROUP BY SS.idSessions, idSessionsAdd, SS.idComp, SS.idClients, SS.started, SS.start, SS.stop, 
            SS.idTarif, SS.whole, SS.postpay, SS.description,
            SS.CommonPay, SS.SeparateTrafficPay, SS.PrintCost, SS.ServiceCost, SS.AdditionalMinutes, 
            SS.CurrentTraffic, SS.CurrentTrafficCost, SS.CurrentSeparateTrafficCost,
            SS.CurrentCommonPay, 
            SS.state, SS.status
        ORDER BY SS.idSessions
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsSeparateTrafficConstSelect]') 
  and OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE SessionsSeparateTrafficConstSelect
GO

CREATE PROCEDURE SessionsSeparateTrafficConstSelect
  @id int = NULL

AS 
    SET NOCOUNT ON
    SELECT SS.idSessions, SS.CurrentSeparateTrafficPay FROM
    (SELECT S.[id] idSessions, ISNULL(SUM(SA2SeparateTraff.[summa]), 0) CurrentSeparateTrafficPay
        FROM Sessions AS S
        INNER JOIN SessionsAdd AS SA ON (S.[id] = SA.[idSessions])
        LEFT OUTER JOIN SessionsAdd2 AS SA2SeparateTraff 
            ON (SA.[id] = SA2SeparateTraff.[idSessionsAdd]) AND (SA2SeparateTraff.[ActionType] = 3)
        WHERE (SA.[idSessions] = @id)
        GROUP BY S.[id] ) SS
        INNER JOIN SessionsAdd AS SA ON (SA.[idSessions] = SS.[idSessions])
        GROUP BY SS.idSessions, SS.CurrentSeparateTrafficPay ORDER BY SS.idSessions

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[SessionsSeparateTrafficConstSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value]='3.85.2' WHERE [key]='BaseVersion'
GO


