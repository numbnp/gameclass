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
    DataGrouping.GroupLevels = <
      item
        ColumnName = 'Column_1_Company'
      end>
    DataGrouping.Footers = <
      item
        Visible = True
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
      end>
    DataGrouping.FootersDefValues.ShowFunctionName = True
    DataGrouping.FootersDefValues.RunTimeCustomizable = True
    DataGrouping.GroupPanelVisible = True
    DataGrouping.ParentColor = False
    DataGrouping.GroupRowDefValues.RowHeight = 4
    DataGrouping.GroupRowDefValues.RowLines = 1
    DataSource = DataSource1
    DynProps = <>
    EditActions = [geaCopyEh, geaSelectAllEh]
    EvenRowColor = clWindow
    Flat = True
    FooterParams.Color = clBtnFace
    GridLineParams.GridBoundaries = True
    IndicatorOptions = [gioShowRowIndicatorEh]
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
    STFilter.InstantApply = True
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    STFilter.FilterButtonDrawTime = fbdtWhenRowHotEh
    TabOrder = 1
    TitleParams.VTitleMargin = 5
    VertScrollBar.SmoothStep = True
    OnActiveGroupingStructChanged = DBGridEh1ActiveGroupingStructChanged
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CustNo'
        Footers = <>
        Width = 42
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Company'
        Footers = <>
        Visible = False
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'OrderNo'
        Footers = <>
        Width = 41
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipDate'
        Footers = <>
        Width = 76
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipVIA'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Terms'
        Footers = <>
        Width = 34
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ItemsTotal'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'PartNo'
        Footers = <>
        Width = 36
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Qty'
        Footers = <>
        Width = 33
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Discount'
        Footers = <>
        Width = 43
      end
      item
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
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ADODataDriverEh1
    Left = 138
    Top = 399
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
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
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 152
    Top = 424
  end
end
