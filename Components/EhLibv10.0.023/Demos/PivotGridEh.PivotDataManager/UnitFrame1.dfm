object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 521
  Height = 427
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 241
    Top = 0
    Width = 8
    Height = 427
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 241
    Height = 427
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object DBGridEh2: TDBGridEh
      Left = 0
      Top = 28
      Width = 241
      Height = 399
      Align = alClient
      AllowedOperations = [alopUpdateEh, alopDeleteEh, alopAppendEh]
      AutoFitColWidths = True
      DataSource = dsReportList
      DynProps = <>
      HorzScrollBar.ExtraPanel.NavigatorButtons = [nbInsertEh, nbDeleteEh, nbEditEh, nbPostEh, nbCancelEh]
      HorzScrollBar.ExtraPanel.Visible = True
      HorzScrollBar.Height = 24
      IndicatorTitle.ShowDropDownSign = True
      IndicatorTitle.TitleButton = True
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu1
      TabOrder = 0
      Columns = <
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'RepName'
          Footers = <>
          Title.Caption = 'Report Name'
          Width = 208
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'ID'
          Footers = <>
          Visible = False
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'SQLText'
          Footers = <>
          Visible = False
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'ColsList'
          Footers = <>
          Visible = False
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'RowsList'
          Footers = <>
          Visible = False
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'ValuesList'
          Footers = <>
          Visible = False
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 241
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        241
        28)
      object SpeedButton1: TSpeedButton
        Left = 2
        Top = 1
        Width = 29
        Height = 27
        Hint = 'Go to Pivot Data Page'
        Caption = '>'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton1Click
      end
      object bSelectTheRep: TButton
        Left = 32
        Top = 1
        Width = 207
        Height = 27
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Select Report'
        TabOrder = 0
        OnClick = bSelectTheRepClick
      end
    end
  end
  object PageControl1: TPageControl
    Left = 249
    Top = 0
    Width = 272
    Height = 427
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Public Fields'
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 264
        Height = 399
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          264
          399)
        object DBMemoEh1: TDBMemoEh
          Left = 6
          Top = 28
          Width = 251
          Height = 109
          ControlLabel.Width = 110
          ControlLabel.Height = 13
          ControlLabel.Caption = 'Connection Parameters'
          ControlLabel.Visible = True
          ScrollBars = ssVertical
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          DataField = 'ConnectionParameters'
          DataSource = dsReportList
          DynProps = <>
          EditButtons = <
            item
              Style = ebsEllipsisEh
              OnClick = DBMemoEh1EditButtons0Click
            end>
          TabOrder = 0
          Visible = True
          WantReturns = True
        end
        object DBMemoEh2: TDBMemoEh
          Left = 6
          Top = 156
          Width = 251
          Height = 61
          ControlLabel.Width = 45
          ControlLabel.Height = 13
          ControlLabel.Caption = 'File paths'
          ControlLabel.Visible = True
          ScrollBars = ssVertical
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          DataField = 'FilePaths'
          DataSource = dsReportList
          DynProps = <>
          EditButtons = <>
          TabOrder = 1
          Visible = True
          WantReturns = True
        end
        object DBMemoEh3: TDBMemoEh
          Left = 6
          Top = 240
          Width = 251
          Height = 153
          ControlLabel.Width = 45
          ControlLabel.Height = 13
          ControlLabel.Caption = 'SQL Text'
          ControlLabel.Visible = True
          ScrollBars = ssBoth
          Anchors = [akLeft, akTop, akRight, akBottom]
          AutoSize = False
          DataField = 'SQLText'
          DataSource = dsReportList
          DynProps = <>
          EditButtons = <>
          TabOrder = 2
          Visible = True
          WantReturns = True
        end
        object bTestConnection: TButton
          Left = 136
          Top = 7
          Width = 121
          Height = 19
          Caption = 'Test Connection'
          TabOrder = 3
          OnClick = bTestConnectionClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Internal Fields'
      ImageIndex = 1
      object DBMemoEh4: TDBMemo
        Left = 0
        Top = 0
        Width = 264
        Height = 399
        Align = alClient
        DataField = 'LayoutAsXML'
        DataSource = dsReportList
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object mtReportList: TMemTableEh
    Active = True
    Params = <>
    DataDriver = ddrReportList
    Left = 30
    Top = 333
  end
  object dsReportList: TDataSource
    DataSet = mtReportList
    Left = 112
    Top = 333
  end
  object ddrReportList: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SpecParams.Strings = (
      'AUTO_INCREMENT_FIELD=ID')
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  PivotReports')
    SelectCommand.Parameters = <>
    UpdateCommand.CommandText.Strings = (
      'update PivotReports'
      'set'
      '  RepName = :RepName,'
      '  ConnectionParameters = :ConnectionParameters,'
      '  FilePaths = :FilePaths,'
      '  SQLText = :SQLText,'
      '  LayoutAsXML = :LayoutAsXML'
      'where'
      '  ID = :OLD_ID')
    UpdateCommand.Parameters = <
      item
        Name = 'RepName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'ConnectionParameters'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'FilePaths'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'SQLText'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'LayoutAsXML'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'OLD_ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    InsertCommand.CommandText.Strings = (
      'insert into PivotReports'
      
        '  (RepName, ConnectionParameters, FilePaths, SQLText, LayoutAsXM' +
        'L)'
      'values'
      
        '  (:RepName, :ConnectionParameters, :FilePaths, :SQLText, :Layou' +
        'tAsXML)')
    InsertCommand.Parameters = <
      item
        Name = 'RepName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'ConnectionParameters'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'FilePaths'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'SQLText'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'LayoutAsXML'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    DeleteCommand.CommandText.Strings = (
      'delete from PivotReports'
      'where'
      '  ID = :OLD_ID')
    DeleteCommand.Parameters = <
      item
        Name = 'OLD_ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    GetrecCommand.CommandText.Strings = (
      'select *'
      'from'
      '  PivotReports'
      '  ID = :OLD_ID')
    GetrecCommand.Parameters = <
      item
        Name = 'OLD_ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 146
    Top = 333
  end
  object ADOConnectionProviderEh1: TADOConnectionProviderEh
    InlineConnection.Connected = True
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\..\D' +
      'ata\DBTest.mdb;Persist Security Info=False'
    InlineConnection.Mode = cmShareDenyNone
    InlineConnection.Provider = 'Microsoft.Jet.OLEDB.4.0'
    ServerType = 'MSAccess'
    OnExecuteCommand = ADOConnectionProviderEh1ExecuteCommand
    InlineConnectionBeforeConnect = ADOConnectionProviderEh1InlineConnectionBeforeConnect
    Left = 178
    Top = 333
  end
  object PopupMenu1: TPopupMenu
    Left = 160
    Top = 160
    object ShowHideSQLMonitor1: TMenuItem
      Caption = 'Show/Hide SQL Monitor'
      OnClick = ShowHideSQLMonitor1Click
    end
  end
end
