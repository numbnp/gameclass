USE GameClass
GO

UPDATE SessionsAdd2 set summa=ROUND(summa,0)
GO

UPDATE JournalOp SET summa=ROUND(summa,0)
GO

UPDATE Accounts SET balance=ROUND(balance,0), summary=ROUND(summary,0) 
GO

UPDATE AccountsHistory SET summa=ROUND(summa,0) 
GO

UPDATE Sessions SET payed=ROUND(payed,0) 
GO
