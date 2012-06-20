object dmMain: TdmMain
  OldCreateOrder = False
  Left = 175
  Top = 267
  Height = 332
  Width = 637
  object bsPolyglotManager: TbsPolyglotManager
    LangsDir = '.\Language\'
    TranslateResourceStrings = True
    Left = 32
  end
  object bsPolyglotTranslator: TbsPolyglotTranslator
    Manager = bsPolyglotManager
    Left = 144
  end
  object cnnMain: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password="";Persist Security Info=True;User ' +
      'ID=manager;Initial Catalog=GameClass;Data Source=pva-xp'
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 48
  end
  object dstOnInitDatabase: TADOStoredProc
    ProcedureName = 'OnInitDatabase;1'
    Parameters = <>
    Left = 32
    Top = 96
  end
  object dstGetLogonInfo: TADOStoredProc
    ProcedureName = 'GetLogonInfo;1'
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
        Name = '@Value'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = Null
      end>
    Left = 128
    Top = 96
  end
  object dstCurrentReport: TADOStoredProc
    Connection = cnnMain
    ProcedureName = 'ReportCurrent;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@NewShiftPoint'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@LastShiftPoint'
        Attributes = [paNullable]
        DataType = ftDateTime
        Direction = pdInputOutput
        Value = Null
      end
      item
        Name = '@Time'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@Serices'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@Print'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@Internet'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@AccountsAdded'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@AccountsPayed'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@AccountsReturned'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@Rest'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end>
    Left = 32
    Top = 152
  end
end
