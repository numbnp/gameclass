object frFrameNew: TfrFrameNew
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
    AutoFitColWidths = True
    Border.Color = clBtnShadow
    Border.EdgeBorders = [ebTop]
    DataSource = DataSource1
    DynProps = <>
    EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
    Flat = True
    FooterRowCount = 1
    FooterParams.RowHeight = 5
    FooterParams.RowLines = 1
    GridLineParams.ColorScheme = glcsThemedEh
    GridLineParams.GridBoundaries = True
    HorzScrollBar.ExtraPanel.Visible = True
    IndicatorOptions = [gioShowRecNoEh]
    IndicatorParams.FillStyle = cfstSolidEh
    IndicatorParams.RecNoShowStep = 5
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentShowHint = False
    RowSizingAllowed = True
    SearchPanel.Enabled = True
    SearchPanel.Location = splHorzScrollBarExtraPanelEh
    ShowHint = True
    EditButtonsShowOptions = [sebShowOnlyForCurRowEh]
    SortLocal = True
    STFilter.FilterButtonDrawTime = fbdtWhenCellHotEh
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    SumList.Active = True
    SumList.VirtualRecords = True
    TabOrder = 0
    TitleParams.FillStyle = cfstGradientEh
    TitleParams.MultiTitle = True
    TitleParams.SecondColor = clGradientInactiveCaption
    TitleParams.SortMarkerStyle = smstFrameEh
    TitleParams.VTitleMargin = 5
    Columns = <
      item
        AlwaysShowEditButton = True
        Checkboxes = False
        DropDownSizing = True
        DynProps = <>
        EditButtons = <>
        FieldName = 'VNo'
        Footer.Value = 'Sum and count'
        Footers = <>
        Title.Caption = 'Vendor of parts|Vendor Number|1 '
        Title.TitleButton = True
        ToolTips = True
        Width = 98
      end
      item
        AlwaysShowEditButton = True
        Checkboxes = False
        DropDownBox.ColumnDefValues.EndEllipsis = True
        DropDownBox.ColumnDefValues.Title.ToolTips = True
        DropDownBox.ColumnDefValues.ToolTips = True
        DropDownBox.Options = [dlgColumnResizeEh, dlgColLinesEh]
        DropDownBox.UseMultiTitle = True
        DropDownRows = 14
        DropDownShowTitles = True
        DropDownSizing = True
        DropDownSpecRow.CellsText = '( Empty ); -; -; -'
        DropDownSpecRow.Font.Charset = DEFAULT_CHARSET
        DropDownSpecRow.Font.Color = clWindowText
        DropDownSpecRow.Font.Height = -11
        DropDownSpecRow.Font.Name = 'Microsoft Sans Serif'
        DropDownSpecRow.Font.Style = []
        DropDownSpecRow.Visible = True
        DropDownWidth = -1
        DynProps = <>
        EditButtons = <>
        FieldName = 'VName1'
        Footer.Alignment = taCenter
        Footers = <>
        LookupDisplayFields = 'VendorName;City;State;FAX'
        STFilter.DataField = 'VNo'
        STFilter.KeyField = 'VendorNo'
        STFilter.ListField = 'VendorName'
        Title.Caption = 'Vendor of parts|Vendor Name|2'
        Title.TitleButton = True
        ToolTips = True
        Width = 121
      end
      item
        AlwaysShowEditButton = True
        Checkboxes = False
        DropDownSizing = True
        DynProps = <>
        EditButtons = <>
        FieldName = 'PNo'
        Footers = <>
        Title.Caption = 'Parts|PN|3 '
        Title.TitleButton = True
        ToolTips = True
        Width = 56
      end
      item
        AlwaysShowEditButton = True
        Checkboxes = False
        DropDownSizing = True
        DynProps = <>
        EditButtons = <>
        FieldName = 'PDescription'
        Footers = <
          item
            Value = 'Sum'
            ValueType = fvtStaticText
          end
          item
            Value = 'Vendor No'
            ValueType = fvtStaticText
          end>
        STFilter.DataField = 'PDescription'
        STFilter.KeyField = 'Description'
        STFilter.ListField = 'Description'
        Title.Caption = 'Parts|Description|4 '
        Title.TitleButton = True
        ToolTips = True
        Width = 133
      end
      item
        AlwaysShowEditButton = True
        ButtonStyle = cbsUpDown
        Checkboxes = False
        DisplayFormat = '#,#.00'
        DropDownSizing = True
        DynProps = <>
        EditButton.Style = ebsUpDownEh
        EditButton.Visible = True
        EditButtons = <>
        FieldName = 'PCost'
        Footer.Color = clSilver
        Footer.DisplayFormat = '#,#.00'
        Footer.ValueType = fvtSum
        Footers = <
          item
            DisplayFormat = '#,#.00'
            ValueType = fvtSum
          end
          item
            FieldName = 'VNo'
            ValueType = fvtFieldValue
          end>
        Increment = 0.100000000000000000
        Title.Caption = 'Parts|Cost|5 '
        Title.TitleButton = True
        Title.SortIndex = 1
        Title.SortMarker = smDownEh
        ToolTips = True
        Width = 89
      end
      item
        AlwaysShowEditButton = True
        Checkboxes = False
        DropDownSizing = True
        DynProps = <>
        EditButtons = <>
        FieldName = 'IQty'
        Footers = <>
        Title.Caption = 'Items|Qry|6 '
        Title.TitleButton = True
        Title.SortIndex = 2
        Title.SortMarker = smDownEh
        ToolTips = True
        Width = 33
      end
      item
        AlwaysShowEditButton = True
        Checkboxes = True
        DropDownSizing = True
        DynProps = <>
        EditButtons = <>
        FieldName = 'VPreferred'
        Footers = <>
        NotInKeyListIndex = 2
        Title.Caption = 'Preferred'
        Title.Hint = 'Preferred'
        Title.ImageIndex = 0
        Title.TitleButton = True
        Title.Orientation = tohVertical
        ToolTips = True
        Width = 23
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
      Width = 108
      Height = 23
      Caption = 'Frame New'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
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
    object mtQuery1VNo: TFloatField
      DisplayLabel = 'Vendor of parts|Vendor Number|1'
      DisplayWidth = 17
      FieldName = 'VNo'
      Origin = '"Vendors.DB".VendorNo'
      DisplayFormat = 'VN 0000'
    end
    object mtQuery1VName: TStringField
      DisplayLabel = 'Vendor of parts|Vendor Name|2'
      DisplayWidth = 24
      FieldName = 'VName'
      Origin = '"Vendors.DB".VendorName'
      Size = 30
    end
    object mtQuery1PNo: TFloatField
      Alignment = taLeftJustify
      DisplayLabel = 'Parts|PN|3'
      DisplayWidth = 15
      FieldName = 'PNo'
      Origin = '"PARTS.DB".PartNo'
      DisplayFormat = 'PN-00000'
    end
    object mtQuery1PDescription: TStringField
      DisplayLabel = 'Parts|Description|4'
      DisplayWidth = 18
      FieldName = 'PDescription'
      Origin = '"PARTS.DB".Description'
      Size = 30
    end
    object mtQuery1PCost: TCurrencyField
      DisplayLabel = 'Parts|Cost|5'
      DisplayWidth = 9
      FieldName = 'PCost'
      Origin = '"PARTS.DB".Cost'
      DisplayFormat = '#,##0.0000'
    end
    object mtQuery1IQty: TIntegerField
      DisplayLabel = 'Items|Qry|6'
      DisplayWidth = 21
      FieldName = 'IQty'
      Origin = '"ITEMS.DB".Qty'
    end
    object mtQuery1VName1: TStringField
      FieldKind = fkLookup
      FieldName = 'VName1'
      LookupDataSet = qrVendors
      LookupKeyFields = 'VendorNo'
      LookupResultField = 'VendorName'
      KeyFields = 'VNo'
      Lookup = True
    end
    object mtQuery1VPreferred: TBooleanField
      DefaultExpression = 'True'
      FieldName = 'VPreferred'
      Origin = '"vendors.DB".Preferred'
    end
  end
  object ddrData1: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'SELECT'
      '       Vendors.VendorNo As VNo,'
      '       Vendors.VendorName As VName,'
      '       Vendors.Preferred As VPreferred,'
      '       Parts.PartNo As PNo,'
      '       Parts.Description As PDescription,'
      '       Parts.Cost As PCost,'
      '       Items.Qty As IQty'
      ''
      'FROM Vendors, Parts, Items'
      'WHERE Vendors.VendorNo = Parts.VendorNo AND'
      '       Parts.PartNo = Items.PartNo'
      'ORDER BY Items.Qty, Parts.Cost')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 248
    Top = 344
  end
  object qrVendors: TMemTableEh
    Active = True
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
