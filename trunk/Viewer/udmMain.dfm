object dmMain: TdmMain
  OldCreateOrder = False
  Left = 631
  Top = 162
  Height = 673
  Width = 533
  object cnnMain: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password="";Persist Security Info=True;User ' +
      'ID=manager;Initial Catalog=GameClass;Data Source=127.0.0.1'
    Provider = 'SQLOLEDB.1'
    Left = 48
    Top = 8
  end
  object dstFreeComps: TADOQuery
    Parameters = <>
    Left = 320
    Top = 392
  end
  object dsrcFreeComps: TDataSource
    Left = 248
    Top = 440
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
  object dsrcCompStates: TDataSource
    DataSet = dstCompStates
    Left = 352
    Top = 72
  end
  object dstCompStateGroups: TADOQuery
    Connection = cnnMain
    Parameters = <>
    SQL.Strings = (
      'select 3 Free, 4 FreeLimited, 8 BusyLimited, 10 Busy')
    Left = 160
    Top = 392
  end
  object dstSessionsSelect84: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'SessionsSelect;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@now'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end>
    Left = 48
    Top = 120
  end
  object dstCompsSelect: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'ComputersSelect;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@idGroup'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 48
    Top = 224
  end
  object dstCompStates: TADODataSet
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'idComp'
        DataType = ftInteger
      end
      item
        Name = 'number'
        DataType = ftInteger
      end
      item
        Name = 'state'
        DataType = ftInteger
      end
      item
        Name = 'description'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'icon'
        DataType = ftInteger
      end>
    Parameters = <>
    StoreDefs = True
    Left = 216
    Top = 72
  end
  object dstCompRelease: TADODataSet
    FieldDefs = <
      item
        Name = 'count'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'time'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'time0.5'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'time1'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'time1.5'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'time2'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'time3'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'time4'
        DataType = ftString
        Size = 20
      end>
    Parameters = <>
    StoreDefs = True
    Left = 216
    Top = 176
  end
  object dsrcCompRelease: TDataSource
    DataSet = dstCompRelease
    Left = 352
    Top = 176
  end
  object dstTimes: TADODataSet
    FieldDefs = <
      item
        Name = 'time'
        DataType = ftDateTime
      end>
    Parameters = <>
    StoreDefs = True
    Left = 216
    Top = 224
  end
  object dsrcCompStatesSecond: TDataSource
    DataSet = dstCompStatesSecond
    Left = 352
    Top = 128
  end
  object dstCompStatesSecond: TADODataSet
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'idComp'
        DataType = ftInteger
      end
      item
        Name = 'number'
        DataType = ftInteger
      end
      item
        Name = 'state'
        DataType = ftInteger
      end
      item
        Name = 'description'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'icon'
        DataType = ftInteger
      end>
    Parameters = <>
    StoreDefs = True
    Left = 216
    Top = 128
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
  object dstSessionsSelect85: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'SessionsSelect;1'
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
        Name = '@dt'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end>
    Left = 48
    Top = 176
  end
  object dstBaseVersionSelect: TADOQuery
    Connection = cnnMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'exec RegistrySelectByKey '#39'BaseVersion'#39)
    Left = 296
    Top = 8
  end
end
