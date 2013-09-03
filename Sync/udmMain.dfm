object dmMain: TdmMain
  OldCreateOrder = False
  Left = 599
  Top = 315
  Height = 460
  Width = 499
  object cnnMain: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password="";Persist Security Info=True;User ' +
      'ID=manager;Initial Catalog=GameClass;Data Source=PVA'
    Provider = 'SQLOLEDB.1'
    Left = 48
    Top = 8
  end
  object dstUserName: TADOQuery
    Connection = cnnMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'exec RegistrySelectByKey '#39'ClubName'#39)
    Left = 120
    Top = 64
    object dstUserNameValue: TStringField
      FieldName = 'Value'
      Size = 7000
    end
  end
  object dsrcSyncServersSelect: TDataSource
    DataSet = dstSyncServersSelect
    Left = 48
    Top = 168
  end
  object dstSyncServersSelect: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'SyncServersSelect;1'
    Parameters = <>
    Left = 48
    Top = 120
  end
  object cnnDestination: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password="";Persist Security Info=True;User ' +
      'ID=manager;Initial Catalog=GameClass;Data Source=PVA'
    Provider = 'SQLOLEDB.1'
    Left = 120
    Top = 8
  end
  object dstClubName: TADOQuery
    Connection = cnnMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'exec RegistrySelectByKey '#39'ClubName'#39)
    Left = 48
    Top = 64
    object dstClubNameValue: TStringField
      FieldName = 'Value'
      Size = 7000
    end
  end
  object dstSyncServersInsert: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'SyncServersInsert;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Name'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@ClubName'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end>
    Left = 168
    Top = 120
  end
  object dstSyncServersDelete: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'SyncServersDelete;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@id'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 280
    Top = 120
  end
  object dstSyncServersUpdate: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'SyncServersUpdate;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@id'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Name'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@ClubName'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end>
    Left = 392
    Top = 120
  end
  object dstAccountsSelect: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'AccountsSelectUnsynchronized;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@idSyncServer'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 48
    Top = 232
  end
  object dstAccountsSync: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'AccountsSyncUnsynchronized'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@guid'
        Attributes = [paNullable]
        DataType = ftGuid
        Value = Null
      end
      item
        Name = '@idSyncServer'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 168
    Top = 232
  end
  object dstAccountsHistorySelect: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'AccountsHistorySelectUnsynchronized;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@idSyncServer'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 280
    Top = 232
  end
  object dstAccountsHistorySync: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'AccountsHistorySyncUnsynchronized'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@guid'
        Attributes = [paNullable]
        DataType = ftGuid
        Value = Null
      end
      item
        Name = '@idSyncServer'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 408
    Top = 232
  end
  object dstAccountsInsert: TADOStoredProc
    Connection = cnnDestination
    ProcedureName = 'AccountsInsertUnsynchronized'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@guid'
        Attributes = [paNullable]
        DataType = ftGuid
        Value = Null
      end
      item
        Name = '@name'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 50
        Value = Null
      end
      item
        Name = '@password'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 50
        Value = Null
      end
      item
        Name = '@email'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 80
        Value = Null
      end
      item
        Name = '@phone'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 50
        Value = Null
      end
      item
        Name = '@photo'
        Attributes = [paNullable]
        DataType = ftVarBytes
        Size = 2147483647
        Value = Null
      end
      item
        Name = '@seccodes'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 80
        Value = Null
      end
      item
        Name = '@isenabled'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@isblocked'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@isprivileged'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@isdeleted'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@zeroBalance'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@privilegedDiscount'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@balance'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@summary'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@address'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 300
        Value = Null
      end
      item
        Name = '@memo'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 2000
        Value = Null
      end
      item
        Name = '@PeriodOfValidity'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@ExpirationDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 10
        Size = 20
        Value = Null
      end
      item
        Name = '@assigntarif'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@userlevel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@force_tariff'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@referal'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@username'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 80
        Value = Null
      end
      item
        Name = '@uname'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 80
        Value = Null
      end
      item
        Name = '@uotch'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 80
        Value = Null
      end
      item
        Name = '@hardcode'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 50
        Value = Null
      end
      item
        Name = '@ignorehardcode'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 48
    Top = 288
  end
  object dstAccountsUpdate: TADOStoredProc
    Connection = cnnDestination
    ProcedureName = 'AccountsUpdateUnsynchronized'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@guid'
        Attributes = [paNullable]
        DataType = ftGuid
        Value = Null
      end
      item
        Name = '@name'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 50
        Value = Null
      end
      item
        Name = '@password'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 50
        Value = Null
      end
      item
        Name = '@email'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 80
        Value = Null
      end
      item
        Name = '@phone'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 50
        Value = Null
      end
      item
        Name = '@photo'
        Attributes = [paNullable]
        DataType = ftVarBytes
        Size = 2147483647
        Value = Null
      end
      item
        Name = '@seccodes'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 80
        Value = Null
      end
      item
        Name = '@isenabled'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@isblocked'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@isprivileged'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@isdeleted'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@privilegedDiscount'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@zeroBalance'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@summary'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@address'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 300
        Value = Null
      end
      item
        Name = '@memo'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 2000
        Value = Null
      end
      item
        Name = '@updated'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@PeriodOfValidity'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@ExpirationDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 10
        Size = 20
        Value = Null
      end
      item
        Name = '@assigntarif'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@userlevel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@force_tariff'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@referal'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@username'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 80
        Value = Null
      end
      item
        Name = '@uname'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 80
        Value = Null
      end
      item
        Name = '@uotch'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 80
        Value = Null
      end
      item
        Name = '@hardcode'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 50
        Value = Null
      end
      item
        Name = '@ignorehardcode'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 160
    Top = 288
  end
  object dstAccountsHistoryInsert: TADOStoredProc
    Connection = cnnDestination
    ProcedureName = 'AccountsHistoryInsertUnsynchronized;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@guid'
        Attributes = [paNullable]
        DataType = ftGuid
        Value = Null
      end
      item
        Name = '@guidAccounts'
        Attributes = [paNullable]
        DataType = ftGuid
        Value = Null
      end
      item
        Name = '@moment'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@what'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@summa'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@comment'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 200
        Value = Null
      end
      item
        Name = '@initialization'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 288
    Top = 288
  end
  object dstIsManager: TADOQuery
    Connection = cnnMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select dbo.IsManager() as value')
    Left = 200
    Top = 8
  end
  object cmdAccountsDelete: TADOCommand
    CommandText = 'DELETE Accounts WHERE [id] <> 0'
    Connection = cnnMain
    Parameters = <>
    Left = 48
    Top = 344
  end
  object cmdAccountsHistoryDelete: TADOCommand
    CommandText = 'delete AccountsHistory'
    Connection = cnnMain
    Parameters = <>
    Left = 168
    Top = 344
  end
  object dstGetSyncServerIdByName: TADOQuery
    Connection = cnnMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'Name'
        DataType = ftString
        Size = 20
        Value = '11'
      end>
    SQL.Strings = (
      'select dbo.GetSyncServerIdByName(:Name) as value')
    Left = 320
    Top = 8
  end
end
