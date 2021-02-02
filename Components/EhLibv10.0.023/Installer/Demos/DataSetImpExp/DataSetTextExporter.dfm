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
        DataSource = MainDataModule.DataSource1
        DrawGraphicData = True
        DrawMemoText = True
        DynProps = <>
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
    object TabSheet3: TTabSheet
      Caption = 'Adv properties'
      ImageIndex = 2
      object cbUseFormatExportValueEvent: TDBCheckBoxEh
        Left = 16
        Top = 16
        Width = 377
        Height = 17
        Caption = 'Use OnFormatExportValue Event'
        DynProps = <>
        TabOrder = 0
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
  object rbDelim: TRadioButton
    Left = 91
    Top = 79
    Width = 113
    Height = 17
    Caption = 'Indicator separated'
    Checked = True
    TabOrder = 4
    TabStop = True
    OnClick = rbDelimClick
  end
  object rbFixSize: TRadioButton
    Left = 91
    Top = 98
    Width = 153
    Height = 17
    Caption = 'Fixed records lenght'
    TabOrder = 5
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
    TabOrder = 6
    Text = 'UTF8'
    Visible = True
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 229
    Width = 327
    Height = 124
    Caption = ' Date, time, number formats '
    TabOrder = 7
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
      ControlLabel.Caption = '??????????? ????'
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
      Top = 46
      Width = 53
      Height = 21
      ControlLabel.Caption = '??????????? ???????'
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
      Top = 46
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
    TabOrder = 8
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
    TabOrder = 9
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
    TabOrder = 10
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
    TabOrder = 11
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
    TabOrder = 12
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
          Width = 46
        end
        item
          CellButtons = <>
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
  object dbTableName: TDBComboBoxEh
    Left = 210
    Top = 46
    Width = 121
    Height = 21
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      'Orders'
      'FishFact')
    LimitTextToListValues = True
    TabOrder = 13
    Text = 'Orders'
    Visible = True
    OnChange = dbTableNameChange
  end
  object eTimeLong: TDBEditEh
    Left = 663
    Top = 42
    Width = 121
    Height = 21
    Anchors = [akTop, akRight]
    DynProps = <>
    EditButtons = <>
    TabOrder = 14
    Text = '0'
    Visible = True
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
      'DataSetTextExporterEh1,272,72')
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
end
