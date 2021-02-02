object frDataSetImporter: TfrDataSetImporter
  Left = 0
  Top = 0
  Width = 794
  Height = 572
  TabOrder = 0
  DesignSize = (
    794
    572)
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
      Width = 215
      Height = 23
      Caption = 'DataSet Text Importer'
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
    Caption = 'Import to DataSet'
    TabOrder = 1
    OnClick = Button1Click
  end
  object PageControl1: TPageControl
    Left = 348
    Top = 100
    Width = 436
    Height = 459
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Src Data'
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 428
        Height = 431
        Align = alClient
        DataSource = DataSource1
        DrawGraphicData = True
        DrawMemoText = True
        DynProps = <>
        TabOrder = 0
        Columns = <
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'OrderNo'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'CustNo'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'SaleDate'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ShipDate'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'EmpNo'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ShipToContact'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ShipToAddr1'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ShipToAddr2'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ShipToCity'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ShipToState'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ShipToZip'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ShipToCountry'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ShipToPhone'
            Footers = <>
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
            FieldName = 'PO'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'Terms'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'PaymentMethod'
            Footers = <>
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
            FieldName = 'TaxRate'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'Freight'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'AmountPaid'
            Footers = <>
          end>
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
        Height = 431
        Lines.Strings = (
          '')
        ScrollBars = ssBoth
        Align = alClient
        AutoSize = False
        DynProps = <>
        EditButtons = <>
        TabOrder = 0
        Visible = True
        WantReturns = True
        WordWrap = False
      end
    end
  end
  object Button2: TButton
    Left = 348
    Top = 42
    Width = 121
    Height = 25
    Caption = 'ShowImpExpListEditor'
    TabOrder = 3
    Visible = False
  end
  object Button3: TButton
    Left = 491
    Top = 42
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 4
    Visible = False
  end
  object rbDelim: TRadioButton
    Left = 91
    Top = 79
    Width = 113
    Height = 17
    Caption = 'Indicator separated'
    Checked = True
    TabOrder = 5
    TabStop = True
    OnClick = rbDelimClick
  end
  object rbFixSize: TRadioButton
    Left = 91
    Top = 98
    Width = 153
    Height = 17
    Caption = 'Fixed records lenght'
    TabOrder = 6
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
    TabOrder = 7
    Text = 'UTF8'
    Visible = True
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 229
    Width = 313
    Height = 103
    Caption = ' Date, time, number formats '
    TabOrder = 8
    object cbbDecSep: TDBComboBoxEh
      Left = 189
      Top = 73
      Width = 63
      Height = 21
      ControlLabel.Width = 88
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Decimal separator '
      ControlLabel.Visible = True
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        ','
        '.')
      TabOrder = 0
      Text = ','
      Visible = True
    end
    object cbbDateFormat: TDBComboBoxEh
      Left = 161
      Top = 18
      Width = 90
      Height = 21
      ControlLabel.Width = 123
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Date format and separator'
      ControlLabel.Layout = tlCenter
      ControlLabel.Visible = True
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        'DD/MM/YYYY'
        'MM/DD/YYYY'
        'YYYY/MM/DD')
      TabOrder = 1
      Text = 'YYYY/MM/DD'
      Visible = True
    end
    object cbbTimeFormat: TDBComboBoxEh
      Left = 161
      Top = 46
      Width = 90
      Height = 21
      ControlLabel.Width = 123
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Time format and separator'
      ControlLabel.Transparent = True
      ControlLabel.Visible = True
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        'HH:MM'
        'HH:MM:SS')
      TabOrder = 2
      Text = 'HH:MM:SS'
      Visible = True
    end
    object cbbTimeSep: TDBComboBoxEh
      Left = 252
      Top = 46
      Width = 53
      Height = 21
      ControlLabel.Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1074#1088#1077#1084#1077#1085#1080
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        ':'
        '-')
      TabOrder = 3
      Text = ':'
      Visible = True
    end
    object cbbDateSep: TDBComboBoxEh
      Left = 252
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
      TabOrder = 4
      Text = '/'
      Visible = True
    end
  end
  object DBEditEh1: TDBEditEh
    Left = 395
    Top = 73
    Width = 389
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ControlLabel.Width = 45
    ControlLabel.Height = 13
    ControlLabel.Caption = 'File name'
    ControlLabel.Visible = True
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <
      item
        Style = ebsEllipsisEh
        OnClick = DBEditEh1EditButtons0Click
      end>
    TabOrder = 9
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
    TabOrder = 10
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
    TabOrder = 11
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
    TabOrder = 12
    Text = ';'
    Visible = True
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 333
    Width = 314
    Height = 225
    Anchors = [akLeft, akTop, akBottom]
    Caption = ' Fields Map '
    TabOrder = 13
    DesignSize = (
      314
      225)
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
      Width = 301
      Height = 165
      AllowedSelections = [gstRecordBookmarks]
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColumnDefValues.Title.ToolTips = True
      ColumnDefValues.ToolTips = True
      DataSource = dsFixSetParams
      DynProps = <>
      HorzScrollBar.ExtraPanel.Visible = True
      HorzScrollBar.Height = 20
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Columns = <
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'DataSetFieldName'
          Footers = <>
          Width = 106
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'FileFieldName'
          Footers = <>
          Width = 92
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'FileFieldPos'
          Footers = <>
          Width = 31
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'FileFieldLen'
          Footers = <>
          Width = 32
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
  object MemTableEh1: TMemTableEh
    Active = True
    FieldDefs = <
      item
        Name = 'OrderNo'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'CustNo'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'SaleDate'
        DataType = ftDateTime
      end
      item
        Name = 'ShipDate'
        DataType = ftDateTime
      end
      item
        Name = 'EmpNo'
        DataType = ftInteger
        Precision = 15
      end
      item
        Name = 'ShipToContact'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'ShipToAddr1'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'ShipToAddr2'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'ShipToCity'
        DataType = ftWideString
        Size = 15
      end
      item
        Name = 'ShipToState'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'ShipToZip'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'ShipToCountry'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'ShipToPhone'
        DataType = ftWideString
        Size = 15
      end
      item
        Name = 'ShipVIA'
        DataType = ftWideString
        Size = 7
      end
      item
        Name = 'PO'
        DataType = ftWideString
        Size = 15
      end
      item
        Name = 'Terms'
        DataType = ftWideString
        Size = 6
      end
      item
        Name = 'PaymentMethod'
        DataType = ftWideString
        Size = 7
      end
      item
        Name = 'ItemsTotal'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'TaxRate'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'Freight'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'AmountPaid'
        DataType = ftFloat
        Precision = 15
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Top = 65486
    object MemTableEh1OrderNo: TFloatField
      DisplayWidth = 10
      FieldName = 'OrderNo'
    end
    object MemTableEh1CustNo: TFloatField
      DisplayWidth = 10
      FieldName = 'CustNo'
    end
    object MemTableEh1SaleDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'SaleDate'
    end
    object MemTableEh1ShipDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'ShipDate'
    end
    object MemTableEh1EmpNo: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmpNo'
    end
    object MemTableEh1ShipToContact: TWideStringField
      DisplayWidth = 20
      FieldName = 'ShipToContact'
    end
    object MemTableEh1ShipToAddr1: TWideStringField
      DisplayWidth = 30
      FieldName = 'ShipToAddr1'
      Size = 30
    end
    object MemTableEh1ShipToAddr2: TWideStringField
      DisplayWidth = 30
      FieldName = 'ShipToAddr2'
      Size = 30
    end
    object MemTableEh1ShipToCity: TWideStringField
      DisplayWidth = 15
      FieldName = 'ShipToCity'
      Size = 15
    end
    object MemTableEh1ShipToState: TWideStringField
      DisplayWidth = 20
      FieldName = 'ShipToState'
    end
    object MemTableEh1ShipToZip: TWideStringField
      DisplayWidth = 10
      FieldName = 'ShipToZip'
      Size = 10
    end
    object MemTableEh1ShipToCountry: TWideStringField
      DisplayWidth = 20
      FieldName = 'ShipToCountry'
    end
    object MemTableEh1ShipToPhone: TWideStringField
      DisplayWidth = 15
      FieldName = 'ShipToPhone'
      Size = 15
    end
    object MemTableEh1ShipVIA: TWideStringField
      DisplayWidth = 7
      FieldName = 'ShipVIA'
      Size = 7
    end
    object MemTableEh1PO: TWideStringField
      DisplayWidth = 15
      FieldName = 'PO'
      Size = 15
    end
    object MemTableEh1Terms: TWideStringField
      DisplayWidth = 6
      FieldName = 'Terms'
      Size = 6
    end
    object MemTableEh1PaymentMethod: TWideStringField
      DisplayWidth = 7
      FieldName = 'PaymentMethod'
      Size = 7
    end
    object MemTableEh1ItemsTotal: TFloatField
      DisplayWidth = 10
      FieldName = 'ItemsTotal'
    end
    object MemTableEh1TaxRate: TFloatField
      DisplayWidth = 10
      FieldName = 'TaxRate'
    end
    object MemTableEh1Freight: TFloatField
      DisplayWidth = 10
      FieldName = 'Freight'
    end
    object MemTableEh1AmountPaid: TFloatField
      DisplayWidth = 10
      FieldName = 'AmountPaid'
    end
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
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Top = 65486
  end
  object SaveTextFileDialog1: TSaveDialog
    Top = 65486
  end
  object CompoManEh1: TCompoManEh
    Left = 440
    Top = 65528
    VisibleComponentListPos = (
      'DataSource1,276,0'
      'dsFixSetParams,8,504'
      'MemTableEh1,341,0'
      'mtFieldsMap,8,464'
      'SaveTextFileDialog1,432,56')
  end
end
