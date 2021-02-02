object frDataSetExporter: TfrDataSetExporter
  Left = 0
  Top = 0
  Width = 794
  Height = 571
  TabOrder = 0
  DesignSize = (
    794
    571)
  object Label2: TLabel
    Left = 8
    Top = 79
    Width = 51
    Height = 13
    Caption = 'File format:'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 794
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 794
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
      Width = 211
      Height = 23
      Caption = 'DataSet Text Exporter'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Button1: TButton
    Left = 3
    Top = 42
    Width = 178
    Height = 25
    Caption = 'Export to DBMemo'
    TabOrder = 1
    OnClick = Button1Click
  end
  object PageControl1: TPageControl
    Left = 348
    Top = 100
    Width = 436
    Height = 458
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Src Data'
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 428
        Height = 430
        Align = alClient
        DataSource = DataSource1
        DrawGraphicData = True
        DrawMemoText = True
        DynProps = <>
        IndicatorOptions = [gioShowRowIndicatorEh]
        TabOrder = 0
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Result Data'
      ImageIndex = 1
      object DBMemoEh1: TDBMemoEh
        Left = 0
        Top = 0
        Width = 428
        Height = 430
        Lines.Strings = (
          '')
        ScrollBars = ssBoth
        Align = alClient
        AutoSize = False
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Visible = True
        WantReturns = True
        WordWrap = False
      end
    end
  end
  object rbDelim: TRadioButton
    Left = 91
    Top = 79
    Width = 113
    Height = 17
    Caption = 'Indicator separated'
    Checked = True
    TabOrder = 3
    TabStop = True
    OnClick = rbDelimClick
  end
  object rbFixSize: TRadioButton
    Left = 91
    Top = 98
    Width = 153
    Height = 17
    Caption = 'Fixed records lenght'
    TabOrder = 4
    OnClick = rbFixSizeClick
  end
  object cbxCodePage: TDBComboBoxEh
    Left = 115
    Top = 125
    Width = 206
    Height = 21
    ControlLabel.Width = 59
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Text coding:'
    ControlLabel.Visible = True
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      'UTF8'
      'UTF7'
      'Unicode'
      'BigEndianUnicode'
      'ANSI'
      'ASCII')
    TabOrder = 5
    Text = 'UTF8'
    Visible = True
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 229
    Width = 327
    Height = 124
    Caption = ' Date, time, number formats '
    TabOrder = 6
    object cbbDateFormat: TDBComboBoxEh
      Left = 169
      Top = 18
      Width = 90
      Height = 21
      ControlLabel.Width = 126
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Date format and separator '
      ControlLabel.Layout = tlCenter
      ControlLabel.Visible = True
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        'DD/MM/YYYY'
        'MM/DD/YYYY'
        'YYYY/MM/DD')
      TabOrder = 0
      Text = 'YYYY/MM/DD'
      Visible = True
    end
    object cbbDateSep: TDBComboBoxEh
      Left = 265
      Top = 18
      Width = 53
      Height = 21
      ControlLabel.Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1076#1072#1090#1099
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        '/'
        '.'
        '-'
        ',')
      TabOrder = 1
      Text = '/'
      Visible = True
    end
    object cbbTimeSep: TDBComboBoxEh
      Left = 265
      Top = 45
      Width = 53
      Height = 21
      ControlLabel.Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1074#1088#1077#1084#1077#1085#1080
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        ':'
        '-')
      TabOrder = 2
      Text = ':'
      Visible = True
    end
    object cbbDecSep: TDBComboBoxEh
      Left = 169
      Top = 95
      Width = 53
      Height = 21
      ControlLabel.Width = 85
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Decimal separator'
      ControlLabel.Visible = True
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        ','
        '.')
      TabOrder = 3
      Text = ','
      Visible = True
    end
    object cbbTimeFormat: TDBComboBoxEh
      Left = 169
      Top = 45
      Width = 90
      Height = 21
      ControlLabel.Width = 126
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Time format and separator '
      ControlLabel.Transparent = True
      ControlLabel.Visible = True
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        'HH:MM'
        'HH:MM:SS')
      TabOrder = 4
      Text = 'HH:MM:SS'
      Visible = True
    end
    object cbbDateTimeFormat: TDBComboBoxEh
      Left = 170
      Top = 70
      Width = 148
      Height = 21
      ControlLabel.Width = 81
      ControlLabel.Height = 13
      ControlLabel.Caption = 'DateTime format '
      ControlLabel.Transparent = True
      ControlLabel.Visible = True
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        'YYYY/MM/DD"T"HH:NN:SS'
        'DD/MM/YYYY HH:NN:SS'
        'MM/DD/YYYY HH:NN:SS'
        'YYYY/MM/DD HH:NN:SS')
      TabOrder = 5
      Text = 'YYYY/MM/DD HH:NN:SS'
      Visible = True
    end
  end
  object DBEditEh1: TDBEditEh
    Left = 395
    Top = 73
    Width = 389
    Height = 21
    ControlLabel.Width = 45
    ControlLabel.Height = 13
    ControlLabel.Caption = 'File name'
    ControlLabel.Visible = True
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    Anchors = [akLeft, akTop, akRight]
    DynProps = <>
    EditButtons = <
      item
        Style = ebsEllipsisEh
        OnClick = DBEditEh1EditButtons0Click
      end>
    TabOrder = 7
    Text = 'DBEditEh1'
    Visible = True
  end
  object cbIncludeFieldNames: TDBCheckBoxEh
    Left = 19
    Top = 152
    Width = 301
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Field name at the first line of the file'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 8
  end
  object cbxTextQuoteChar: TDBComboBoxEh
    Left = 200
    Top = 202
    Width = 121
    Height = 21
    ControlLabel.Width = 78
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Text Quote Char'
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 181
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      '"'
      #39)
    TabOrder = 9
    Text = '"'
    Visible = True
  end
  object cbxFieldsDelimiter: TDBComboBoxEh
    Left = 200
    Top = 175
    Width = 121
    Height = 21
    ControlLabel.Width = 74
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Fields separator'
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 181
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      ','
      ';'
      '|'
      '<Tab>')
    TabOrder = 10
    Text = ';'
    Visible = True
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 359
    Width = 327
    Height = 199
    Anchors = [akLeft, akTop, akBottom]
    Caption = ' Fields Map '
    TabOrder = 11
    DesignSize = (
      327
      199)
    object bResetFielsMapTable: TButton
      Left = 10
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Reset'
      TabOrder = 0
      OnClick = bResetFielsMapTableClick
    end
    object bCleaFielsMapTable: TButton
      Left = 91
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 1
      OnClick = bCleaFielsMapTableClick
    end
    object gridFieldsMap: TDBGridEh
      Left = 7
      Top = 55
      Width = 314
      Height = 139
      AllowedSelections = [gstRecordBookmarks]
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColumnDefValues.Title.ToolTips = True
      ColumnDefValues.ToolTips = True
      DataSource = dsFixSetParams
      DynProps = <>
      HorzScrollBar.ExtraPanel.Visible = True
      HorzScrollBar.Height = 20
      IndicatorOptions = [gioShowRowIndicatorEh]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'DataSetFieldName'
          Footers = <>
          Width = 106
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'FileFieldName'
          Footers = <>
          Width = 92
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'FileFieldPos'
          Footers = <>
          Width = 46
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'FileFieldLen'
          Footers = <>
          Width = 45
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object dsFixSetParams: TDataSource
    DataSet = mtFieldsMap
    Top = 65486
  end
  object mtFieldsMap: TMemTableEh
    Active = True
    Params = <>
    Top = 65486
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object DataSetFieldName: TMTStringDataFieldEh
          FieldName = 'DataSetFieldName'
          StringDataType = fdtWideStringEh
          DisplayWidth = 20
        end
        object FileFieldName: TMTStringDataFieldEh
          FieldName = 'FileFieldName'
          StringDataType = fdtWideStringEh
          DisplayWidth = 20
        end
        object FileFieldPos: TMTNumericDataFieldEh
          FieldName = 'FileFieldPos'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayWidth = 20
          currency = False
          Precision = 15
        end
        object FileFieldLen: TMTNumericDataFieldEh
          FieldName = 'FileFieldLen'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayWidth = 20
          currency = False
          Precision = 15
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object CompoManEh1: TCompoManEh
    Left = 504
    Top = 65528
    VisibleComponentListPos = (
      'dsFixSetParams,176,472'
      'mtFieldsMap,88,472'
      'SaveTextFileDialog1,520,56'
      'DataSetTextExporterEh1,272,72'
      'DataSource1,384,272'
      'MemTableEh1,416,8')
  end
  object DataSetTextExporterEh1: TDataSetTextExporterEh
    FieldsMap = <>
    IsExportFieldNames = False
    ExportFormats.DateSeparator = '-'
    Top = 65486
  end
  object SaveTextFileDialog1: TSaveDialog
    Top = 65486
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Params = <>
    Top = 65486
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object OrderNo: TMTNumericDataFieldEh
          FieldName = 'OrderNo'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'OrderNo'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object CustNo: TMTNumericDataFieldEh
          FieldName = 'CustNo'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'CustNo'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object SaleDate: TMTDateTimeDataFieldEh
          FieldName = 'SaleDate'
          DateTimeDataType = fdtDateTimeEh
          DisplayLabel = 'SaleDate'
          DisplayWidth = 18
        end
        object ShipDate: TMTDateTimeDataFieldEh
          FieldName = 'ShipDate'
          DateTimeDataType = fdtDateTimeEh
          DisplayLabel = 'ShipDate'
          DisplayWidth = 18
        end
        object EmpNo: TMTNumericDataFieldEh
          FieldName = 'EmpNo'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'EmpNo'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object ShipToContact: TMTStringDataFieldEh
          FieldName = 'ShipToContact'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'ShipToContact'
          DisplayWidth = 20
          Transliterate = True
        end
        object ShipToAddr1: TMTStringDataFieldEh
          FieldName = 'ShipToAddr1'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'ShipToAddr1'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object ShipToAddr2: TMTStringDataFieldEh
          FieldName = 'ShipToAddr2'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'ShipToAddr2'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object ShipToCity: TMTStringDataFieldEh
          FieldName = 'ShipToCity'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'ShipToCity'
          DisplayWidth = 15
          Size = 15
          Transliterate = True
        end
        object ShipToState: TMTStringDataFieldEh
          FieldName = 'ShipToState'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'ShipToState'
          DisplayWidth = 20
          Transliterate = True
        end
        object ShipToZip: TMTStringDataFieldEh
          FieldName = 'ShipToZip'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'ShipToZip'
          DisplayWidth = 10
          Size = 10
          Transliterate = True
        end
        object ShipToCountry: TMTStringDataFieldEh
          FieldName = 'ShipToCountry'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'ShipToCountry'
          DisplayWidth = 20
          Transliterate = True
        end
        object ShipToPhone: TMTStringDataFieldEh
          FieldName = 'ShipToPhone'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'ShipToPhone'
          DisplayWidth = 15
          Size = 15
          Transliterate = True
        end
        object ShipVIA: TMTStringDataFieldEh
          FieldName = 'ShipVIA'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'ShipVIA'
          DisplayWidth = 7
          Size = 7
          Transliterate = True
        end
        object PO: TMTStringDataFieldEh
          FieldName = 'PO'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'PO'
          DisplayWidth = 15
          Size = 15
          Transliterate = True
        end
        object Terms: TMTStringDataFieldEh
          FieldName = 'Terms'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Terms'
          DisplayWidth = 6
          Size = 6
          Transliterate = True
        end
        object PaymentMethod: TMTStringDataFieldEh
          FieldName = 'PaymentMethod'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'PaymentMethod'
          DisplayWidth = 7
          Size = 7
          Transliterate = True
        end
        object ItemsTotal: TMTNumericDataFieldEh
          FieldName = 'ItemsTotal'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'ItemsTotal'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object TaxRate: TMTNumericDataFieldEh
          FieldName = 'TaxRate'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'TaxRate'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object Freight: TMTNumericDataFieldEh
          FieldName = 'Freight'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'Freight'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object AmountPaid: TMTNumericDataFieldEh
          FieldName = 'AmountPaid'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'AmountPaid'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1003.000000000000000000
            1351.000000000000000000
            32245d
            32266d
            114
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            1250.000000000000000000
            4.500000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1004.000000000000000000
            2156.000000000000000000
            32250d
            32251d
            145
            'Maria Eventosh'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            'DHL'
            nil
            'FOB'
            'Check'
            7885.000000000000000000
            0.000000000000000000
            0.000000000000000000
            7885.000000000000000000)
          (
            1005.000000000000000000
            1356.000000000000000000
            32253d
            32163d
            110
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Visa'
            4807.000000000000000000
            0.000000000000000000
            0.000000000000000000
            4807.000000000000000000)
          (
            1006.000000000000000000
            1380.000000000000000000
            34644d
            32454d
            46
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'Emery'
            'P101324'
            'FOB'
            'Visa'
            31987.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1007.000000000000000000
            1384.000000000000000000
            32264d
            32265d
            45
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Visa'
            6500.000000000000000000
            0.000000000000000000
            0.000000000000000000
            6500.000000000000000000)
          (
            1008.000000000000000000
            1510.000000000000000000
            32266d
            32267d
            12
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'Visa'
            1449.500000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1009.000000000000000000
            1513.000000000000000000
            32274d
            32275d
            71
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'COD'
            5587.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1010.000000000000000000
            1551.000000000000000000
            32274d
            32275d
            46
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'COD'
            4996.000000000000000000
            0.000000000000000000
            0.000000000000000000
            4996.000000000000000000)
          (
            1011.000000000000000000
            1560.000000000000000000
            32281d
            32282d
            5
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'COD'
            2679.850000000000000000
            0.000000000000000000
            0.000000000000000000
            2679.850000000000000000)
          (
            1012.000000000000000000
            1563.000000000000000000
            32282d
            32283d
            118
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            5201.000000000000000000
            0.000000000000000000
            0.000000000000000000
            5201.000000000000000000)
          (
            1013.000000000000000000
            1624.000000000000000000
            32288d
            32289d
            134
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'Emery'
            nil
            'Net 30'
            'Credit'
            3115.000000000000000000
            0.000000000000000000
            0.000000000000000000
            3115.000000000000000000)
          (
            1014.000000000000000000
            1645.000000000000000000
            32288d
            32289d
            144
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'Emery'
            nil
            'Net 30'
            'Credit'
            134.850000000000000000
            0.000000000000000000
            0.000000000000000000
            134.850000000000000000)
          (
            1015.000000000000000000
            1651.000000000000000000
            32288d
            32289d
            71
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'Emery'
            nil
            'FOB'
            'MC'
            20321.750000000000000000
            0.000000000000000000
            0.000000000000000000
            20321.750000000000000000)
          (
            1016.000000000000000000
            1680.000000000000000000
            32296d
            32297d
            65
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'AmEx'
            2605.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1017.000000000000000000
            1984.000000000000000000
            32306d
            32307d
            28
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Check'
            10195.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1018.000000000000000000
            2118.000000000000000000
            32312d
            32313d
            118
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Check'
            5256.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1019.000000000000000000
            2135.000000000000000000
            32318d
            32319d
            114
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'Credit'
            20602.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1020.000000000000000000
            2156.000000000000000000
            32318d
            32319d
            61
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'Credit'
            9955.000000000000000000
            0.000000000000000000
            0.000000000000000000
            9955.000000000000000000)
          (
            1021.000000000000000000
            2163.000000000000000000
            32318d
            32319d
            52
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            3719.000000000000000000
            0.000000000000000000
            0.000000000000000000
            3719.000000000000000000)
          (
            1022.000000000000000000
            2163.000000000000000000
            32324d
            32325d
            46
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            10064.650000000000000000
            0.000000000000000000
            0.000000000000000000
            10064.650000000000000000)
          (
            1023.000000000000000000
            1221.000000000000000000
            32325d
            32326d
            5
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Check'
            4674.000000000000000000
            0.000000000000000000
            0.000000000000000000
            4674.000000000000000000)
          (
            1024.000000000000000000
            3151.000000000000000000
            32326d
            32327d
            2
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Check'
            6897.000000000000000000
            0.000000000000000000
            0.000000000000000000
            6897.000000000000000000)
          (
            1025.000000000000000000
            1510.000000000000000000
            32327d
            32328d
            8
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'AmEx'
            930.000000000000000000
            0.000000000000000000
            0.000000000000000000
            930.000000000000000000)
          (
            1026.000000000000000000
            1624.000000000000000000
            32331d
            32332d
            44
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'AmEx'
            2920.000000000000000000
            0.000000000000000000
            0.000000000000000000
            2920.000000000000000000)
          (
            1027.000000000000000000
            1384.000000000000000000
            32331d
            32332d
            34
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Visa'
            25210.000000000000000000
            0.000000000000000000
            0.000000000000000000
            25210.000000000000000000)
          (
            1028.000000000000000000
            1651.000000000000000000
            32331d
            32332d
            11
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'Emery'
            nil
            'FOB'
            'Visa'
            343.800000000000000000
            0.000000000000000000
            0.000000000000000000
            343.800000000000000000)
          (
            1029.000000000000000000
            1645.000000000000000000
            32342d
            32343d
            110
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'MC'
            20108.000000000000000000
            0.000000000000000000
            0.000000000000000000
            20108.000000000000000000)
          (
            1030.000000000000000000
            3615.000000000000000000
            32349d
            32350d
            107
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'MC'
            559.600000000000000000
            0.000000000000000000
            0.000000000000000000
            559.600000000000000000)
          (
            1031.000000000000000000
            2118.000000000000000000
            32352d
            32356d
            127
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Credit'
            12685.000000000000000000
            0.000000000000000000
            0.000000000000000000
            12685.000000000000000000)
          (
            1032.000000000000000000
            2163.000000000000000000
            32352d
            32356d
            144
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Credit'
            775.000000000000000000
            0.000000000000000000
            0.000000000000000000
            775.000000000000000000)
          (
            1033.000000000000000000
            1384.000000000000000000
            32356d
            32357d
            138
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Cash'
            1238.000000000000000000
            0.000000000000000000
            0.000000000000000000
            1238.000000000000000000)
          (
            1034.000000000000000000
            1680.000000000000000000
            32368d
            32369d
            24
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Check'
            18532.000000000000000000
            0.000000000000000000
            0.000000000000000000
            18532.000000000000000000)
          (
            1035.000000000000000000
            1560.000000000000000000
            32371d
            32372d
            15
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            560.000000000000000000
            0.000000000000000000
            0.000000000000000000
            560.000000000000000000)
          (
            1036.000000000000000000
            5384.000000000000000000
            32380d
            32381d
            4
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Credit'
            4110.000000000000000000
            0.000000000000000000
            0.000000000000000000
            4110.000000000000000000)
          (
            1037.000000000000000000
            1984.000000000000000000
            32381d
            32382d
            12
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Credit'
            3117.000000000000000000
            0.000000000000000000
            0.000000000000000000
            3117.000000000000000000)
          (
            1038.000000000000000000
            1645.000000000000000000
            32381d
            32382d
            72
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Visa'
            10152.000000000000000000
            0.000000000000000000
            0.000000000000000000
            10152.000000000000000000)
          (
            1039.000000000000000000
            3158.000000000000000000
            32384d
            32387d
            61
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Visa'
            536.800000000000000000
            0.000000000000000000
            0.000000000000000000
            536.800000000000000000)
          (
            1040.000000000000000000
            6812.000000000000000000
            32390d
            32391d
            52
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'Visa'
            3632.000000000000000000
            0.000000000000000000
            0.000000000000000000
            3632.000000000000000000)
          (
            1041.000000000000000000
            4652.000000000000000000
            32402d
            32403d
            109
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'AmEx'
            7807.000000000000000000
            0.000000000000000000
            0.000000000000000000
            7807.000000000000000000)
          (
            1042.000000000000000000
            3984.000000000000000000
            32410d
            32411d
            9
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'AmEx'
            971.700000000000000000
            0.000000000000000000
            0.000000000000000000
            971.700000000000000000)
          (
            1043.000000000000000000
            5132.000000000000000000
            32416d
            32417d
            14
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            12455.000000000000000000
            0.000000000000000000
            0.000000000000000000
            12455.000000000000000000)
          (
            1044.000000000000000000
            5515.000000000000000000
            32424d
            32425d
            12
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            64050.000000000000000000
            0.000000000000000000
            0.000000000000000000
            64050.000000000000000000)
          (
            1045.000000000000000000
            9841.000000000000000000
            32432d
            32433d
            36
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Credit'
            787.800000000000000000
            0.000000000000000000
            0.000000000000000000
            787.800000000000000000)
          (
            1046.000000000000000000
            2315.000000000000000000
            32459d
            32460d
            24
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Check'
            766.800000000000000000
            0.000000000000000000
            0.000000000000000000
            766.800000000000000000)
          (
            1047.000000000000000000
            5515.000000000000000000
            32474d
            32475d
            44
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Cash'
            15365.000000000000000000
            0.000000000000000000
            0.000000000000000000
            15365.000000000000000000)
          (
            1048.000000000000000000
            5432.000000000000000000
            32479d
            32480d
            118
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Visa'
            7346.000000000000000000
            0.000000000000000000
            0.000000000000000000
            7346.000000000000000000)
          (
            1049.000000000000000000
            9841.000000000000000000
            32490d
            32491d
            107
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'MC'
            1809.850000000000000000
            0.000000000000000000
            0.000000000000000000
            1809.850000000000000000)
          (
            1050.000000000000000000
            3052.000000000000000000
            32501d
            32502d
            94
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'AmEx'
            6287.850000000000000000
            0.000000000000000000
            0.000000000000000000
            6287.850000000000000000)
          (
            1051.000000000000000000
            2165.000000000000000000
            32512d
            32513d
            2
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Credit'
            325.000000000000000000
            0.000000000000000000
            0.000000000000000000
            325.000000000000000000)
          (
            1052.000000000000000000
            1351.000000000000000000
            32514d
            32515d
            144
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Credit'
            16788.000000000000000000
            0.000000000000000000
            0.000000000000000000
            16788.000000000000000000)
          (
            1053.000000000000000000
            6516.000000000000000000
            32523d
            32524d
            145
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Credit'
            24650.000000000000000000
            0.000000000000000000
            0.000000000000000000
            24650.000000000000000000)
          (
            1054.000000000000000000
            5432.000000000000000000
            32536d
            32540d
            83
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Visa'
            14188.000000000000000000
            0.000000000000000000
            0.000000000000000000
            14188.000000000000000000)
          (
            1055.000000000000000000
            1351.000000000000000000
            32543d
            32544d
            29
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            23406.000000000000000000
            0.000000000000000000
            0.000000000000000000
            23406.000000000000000000)
          (
            1056.000000000000000000
            1513.000000000000000000
            32547d
            32548d
            24
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'MC'
            19293.700000000000000000
            0.000000000000000000
            0.000000000000000000
            19293.700000000000000000)
          (
            1057.000000000000000000
            1563.000000000000000000
            32557d
            32558d
            14
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            1975.000000000000000000
            0.000000000000000000
            0.000000000000000000
            1975.000000000000000000)
          (
            1058.000000000000000000
            2118.000000000000000000
            32560d
            32561d
            8
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'Credit'
            12736.000000000000000000
            0.000000000000000000
            0.000000000000000000
            12736.000000000000000000)
          (
            1059.000000000000000000
            1356.000000000000000000
            32563d
            32564d
            109
            nil
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'America'
            '808-555-0269'
            'US Mail'
            nil
            'FOB'
            'Cash'
            2150.000000000000000000
            8.500000000000000000
            0.000000000000000000
            2150.000000000000000000)
          (
            1060.000000000000000000
            1231.000000000000000000
            32567d
            32568d
            94
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Check'
            15355.000000000000000000
            0.000000000000000000
            0.000000000000000000
            15355.000000000000000000)
          (
            1061.000000000000000000
            1563.000000000000000000
            32570d
            32571d
            2
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Credit'
            24277.300000000000000000
            0.000000000000000000
            0.000000000000000000
            24277.300000000000000000)
          (
            1062.000000000000000000
            2118.000000000000000000
            32575d
            32576d
            11
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Credit'
            18320.000000000000000000
            0.000000000000000000
            0.000000000000000000
            18320.000000000000000000)
          (
            1063.000000000000000000
            3042.000000000000000000
            32580d
            32581d
            24
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Credit'
            61869.300000000000000000
            0.000000000000000000
            0.000000000000000000
            61869.300000000000000000)
          (
            1064.000000000000000000
            2118.000000000000000000
            32591d
            32592d
            83
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'Credit'
            395.000000000000000000
            0.000000000000000000
            0.000000000000000000
            395.000000000000000000)
          (
            1065.000000000000000000
            6312.000000000000000000
            32592d
            32593d
            72
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Visa'
            17814.000000000000000000
            0.000000000000000000
            0.000000000000000000
            17814.000000000000000000)
          (
            1066.000000000000000000
            3054.000000000000000000
            32593d
            32594d
            65
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'Visa'
            19812.000000000000000000
            0.000000000000000000
            0.000000000000000000
            19812.000000000000000000)
          (
            1067.000000000000000000
            1351.000000000000000000
            32599d
            32600d
            34
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Visa'
            4495.000000000000000000
            0.000000000000000000
            0.000000000000000000
            4495.000000000000000000)
          (
            1068.000000000000000000
            4531.000000000000000000
            32601d
            32602d
            105
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'MC'
            31847.000000000000000000
            0.000000000000000000
            0.000000000000000000
            31847.000000000000000000)
          (
            1069.000000000000000000
            2975.000000000000000000
            32603d
            32604d
            136
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            33829.450000000000000000
            0.000000000000000000
            0.000000000000000000
            33829.450000000000000000)
          (
            1070.000000000000000000
            6215.000000000000000000
            32605d
            32606d
            144
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'Credit'
            22354.000000000000000000
            0.000000000000000000
            0.000000000000000000
            22354.000000000000000000)
          (
            1071.000000000000000000
            1560.000000000000000000
            32607d
            32608d
            114
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Cash'
            103041.000000000000000000
            0.000000000000000000
            0.000000000000000000
            103041.000000000000000000)
          (
            1072.000000000000000000
            1356.000000000000000000
            32609d
            32610d
            29
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'Cash'
            3596.000000000000000000
            0.000000000000000000
            0.000000000000000000
            3596.000000000000000000)
          (
            1073.000000000000000000
            1231.000000000000000000
            32613d
            32614d
            2
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'MC'
            19414.000000000000000000
            0.000000000000000000
            0.000000000000000000
            19414.000000000000000000)
          (
            1074.000000000000000000
            1984.000000000000000000
            32617d
            32618d
            15
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'MC'
            2195.000000000000000000
            0.000000000000000000
            0.000000000000000000
            2195.000000000000000000)
          (
            1075.000000000000000000
            1351.000000000000000000
            32619d
            32620d
            11
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'MC'
            8560.000000000000000000
            0.000000000000000000
            0.000000000000000000
            8560.000000000000000000)
          (
            1076.000000000000000000
            1221.000000000000000000
            34684d
            32624d
            9
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Visa'
            17781.000000000000000000
            0.000000000000000000
            0.000000000000000000
            17781.000000000000000000)
          (
            1077.000000000000000000
            1551.000000000000000000
            32627d
            32629d
            110
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Credit'
            156.000000000000000000
            0.000000000000000000
            0.000000000000000000
            156.000000000000000000)
          (
            1078.000000000000000000
            3041.000000000000000000
            32629d
            32630d
            29
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Credit'
            79116.000000000000000000
            0.000000000000000000
            0.000000000000000000
            79116.000000000000000000)
          (
            1079.000000000000000000
            1380.000000000000000000
            32631d
            32632d
            44
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Credit'
            4445.000000000000000000
            0.000000000000000000
            0.000000000000000000
            4445.000000000000000000)
          (
            1080.000000000000000000
            1356.000000000000000000
            32633d
            32634d
            45
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            9634.000000000000000000
            0.000000000000000000
            0.000000000000000000
            9634.000000000000000000)
          (
            1081.000000000000000000
            3042.000000000000000000
            32635d
            32636d
            109
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'AmEx'
            30566.000000000000000000
            0.000000000000000000
            0.000000000000000000
            30566.000000000000000000)
          (
            1082.000000000000000000
            1551.000000000000000000
            32637d
            32638d
            2
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'AmEx'
            1416.450000000000000000
            0.000000000000000000
            0.000000000000000000
            1416.450000000000000000)
          (
            1083.000000000000000000
            1563.000000000000000000
            32637d
            32638d
            20
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Cash'
            11164.800000000000000000
            0.000000000000000000
            0.000000000000000000
            11164.800000000000000000)
          (
            1084.000000000000000000
            1680.000000000000000000
            32639d
            32640d
            15
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'Cash'
            1185.000000000000000000
            0.000000000000000000
            0.000000000000000000
            1185.000000000000000000)
          (
            1086.000000000000000000
            1513.000000000000000000
            32646d
            32647d
            29
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'Cash'
            14049.950000000000000000
            0.000000000000000000
            0.000000000000000000
            14049.950000000000000000)
          (
            1087.000000000000000000
            1351.000000000000000000
            32648d
            32649d
            127
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'Credit'
            14045.000000000000000000
            0.000000000000000000
            0.000000000000000000
            14045.000000000000000000)
          (
            1089.000000000000000000
            3151.000000000000000000
            32650d
            32651d
            113
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            2706.000000000000000000
            0.000000000000000000
            0.000000000000000000
            2706.000000000000000000)
          (
            1090.000000000000000000
            1513.000000000000000000
            32653d
            32654d
            94
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Credit'
            8507.000000000000000000
            0.000000000000000000
            0.000000000000000000
            8507.000000000000000000)
          (
            1091.000000000000000000
            1563.000000000000000000
            32656d
            32660d
            83
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Credit'
            1950.000000000000000000
            0.000000000000000000
            0.000000000000000000
            1950.000000000000000000)
          (
            1092.000000000000000000
            6582.000000000000000000
            32658d
            32660d
            61
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Visa'
            76698.750000000000000000
            0.000000000000000000
            0.000000000000000000
            76698.750000000000000000)
          (
            1093.000000000000000000
            1680.000000000000000000
            32660d
            32661d
            2
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Visa'
            479.800000000000000000
            0.000000000000000000
            0.000000000000000000
            479.800000000000000000)
          (
            1094.000000000000000000
            5163.000000000000000000
            32662d
            32663d
            4
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'MC'
            4113.750000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1095.000000000000000000
            2156.000000000000000000
            32664d
            32665d
            36
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'MC'
            7531.750000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1096.000000000000000000
            2354.000000000000000000
            32668d
            32668d
            34
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'MC'
            123740.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1097.000000000000000000
            3615.000000000000000000
            32671d
            32671d
            107
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'MC'
            12953.600000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1098.000000000000000000
            2315.000000000000000000
            32673d
            32673d
            118
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            472.900000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1099.000000000000000000
            1984.000000000000000000
            32675d
            32675d
            138
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            859.950000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1100.000000000000000000
            1384.000000000000000000
            32679d
            32679d
            9
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            6094.800000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1101.000000000000000000
            2165.000000000000000000
            32693d
            32693d
            37
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            11629.850000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1102.000000000000000000
            1231.000000000000000000
            33761d
            33761d
            105
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            2844.000000000000000000
            0.000000000000000000
            0.000000000000000000
            2844.000000000000000000)
          (
            1103.000000000000000000
            3042.000000000000000000
            33798d
            33798d
            94
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            39797.700000000000000000
            0.000000000000000000
            0.000000000000000000
            39797.700000000000000000)
          (
            1104.000000000000000000
            1354.000000000000000000
            33803d
            33803d
            83
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Check'
            51673.149999999990000000
            0.000000000000000000
            0.000000000000000000
            51673.150000000000000000)
          (
            1105.000000000000000000
            1356.000000000000000000
            33806d
            33806d
            28
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Visa'
            31219.950000000000000000
            0.000000000000000000
            0.000000000000000000
            31219.950000000000000000)
          (
            1106.000000000000000000
            1380.000000000000000000
            33870d
            33870d
            15
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'Emery'
            nil
            'FOB'
            'Visa'
            3531.800000000000000000
            0.000000000000000000
            0.000000000000000000
            3531.800000000000000000)
          (
            1107.000000000000000000
            1384.000000000000000000
            33901d
            33901d
            134
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Visa'
            28389.000000000000000000
            0.000000000000000000
            0.000000000000000000
            28389.000000000000000000)
          (
            1109.000000000000000000
            1513.000000000000000000
            33921d
            33921d
            145
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'COD'
            203.000000000000000000
            0.000000000000000000
            0.000000000000000000
            203.000000000000000000)
          (
            1111.000000000000000000
            1560.000000000000000000
            33952d
            33952d
            2
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'COD'
            4720.800000000000000000
            0.000000000000000000
            0.000000000000000000
            4720.800000000000000000)
          (
            1112.000000000000000000
            4531.000000000000000000
            33971d
            33971d
            61
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            5565.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1113.000000000000000000
            1624.000000000000000000
            34012d
            34012d
            9
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'Emery'
            nil
            'Net 30'
            'Credit'
            2514.650000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1115.000000000000000000
            4684.000000000000000000
            34041d
            34041d
            29
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'Emery'
            nil
            'FOB'
            'MC'
            4894.950000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1116.000000000000000000
            1680.000000000000000000
            34049d
            34049d
            113
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'AmEx'
            23104.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1117.000000000000000000
            1984.000000000000000000
            34072d
            34072d
            44
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Check'
            6734.850000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            1118.000000000000000000
            2118.000000000000000000
            34082d
            34082d
            34
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Check'
            21614.000000000000000000
            0.000000000000000000
            0.000000000000000000
            21614.000000000000000000)
          (
            1119.000000000000000000
            5384.000000000000000000
            34104d
            34104d
            2
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'Credit'
            14557.950000000000000000
            0.000000000000000000
            0.000000000000000000
            14557.950000000000000000)
          (
            1120.000000000000000000
            2156.000000000000000000
            34114d
            34114d
            46
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'Credit'
            784.900000000000000000
            0.000000000000000000
            0.000000000000000000
            784.900000000000000000)
          (
            1121.000000000000000000
            2163.000000000000000000
            34122d
            34122d
            85
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            820.000000000000000000
            0.000000000000000000
            0.000000000000000000
            820.000000000000000000)
          (
            1122.000000000000000000
            2163.000000000000000000
            34173d
            34173d
            141
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            44854.000000000000000000
            0.000000000000000000
            0.000000000000000000
            44854.000000000000000000)
          (
            1123.000000000000000000
            1221.000000000000000000
            34205d
            34205d
            121
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Check'
            13945.000000000000000000
            0.000000000000000000
            0.000000000000000000
            13945.000000000000000000)
          (
            1124.000000000000000000
            1384.000000000000000000
            34213d
            34213d
            71
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Check'
            33071.000000000000000000
            0.000000000000000000
            0.000000000000000000
            33071.000000000000000000)
          (
            1125.000000000000000000
            1510.000000000000000000
            34216d
            34216d
            44
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'AmEx'
            6583.800000000000000000
            0.000000000000000000
            0.000000000000000000
            6583.800000000000000000)
          (
            1126.000000000000000000
            1624.000000000000000000
            34243d
            34243d
            45
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'AmEx'
            10107.000000000000000000
            0.000000000000000000
            0.000000000000000000
            10107.000000000000000000)
          (
            1127.000000000000000000
            1384.000000000000000000
            34244d
            34244d
            65
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Visa'
            25071.000000000000000000
            0.000000000000000000
            0.000000000000000000
            25071.000000000000000000)
          (
            1128.000000000000000000
            1651.000000000000000000
            34250d
            34250d
            37
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'Emery'
            nil
            'FOB'
            'Visa'
            8294.000000000000000000
            0.000000000000000000
            0.000000000000000000
            8294.000000000000000000)
          (
            1129.000000000000000000
            1645.000000000000000000
            34261d
            34261d
            24
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'MC'
            1004.800000000000000000
            0.000000000000000000
            0.000000000000000000
            1004.800000000000000000)
          (
            1130.000000000000000000
            4312.000000000000000000
            34268d
            34268d
            114
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'MC'
            6300.000000000000000000
            0.000000000000000000
            0.000000000000000000
            6300.000000000000000000)
          (
            1131.000000000000000000
            2118.000000000000000000
            34274d
            34274d
            134
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Credit'
            11989.200000000000000000
            0.000000000000000000
            0.000000000000000000
            11989.200000000000000000)
          (
            1132.000000000000000000
            2163.000000000000000000
            34274d
            34274d
            121
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Credit'
            906.000000000000000000
            0.000000000000000000
            0.000000000000000000
            906.000000000000000000)
          (
            1133.000000000000000000
            3151.000000000000000000
            34275d
            34275d
            138
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Cash'
            2419.000000000000000000
            0.000000000000000000
            0.000000000000000000
            2419.000000000000000000)
          (
            1134.000000000000000000
            5151.000000000000000000
            34287d
            34287d
            94
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Check'
            6675.950000000000000000
            0.000000000000000000
            0.000000000000000000
            6675.950000000000000000)
          (
            1136.000000000000000000
            2163.000000000000000000
            34300d
            34300d
            71
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Credit'
            2971.000000000000000000
            0.000000000000000000
            0.000000000000000000
            2971.000000000000000000)
          (
            1137.000000000000000000
            1984.000000000000000000
            34300d
            34300d
            11
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Credit'
            6785.400000000000000000
            0.000000000000000000
            0.000000000000000000
            6785.400000000000000000)
          (
            1139.000000000000000000
            1510.000000000000000000
            34304d
            34304d
            29
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Visa'
            47710.750000000000000000
            0.000000000000000000
            0.000000000000000000
            47710.750000000000000000)
          (
            1140.000000000000000000
            6812.000000000000000000
            34315d
            34315d
            52
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'Visa'
            1240.000000000000000000
            0.000000000000000000
            0.000000000000000000
            1240.000000000000000000)
          (
            1141.000000000000000000
            4652.000000000000000000
            34320d
            34320d
            83
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'AmEx'
            1846.000000000000000000
            0.000000000000000000
            0.000000000000000000
            1846.000000000000000000)
          (
            1142.000000000000000000
            3984.000000000000000000
            34328d
            34328d
            105
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'AmEx'
            3546.000000000000000000
            0.000000000000000000
            0.000000000000000000
            3546.000000000000000000)
          (
            1143.000000000000000000
            5132.000000000000000000
            34335d
            34335d
            113
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            3087.000000000000000000
            0.000000000000000000
            0.000000000000000000
            3087.000000000000000000)
          (
            1144.000000000000000000
            5515.000000000000000000
            34343d
            34343d
            134
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            10054.000000000000000000
            0.000000000000000000
            0.000000000000000000
            10054.000000000000000000)
          (
            1145.000000000000000000
            9841.000000000000000000
            34351d
            34351d
            144
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Credit'
            4229.800000000000000000
            0.000000000000000000
            0.000000000000000000
            4229.800000000000000000)
          (
            1146.000000000000000000
            2315.000000000000000000
            34378d
            34378d
            94
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Check'
            15052.000000000000000000
            0.000000000000000000
            0.000000000000000000
            15052.000000000000000000)
          (
            1148.000000000000000000
            1563.000000000000000000
            34396d
            34396d
            83
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'Visa'
            5011.000000000000000000
            0.000000000000000000
            0.000000000000000000
            5011.000000000000000000)
          (
            1149.000000000000000000
            9841.000000000000000000
            34407d
            34407d
            52
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'MC'
            12900.750000000000000000
            0.000000000000000000
            0.000000000000000000
            12900.750000000000000000)
          (
            1150.000000000000000000
            3052.000000000000000000
            34418d
            34418d
            44
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'AmEx'
            7671.900000000000000000
            0.000000000000000000
            0.000000000000000000
            7671.900000000000000000)
          (
            1152.000000000000000000
            1351.000000000000000000
            34431d
            34431d
            24
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Credit'
            97698.599999999990000000
            0.000000000000000000
            0.000000000000000000
            97698.600000000010000000)
          (
            1153.000000000000000000
            1380.000000000000000000
            34440d
            34440d
            4
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Credit'
            3860.850000000000000000
            0.000000000000000000
            0.000000000000000000
            3860.850000000000000000)
          (
            1154.000000000000000000
            1560.000000000000000000
            34455d
            34455d
            9
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Visa'
            13226.800000000000000000
            0.000000000000000000
            0.000000000000000000
            13226.800000000000000000)
          (
            1155.000000000000000000
            1351.000000000000000000
            34459d
            34459d
            37
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            13935.950000000000000000
            0.000000000000000000
            0.000000000000000000
            13935.950000000000000000)
          (
            1156.000000000000000000
            1513.000000000000000000
            34463d
            34463d
            46
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'MC'
            12367.000000000000000000
            0.000000000000000000
            0.000000000000000000
            12367.000000000000000000)
          (
            1158.000000000000000000
            5165.000000000000000000
            34476d
            34476d
            141
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'Credit'
            9793.549999999999000000
            0.000000000000000000
            0.000000000000000000
            9793.549999999999000000)
          (
            1160.000000000000000000
            1231.000000000000000000
            34486d
            34486d
            110
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Check'
            2206.850000000000000000
            0.000000000000000000
            0.000000000000000000
            2206.850000000000000000)
          (
            1161.000000000000000000
            1563.000000000000000000
            34489d
            34489d
            94
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Credit'
            102453.600000000000000000
            0.000000000000000000
            0.000000000000000000
            102453.600000000000000000)
          (
            1162.000000000000000000
            2118.000000000000000000
            34494d
            34494d
            114
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Credit'
            3153.000000000000000000
            0.000000000000000000
            0.000000000000000000
            3153.000000000000000000)
          (
            1163.000000000000000000
            1351.000000000000000000
            34499d
            34499d
            83
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Credit'
            342.000000000000000000
            0.000000000000000000
            0.000000000000000000
            342.000000000000000000)
          (
            1165.000000000000000000
            1513.000000000000000000
            34511d
            34511d
            72
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Visa'
            2692.850000000000000000
            0.000000000000000000
            0.000000000000000000
            2692.850000000000000000)
          (
            1166.000000000000000000
            3054.000000000000000000
            34516d
            34516d
            71
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'Visa'
            28862.000000000000000000
            0.000000000000000000
            0.000000000000000000
            28862.000000000000000000)
          (
            1168.000000000000000000
            1563.000000000000000000
            34519d
            34519d
            9
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'MC'
            104.000000000000000000
            0.000000000000000000
            0.000000000000000000
            104.000000000000000000)
          (
            1169.000000000000000000
            1221.000000000000000000
            34521d
            34521d
            12
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            9471.950000000001000000
            0.000000000000000000
            0.000000000000000000
            9471.950000000001000000)
          (
            1170.000000000000000000
            1551.000000000000000000
            34523d
            34523d
            20
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'Credit'
            5654.800000000000000000
            0.000000000000000000
            0.000000000000000000
            5654.800000000000000000)
          (
            1171.000000000000000000
            1560.000000000000000000
            34525d
            34525d
            136
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Cash'
            2356.900000000000000000
            0.000000000000000000
            0.000000000000000000
            2356.900000000000000000)
          (
            1173.000000000000000000
            1231.000000000000000000
            34531d
            34531d
            127
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'MC'
            54.000000000000000000
            0.000000000000000000
            0.000000000000000000
            54.000000000000000000)
          (
            1175.000000000000000000
            3051.000000000000000000
            34537d
            34537d
            110
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'MC'
            13814.050000000000000000
            0.000000000000000000
            0.000000000000000000
            13814.050000000000000000)
          (
            1176.000000000000000000
            1221.000000000000000000
            34541d
            34541d
            52
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Visa'
            4178.850000000000000000
            0.000000000000000000
            0.000000000000000000
            4178.850000000000000000)
          (
            1178.000000000000000000
            1231.000000000000000000
            34548d
            34548d
            24
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Credit'
            5511.750000000000000000
            0.000000000000000000
            0.000000000000000000
            5511.750000000000000000)
          (
            1180.000000000000000000
            1356.000000000000000000
            34552d
            34552d
            144
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            3640.000000000000000000
            0.000000000000000000
            0.000000000000000000
            3640.000000000000000000)
          (
            1183.000000000000000000
            4531.000000000000000000
            34556d
            34556d
            5
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Cash'
            3650.000000000000000000
            0.000000000000000000
            0.000000000000000000
            3650.000000000000000000)
          (
            1195.000000000000000000
            5384.000000000000000000
            34583d
            34583d
            20
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'MC'
            7868.000000000000000000
            0.000000000000000000
            0.000000000000000000
            7868.000000000000000000)
          (
            1196.000000000000000000
            2354.000000000000000000
            34585d
            34585d
            9
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'MC'
            5983.000000000000000000
            0.000000000000000000
            0.000000000000000000
            5983.000000000000000000)
          (
            1197.000000000000000000
            1513.000000000000000000
            34589d
            34589d
            71
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'MC'
            6731.000000000000000000
            0.000000000000000000
            0.000000000000000000
            6731.000000000000000000)
          (
            1198.000000000000000000
            2315.000000000000000000
            34591d
            34591d
            65
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            72089.900000000010000000
            0.000000000000000000
            0.000000000000000000
            72089.899999999990000000)
          (
            1199.000000000000000000
            5163.000000000000000000
            34593d
            34593d
            85
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            716.000000000000000000
            0.000000000000000000
            0.000000000000000000
            716.000000000000000000)
          (
            1200.000000000000000000
            1384.000000000000000000
            34597d
            34597d
            107
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            1827.000000000000000000
            0.000000000000000000
            0.000000000000000000
            1827.000000000000000000)
          (
            1201.000000000000000000
            2984.000000000000000000
            34611d
            34611d
            114
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            7990.000000000000000000
            0.000000000000000000
            0.000000000000000000
            7990.000000000000000000)
          (
            1202.000000000000000000
            1231.000000000000000000
            34613d
            34613d
            145
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            4205.000000000000000000
            0.000000000000000000
            0.000000000000000000
            4205.000000000000000000)
          (
            1204.000000000000000000
            3053.000000000000000000
            34625d
            34625d
            141
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Check'
            10263.750000000000000000
            0.000000000000000000
            0.000000000000000000
            10263.750000000000000000)
          (
            1205.000000000000000000
            3054.000000000000000000
            34628d
            34628d
            8
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Visa'
            4029.550000000000000000
            0.000000000000000000
            0.000000000000000000
            4029.550000000000000000)
          (
            1207.000000000000000000
            1384.000000000000000000
            34649d
            34649d
            52
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Visa'
            12949.700000000000000000
            0.000000000000000000
            0.000000000000000000
            12949.700000000000000000)
          (
            1209.000000000000000000
            1513.000000000000000000
            34650d
            34650d
            61
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'COD'
            20711.900000000000000000
            0.000000000000000000
            0.000000000000000000
            20711.900000000000000000)
          (
            1212.000000000000000000
            1563.000000000000000000
            34652d
            34652d
            4
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            3975.750000000000000000
            0.000000000000000000
            0.000000000000000000
            3975.750000000000000000)
          (
            1215.000000000000000000
            1651.000000000000000000
            34654d
            34654d
            34
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'Emery'
            nil
            'FOB'
            'MC'
            8305.949999999999000000
            0.000000000000000000
            0.000000000000000000
            8305.950000000001000000)
          (
            1217.000000000000000000
            1984.000000000000000000
            34660d
            34660d
            14
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Check'
            51730.800000000000000000
            0.000000000000000000
            0.000000000000000000
            51730.800000000000000000)
          (
            1221.000000000000000000
            2163.000000000000000000
            34661d
            34661d
            2
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            2099.000000000000000000
            0.000000000000000000
            0.000000000000000000
            2099.000000000000000000)
          (
            1250.000000000000000000
            3052.000000000000000000
            34662d
            34662d
            61
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'AmEx'
            45160.100000000010000000
            0.000000000000000000
            0.000000000000000000
            45160.100000000000000000)
          (
            1253.000000000000000000
            1380.000000000000000000
            34664d
            34664d
            46
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Credit'
            4774.850000000000000000
            0.000000000000000000
            0.000000000000000000
            4774.850000000000000000)
          (
            1255.000000000000000000
            1351.000000000000000000
            34677d
            34677d
            127
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            64115.750000000000000000
            0.000000000000000000
            0.000000000000000000
            64115.750000000000000000)
          (
            1260.000000000000000000
            3041.000000000000000000
            34678d
            34678d
            107
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Check'
            2577.850000000000000000
            0.000000000000000000
            0.000000000000000000
            2577.850000000000000000)
          (
            1261.000000000000000000
            1563.000000000000000000
            34679d
            34679d
            45
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Credit'
            1999.000000000000000000
            0.000000000000000000
            0.000000000000000000
            1999.000000000000000000)
          (
            1263.000000000000000000
            3053.000000000000000000
            34682d
            34682d
            44
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'FOB'
            'Credit'
            158922.650000000000000000
            0.000000000000000000
            0.000000000000000000
            158922.650000000000000000)
          (
            1266.000000000000000000
            1356.000000000000000000
            34683d
            34683d
            71
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'Visa'
            6935.000000000000000000
            0.000000000000000000
            0.000000000000000000
            6935.000000000000000000)
          (
            1269.000000000000000000
            1221.000000000000000000
            34684d
            34684d
            28
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            1400.000000000000000000
            0.000000000000000000
            0.000000000000000000
            1400.000000000000000000)
          (
            1271.000000000000000000
            1560.000000000000000000
            34688d
            34688d
            145
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Cash'
            304.000000000000000000
            0.000000000000000000
            0.000000000000000000
            304.000000000000000000)
          (
            1275.000000000000000000
            1351.000000000000000000
            34690d
            34690d
            20
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'MC'
            16939.500000000000000000
            0.000000000000000000
            0.000000000000000000
            16939.500000000000000000)
          (
            1278.000000000000000000
            1231.000000000000000000
            34691d
            34691d
            71
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Credit'
            11568.000000000000000000
            0.000000000000000000
            0.000000000000000000
            11568.000000000000000000)
          (
            1280.000000000000000000
            1356.000000000000000000
            34694d
            34694d
            118
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            4317.750000000000000000
            0.000000000000000000
            0.000000000000000000
            4317.750000000000000000)
          (
            1283.000000000000000000
            1563.000000000000000000
            34698d
            34698d
            113
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Cash'
            7134.000000000000000000
            0.000000000000000000
            0.000000000000000000
            7134.000000000000000000)
          (
            1292.000000000000000000
            1354.000000000000000000
            34700d
            34700d
            136
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'Net 30'
            'Visa'
            7986.900000000000000000
            0.000000000000000000
            0.000000000000000000
            7986.900000000000000000)
          (
            1294.000000000000000000
            1984.000000000000000000
            34703d
            34703d
            85
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'FedEx'
            nil
            'FOB'
            'MC'
            3304.850000000000000000
            0.000000000000000000
            0.000000000000000000
            3304.850000000000000000)
          (
            1295.000000000000000000
            2156.000000000000000000
            34705d
            34705d
            45
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'MC'
            17917.000000000000000000
            0.000000000000000000
            0.000000000000000000
            17917.000000000000000000)
          (
            1296.000000000000000000
            5412.000000000000000000
            34707d
            34707d
            34
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'Net 30'
            'MC'
            7423.349999999999000000
            0.000000000000000000
            0.000000000000000000
            7423.350000000000000000)
          (
            1298.000000000000000000
            2315.000000000000000000
            34708d
            34708d
            11
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            9897.000000000000000000
            0.000000000000000000
            0.000000000000000000
            9897.000000000000000000)
          (
            1300.000000000000000000
            1384.000000000000000000
            34709d
            34709d
            28
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            52729.250000000000000000
            0.000000000000000000
            0.000000000000000000
            52729.250000000000000000)
          (
            1302.000000000000000000
            1231.000000000000000000
            34715d
            34715d
            52
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Credit'
            24485.000000000000000000
            0.000000000000000000
            0.000000000000000000
            24485.000000000000000000)
          (
            1305.000000000000000000
            1356.000000000000000000
            34719d
            34719d
            65
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'Visa'
            3065.000000000000000000
            0.000000000000000000
            0.000000000000000000
            3065.000000000000000000)
          (
            1309.000000000000000000
            3615.000000000000000000
            34721d
            34721d
            94
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'US Mail'
            nil
            'Net 30'
            'COD'
            465.000000000000000000
            0.000000000000000000
            0.000000000000000000
            465.000000000000000000)
          (
            1315.000000000000000000
            1651.000000000000000000
            34725d
            34725d
            121
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'Emery'
            nil
            'FOB'
            'MC'
            5037.100000000000000000
            0.000000000000000000
            0.000000000000000000
            5037.100000000000000000)
          (
            1317.000000000000000000
            1984.000000000000000000
            34731d
            34731d
            138
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'DHL'
            nil
            'FOB'
            'Check'
            7572.000000000000000000
            0.000000000000000000
            0.000000000000000000
            7572.000000000000000000)
          (
            1350.000000000000000000
            3052.000000000000000000
            34732d
            34732d
            71
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'FOB'
            'AmEx'
            8939.600000000000000000
            0.000000000000000000
            0.000000000000000000
            8939.600000000000000000)
          (
            1355.000000000000000000
            3053.000000000000000000
            34735d
            34735d
            141
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'Net 30'
            'Credit'
            13908.000000000000000000
            0.000000000000000000
            0.000000000000000000
            13908.000000000000000000)
          (
            1860.000000000000000000
            3615.000000000000000000
            35099d
            nil
            9
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            'UPS'
            nil
            'net 30'
            'Check'
            65.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Top = 65486
  end
end
