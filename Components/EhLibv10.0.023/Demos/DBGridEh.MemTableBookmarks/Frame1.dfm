object frFrame1: TfrFrame1
  Left = 0
  Top = 0
  Width = 705
  Height = 631
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 705
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 705
      Height = 36
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 41
      Top = 7
      Width = 193
      Height = 23
      Caption = 'Bookmarks - Demo1'
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
    Top = 78
    Width = 705
    Height = 553
    Align = alClient
    AllowedSelections = [gstRecordBookmarks]
    ColumnDefValues.Title.TitleButton = True
    DataSource = DataSource1
    DynProps = <>
    EditActions = [geaCopyEh]
    FooterParams.Color = clWindow
    HorzScrollBar.ExtraPanel.NavigatorButtons = [nbFirstEh, nbPriorEh, nbNextEh, nbLastEh]
    HorzScrollBar.ExtraPanel.Visible = True
    HorzScrollBar.Height = 24
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh, gioShowRowselCheckboxesEh]
    IndicatorParams.Color = clWhite
    IndicatorParams.FillStyle = cfstSolidEh
    IndicatorParams.RecNoShowStep = 5
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghHighlightFocus, dghAutoSortMarking, dghMultiSortMarking, dghIncSearch, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
    SearchPanel.Enabled = True
    SortLocal = True
    STFilter.Local = True
    STFilter.Visible = True
    TabOrder = 0
    TitleParams.FillStyle = cfstThemedEh
    TitleParams.RowHeight = 5
    TitleParams.RowLines = 1
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Name'
        Footers = <>
        Width = 86
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Capital'
        Footers = <>
        Width = 113
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Continent'
        Footers = <>
        Width = 107
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Area'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Population'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 36
    Width = 705
    Height = 42
    Align = alTop
    TabOrder = 2
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 145
      Height = 25
      Caption = 'Select North America'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 160
      Top = 8
      Width = 145
      Height = 25
      Caption = 'Sort By Area'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Filtered = True
    FetchAllOnOpen = True
    Params = <>
    Left = 56
    Top = 376
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object Name: TMTStringDataFieldEh
          FieldName = 'Name'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Name'
          DisplayWidth = 24
          Size = 24
          Transliterate = True
        end
        object Capital: TMTStringDataFieldEh
          FieldName = 'Capital'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Capital'
          DisplayWidth = 24
          Size = 24
          Transliterate = True
        end
        object Continent: TMTStringDataFieldEh
          FieldName = 'Continent'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Continent'
          DisplayWidth = 24
          Size = 24
          Transliterate = True
        end
        object Area: TMTNumericDataFieldEh
          FieldName = 'Area'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'Area'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object Population: TMTNumericDataFieldEh
          FieldName = 'Population'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'Population'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            'Argentina'
            'Buenos Aires'
            'South America'
            2777815.000000000000000000
            32300003.000000000000000000)
          (
            'Bolivia'
            'La Paz'
            'South America'
            1098575.000000000000000000
            7300000.000000000000000000)
          (
            'Brazil'
            'Brasilia'
            'South America'
            8511196.000000000000000000
            150400000.000000000000000000)
          (
            'Canada'
            'Ottawa'
            'North America'
            9976147.000000000000000000
            26500000.000000000000000000)
          (
            'Chile'
            'Santiago'
            'South America'
            756943.000000000000000000
            13200000.000000000000000000)
          (
            'Colombia'
            'Bagota'
            'South America'
            1138907.000000000000000000
            33000000.000000000000000000)
          (
            'Cuba'
            'Havana'
            'North America'
            114524.000000000000000000
            10600000.000000000000000000)
          (
            'Ecuador'
            'Quito'
            'South America'
            455502.000000000000000000
            10600000.000000000000000000)
          (
            'El Salvador'
            'San Salvador'
            'North America'
            20865.000000000000000000
            5300000.000000000000000000)
          (
            'Guyana'
            'Georgetown'
            'South America'
            214969.000000000000000000
            800000.000000000000000000)
          (
            'Jamaica'
            'Kingston'
            'North America'
            11424.000000000000000000
            2500000.000000000000000000)
          (
            'Mexico'
            'Mexico City'
            'North America'
            1967180.000000000000000000
            88600000.000000000000000000)
          (
            'Nicaragua'
            'Managua'
            'North America'
            139000.000000000000000000
            3900000.000000000000000000)
          (
            'Paraguay'
            'Asuncion'
            'South America'
            406576.000000000000000000
            4660000.000000000000000000)
          (
            'Peru'
            'Lima'
            'South America'
            1285215.000000000000000000
            21600000.000000000000000000)
          (
            'United States of America'
            'Washington'
            'North America'
            9363130.000000000000000000
            249200000.000000000000000000)
          (
            'Uruguay'
            'Montevideo'
            'South America'
            176140.000000000000000000
            3002000.000000000000000000)
          (
            'Venezuela'
            'Caracas'
            'South America'
            912047.000000000000000000
            19700000.000000000000000000))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 88
    Top = 296
  end
end
