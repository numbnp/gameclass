object frMasterDetail: TfrMasterDetail
  Left = 0
  Top = 0
  Width = 435
  Height = 266
  Align = alClient
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 0
    Top = 123
    Width = 435
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 0
    Top = 36
    Width = 435
    Height = 87
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      435
      87)
    object DBGridEh3: TDBGridEh
      Left = 10
      Top = 32
      Width = 416
      Height = 49
      Anchors = [akLeft, akTop, akRight, akBottom]
      Border.Color = clScrollBar
      ColumnDefValues.AlwaysShowEditButton = True
      DataSource = DataSource1
      DynProps = <>
      EditActions = [geaCopyEh, geaSelectAllEh]
      Flat = True
      FooterRowCount = 1
      FooterParams.Color = clBtnFace
      FooterParams.FillStyle = cfstSolidEh
      FooterParams.Font.Charset = DEFAULT_CHARSET
      FooterParams.Font.Color = clWindowText
      FooterParams.Font.Height = -11
      FooterParams.Font.Name = 'Microsoft Sans Serif'
      FooterParams.Font.Style = [fsBold]
      FooterParams.ParentFont = False
      FrozenCols = 2
      GridLineParams.GridBoundaries = True
      GridLineParams.ColorScheme = glcsThemedEh
      IndicatorOptions = [gioShowRowIndicatorEh]
      IndicatorTitle.ShowDropDownSign = True
      IndicatorTitle.TitleButton = True
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghFixed3D, dghFooter3D, dghHighlightFocus, dghClearSelection, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
      ParentShowHint = False
      ShowHint = True
      STFilter.Local = True
      STFilter.Location = stflInTitleFilterEh
      STFilter.Visible = True
      STFilter.FilterButtonDrawTime = fbdtWhenCellHotEh
      SumList.Active = True
      TabOrder = 0
      TitleParams.FillStyle = cfstThemedEh
      TitleParams.BorderInFillStyle = True
      Columns = <
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'OrderNo'
          Footer.Alignment = taCenter
          Footer.ValueType = fvtCount
          Footers = <>
          ToolTips = True
          Width = 42
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'CustNo'
          Footers = <>
          ToolTips = True
          Width = 50
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'ItemsTotal'
          Footer.ValueType = fvtSum
          Footers = <>
          ToolTips = True
          Width = 79
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'TaxRate'
          Footer.ValueType = fvtSum
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'Freight'
          Footer.ValueType = fvtSum
          Footers = <>
          ToolTips = True
        end
        item
          ButtonStyle = cbsDropDown
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'AmountPaid'
          Footer.ValueType = fvtSum
          Footers = <>
          ToolTips = True
          Width = 82
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'SaleDate'
          Footer.Alignment = taCenter
          Footer.FieldName = 'PaymentMethod'
          Footer.ValueType = fvtFieldValue
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'ShipDate'
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'EmpNo'
          Footers = <>
          ToolTips = True
        end
        item
          Alignment = taCenter
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'ShipToContact'
          Footers = <>
          ToolTips = True
          Width = 55
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'ShipToAddr1'
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'ShipToAddr2'
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'ShipToCity'
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'ShipToState'
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'ShipToZip'
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'ShipToCountry'
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'ShipToPhone'
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'ShipVIA'
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'PO'
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'Terms'
          Footers = <>
          ToolTips = True
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'PaymentMethod'
          Footers = <>
          ToolTips = True
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object DBNavigator2: TDBNavigator
      Left = 10
      Top = 4
      Width = 220
      Height = 25
      DataSource = DataSource1
      Flat = True
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 128
    Width = 435
    Height = 138
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      435
      138)
    object DBGridEh4: TDBGridEh
      Left = 9
      Top = 33
      Width = 363
      Height = 97
      Anchors = [akLeft, akTop, akBottom]
      AutoFitColWidths = True
      Border.Color = clScrollBar
      DataSource = DataSource2
      DynProps = <>
      Flat = True
      FooterRowCount = 1
      FooterParams.Color = clWindow
      FooterParams.HorzLines = False
      GridLineParams.ColorScheme = glcsThemedEh
      GridLineParams.VertEmptySpaceStyle = dessSolidEh
      IndicatorOptions = [gioShowRowIndicatorEh]
      IndicatorParams.HorzLines = True
      IndicatorTitle.ShowDropDownSign = True
      IndicatorTitle.TitleButton = True
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghFooter3D, dghHighlightFocus, dghClearSelection, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
      SumList.Active = True
      TabOrder = 0
      TitleParams.HorzLines = True
      Columns = <
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'OrderNo'
          Footer.Alignment = taCenter
          Footer.Font.Charset = DEFAULT_CHARSET
          Footer.Font.Color = clWindowText
          Footer.Font.Height = -11
          Footer.Font.Name = 'Microsoft Sans Serif'
          Footer.Font.Style = [fsBold]
          Footer.ValueType = fvtCount
          Footers = <>
        end
        item
          Checkboxes = False
          Color = 16116704
          DynProps = <>
          EditButtons = <>
          FieldName = 'ItemNo'
          Footer.Color = 15855076
          Footer.Font.Charset = DEFAULT_CHARSET
          Footer.Font.Color = clWindowText
          Footer.Font.Height = -11
          Footer.Font.Name = 'Microsoft Sans Serif'
          Footer.Font.Style = [fsBold]
          Footers = <>
          Title.Color = 15197150
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'PartNo'
          Footer.Font.Charset = DEFAULT_CHARSET
          Footer.Font.Color = clWindowText
          Footer.Font.Height = -11
          Footer.Font.Name = 'Microsoft Sans Serif'
          Footer.Font.Style = [fsBold]
          Footers = <>
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'Qty'
          Footer.Font.Charset = DEFAULT_CHARSET
          Footer.Font.Color = clWindowText
          Footer.Font.Height = -11
          Footer.Font.Name = 'Microsoft Sans Serif'
          Footer.Font.Style = [fsBold]
          Footer.ValueType = fvtSum
          Footers = <>
        end
        item
          Checkboxes = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'Discount'
          Footer.Font.Charset = DEFAULT_CHARSET
          Footer.Font.Color = clWindowText
          Footer.Font.Height = -11
          Footer.Font.Name = 'Microsoft Sans Serif'
          Footer.Font.Style = [fsBold]
          Footers = <>
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object DBNavigator3: TDBNavigator
      Left = 9
      Top = 5
      Width = 220
      Height = 24
      DataSource = DataSource2
      Flat = True
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 2
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 435
      Height = 35
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
      Width = 212
      Height = 23
      Caption = 'Master/Detail relation'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 35
      Width = 435
      Height = 1
      Align = alBottom
      Shape = bsTopLine
    end
  end
  object DataSource1: TDataSource
    DataSet = mtTable1
    Left = 44
    Top = 235
  end
  object DataSource2: TDataSource
    DataSet = mtTable2
    Left = 134
    Top = 235
  end
  object mtTable1: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ddrOrders
    Left = 44
    Top = 209
  end
  object mtTable2: TMemTableEh
    Active = True
    CachedUpdates = True
    DetailFields = 'OrderNo'
    FetchAllOnOpen = True
    MasterFields = 'OrderNo'
    MasterSource = DataSource1
    Params = <>
    DataDriver = ddrItems
    Left = 135
    Top = 209
  end
  object ddrOrders: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  orders')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 43
    Top = 182
  end
  object ddrItems: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  items')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 135
    Top = 182
  end
end
