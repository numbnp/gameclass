object Form1: TForm1
  Left = 347
  Top = 124
  Width = 670
  Height = 507
  Caption = 'Form1'
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 392
    Top = 38
    Width = 8
    Height = 430
    Align = alRight
    ResizeStyle = rsUpdate
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 38
    Width = 392
    Height = 430
    Align = alClient
    ColumnDefValues.AlwaysShowEditButton = True
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    HorzScrollBar.ExtraPanel.Visible = True
    HorzScrollBar.Height = 25
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    RowSizingAllowed = True
    SearchPanel.Enabled = True
    TabOrder = 0
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBVertGridEh1: TDBVertGridEh
    Left = 400
    Top = 38
    Width = 254
    Height = 430
    Align = alRight
    AllowedSelections = []
    RowCategories.CategoryProps = <>
    PrintService.ColorSchema = pcsFullColorEh
    DataColParams.MaxRowHeight = 2
    DataColParams.MaxRowLines = 10
    DataSource = DataSource1
    DrawGraphicData = True
    DrawMemoText = True
    Flat = True
    Options = [dgvhEditing, dgvhLabelCol, dgvhColLines, dgvhRowLines, dgvhTabs, dgvhConfirmDelete, dgvhCancelOnExit]
    RowsDefValues.FitRowHeightToData = True
    SearchPanel.Enabled = True
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 654
    Height = 38
    Align = alTop
    ParentBackground = False
    TabOrder = 2
    object DBNavigator1: TDBNavigator
      Left = 14
      Top = 7
      Width = 200
      Height = 25
      DataSource = DataSource1
      Flat = True
      TabOrder = 0
    end
  end
  object ADOConnectionProviderEh1: TADOConnectionProviderEh
    InlineConnection.Connected = True
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\RADStudio\12.0\E' +
      'hLib\Demos\Data\cities10000.mdb;Persist Security Info=False'
    InlineConnection.UseAtDesignTime = False
    InlineConnection.UseAtRunTime = False
    InlineConnection.Mode = cmShareDenyNone
    InlineConnection.Provider = 'Microsoft.Jet.OLEDB.4.0'
    ServerType = 'MSAccess'
    InlineConnectionBeforeConnect = ADOConnectionProviderEh1InlineConnectionBeforeConnect
    Left = 8
    Top = 328
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  Cities1000'
      'where '
      'gname >= '#39'Russ'#39
      'and gname < '#39'Rv'#39)
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    OnBuildDataStruct = ADODataDriverEh1BuildDataStruct
    Left = 32
    Top = 264
  end
  object MemTableEh1: TMemTableEh
    Active = True
    AggregatesActive = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    AfterOpen = MemTableEh1AfterOpen
    Left = 72
    Top = 312
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object geonameid: TMTNumericDataFieldEh
          FieldName = 'geonameid'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'geonameid'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object gname: TMTStringDataFieldEh
          FieldName = 'gname'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'gname'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object asciiname: TMTStringDataFieldEh
          FieldName = 'asciiname'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'asciiname'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object latitude: TMTNumericDataFieldEh
          FieldName = 'latitude'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'latitude'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object longitude: TMTNumericDataFieldEh
          FieldName = 'longitude'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'longitude'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object feature_class: TMTStringDataFieldEh
          FieldName = 'feature_class'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'feature_class'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object feature_code: TMTStringDataFieldEh
          FieldName = 'feature_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'feature_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object country_code: TMTStringDataFieldEh
          FieldName = 'country_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'country_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object cc2: TMTStringDataFieldEh
          FieldName = 'cc2'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'cc2'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object admin1_code: TMTStringDataFieldEh
          FieldName = 'admin1_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'admin1_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object admin2_code: TMTStringDataFieldEh
          FieldName = 'admin2_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'admin2_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object admin3_code: TMTStringDataFieldEh
          FieldName = 'admin3_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'admin3_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object admin4_code: TMTStringDataFieldEh
          FieldName = 'admin4_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'admin4_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object population: TMTNumericDataFieldEh
          FieldName = 'population'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'population'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object elevation: TMTStringDataFieldEh
          FieldName = 'elevation'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'elevation'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object dem: TMTStringDataFieldEh
          FieldName = 'dem'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'dem'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object timezone: TMTStringDataFieldEh
          FieldName = 'timezone'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'timezone'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object modification_date: TMTDateTimeDataFieldEh
          FieldName = 'modification_date'
          DateTimeDataType = fdtDateTimeEh
          DisplayLabel = 'modification_date'
          DisplayWidth = 18
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            426700
            'Ruyigi'
            'Ruyigi'
            -3.476390000000000000
            30.248610000000000000
            'P'
            'PPLA'
            'BI'
            nil
            '21'
            nil
            nil
            nil
            38458
            nil
            '1596'
            'Africa/Bujumbura'
            40927d)
          (
            433635
            'Rutana'
            'Rutana'
            -3.927900000000000000
            29.992000000000000000
            'P'
            'PPLA'
            'BI'
            nil
            '20'
            nil
            nil
            nil
            20893
            nil
            '1792'
            'Africa/Bujumbura'
            40927d)
          (
            500299
            'Ruzayevka'
            'Ruzayevka'
            54.063870000000000000
            44.950900000000000000
            'P'
            'PPL'
            'RU'
            nil
            '46'
            nil
            nil
            nil
            49311
            nil
            '199'
            'Europe/Moscow'
            40925d)
          (
            500303
            'Ruza'
            'Ruza'
            55.698980000000000000
            36.195220000000000000
            'P'
            'PPL'
            'RU'
            nil
            '47'
            nil
            nil
            nil
            13480
            nil
            '183'
            'Europe/Moscow'
            40925d)
          (
            500316
            'Rutul'
            'Rutul'
            41.535660000000000000
            47.423910000000000000
            'P'
            'PPL'
            'RU'
            nil
            '17'
            nil
            nil
            nil
            4237
            nil
            '1353'
            'Europe/Moscow'
            40925d)
          (
            500350
            'Russko-Vysotskoye'
            'Russko-Vysotskoye'
            59.699630000000000000
            29.944040000000000000
            'P'
            'PPL'
            'RU'
            nil
            '42'
            nil
            nil
            nil
            4711
            nil
            '115'
            'Europe/Moscow'
            40925d)
          (
            500400
            'Russkiy Kameshkir'
            'Russkiy Kameshkir'
            52.859550000000000000
            46.088610000000000000
            'P'
            'PPL'
            'RU'
            nil
            '57'
            nil
            nil
            nil
            5305
            nil
            '215'
            'Europe/Moscow'
            40925d)
          (
            583573
            'Russkiy Aktash'
            'Russkiy Aktash'
            55.038400000000000000
            52.121400000000000000
            'P'
            'PPL'
            'RU'
            nil
            '73'
            nil
            nil
            nil
            4195
            nil
            '88'
            'Europe/Moscow'
            40925d)
          (
            612287
            'Rust'#8217'avi'
            'Rust'#39'avi'
            41.549490000000000000
            44.993230000000000000
            'P'
            'PPL'
            'GE'
            nil
            '00'
            nil
            nil
            nil
            50000
            nil
            '338'
            'Asia/Tbilisi'
            40925d)
          (
            638622
            'Ruukki'
            'Ruukki'
            64.666670000000000000
            25.100000000000000000
            'P'
            'PPL'
            'FI'
            nil
            '08'
            '17'
            '748'
            nil
            4386
            nil
            '48'
            'Europe/Helsinki'
            40926d)
          (
            695082
            'Ruzhyn'
            'Ruzhyn'
            49.722800000000000000
            29.204550000000000000
            'P'
            'PPL'
            'UA'
            nil
            '27'
            nil
            nil
            nil
            4993
            nil
            '227'
            'Europe/Kiev'
            40926d)
          (
            695104
            'Russkaya Polyana'
            'Russkaya Polyana'
            49.417000000000000000
            31.920090000000000000
            'P'
            'PPL'
            'UA'
            nil
            '01'
            nil
            nil
            nil
            7780
            nil
            '116'
            'Europe/Kiev'
            40539d)
          (
            727495
            'Ruzhintsi'
            'Ruzhintsi'
            43.623330000000000000
            22.830830000000000000
            'P'
            'PPL'
            'BG'
            'BG'
            '63'
            'VID33'
            nil
            nil
            1269
            nil
            '192'
            'Europe/Sofia'
            40926d)
          (
            759946
            'Rutki'
            'Rutki'
            53.100000000000000000
            22.433330000000000000
            'P'
            'PPLA3'
            'PL'
            nil
            '81'
            '2014'
            '201403'
            nil
            0
            nil
            '117'
            'Europe/Warsaw'
            40755d)
          (
            958724
            'Rustenburg'
            'Rustenburg'
            -25.667560000000000000
            27.242080000000000000
            'P'
            'PPL'
            'ZA'
            nil
            '10'
            nil
            nil
            nil
            124064
            nil
            '1171'
            'Africa/Johannesburg'
            40926d)
          (
            1128186
            'R'#363'-ye Sang'
            'Ru-ye Sang'
            35.319990000000000000
            67.633870000000000000
            'P'
            'PPLA2'
            'AF'
            nil
            '05'
            nil
            nil
            nil
            0
            nil
            '1751'
            'Asia/Kabul'
            40967d)
          (
            1128265
            'Rust'#257'q'
            'Rustaq'
            37.126040000000010000
            69.830450000000000000
            'P'
            'PPLA2'
            'AF'
            nil
            '26'
            nil
            nil
            nil
            25636
            nil
            '1314'
            'Asia/Kabul'
            40967d)
          (
            1166720
            'Rustam jo Goth'
            'Rustam jo Goth'
            27.968970000000000000
            68.804810000000000000
            'P'
            'PPL'
            'PK'
            nil
            '05'
            nil
            nil
            nil
            9048
            nil
            '67'
            'Asia/Karachi'
            40925d)
          (
            1280116
            'Rutog'
            'Rutog'
            33.418440000000000000
            79.639190000000000000
            'P'
            'PPLA3'
            'CN'
            nil
            '14'
            nil
            nil
            nil
            0
            nil
            '4253'
            'Asia/Kashgar'
            40926d)
          (
            1493423
            'Russkaya Polyana'
            'Russkaya Polyana'
            53.779440000000000000
            73.880560000000000000
            'P'
            'PPL'
            'RU'
            nil
            '54'
            nil
            nil
            nil
            6454
            nil
            '127'
            'Asia/Omsk'
            40925d)
          (
            1629380
            'Ruteng'
            'Ruteng'
            -8.613600000000000000
            120.472100000000000000
            'P'
            'PPL'
            'ID'
            nil
            '18'
            nil
            nil
            nil
            34569
            nil
            '1203'
            'Asia/Makassar'
            40925d)
          (
            2017364
            'Russkiy'
            'Russkiy'
            43.022400000000000000
            131.860100000000000000
            'P'
            'PPL'
            'RU'
            nil
            '59'
            nil
            nil
            nil
            5080
            nil
            '10'
            'Asia/Vladivostok'
            40967d)
          (
            2511649
            'Rute'
            'Rute'
            37.326900000000000000
            -4.368270000000000000
            'P'
            'PPLA3'
            'ES'
            nil
            '51'
            'CO'
            '14058'
            nil
            10559
            nil
            '658'
            'Europe/Madrid'
            40972d)
          (
            2638925
            'Ruthin'
            'Ruthin'
            53.113680000000000000
            -3.317820000000000000
            'P'
            'PPLA2'
            'GB'
            nil
            'WLS'
            'X9'
            '00NG036'
            nil
            5344
            nil
            '60'
            'Europe/London'
            41011d)
          (
            2638926
            'Rutherglen'
            'Rutherglen'
            55.828850000000000000
            -4.213760000000000000
            'P'
            'PPL'
            'GB'
            nil
            'SCT'
            'W5'
            nil
            nil
            25000
            nil
            '23'
            'Europe/London'
            40997d)
          (
            2638930
            'Rustington'
            'Rustington'
            50.810270000000000000
            -0.506740000000000000
            'P'
            'PPL'
            'GB'
            nil
            'ENG'
            'P6'
            '45UC'
            nil
            13210
            nil
            '6'
            'Europe/London'
            40997d)
          (
            2658909
            'R'#252'ti'
            'Rueti'
            47.256030000000000000
            8.855520000000000000
            'P'
            'PPL'
            'CH'
            nil
            'ZH'
            '105'
            '117'
            nil
            9576
            nil
            '470'
            'Europe/Zurich'
            39528d)
          (
            2658912
            'R'#252'thi'
            'Ruthi'
            47.294800000000000000
            9.538570000000000000
            'P'
            'PPL'
            'CH'
            nil
            'SG'
            '1723'
            '3256'
            nil
            1945
            nil
            '433'
            'Europe/Zurich'
            40273d)
          (
            2658914
            'Ruswil'
            'Ruswil'
            47.084250000000000000
            8.126450000000000000
            'P'
            'PPL'
            'CH'
            nil
            'LU'
            '304'
            '1098'
            nil
            6432
            nil
            '642'
            'Europe/Zurich'
            40925d)
          (
            2658917
            'Russikon'
            'Russikon'
            47.396690000000000000
            8.775150000000000000
            'P'
            'PPL'
            'CH'
            nil
            'ZH'
            '108'
            '178'
            nil
            2415
            nil
            '628'
            'Europe/Zurich'
            38995d)
          (
            2766932
            'Rutzenham'
            'Rutzenham'
            48.060760000000000000
            13.718830000000000000
            'P'
            'PPLA3'
            'AT'
            nil
            '04'
            '417'
            '41733'
            nil
            0
            nil
            '409'
            'Europe/Vienna'
            40755d)
          (
            2766936
            'R'#252'storf'
            'Rustorf'
            48.043259999999990000
            13.789820000000000000
            'P'
            'PPLA3'
            'AT'
            nil
            '04'
            '417'
            '41732'
            nil
            0
            nil
            '378'
            'Europe/Vienna'
            40755d)
          (
            2766939
            'Rust'
            'Rust'
            47.801220000000000000
            16.671580000000000000
            'P'
            'PPLA2'
            'AT'
            nil
            '01'
            '102'
            '10201'
            nil
            1726
            nil
            '127'
            'Europe/Vienna'
            40942d)
          (
            2842785
            'Rutsweiler an der Lauter'
            'Rutsweiler an der Lauter'
            49.566670000000000000
            7.616670000000000000
            'P'
            'PPLA4'
            'DE'
            nil
            '08'
            '00'
            '07336'
            '07336090'
            390
            nil
            '256'
            'Europe/Berlin'
            40658d)
          (
            2842795
            'R'#252'ting'
            'Ruting'
            53.783330000000000000
            11.216670000000000000
            'P'
            'PPLA4'
            'DE'
            nil
            '12'
            '00'
            '13058'
            '13058091'
            604
            nil
            '43'
            'Europe/Berlin'
            40658d)
          (
            2842796
            'Ruthweiler'
            'Ruthweiler'
            49.550000000000000000
            7.366670000000000000
            'P'
            'PPLA4'
            'DE'
            nil
            '08'
            '00'
            '07336'
            '07336088'
            537
            nil
            '298'
            'Europe/Berlin'
            40658d)
          (
            2842801
            'R'#252'thnick'
            'Ruthnick'
            52.881200000000000000
            12.996480000000000000
            'P'
            'PPLA4'
            'DE'
            nil
            '11'
            '00'
            '12068'
            '12068372'
            536
            nil
            '43'
            'Europe/Berlin'
            40755d)
          (
            2842816
            'R'#252'then'
            'Ruthen'
            51.490900000000010000
            8.435960000000000000
            'P'
            'PPL'
            'DE'
            nil
            '07'
            '059'
            nil
            nil
            11299
            nil
            '376'
            'Europe/Berlin'
            40497d)
          (
            2842824
            'Rutesheim'
            'Rutesheim'
            48.808080000000000000
            8.945360000000001000
            'P'
            'PPLA4'
            'DE'
            nil
            '01'
            '081'
            '08115'
            '08115042'
            10222
            nil
            '440'
            'Europe/Berlin'
            40658d)
          (
            2842854
            'Rustenfelde'
            'Rustenfelde'
            51.400000000000000000
            10.000000000000000000
            'P'
            'PPLA4'
            'DE'
            nil
            '15'
            '00'
            '16061'
            '16061082'
            504
            nil
            '342'
            'Europe/Berlin'
            40658d)
          (
            2842861
            'Rust'
            'Rust'
            48.266670000000000000
            7.733330000000000000
            'P'
            'PPLA4'
            'DE'
            nil
            '01'
            '083'
            '08317'
            '08317114'
            3577
            nil
            '162'
            'Europe/Berlin'
            40658d)
          (
            2842869
            'R'#252'ssingen'
            'Russingen'
            49.615830000000000000
            8.088329999999999000
            'P'
            'PPLA4'
            'DE'
            nil
            '08'
            '00'
            '07333'
            '07333064'
            508
            nil
            '250'
            'Europe/Berlin'
            40658d)
          (
            2842884
            'R'#252'sselsheim'
            'Russelsheim'
            49.992500000000000000
            8.435000000000001000
            'P'
            'PPL'
            'DE'
            nil
            '05'
            nil
            nil
            nil
            59730
            nil
            '93'
            'Europe/Berlin'
            40926d)
          (
            2982102
            'Ruy'
            'Ruy'
            45.587720000000000000
            5.318900000000000000
            'P'
            'PPL'
            'FR'
            nil
            'B9'
            '38'
            '382'
            '38348'
            4090
            nil
            '269'
            'Europe/Paris'
            40926d)
          (
            2982119
            'Russange'
            'Russange'
            49.483080000000000000
            5.952390000000000000
            'P'
            'PPL'
            'FR'
            nil
            'B2'
            '57'
            '578'
            '57603'
            1103
            nil
            '320'
            'Europe/Paris'
            40926d)
          (
            2982122
            'Russ'
            'Russ'
            48.494950000000000000
            7.260530000000000000
            'P'
            'PPL'
            'FR'
            nil
            'C1'
            '67'
            '673'
            '67420'
            1251
            nil
            '310'
            'Europe/Paris'
            40926d)
          (
            3045688
            'Ruzsa'
            'Ruzsa'
            46.288060000000000000
            19.747140000000000000
            'P'
            'PPL'
            'HU'
            nil
            '06'
            nil
            nil
            nil
            2764
            nil
            '113'
            'Europe/Budapest'
            40926d)
          (
            3057789
            'Ru'#382'omberok'
            'Ruzomberok'
            49.074800000000010000
            19.307510000000000000
            'P'
            'PPL'
            'SK'
            nil
            '08'
            nil
            nil
            nil
            30806
            nil
            '481'
            'Europe/Bratislava'
            40926d)
          (
            3168770
            'Ruvo di Puglia'
            'Ruvo di Puglia'
            41.113630000000000000
            16.487780000000000000
            'P'
            'PPLA3'
            'IT'
            nil
            '13'
            'BA'
            '072038'
            nil
            25741
            nil
            '250'
            'Europe/Rome'
            40954d)
          (
            3168771
            'Ruvo del Monte'
            'Ruvo del Monte'
            40.848820000000010000
            15.541360000000000000
            'P'
            'PPLA3'
            'IT'
            nil
            '02'
            'PZ'
            '076072'
            nil
            1262
            nil
            '631'
            'Europe/Rome'
            40954d)
          (
            3168772
            'Ruviano'
            'Ruviano'
            41.210320000000000000
            14.409230000000000000
            'P'
            'PPLA3'
            'IT'
            nil
            '04'
            'CE'
            '061073'
            nil
            1914
            nil
            '76'
            'Europe/Rome'
            40954d)
          (
            3168774
            'Rutino'
            'Rutino'
            40.299700000000000000
            15.072760000000000000
            'P'
            'PPLA3'
            'IT'
            nil
            '04'
            'SA'
            '065112'
            nil
            920
            nil
            '377'
            'Europe/Rome'
            40954d)
          (
            3168775
            'Rutigliano'
            'Rutigliano'
            41.011130000000000000
            17.005490000000000000
            'P'
            'PPLA3'
            'IT'
            nil
            '13'
            'BA'
            '072037'
            nil
            17559
            nil
            '133'
            'Europe/Rome'
            40954d)
          (
            3168784
            'Russi'
            'Russi'
            44.372500000000000000
            12.032220000000000000
            'P'
            'PPLA3'
            'IT'
            nil
            '05'
            'RA'
            '039016'
            nil
            10503
            nil
            '12'
            'Europe/Rome'
            40954d)
          (
            3207490
            'Ruttersdorf-Lotschen'
            'Ruttersdorf-Lotschen'
            50.883330000000000000
            11.733330000000000000
            'P'
            'PPLA4'
            'DE'
            nil
            '15'
            '00'
            '16074'
            '16074081'
            332
            nil
            '253'
            'Europe/Berlin'
            40658d)
          (
            3390160
            'Russas'
            'Russas'
            -4.940279999999999000
            -37.975830000000000000
            'P'
            'PPL'
            'BR'
            nil
            '06'
            nil
            nil
            nil
            39465
            nil
            '26'
            'America/Fortaleza'
            39064d)
          (
            3450832
            'Ruy Barbosa'
            'Ruy Barbosa'
            -12.283890000000000000
            -40.493890000000000000
            'P'
            'PPL'
            'BR'
            nil
            '05'
            nil
            nil
            nil
            21093
            nil
            '344'
            'America/Bahia'
            39064d)
          (
            4087313
            'Russellville'
            'Russellville'
            34.507870000000000000
            -87.728640000000000000
            'P'
            'PPLA2'
            'US'
            nil
            'AL'
            '059'
            nil
            nil
            9830
            '232'
            '234'
            'America/Chicago'
            40677d)
          (
            4129397
            'Russellville'
            'Russellville'
            35.278420000000000000
            -93.133790000000000000
            'P'
            'PPLA2'
            'US'
            nil
            'AR'
            '115'
            nil
            nil
            27920
            '106'
            '109'
            'America/Chicago'
            40677d)
          (
            4220151
            'Russell'
            'Russell'
            33.978720000000000000
            -83.700170000000000000
            'P'
            'PPL'
            'US'
            nil
            'GA'
            '013'
            nil
            nil
            1203
            '299'
            '299'
            'America/New_York'
            40677d)
          (
            4278471
            'Russell'
            'Russell'
            38.895290000000000000
            -98.859810000000000000
            'P'
            'PPLA2'
            'US'
            nil
            'KS'
            '167'
            nil
            nil
            4506
            '557'
            '562'
            'America/Chicago'
            40677d)
          (
            4306972
            'Russell'
            'Russell'
            38.517300000000000000
            -82.697660000000000000
            'P'
            'PPL'
            'US'
            nil
            'KY'
            '089'
            nil
            nil
            3380
            '197'
            '204'
            'America/New_York'
            40677d)
          (
            4307012
            'Russell Springs'
            'Russell Springs'
            37.056180000000000000
            -85.088570000000000000
            'P'
            'PPL'
            'US'
            nil
            'KY'
            '207'
            nil
            nil
            2441
            '331'
            '332'
            'America/Chicago'
            40677d)
          (
            4307025
            'Russellville'
            'Russellville'
            36.845320000000000000
            -86.887220000000000000
            'P'
            'PPLA2'
            'US'
            nil
            'KY'
            '141'
            nil
            nil
            6960
            '181'
            '185'
            'America/Chicago'
            40677d)
          (
            4339348
            'Ruston'
            'Ruston'
            32.523210000000000000
            -92.637930000000000000
            'P'
            'PPLA2'
            'US'
            nil
            'LA'
            '061'
            nil
            nil
            21859
            '102'
            '104'
            'America/Chicago'
            40677d)
          (
            4489354
            'Rutherford College'
            'Rutherford College'
            35.748460000000000000
            -81.522589999999990000
            'P'
            'PPL'
            'US'
            nil
            'NC'
            '023'
            nil
            nil
            1341
            '368'
            '370'
            'America/New_York'
            40677d)
          (
            4489365
            'Rutherfordton'
            'Rutherfordton'
            35.369290000000000000
            -81.956770000000010000
            'P'
            'PPLA2'
            'US'
            nil
            'NC'
            '161'
            nil
            nil
            4213
            '295'
            '292'
            'America/New_York'
            40677d)
          (
            4654953
            'Rutherford'
            'Rutherford'
            36.127570000000000000
            -88.985900000000000000
            'P'
            'PPL'
            'US'
            nil
            'TN'
            '053'
            nil
            nil
            1151
            '101'
            '100'
            'America/Chicago'
            40677d)
          (
            4654984
            'Rutledge'
            'Rutledge'
            36.280920000000000000
            -83.514900000000000000
            'P'
            'PPLA2'
            'US'
            nil
            'TN'
            '057'
            nil
            nil
            1122
            '310'
            '309'
            'America/New_York'
            40677d)
          (
            4783303
            'Rustburg'
            'Rustburg'
            37.276810000000000000
            -79.100849999999990000
            'P'
            'PPLA2'
            'US'
            nil
            'VA'
            '031'
            nil
            nil
            1431
            '269'
            '267'
            'America/New_York'
            40677d)
          (
            4925674
            'Russiaville'
            'Russiaville'
            40.417540000000000000
            -86.271379999999990000
            'P'
            'PPL'
            'US'
            nil
            'IN'
            '067'
            nil
            nil
            1094
            '258'
            '259'
            'America/Indiana/Indianapolis'
            40677d)
          (
            4949245
            'Rutland'
            'Rutland'
            42.369540000000000000
            -71.948130000000010000
            'P'
            'PPL'
            'US'
            nil
            'MA'
            '027'
            nil
            nil
            2111
            '343'
            '347'
            'America/New_York'
            40677d)
          (
            5103580
            'Rutherford'
            'Rutherford'
            40.826490000000000000
            -74.106810000000000000
            'P'
            'PPL'
            'US'
            nil
            'NJ'
            '003'
            nil
            nil
            18061
            '28'
            '32'
            'America/New_York'
            40677d)
          (
            5168837
            'Russells Point'
            'Russells Point'
            40.471160000000000000
            -83.892720000000000000
            'P'
            'PPL'
            'US'
            nil
            'OH'
            '091'
            nil
            nil
            1391
            '306'
            '306'
            'America/New_York'
            40677d)
          (
            5209332
            'Russell'
            'Russell'
            41.941450000000010000
            -79.135050000000010000
            'P'
            'PPL'
            'US'
            nil
            'PA'
            '123'
            nil
            nil
            1408
            '381'
            '383'
            'America/New_York'
            40677d)
          (
            5209347
            'Russellton'
            'Russellton'
            40.611460000000000000
            -79.837000000000000000
            'P'
            'PPL'
            'US'
            nil
            'PA'
            '003'
            nil
            nil
            1440
            '291'
            '289'
            'America/New_York'
            40677d)
          (
            5209362
            'Rutherford'
            'Rutherford'
            40.268980000000000000
            -76.768030000000000000
            'P'
            'PPL'
            'US'
            nil
            'PA'
            '043'
            nil
            nil
            4303
            '158'
            '157'
            'America/New_York'
            40677d)
          (
            5240509
            'Rutland'
            'Rutland'
            43.610620000000000000
            -72.972610000000000000
            'P'
            'PPLA2'
            'US'
            nil
            'VT'
            '021'
            nil
            nil
            16495
            '197'
            '200'
            'America/New_York'
            40677d)
          (
            6292396
            'R'#252'ti / Westlicher Dorfteil'
            'Rueti / Westlicher Dorfteil'
            47.255480000000000000
            8.844900000000001000
            'P'
            'PPLX'
            'CH'
            nil
            'ZH'
            '105'
            '118'
            nil
            3083
            nil
            '475'
            'Europe/Zurich'
            39011d)
          (
            6292397
            'R'#252'ti / Dorfzentrum, S'#252'dl. Teil'
            'Rueti / Dorfzentrum, Suedl. Teil'
            47.253680000000000000
            8.856540000000001000
            'P'
            'PPLX'
            'CH'
            nil
            'ZH'
            '105'
            '118'
            nil
            3618
            nil
            '469'
            'Europe/Zurich'
            39011d)
          (
            6292398
            'R'#252'ti / Oberdorf'
            'Rueti / Oberdorf'
            47.258940000000000000
            8.865119999999999000
            'P'
            'PPLX'
            'CH'
            nil
            'ZH'
            '105'
            '118'
            nil
            2875
            nil
            '540'
            'Europe/Zurich'
            39011d)
          (
            7389785
            'Rutojawa'
            'Rutojawa'
            -8.913200000000000000
            121.014200000000000000
            'P'
            'PPLA4'
            'ID'
            nil
            '18'
            nil
            nil
            nil
            0
            nil
            '710'
            'Asia/Makassar'
            40929d)
          (
            7534709
            'Rutki-Kossaki'
            'Rutki-Kossaki'
            53.089320000000000000
            22.440110000000000000
            'P'
            'PPL'
            'PL'
            nil
            '81'
            '2014'
            '201403'
            nil
            1300
            nil
            '142'
            'Europe/Warsaw'
            40432d)
          (
            7610623
            'Ruto'
            'Ruto'
            -8.925400000000000000
            120.925400000000000000
            'P'
            'PPLA4'
            'ID'
            nil
            '18'
            nil
            nil
            nil
            0
            nil
            '35'
            'Asia/Makassar'
            40929d)
          (
            7838895
            'Russeifa'
            'Russeifa'
            32.017780000000000000
            36.046390000000000000
            'P'
            'PPL'
            'JO'
            nil
            '17'
            nil
            nil
            nil
            268237
            nil
            '614'
            'Asia/Amman'
            40688d))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 104
    Top = 304
  end
  object ADOConnectionProviderEh2: TADOConnectionProviderEh
    InlineConnection.Connected = True
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\DelphiStuff\_Dem' +
      'oDBs\Database_Small.mdb;Persist Security Info=False'
    InlineConnection.UseAtDesignTime = False
    InlineConnection.UseAtRunTime = False
    InlineConnection.Mode = cmShareDenyNone
    InlineConnection.Provider = 'Microsoft.Jet.OLEDB.4.0'
    ServerType = 'MSAccess'
    InlineConnectionBeforeConnect = ADOConnectionProviderEh1InlineConnectionBeforeConnect
    Left = 8
    Top = 392
  end
  object ADODataDriverEh2: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh2
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  SH'
      'where'
      '  ID < 10')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    OnBuildDataStruct = ADODataDriverEh1BuildDataStruct
    Left = 64
    Top = 384
  end
end
