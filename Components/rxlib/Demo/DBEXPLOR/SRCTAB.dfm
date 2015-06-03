object SrcTableDlg: TSrcTableDlg
  Left = 200
  Top = 99
  ActiveControl = SrcNameEdit
  BorderStyle = bsDialog
  Caption = 'Import to %s'
  ClientHeight = 280
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 94
    Height = 13
    Caption = '&Select source table:'
    FocusControl = SrcNameEdit
  end
  object Label3: TLabel
    Left = 8
    Top = 152
    Width = 73
    Height = 13
    Caption = '&Field mappings:'
    FocusControl = MapGrid
  end
  object Collapsed: TBevel
    Left = 0
    Top = 0
    Width = 9
    Height = 149
    Shape = bsLeftLine
    Visible = False
  end
  object Expanded: TBevel
    Left = 328
    Top = 0
    Width = 9
    Height = 281
    Shape = bsLeftLine
    Visible = False
  end
  object Label4: TLabel
    Left = 8
    Top = 104
    Width = 61
    Height = 13
    Caption = 'Import &mode:'
    FocusControl = ModeCombo
  end
  object OkBtn: TButton
    Left = 335
    Top = 13
    Width = 77
    Height = 25
    Caption = 'OK'
    Default = True
    Enabled = False
    TabOrder = 4
    OnClick = OkBtnClick
  end
  object CancelBtn: TButton
    Left = 335
    Top = 45
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object RecordCountBox: TGroupBox
    Left = 8
    Top = 53
    Width = 315
    Height = 44
    Caption = ' &Record count to import '
    TabOrder = 1
    object Label2: TLabel
      Left = 268
      Top = 20
      Width = 38
      Height = 13
      Caption = 'records '
    end
    object FirstRecsBtn: TRadioButton
      Left = 153
      Top = 18
      Width = 48
      Height = 17
      Caption = ' &First '
      TabOrder = 1
      OnClick = AllRecsBtnClick
    end
    object AllRecsBtn: TRadioButton
      Left = 17
      Top = 18
      Width = 96
      Height = 17
      Caption = ' &All records'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = AllRecsBtnClick
    end
    object RecordCntEdit: TCurrencyEdit
      Left = 205
      Top = 16
      Width = 55
      Height = 21
      DecimalPlaces = 0
      DisplayFormat = ',0'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnFace
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      MaxValue = 2147483647.000000000000000000
      ParentColor = True
      ParentFont = False
      TabOrder = 2
    end
  end
  object MapGrid: TStringGrid
    Left = 8
    Top = 168
    Width = 315
    Height = 105
    ColCount = 2
    DefaultColWidth = 145
    DefaultRowHeight = 16
    Enabled = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goEditing]
    ScrollBars = ssVertical
    TabOrder = 3
    OnSelectCell = MapGridSelectCell
  end
  object MapBtn: TButton
    Left = 336
    Top = 80
    Width = 77
    Height = 25
    Enabled = False
    TabOrder = 6
    OnClick = MapBtnClick
  end
  object ModeCombo: TComboBox
    Left = 8
    Top = 120
    Width = 161
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      'Append'
      'Update'
      'AppendUpdate')
  end
  object SrcNameEdit: TFilenameEdit
    Left = 8
    Top = 24
    Width = 315
    Height = 21
    AcceptFiles = True
    DefaultExt = 'DB'
    Filter = 
      'Paradox and DBase files|*.DB;*.DBF|Paradox files (*.db)|*.DB|DBa' +
      'se files (*.dbf)|*.DBF|ASCII files (*.txt)|*.TXT|All files (*.*)' +
      '|*.*'
    DialogOptions = [ofHideReadOnly, ofPathMustExist]
    DialogTitle = 'Browse files'
    ButtonHint = 'Browse files|'
    NumGlyphs = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = SrcNameEditChange
  end
  object FormStorage: TFormStorage
    StoredProps.Strings = (
      'SrcNameEdit.InitialDir'
      'SrcNameEdit.FilterIndex')
    StoredValues = <>
    Left = 344
    Top = 124
  end
  object TableFields: TTableItems
    Left = 372
    Top = 124
  end
end
