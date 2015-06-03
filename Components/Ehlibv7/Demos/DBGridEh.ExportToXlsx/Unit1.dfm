object Form1: TForm1
  Left = 514
  Top = 289
  Width = 532
  Height = 472
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    516
    434)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 352
    Width = 501
    Height = 73
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    Caption = 
      'Run the project under Delphi XE2 or higher version of compiler t' +
      'o prevent '#39'ZipFileProviderClass is not assigned'#39' error. For Delp' +
      'hi lower then XE2 it is needed to write and register class inher' +
      'ited from TCustomFileZipingProviderEh or use ThirdParty componen' +
      'ts to make ZIP v2 files. See example of such a class in the unit' +
      ' - <EhLib arhcive>\ZipProviders\FWZipFileProviderEh.pas '
    WordWrap = True
  end
  object Button1: TButton
    Left = 8
    Top = 5
    Width = 273
    Height = 25
    Caption = 'Export to xlsx-file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGridEh: TDBGridEh
    Left = 8
    Top = 39
    Width = 500
    Height = 298
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    DynProps = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FooterRowCount = 2
    FooterParams.Color = clWindow
    GridLineParams.DataVertLines = True
    GridLineParams.DataHorzLines = True
    GridLineParams.VertEmptySpaceStyle = dessSolidEh
    IndicatorOptions = [gioShowRowIndicatorEh]
    ParentFont = False
    TabOrder = 1
    TitleParams.HorzLines = True
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Footers = <
          item
            Value = 'test'
            ValueType = fvtStaticText
          end>
        Width = 68
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Capital'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Footers = <>
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 53
      end
      item
        Color = clMoneyGreen
        DynProps = <>
        EditButtons = <>
        FieldName = 'Continent'
        Footers = <>
        Width = 106
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Area'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Footer.FieldName = 'Area'
        Footer.ValueType = fvtSum
        Footers = <
          item
            FieldName = 'Population'
            ValueType = fvtFieldValue
          end
          item
            FieldName = 'Area'
            ValueType = fvtCount
          end>
        Width = 56
      end
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'Population'
        Footers = <>
        Width = 74
        OnGetCellParams = DBGridEhColumns4GetCellParams
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Button3: TButton
    Left = 288
    Top = 5
    Width = 222
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = #1054#1090#1082#1088#1099#1090#1100' xlsx-'#1092#1072#1081#1083
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button3Click
  end
  object MTE: TMemTableEh
    Active = True
    Filter = 'Name='#39'Canada'#39
    Params = <>
    Left = 432
    Top = 104
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
    DataSet = MTE
    Left = 432
    Top = 160
  end
end
