object frDataGrouping: TfrDataGrouping
  Left = 0
  Top = 0
  Width = 610
  Height = 264
  Color = clBtnFace
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 610
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 610
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
      Width = 138
      Height = 23
      Caption = 'Data Grouping'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 33
    Width = 610
    Height = 189
    Align = alClient
    AllowedSelections = [gstRecordBookmarks, gstRectangle, gstAll]
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.Title.TitleButton = True
    ColumnDefValues.Title.ToolTips = True
    ColumnDefValues.ToolTips = True
    Ctl3D = True
    DataGrouping.Active = True
    DataGrouping.Color = clGradientInactiveCaption
    DataGrouping.Footers = <
      item
        ColumnItems = <
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
            ValueType = gfvSumEh
          end>
        Visible = True
      end>
    DataGrouping.FootersDefValues.ShowFunctionName = True
    DataGrouping.FootersDefValues.RunTimeCustomizable = True
    DataGrouping.GroupLevels = <
      item
        ColumnName = 'Column_1_Company'
      end>
    DataGrouping.GroupPanelVisible = True
    DataGrouping.GroupRowDefValues.RowHeight = 4
    DataGrouping.GroupRowDefValues.RowLines = 1
    DataGrouping.ParentColor = False
    DataSource = DataSource1
    DynProps = <>
    EditActions = [geaCopyEh, geaSelectAllEh]
    EvenRowColor = clWindow
    Flat = True
    FooterParams.Color = clBtnFace
    GridLineParams.GridBoundaries = True
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghIncSearch, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentCtl3D = False
    ParentShowHint = False
    RowDetailPanel.Height = 200
    RowSizingAllowed = True
    ShowHint = True
    SortLocal = True
    STFilter.FilterButtonDrawTime = fbdtWhenRowHotEh
    STFilter.InstantApply = True
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    TabOrder = 1
    TitleParams.VTitleMargin = 5
    VertScrollBar.SmoothStep = True
    OnActiveGroupingStructChanged = DBGridEh1ActiveGroupingStructChanged
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'CustNo'
        Footers = <>
        Width = 42
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Company'
        Footers = <>
        Visible = False
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'OrderNo'
        Footers = <>
        Width = 41
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipDate'
        Footers = <>
        Width = 76
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipVIA'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Terms'
        Footers = <>
        Width = 34
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'ItemsTotal'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'PartNo'
        Footers = <>
        Width = 36
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Qty'
        Footers = <>
        Width = 33
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Discount'
        Footers = <>
        Width = 43
      end
      item
        CellButtons = <>
        DisplayFormat = ',#.##'
        DynProps = <>
        EditButtons = <>
        FieldName = 'PartPrice'
        Footers = <>
        Width = 108
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 222
    Width = 610
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object CheckBox1: TCheckBox
      Left = 8
      Top = 13
      Width = 129
      Height = 17
      Caption = 'Footer in Row'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
  end
  object DataSource1: TDataSource
    DataSet = mtTable1
    Left = 134
    Top = 374
  end
  object mtTable1: TMemTableEh
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = SQLDataDriverEh1
    Left = 138
    Top = 399
  end
  object SQLDataDriverEh1: TSQLDataDriverEh
    DeleteCommand.Params = <>
    DynaSQLParams.Options = []
    GetrecCommand.Params = <>
    InsertCommand.Params = <>
    SelectCommand.Params = <>
    SelectCommand.CommandText.Strings = (
      'SELECT '
      ''
      'customer.CustNo, '
      'customer.Company, '
      'orders.OrderNo, '
      'orders.ShipDate, '
      'orders.ShipVIA, '
      'orders.Terms, '
      'orders.ItemsTotal, '
      'items.PartNo, '
      'items.Qty, '
      'items.Discount, '
      '[items.PartNo]*[parts.Cost] AS PartPrice'
      ''
      'FROM parts INNER JOIN '
      
        '   ((customer INNER JOIN orders ON customer.CustNo = orders.Cust' +
        'No) '
      
        '           INNER JOIN items ON orders.OrderNo = items.OrderNo) O' +
        'N parts.PartNo = items.PartNo;')
    UpdateCommand.Params = <>
    ConnectionProvider = Form1.SQLConnectionProviderEh1
    MacroVars.Macros = <>
    SpecParams.Strings = (
      'table=table_CustomerOrdersItems')
    Left = 152
    Top = 424
  end
end
