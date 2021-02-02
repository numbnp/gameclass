object Frame2: TFrame2
  Left = 0
  Top = 0
  Width = 687
  Height = 560
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 217
    Top = 0
    Width = 8
    Height = 560
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 217
    Height = 560
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 217
      Height = 67
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        217
        67)
      object lReportName: TLabel
        Left = 39
        Top = 11
        Width = 62
        Height = 13
        Caption = 'lReportName'
      end
      object SpeedButton1: TSpeedButton
        Left = 4
        Top = 1
        Width = 32
        Height = 32
        Hint = 'Go to Report list Page'
        Caption = '<'
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton1Click
      end
      object sbSave: TSpeedButton
        Left = 175
        Top = 1
        Width = 32
        Height = 32
        Hint = 'Save Pivot structure and layout'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000C9AEFFC9AEFF
          C9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AE
          FFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9
          AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFF
          D4AE74C1862ECABBA2CABBA2CABBA2CABBA2CABBA2CABBA2CABBA2CABBA2C186
          2ED4AF75C9AEFFC9AEFFC9AEFFC9AEFFD69433DB9834F1F0ECF1F0ECF1F0ECF1
          F0ECF1F0ECF1F0ECF1F0ECF1F0ECDB9834D59432C9AEFFC9AEFFC9AEFFC9AEFF
          DB9834DB9834F1F0ECDEDCD7D4D2CCD4D2CCD4D2CCD4D2CCDEDCD7F1F0ECDB98
          34DB9834C9AEFFC9AEFFC9AEFFC9AEFFDB9834DB9834F1F0ECDEDCD7D5D2CED5
          D2CED5D2CED5D2CEDFDDD7F1F0ECDB9834DB9834C9AEFFC9AEFFC9AEFFC9AEFF
          DB9834DB9834EEE5D4F1F0ECF1F0ECF1F0ECF1F0ECF1F0ECF1F0ECEEE3D2DB98
          34DB9834C9AEFFC9AEFFC9AEFFC9AEFFDB9834DB9834DEA147E2B673E2B773E2
          B773E2B773E2B773E2B672DEA146DB9834DB9834C9AEFFC9AEFFC9AEFFC9AEFF
          DB9834DB9834DB9834DB9834DB9834DB9834DB9834DB9834DB9834DB9834DB98
          34DB9834C9AEFFC9AEFFC9AEFFC9AEFFDB9834DB9834DB9834DB9834DB9834DB
          9834DB9834DB9834DB9834DB9834DB9834DB9834C9AEFFC9AEFFC9AEFFC9AEFF
          DB9834DB9834C6892DC3954ECBA569CBA569CBA569CBA569C3954DC68A2DDB98
          34DB9834C9AEFFC9AEFFC9AEFFC9AEFFDB9834DB9834C49751D7D6CDBFBFB3C7
          C6BCF1F0ECF1F0ECF0EFEAC3954DDB9834DB9834C9AEFFC9AEFFC9AEFFC9AEFF
          D99635DB9834CCA76CBEBDB2A6A595A6A595F1F0ECF1F0ECF1F0ECCBA569DB98
          34EDCB99C9AEFFC9AEFFC9AEFFC9AEFFE8BE7FD99635CCA76CD4D2CCCCC9C3CC
          C9C3F1F0ECF1F0ECF1F0ECCBA569EDCB99C9AEFFC9AEFFC9AEFFC9AEFFC9AEFF
          C9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AE
          FFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9
          AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFFC9AEFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = sbSaveClick
      end
      object bRebuildPivotData: TButton
        Left = 4
        Top = 34
        Width = 203
        Height = 32
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Rebuild Pivot Data'
        TabOrder = 0
        OnClick = bRebuildPivotDataClick
      end
    end
    object panPivotGridToolBox: TPanel
      Left = 0
      Top = 67
      Width = 217
      Height = 441
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 217
        Height = 441
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object PivotGridToolBoxEh1: TPivotGridToolBoxEh
          Left = 0
          Top = 0
          Width = 217
          Height = 441
          PivotDataSource = PivotDataSourceEh1
          Align = alClient
          BevelOuter = bvNone
          Caption = 'PivotGridToolBoxEh1'
          DoubleBuffered = False
          TabOrder = 0
        end
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 508
      Width = 217
      Height = 52
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object neDefColWidth: TDBNumberEditEh
        Left = 142
        Top = 14
        Width = 65
        Height = 21
        ControlLabel.Width = 104
        ControlLabel.Height = 13
        ControlLabel.Caption = 'Default Column Width'
        ControlLabel.Visible = True
        ControlLabelLocation.Position = lpLeftCenterEh
        DynProps = <>
        EditButton.Style = ebsUpDownEh
        EditButton.Visible = True
        EditButtons = <>
        TabOrder = 0
        Value = 80.000000000000000000
        Visible = True
      end
    end
  end
  object PageControl1: TPageControl
    Left = 225
    Top = 0
    Width = 462
    Height = 560
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Pivot Grid'
      object PivotGridEh1: TPivotGridEh
        Left = 0
        Top = 0
        Width = 454
        Height = 532
        PivotDataSource = PivotDataSourceEh1
        OnGridDefinitionChanged = PivotGridEh1GridDefinitionChanged
        OnGridLayoutChanged = PivotGridEh1GridLayoutChanged
        Align = alClient
        ContraColCount = 0
        PrintService.ColorSchema = pcsFullColorEh
        ParentColor = False
        ShowToolTips = False
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Source Data'
      ImageIndex = 1
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 454
        Height = 532
        Align = alClient
        DataSource = dsMasterData
        DynProps = <>
        Flat = True
        HorzScrollBar.ExtraPanel.NavigatorButtons = [nbFirstEh, nbPriorEh, nbNextEh, nbLastEh]
        HorzScrollBar.ExtraPanel.Visible = True
        PopupMenu = ppmSourceDataGrid
        TabOrder = 0
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object mtMasterData: TMemTableEh
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ddrMasterData
    Left = 261
    Top = 96
  end
  object ddrMasterData: TADODataDriverEh
    ConnectionProvider = ConProvMaster
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select * from Cities1000')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 336
    Top = 96
  end
  object ConProvMaster: TADOConnectionProviderEh
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\Demo' +
      's\Data\cities10000.mdb;Persist Security Info=False'
    InlineConnection.UseAtDesignTime = True
    InlineConnection.UseAtRunTime = True
    InlineConnection.Mode = cmShareDenyNone
    InlineConnection.Provider = 'Microsoft.Jet.OLEDB.4.0'
    ServerType = 'MSAccess'
    Left = 413
    Top = 96
  end
  object dsMasterData: TDataSource
    DataSet = mtMasterData
    Left = 544
    Top = 32
  end
  object PivotDataSourceEh1: TPivotDataSourceEh
    DataSet = mtMasterData
    PivotFields = <>
    ValueFieldDefs = <>
    Left = 253
    Top = 176
  end
  object ppmSourceDataGrid: TPopupMenu
    Left = 261
    Top = 476
    object Savetofile1: TMenuItem
      Caption = 'Save to file'
      OnClick = Savetofile1Click
    end
    object LoadFromFile1: TMenuItem
      Caption = 'LoadFromFile'
      OnClick = LoadFromFile1Click
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 349
    Top = 404
  end
  object OpenDialog1: TOpenDialog
    Left = 417
    Top = 408
  end
end
