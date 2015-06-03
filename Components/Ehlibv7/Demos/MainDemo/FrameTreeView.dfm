object frTreeView: TfrTreeView
  Left = 0
  Top = 0
  Width = 594
  Height = 621
  ParentBackground = False
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 594
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 594
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
      Width = 95
      Height = 23
      Caption = 'Tree View'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DBGridEh9: TDBGridEh
    Left = 0
    Top = 33
    Width = 594
    Height = 546
    Align = alClient
    AllowedSelections = [gstRecordBookmarks, gstRectangle, gstColumns]
    Border.ExtendedDraw = True
    Border.Color = clRed
    Border.EdgeBorders = [ebTop, ebBottom]
    Ctl3D = False
    DataSource = dsTreeView
    DynProps = <>
    EditActions = [geaCopyEh, geaSelectAllEh]
    Flat = True
    FooterParams.Color = clWindow
    FrozenCols = 1
    GridLineParams.DataVertLines = True
    GridLineParams.DataHorzLines = False
    GridLineParams.GridBoundaries = True
    GridLineParams.ColorScheme = glcsThemedEh
    GridLineParams.VertEmptySpaceStyle = dessSolidEh
    IndicatorOptions = [gioShowRowIndicatorEh]
    IndicatorParams.FillStyle = cfstSolidEh
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDblClickOptimizeColWidth, dghDialogFind, dghRecordMoving, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentCtl3D = False
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    STFilter.FilterButtonDrawTime = fbdtWhenRowHotEh
    TabOrder = 1
    TreeViewParams.ShowTreeLines = False
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'NAME'
        Footers = <>
        Width = 220
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID'
        Footers = <>
        Width = 48
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID_PARENT'
        Footers = <>
        Width = 100
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Expanded'
        Footer.FieldName = 'ExpCount'
        Footer.ValueType = fvtFieldValue
        Footers = <>
        Width = 79
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Visible'
        Footers = <>
        Width = 58
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 579
    Width = 594
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Label2: TLabel
      Left = 181
      Top = 15
      Width = 71
      Height = 13
      Caption = 'Tree sign style:'
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 13
      Width = 121
      Height = 17
      Caption = 'Show Tree Lines'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object DBComboBoxEh1: TDBComboBoxEh
      Left = 269
      Top = 13
      Width = 121
      Height = 19
      AlwaysShowBorder = True
      DynProps = <>
      EditButtons = <>
      Flat = True
      Items.Strings = (
        'Classic'
        'Themed'
        'Explorer')
      KeyItems.Strings = (
        'Classic'
        'Themed'
        'Explorer')
      TabOrder = 1
      Text = 'Themed'
      Visible = True
      OnChange = DBComboBoxEh1Change
    end
  end
  object mtTreeView: TMemTableEh
    Active = True
    CachedUpdates = True
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_PARENT'
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Expanded'
        DataType = ftInteger
      end
      item
        Name = 'Visible'
        DataType = ftInteger
      end>
    FetchAllOnOpen = True
    IndexDefs = <
      item
        Name = 'MemTableEh1Index1'
        Fields = 'ID'
        Options = [ixPrimary]
      end>
    Params = <>
    StoreDefs = True
    TreeList.Active = True
    TreeList.KeyFieldName = 'ID'
    TreeList.RefParentFieldName = 'ID_PARENT'
    TreeList.DefaultNodeExpanded = True
    Left = 560
    Top = 144
    object mtTreeViewExpCount: TAggregateField
      FieldName = 'ExpCount'
      Active = True
      Expression = 'SUM(Expanded)'
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object ID: TMTNumericDataFieldEh
          FieldName = 'ID'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'ID'
          DisplayWidth = 10
          currency = False
          Precision = 0
        end
        object ID_PARENT: TMTNumericDataFieldEh
          FieldName = 'ID_PARENT'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'ID_PARENT'
          DisplayWidth = 10
          currency = False
          Precision = 0
        end
        object NAME: TMTStringDataFieldEh
          FieldName = 'NAME'
          StringDataType = fdtStringEh
          DisplayLabel = 'NAME'
          DisplayWidth = 30
          Size = 30
        end
        object Expanded: TMTNumericDataFieldEh
          FieldName = 'Expanded'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'Expanded'
          DisplayWidth = 10
          currency = False
          Precision = 0
        end
        object Visible: TMTNumericDataFieldEh
          FieldName = 'Visible'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'Visible'
          DisplayWidth = 10
          currency = False
          Precision = 0
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1
            0
            'ROOT1'
            1
            1)
          (
            2
            0
            'ROOT2'
            1
            1)
          (
            3
            0
            'ROOT3'
            1
            1)
          (
            4
            1
            'CHILD1'
            1
            1)
          (
            5
            1
            'CHILD2'
            1
            1)
          (
            6
            1
            'CHILD3'
            1
            1)
          (
            7
            2
            'CHILD4'
            1
            1)
          (
            8
            2
            'CHILD5'
            1
            1)
          (
            9
            2
            'CHILD6'
            1
            1)
          (
            10
            3
            'CHILD7'
            1
            1)
          (
            11
            3
            'CHILD8'
            1
            1)
          (
            12
            3
            'CHILD9'
            1
            1)
          (
            13
            1
            'CHILD10'
            1
            1)
          (
            14
            1
            'CHILD11'
            1
            1)
          (
            15
            1
            'CHILD12'
            1
            1)
          (
            16
            2
            'CHILD13'
            1
            1)
          (
            17
            2
            'CHILD14'
            1
            1)
          (
            18
            2
            'CHILD15'
            1
            1)
          (
            19
            3
            'CHILD16'
            1
            1)
          (
            20
            3
            'CHILD17'
            1
            1)
          (
            21
            5
            'SUBCH1'
            1
            1)
          (
            22
            5
            'SUBCH2'
            1
            1)
          (
            23
            5
            'SUBCH3'
            1
            1)
          (
            24
            5
            'SUBCH4'
            1
            1)
          (
            25
            22
            'SUBSUB1'
            1
            1))
      end
    end
  end
  object dsTreeView: TDataSource
    DataSet = mtTreeView
    Left = 560
    Top = 96
  end
end
