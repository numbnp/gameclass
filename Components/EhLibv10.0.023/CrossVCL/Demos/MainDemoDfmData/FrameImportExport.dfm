object frImportExport: TfrImportExport
  Left = 0
  Top = 0
  Width = 728
  Height = 603
  ParentBackground = False
  TabOrder = 0
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 33
    Width = 547
    Height = 570
    Align = alClient
    AutoFitColWidths = True
    Border.Color = clBtnShadow
    Border.EdgeBorders = []
    DataSource = DataSource1
    DynProps = <>
    EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
    EvenRowColor = clWindow
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    FooterRowCount = 1
    FooterParams.Font.Charset = DEFAULT_CHARSET
    FooterParams.Font.Color = clWindowText
    FooterParams.Font.Height = -11
    FooterParams.Font.Name = 'Microsoft Sans Serif'
    FooterParams.Font.Style = [fsBold]
    FooterParams.ParentFont = False
    FooterParams.RowHeight = 5
    FooterParams.RowLines = 1
    GridLineParams.ColorScheme = glcsThemedEh
    GridLineParams.GridBoundaries = True
    IndicatorOptions = [gioShowRecNoEh]
    IndicatorParams.FillStyle = cfstSolidEh
    IndicatorParams.RecNoShowStep = 5
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    OddRowColor = 16772332
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentFont = False
    ParentShowHint = False
    RowSizingAllowed = True
    SearchPanel.FilterEnabled = False
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
    TitleParams.SecondColor = 16382457
    TitleParams.SortMarkerStyle = smstFrameEh
    TitleParams.VTitleMargin = 5
    Columns = <
      item
        AlwaysShowEditButton = True
        CellButtons = <>
        Checkboxes = False
        DropDownSizing = True
        DynProps = <>
        EditButtons = <>
        FieldName = 'VNo'
        Footer.Value = 'Sum and count'
        Footer.ValueType = fvtStaticText
        Footers = <
          item
            Value = 'Sum of cost'
            ValueType = fvtStaticText
          end
          item
            Value = 'Record count'
            ValueType = fvtStaticText
          end>
        Title.Caption = 'Vendor of parts|Vendor Number|1 '
        Title.TitleButton = True
        ToolTips = True
        Width = 98
      end
      item
        AlwaysShowEditButton = True
        CellButtons = <>
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
        Footer.ValueType = fvtCount
        Footers = <
          item
            Alignment = taCenter
            FieldName = 'PCost'
            ValueType = fvtSum
          end>
        LookupDisplayFields = 'VendorName;City;State;FAX'
        STFilter.DataField = 'VNo'
        STFilter.KeyField = 'VendorNo'
        STFilter.ListField = 'VendorName'
        Title.Caption = 'Vendor of parts|Vendor Name|2'
        ToolTips = True
        Width = 121
      end
      item
        AlwaysShowEditButton = True
        CellButtons = <>
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
        CellButtons = <>
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
        CellButtons = <>
        Checkboxes = False
        DropDownSizing = True
        DynProps = <>
        EditButton.Style = ebsUpDownEh
        EditButton.Visible = True
        EditButtons = <>
        FieldName = 'PCost'
        Footer.ValueType = fvtSum
        Footers = <
          item
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
        CellButtons = <>
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
        CellButtons = <>
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
        ToolTips = True
        Width = 23
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 547
    Top = 33
    Width = 181
    Height = 570
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object RBSaveAll: TRadioButton
      Left = 12
      Top = 9
      Width = 90
      Height = 17
      Caption = 'Save all'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 12
      Top = 29
      Width = 107
      Height = 17
      Caption = 'Save selected'
      TabOrder = 1
    end
    object btnExportAsTxt: TButton
      Left = 7
      Top = 52
      Width = 168
      Height = 25
      Caption = 'Export as TXT'
      TabOrder = 2
      OnClick = btnExportAsTxtClick
    end
    object btnExportAsUnicodeText: TButton
      Left = 7
      Top = 83
      Width = 168
      Height = 25
      Caption = 'Export as unicode text'
      TabOrder = 3
      OnClick = btnExportAsUnicodeTextClick
    end
    object btnExportAsCSV: TButton
      Left = 7
      Top = 114
      Width = 168
      Height = 25
      Caption = 'Export as CSV'
      TabOrder = 4
      OnClick = btnExportAsCSVClick
    end
    object btnExportAsHTML: TButton
      Left = 7
      Top = 145
      Width = 168
      Height = 25
      Caption = 'Export as HTML'
      TabOrder = 5
      OnClick = btnExportAsHTMLClick
    end
    object btnExportAsRTF: TButton
      Left = 7
      Top = 176
      Width = 168
      Height = 25
      Caption = 'Export as RTF'
      TabOrder = 6
      OnClick = btnExportAsRTFClick
    end
    object btnExportAsXLS: TButton
      Left = 7
      Top = 207
      Width = 168
      Height = 25
      Caption = 'Export as XLS (MS Excel v.2)'
      TabOrder = 7
      OnClick = btnExportAsXLSClick
    end
    object btnExportAsOLEXLS: TButton
      Left = 7
      Top = 238
      Width = 168
      Height = 25
      Caption = 'Export as OLE XLS'
      TabOrder = 8
      OnClick = btnExportAsOLEXLSClick
    end
    object btnImportAsTXT: TButton
      Left = 7
      Top = 319
      Width = 168
      Height = 25
      Caption = 'Import as TXT'
      TabOrder = 9
      OnClick = btnImportAsTXTClick
    end
    object btnImportAsUnicodeText: TButton
      Left = 7
      Top = 350
      Width = 168
      Height = 25
      Caption = 'Import as unicode text'
      TabOrder = 10
      OnClick = btnImportAsUnicodeTextClick
    end
    object btnExportAsXlsx: TButton
      Left = 7
      Top = 269
      Width = 168
      Height = 25
      Caption = 'Export as Xlsx'
      TabOrder = 11
      OnClick = btnExportAsXlsxClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 728
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 728
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
    object Label1: TLabel
      Left = 22
      Top = 4
      Width = 141
      Height = 23
      Caption = 'Import/Export'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object qrVendors: TMemTableEh
    Params = <>
    DataDriver = ddrVendors
    Left = 192
    Top = 276
  end
  object ddrVendors: TSQLDataDriverEh
    DeleteCommand.Params = <>
    DynaSQLParams.Options = []
    GetrecCommand.Params = <>
    InsertCommand.Params = <>
    SelectCommand.Params = <>
    SelectCommand.CommandText.Strings = (
      'select * from Vendors'
      'order by VendorName')
    UpdateCommand.Params = <>
    ConnectionProvider = Form1.SQLConnectionProviderEh1
    MacroVars.Macros = <>
    SpecParams.Strings = (
      'table=table_Vendors')
    Left = 268
    Top = 276
  end
  object DataSource1: TDataSource
    DataSet = mtQuery1
    Left = 170
    Top = 348
  end
  object mtQuery1: TMemTableEh
    CachedUpdates = True
    Filtered = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ddrData1
    Left = 234
    Top = 356
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
      FieldName = 'VPreferred'
      Origin = '"vendors.DB".Preferred'
    end
  end
  object ddrData1: TSQLDataDriverEh
    DeleteCommand.Params = <>
    DynaSQLParams.Options = []
    GetrecCommand.Params = <>
    InsertCommand.Params = <>
    SelectCommand.Params = <>
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
    UpdateCommand.Params = <>
    ConnectionProvider = Form1.SQLConnectionProviderEh1
    MacroVars.Macros = <>
    SpecParams.Strings = (
      'table=table_VendorsPartsItems')
    Left = 292
    Top = 344
  end
  object SaveDialog1: TSaveDialog
    Left = 384
    Top = 112
  end
  object OpenDialog1: TOpenDialog
    Left = 384
    Top = 168
  end
end
