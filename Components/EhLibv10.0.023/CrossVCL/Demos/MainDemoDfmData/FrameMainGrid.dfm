object frMainGrid: TfrMainGrid
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 36
    Width = 451
    Height = 269
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
    HorzScrollBar.Height = 20
    IndicatorOptions = [gioShowRecNoEh]
    IndicatorParams.FillStyle = cfstSolidEh
    IndicatorParams.RecNoShowStep = 5
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentShowHint = False
    PopupMenu = PopupMenu1
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
        CellButtons = <>
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
    Width = 451
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 451
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
      Width = 92
      Height = 23
      Caption = 'Main Grid'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Image1: TImage
      Left = 9
      Top = 6
      Width = 24
      Height = 24
      Center = True
      Picture.Data = {
        07544269746D617036030000424D360300000000000036000000280000001000
        000010000000010018000000000000030000120B0000120B0000000000000000
        0000BD7C6EBB7A6BB9786AB77767B57565B37463B17261AF705FAD6F5DAB6D5B
        AA6B59A86A57A66855A46653A26551A16450BF7E7042C1C1BB7A6B75FEF86BFF
        F861FEF957FEFAE3C0B343FEFB39FEFB2FFEFCE3C0B31BFEFD11FEFE07FEFEA2
        6551C17F72BF7E70BD7C6EE3C0B3E3C0B3E3C0B3E3C0B3E3C0B3E3C0B3E3C0B3
        E3C0B3E3C0B3E3C0B3E3C0B3E3C0B3A46653C3817442C1C1BF7E70FEECDDFEEB
        DBFEEADAFEE9D8E3C0B3FEE7D5FEE6D4FEE5D2E3C0B3FEE4D0FEE3CEFEE2CCA6
        6855C58376C38174C17F72E3C0B3E3C0B3E3C0B3E3C0B3E3C0B3E3C0B3E3C0B3
        E3C0B3E3C0B3E3C0B3E3C0B3E3C0B3A86A57C7847942C1C1C38174FEEDE0FEEC
        DEFEECDDFEEBDBE3C0B3FEE9D8FEE8D7FEE7D5E3C0B3FEE5D2FEE5D1FEE4D0AA
        6B59C9867BC78479C58376E3C0B3E3C0B3E3C0B3E3C0B3E3C0B3E3C0B3E3C0B3
        E3C0B3E3C0B3E3C0B3E3C0B3E3C0B3AB6D5BCB887D42C1C1C78479FEEFE3FEEE
        E1FEEDE0FEECDEE3C0B3FEEBDBFEEADAFEE9D8E3C0B3FEE7D5FEE6D4FEE5D2AD
        6F5DCD8A7FCB887DC9867BC78479C58376C38174C17F72BF7E70BD7C6EBB7A6B
        B9786AB77767B57565B37463B17261AF705FCF8B81DCDCDCCB887DD8D8D8D6D6
        D6D4D4D4D2D2D2C17F72CDCDCDCBCBCBC9C9C9B9786AC5C5C5C3C3C3C1C1C1B1
        7261D18D84DCDCDCCD8A7FD8D8D8D6D6D6D4D4D4D2D2D2C38174C17F72BF7E70
        BD7C6EBB7A6BB9786AB77767B57565B37463D38F86DCDCDCCF8B81D8D8D8D6D6
        D6D4D4D4D2D2D2C58376CDCDCDCBCBCBC9C9C9C7C7C7C5C5C5C3C3C3C1C1C1B5
        7565D59088DCDCDCD18D84CF8B81CD8A7FCB887DC9867BC78479C58376C38174
        C17F72BF7E70BD7C6EBB7A6BB9786AB77767D7928ADCDCDCD38F86D8D8D8D6D6
        D6D4D4D4D2D2D2C9867BCDCDCDCBCBCBC9C9C9C7C7C7C5C5C5C3C3C3C1C1C1B9
        786AD9948CD7928AD59088D38F86D18D84CF8B81CD8A7FCB887DC9867BC78479
        C58376C38174C17F72BF7E70BD7C6EBB7A6BFEF9F3FFF8F2FFF7F0FFF6EFFEF5
        EDFEF4ECFEF3EAFEF3E9FEF2E7FFF1E6FEF0E4FEEFE3FEEEE1FEEDE0FEECDEFE
        ECDD}
    end
  end
  object DataSource1: TDataSource
    DataSet = mtQuery1
    Left = 154
    Top = 348
  end
  object mtQuery1: TMemTableEh
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
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'VName1'
      LookupDataSet = qrVendors
      LookupKeyFields = 'VendorNo'
      LookupResultField = 'VendorName'
      KeyFields = 'VNo'
      Lookup = True
    end
    object mtQuery1VPreferred: TBooleanField
      DisplayWidth = 5
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
    Left = 288
    Top = 336
  end
  object qrVendors: TMemTableEh
    Params = <>
    DataDriver = ddrVendors
    Left = 200
    Top = 264
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
    Left = 256
    Top = 264
  end
  object PopupMenu1: TPopupMenu
    Left = 408
    Top = 65528
    object Menu1: TMenuItem
      Caption = 'Menu'
    end
    object MenuwithSubMenu1: TMenuItem
      Caption = 'Menu with SubMenu'
      object SubMenu1: TMenuItem
        Caption = 'SubMenu'
      end
    end
  end
end
