object Form1: TForm1
  Left = 375
  Top = 124
  Width = 483
  Height = 630
  Caption = 'DBGridEh.ExtendVerLines Demo'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 467
    Height = 592
    VertScrollBar.Range = 1400
    VertScrollBar.Tracking = True
    Align = alClient
    AutoScroll = False
    TabOrder = 0
    DesignSize = (
      446
      588)
    object DBGridEh1: TDBGridEh
      Left = 8
      Top = 16
      Width = 424
      Height = 121
      Anchors = [akLeft, akTop, akRight]
      Border.Color = cl3DLight
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSource1
      DynProps = <>
      Flat = True
      FooterParams.Color = clWindow
      GridLineParams.DataHorzLines = False
      GridLineParams.ColorScheme = glcsThemedEh
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      SortLocal = True
      TabOrder = 0
      OnSortMarkingChanged = DBGridEh1SortMarkingChanged
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          Width = 78
        end
        item
          Color = 16511978
          DynProps = <>
          EditButtons = <>
          FieldName = 'Capital'
          Footers = <>
          Width = 79
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Continent'
          Footers = <>
          Width = 81
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
    object DBGridEh2: TDBGridEh
      Left = 8
      Top = 176
      Width = 424
      Height = 135
      Anchors = [akLeft, akTop, akRight]
      Border.Color = cl3DLight
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSource1
      DynProps = <>
      Flat = True
      FooterParams.Color = clWindow
      GridLineParams.DataHorzLines = False
      GridLineParams.ColorScheme = glcsThemedEh
      GridLineParams.VertEmptySpaceStyle = dessSolidEh
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      SortLocal = True
      TabOrder = 1
      OnSortMarkingChanged = DBGridEh1SortMarkingChanged
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          Width = 78
        end
        item
          Color = 16511978
          DynProps = <>
          EditButtons = <>
          FieldName = 'Capital'
          Footers = <>
          Width = 79
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Continent'
          Footers = <>
          Width = 77
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
    object DBGridEh3: TDBGridEh
      Left = 8
      Top = 344
      Width = 424
      Height = 136
      Anchors = [akLeft, akTop, akRight]
      Border.Color = cl3DLight
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSource1
      DynProps = <>
      Flat = True
      FooterParams.Color = clWindow
      GridLineParams.DataHorzLines = False
      GridLineParams.GridBoundaries = True
      GridLineParams.ColorScheme = glcsThemedEh
      GridLineParams.VertEmptySpaceStyle = dessNonEh
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove]
      SortLocal = True
      TabOrder = 2
      OnSortMarkingChanged = DBGridEh1SortMarkingChanged
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          Width = 78
        end
        item
          Color = 16511978
          DynProps = <>
          EditButtons = <>
          FieldName = 'Capital'
          Footers = <>
          Width = 79
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Continent'
          Footers = <>
          Width = 77
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
    object DBGridEh4: TDBGridEh
      Left = 8
      Top = 512
      Width = 424
      Height = 136
      Anchors = [akLeft, akTop, akRight]
      Border.Color = cl3DLight
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSource1
      DynProps = <>
      Flat = True
      FooterParams.Color = clWindow
      GridLineParams.DataHorzLines = True
      GridLineParams.ColorScheme = glcsThemedEh
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      SortLocal = True
      TabOrder = 3
      OnSortMarkingChanged = DBGridEh1SortMarkingChanged
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          Width = 78
        end
        item
          Color = 16511978
          DynProps = <>
          EditButtons = <>
          FieldName = 'Capital'
          Footers = <>
          Width = 79
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Continent'
          Footers = <>
          Width = 80
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
    object DBGridEh5: TDBGridEh
      Left = 8
      Top = 680
      Width = 424
      Height = 136
      Anchors = [akLeft, akTop, akRight]
      Border.Color = cl3DLight
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSource1
      DynProps = <>
      Flat = True
      FooterParams.Color = clWindow
      GridLineParams.DataHorzLines = True
      GridLineParams.ColorScheme = glcsThemedEh
      GridLineParams.VertEmptySpaceStyle = dessSolidEh
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      SortLocal = True
      TabOrder = 4
      OnSortMarkingChanged = DBGridEh1SortMarkingChanged
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          Width = 78
        end
        item
          Color = 16511978
          DynProps = <>
          EditButtons = <>
          FieldName = 'Capital'
          Footers = <>
          Width = 79
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Continent'
          Footers = <>
          Width = 80
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
    object DBGridEh6: TDBGridEh
      Left = 8
      Top = 840
      Width = 424
      Height = 136
      Anchors = [akLeft, akTop, akRight]
      Border.Color = cl3DLight
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSource1
      DynProps = <>
      Flat = True
      FooterParams.Color = clWindow
      GridLineParams.DataHorzLines = True
      GridLineParams.GridBoundaries = True
      GridLineParams.ColorScheme = glcsThemedEh
      GridLineParams.VertEmptySpaceStyle = dessSolidEh
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      SortLocal = True
      TabOrder = 5
      OnSortMarkingChanged = DBGridEh1SortMarkingChanged
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          Width = 78
        end
        item
          Color = 16511978
          DynProps = <>
          EditButtons = <>
          FieldName = 'Capital'
          Footers = <>
          Width = 79
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Continent'
          Footers = <>
          Width = 80
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
    object DBGridEh7: TDBGridEh
      Left = 8
      Top = 1030
      Width = 419
      Height = 149
      Anchors = [akLeft, akTop, akRight]
      Border.Color = cl3DLight
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSource1
      DynProps = <>
      Flat = True
      FooterParams.Color = clWindow
      GridLineParams.DataVertLines = False
      GridLineParams.DataHorzLines = False
      GridLineParams.GridBoundaries = True
      GridLineParams.ColorScheme = glcsThemedEh
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      SortLocal = True
      TabOrder = 6
      OnSortMarkingChanged = DBGridEh1SortMarkingChanged
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          Width = 78
        end
        item
          Color = 16513010
          DynProps = <>
          EditButtons = <>
          FieldName = 'Capital'
          Footers = <>
          Width = 79
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Continent'
          Footers = <>
          Width = 81
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
    object DBGridEh8: TDBGridEh
      Left = 8
      Top = 1206
      Width = 419
      Height = 149
      Anchors = [akLeft, akTop, akRight]
      Border.Color = cl3DLight
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSource1
      DynProps = <>
      Flat = True
      FooterParams.Color = clWindow
      GridLineParams.DataVertLines = False
      GridLineParams.DataHorzLines = False
      GridLineParams.GridBoundaries = True
      GridLineParams.ColorScheme = glcsThemedEh
      GridLineParams.VertEmptySpaceStyle = dessSolidEh
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      SortLocal = True
      TabOrder = 7
      OnSortMarkingChanged = DBGridEh1SortMarkingChanged
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          Width = 78
        end
        item
          Color = 16513010
          DynProps = <>
          EditButtons = <>
          FieldName = 'Capital'
          Footers = <>
          Width = 79
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Continent'
          Footers = <>
          Width = 81
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
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Filter = 'Area < 100000'
    Filtered = True
    Params = <>
    Left = 56
    Top = 296
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
