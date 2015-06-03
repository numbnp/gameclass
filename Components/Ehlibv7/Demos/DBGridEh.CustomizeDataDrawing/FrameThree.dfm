object frFrameThree: TfrFrameThree
  Left = 0
  Top = 0
  Width = 435
  Height = 266
  Align = alClient
  TabOrder = 0
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 36
    Width = 435
    Height = 230
    Align = alClient
    Border.Color = clBtnShadow
    Border.EdgeBorders = [ebTop]
    DataSource = DataSource1
    DynProps = <>
    EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
    Flat = True
    FooterRowCount = 1
    FooterParams.RowHeight = 5
    FooterParams.RowLines = 1
    GridLineParams.GridBoundaries = True
    GridLineParams.ColorScheme = glcsThemedEh
    HorzScrollBar.ExtraPanel.Visible = True
    IndicatorOptions = [gioShowRecNoEh]
    IndicatorParams.FillStyle = cfstSolidEh
    IndicatorParams.RecNoShowStep = 5
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentShowHint = False
    SearchPanel.Enabled = True
    SearchPanel.Location = splHorzScrollBarExtraPanelEh
    ShowHint = True
    EditButtonsShowOptions = [sebShowOnlyForCurRowEh]
    SortLocal = True
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    STFilter.FilterButtonDrawTime = fbdtWhenCellHotEh
    SumList.Active = True
    SumList.VirtualRecords = True
    TabOrder = 0
    TitleParams.SecondColor = clGradientInactiveCaption
    TitleParams.MultiTitle = True
    TitleParams.SortMarkerStyle = smstFrameEh
    TitleParams.VTitleMargin = 5
    TitleParams.FillStyle = cfstGradientEh
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'VendorNo'
        Footers = <>
        Width = 29
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'State'
        Footers = <>
        Width = 39
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'VendorName'
        Footers = <>
        Title.Caption = 'Name (Custom Draw)'
        Width = 181
        OnAdvDrawDataCell = DBGridEh1Columns2AdvDrawDataCell
        OnGetCellParams = DBGridEh1Columns2GetCellParams
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Address1'
        Footers = <>
        Width = 118
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Address2'
        Footers = <>
        Width = 103
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'City'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Zip'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Country'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Phone'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'FAX'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Preferred'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 435
      Height = 36
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnPaint = PaintBox1Paint
    end
    object Label1: TLabel
      Left = 41
      Top = 7
      Width = 73
      Height = 23
      Caption = 'Demo 3'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 150
      Top = 11
      Width = 260
      Height = 16
      Caption = 'Using Column.OnAdvDrawDataCell event'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DataSource1: TDataSource
    DataSet = mtQuery1
    Left = 170
    Top = 348
  end
  object mtQuery1: TMemTableEh
    Active = True
    CachedUpdates = True
    Filtered = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ddrData1
    Left = 206
    Top = 340
    object mtQuery1VendorNo: TAutoIncField
      DisplayWidth = 10
      FieldName = 'VendorNo'
    end
    object mtQuery1VendorName: TWideStringField
      DisplayWidth = 30
      FieldName = 'VendorName'
      Size = 30
    end
    object mtQuery1Address1: TWideStringField
      DisplayWidth = 30
      FieldName = 'Address1'
      Size = 30
    end
    object mtQuery1Address2: TWideStringField
      DisplayWidth = 30
      FieldName = 'Address2'
      Size = 30
    end
    object mtQuery1City: TWideStringField
      DisplayWidth = 20
      FieldName = 'City'
    end
    object mtQuery1State: TWideStringField
      DisplayWidth = 20
      FieldName = 'State'
    end
    object mtQuery1Zip: TWideStringField
      DisplayWidth = 10
      FieldName = 'Zip'
      Size = 10
    end
    object mtQuery1Country: TWideStringField
      DisplayWidth = 15
      FieldName = 'Country'
      Size = 15
    end
    object mtQuery1Phone: TWideStringField
      DisplayWidth = 15
      FieldName = 'Phone'
      Size = 15
    end
    object mtQuery1FAX: TWideStringField
      DisplayWidth = 15
      FieldName = 'FAX'
      Size = 15
    end
    object mtQuery1Preferred: TBooleanField
      DisplayWidth = 5
      FieldName = 'Preferred'
    end
  end
  object ddrData1: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  vendors')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 248
    Top = 344
  end
  object qrVendors: TMemTableEh
    CachedUpdates = True
    Params = <>
    DataDriver = ddrVendors
    Left = 200
    Top = 304
  end
  object ddrVendors: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select * from Vendors'
      'order by VendorName')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 248
    Top = 304
  end
end
