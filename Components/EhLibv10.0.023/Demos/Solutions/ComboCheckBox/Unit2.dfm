object DropDownForm2: TDropDownForm2
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'DropDownForm2'
  ClientHeight = 300
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  FormElements = [ddfeLeftGripEh, ddfeRightGripEh]
  DropDownMode = True
  DesignSize = (
    408
    300)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 8
    Width = 392
    Height = 245
    AllowedSelections = [gstRecordBookmarks]
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoFitColWidths = True
    DataSource = DataSource1
    DynProps = <>
    IndicatorOptions = [gioShowRowselCheckboxesEh]
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
    TabOrder = 2
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Id'
        Footers = <>
        Width = 20
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Name'
        Footers = <>
        Width = 285
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object bOk: TButton
    Left = 229
    Top = 263
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 3
    OnClick = bOkClick
    ExplicitLeft = 181
    ExplicitTop = 243
  end
  object bCancel: TButton
    Left = 310
    Top = 263
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
    OnClick = bCancelClick
    ExplicitLeft = 262
    ExplicitTop = 243
  end
  object bClear: TButton
    Left = 8
    Top = 263
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Clear'
    TabOrder = 5
    OnClick = bClearClick
  end
  object Button1: TButton
    Left = 89
    Top = 263
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Select All'
    TabOrder = 6
    OnClick = Button1Click
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Params = <>
    Left = 56
    Top = 212
    object MemTableEh1Id: TAutoIncField
      FieldName = 'Id'
    end
    object MemTableEh1Name: TWideStringField
      FieldName = 'Name'
      Size = 24
    end
    object MemTableEh1Capital: TWideStringField
      FieldName = 'Capital'
      Size = 24
    end
    object MemTableEh1Continent: TWideStringField
      FieldName = 'Continent'
      Size = 24
    end
    object MemTableEh1Area: TFloatField
      FieldName = 'Area'
    end
    object MemTableEh1Population: TFloatField
      FieldName = 'Population'
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object Id: TMTNumericDataFieldEh
          FieldName = 'Id'
          NumericDataType = fdtAutoIncEh
          AutoIncrement = False
          DisplayWidth = 20
          currency = False
          Precision = 15
        end
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
            1
            'Argentina'
            'Buenos Aires'
            'South America'
            2777815.000000000000000000
            32300003.000000000000000000)
          (
            2
            'Bolivia'
            'La Paz'
            'South America'
            1098575.000000000000000000
            7300000.000000000000000000)
          (
            3
            'Brazil'
            'Brasilia'
            'South America'
            8511196.000000000000000000
            150400000.000000000000000000)
          (
            4
            'Canada'
            'Ottawa'
            'North America'
            9976147.000000000000000000
            26500000.000000000000000000)
          (
            5
            'Chile'
            'Santiago'
            'South America'
            756943.000000000000000000
            13200000.000000000000000000)
          (
            6
            'Colombia'
            'Bagota'
            'South America'
            1138907.000000000000000000
            33000000.000000000000000000)
          (
            7
            'Cuba'
            'Havana'
            'North America'
            114524.000000000000000000
            10600000.000000000000000000)
          (
            8
            'Ecuador'
            'Quito'
            'South America'
            455502.000000000000000000
            10600000.000000000000000000)
          (
            9
            'El Salvador'
            'San Salvador'
            'North America'
            20865.000000000000000000
            5300000.000000000000000000)
          (
            10
            'Guyana'
            'Georgetown'
            'South America'
            214969.000000000000000000
            800000.000000000000000000)
          (
            11
            'Jamaica'
            'Kingston'
            'North America'
            11424.000000000000000000
            2500000.000000000000000000)
          (
            12
            'Mexico'
            'Mexico City'
            'North America'
            1967180.000000000000000000
            88600000.000000000000000000)
          (
            13
            'Nicaragua'
            'Managua'
            'North America'
            139000.000000000000000000
            3900000.000000000000000000)
          (
            14
            'Paraguay'
            'Asuncion'
            'South America'
            406576.000000000000000000
            4660000.000000000000000000)
          (
            15
            'Peru'
            'Lima'
            'South America'
            1285215.000000000000000000
            21600000.000000000000000000)
          (
            16
            'United States of America'
            'Washington'
            'North America'
            9363130.000000000000000000
            249200000.000000000000000000)
          (
            17
            'Uruguay'
            'Montevideo'
            'South America'
            176140.000000000000000000
            3002000.000000000000000000)
          (
            18
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
    Top = 212
  end
end
