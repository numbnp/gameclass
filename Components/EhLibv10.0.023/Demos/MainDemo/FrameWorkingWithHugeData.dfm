object frWorkingWithHugeData: TfrWorkingWithHugeData
  Left = 0
  Top = 0
  Width = 628
  Height = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 628
      Height = 33
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnPaint = PaintBox1Paint
    end
    object Label2: TLabel
      Left = 22
      Top = 4
      Width = 239
      Height = 23
      Caption = 'Working With Huge Data'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 33
    Width = 628
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 2
      Width = 364
      Height = 13
      Caption = 
        'To make measuring actual, Run Application in "Run Without Debugi' +
        'ng" mode'
    end
    object Label3: TLabel
      Left = 336
      Top = 27
      Width = 90
      Height = 13
      Caption = 'Action Time (msec)'
    end
    object btnSmallTable: TButton
      Left = 8
      Top = 20
      Width = 98
      Height = 25
      Caption = 'Open Small Table'
      TabOrder = 0
      OnClick = btnSmallTableClick
    end
    object btnBigTable: TButton
      Left = 112
      Top = 20
      Width = 97
      Height = 25
      Caption = 'Open Big Table'
      TabOrder = 1
      OnClick = btnBigTableClick
    end
    object DBEditEh1: TDBEditEh
      Left = 432
      Top = 24
      Width = 121
      Height = 21
      DynProps = <>
      EditButtons = <>
      TabOrder = 2
      Visible = True
    end
    object btnSortBy: TButton
      Left = 215
      Top = 20
      Width = 106
      Height = 25
      Caption = 'Sort by [asciiname]'
      TabOrder = 3
      OnClick = btnSortByClick
    end
    object ProgressBar1: TProgressBar
      Left = 432
      Top = 3
      Width = 121
      Height = 17
      TabOrder = 4
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 82
    Width = 628
    Height = 389
    Align = alClient
    Border.ExtendedDraw = True
    Border.EdgeBorders = [ebTop]
    ColumnDefValues.Title.TitleButton = True
    Ctl3D = True
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    GridLineParams.ColorScheme = glcsThemedEh
    GridLineParams.VertEmptySpaceStyle = dessSolidEh
    HorzScrollBar.ExtraPanel.Visible = True
    HorzScrollBar.ExtraPanel.VisibleItems = [gsbiRecordsInfoEh, gsbiSelAggregationInfoEh]
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorParams.RecNoShowStep = 10
    OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentCtl3D = False
    SearchPanel.Enabled = True
    SortLocal = True
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    TabOrder = 2
    TitleParams.Font.Charset = DEFAULT_CHARSET
    TitleParams.Font.Color = clWindowText
    TitleParams.Font.Height = -11
    TitleParams.Font.Name = 'Tahoma'
    TitleParams.Font.Style = []
    TitleParams.ParentFont = False
    TitleParams.SortMarkerStyle = smstFrameEh
    OnSortMarkingChanged = DBGridEh1SortMarkingChanged
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'geonameid'
        Footers = <>
        Width = 59
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'asciiname'
        Footers = <>
        Width = 113
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'population'
        Footers = <>
        Width = 68
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'timezone'
        Footers = <>
        Width = 79
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'latitude'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'gname'
        Footers = <>
        Width = 123
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'longitude'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'feature_class'
        Footers = <>
        Width = 75
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'feature_code'
        Footers = <>
        Width = 80
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'country_code'
        Footers = <>
        Width = 78
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'cc2'
        Footers = <>
        Width = 29
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin1_code'
        Footers = <>
        Width = 68
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin2_code'
        Footers = <>
        Width = 53
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin3_code'
        Footers = <>
        Width = 24
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin4_code'
        Footers = <>
        Width = 27
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'elevation'
        Footers = <>
        Width = 54
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'dem'
        Footers = <>
        Width = 52
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'modification_date'
        Footers = <>
        Width = 82
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object ADOConnectionProviderEh1: TADOConnectionProviderEh
    Connection = ADOConnection1
    InlineConnection.Connected = True
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\..\D' +
      'ata\cities10000.mdb;Persist Security Info=False'
    InlineConnection.UseAtDesignTime = True
    InlineConnection.UseAtRunTime = False
    InlineConnection.Mode = cmShareDenyNone
    InlineConnection.Provider = 'Microsoft.Jet.OLEDB.4.0'
    ServerType = 'MSAccess'
    Left = 96
    Top = 280
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=%Data' +
      'BasePath%;Mode=Share Deny None;Jet OLEDB:System database="";Jet ' +
      'OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:' +
      'Engine Type=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global' +
      ' Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLE' +
      'DB:New Database Password="";Jet OLEDB:Create System Database=Fal' +
      'se;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale ' +
      'on Compact=False;Jet OLEDB:Compact Without Replica Repair=False;' +
      'Jet OLEDB:SFP=False;'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    BeforeConnect = ADOConnection1BeforeConnect
    Left = 96
    Top = 336
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select'
      '*'
      'from'
      '  Cities1000')
    Left = 184
    Top = 336
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.SpecMacrosUsages = [smuUseFilterMacroEh, smuFilterWithANDPrecedingEh, smuSortOrderAsOrderByClauseEh]
    MacroVars.Macros = <
      item
        Name = '%Table_name%'
        Value = 'Cities1000Small'
      end>
    SelectCommand.CommandText.Strings = (
      'select'
      '*'
      'from'
      '  %Table_name%'
      'where'
      ' 1=1 %Filter%')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 216
    Top = 280
  end
  object DataSetDriverEh1: TDataSetDriverEh
    ProviderDataSet = ADOQuery1
    Left = 256
    Top = 336
  end
  object MemTableEh1: TMemTableEh
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ADODataDriverEh1
    Left = 312
    Top = 280
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 376
    Top = 280
  end
end
