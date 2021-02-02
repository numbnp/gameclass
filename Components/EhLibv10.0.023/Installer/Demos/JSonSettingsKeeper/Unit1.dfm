object Form1: TForm1
  Left = 375
  Top = 124
  Caption = 'Form1'
  ClientHeight = 539
  ClientWidth = 776
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  Visible = True
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 468
    Top = 0
    Width = 8
    Height = 539
    Align = alRight
    ResizeStyle = rsUpdate
    ExplicitLeft = 0
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 468
    Height = 539
    Align = alClient
    ColumnDefValues.Title.TitleButton = True
    DataSource = DataSource1
    DynProps = <>
    FooterParams.Color = clWindow
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghPreferIncSearch, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
    SearchPanel.Enabled = True
    SortLocal = True
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    TabOrder = 0
    TitleParams.RowLines = 2
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Name'
        Footers = <>
        Width = 96
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Capital'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Continent'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Area'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Population'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBVertGridEh1: TDBVertGridEh
    Left = 476
    Top = 0
    Width = 300
    Height = 539
    Align = alRight
    AllowedSelections = []
    RowCategories.CategoryProps = <>
    PrintService.ColorSchema = pcsFullColorEh
    DataSource = DataSource1
    DrawGraphicData = True
    DrawMemoText = True
    TabOrder = 1
  end
  object MemTableEh1: TMemTableEh
    Active = True
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
  object ADOTable1: TADOTable
    ConnectionString = 
      'FILE NAME=C:\Program Files (x86)\Common Files\System\OLE DB\Data' +
      ' Links\DBDEMOS.udl'
    CursorType = ctStatic
    TableName = 'country'
    Left = 184
    Top = 304
  end
end
