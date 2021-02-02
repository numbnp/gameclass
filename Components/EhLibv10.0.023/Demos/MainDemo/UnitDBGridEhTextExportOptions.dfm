object FormDBGridEhTextExportOptions: TFormDBGridEhTextExportOptions
  Left = 696
  Top = 245
  BorderStyle = bsDialog
  Caption = 'Export options ...'
  ClientHeight = 335
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    363
    335)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 10
    Top = 288
    Width = 339
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  object Bevel2: TBevel
    Left = 11
    Top = 63
    Width = 339
    Height = 2
  end
  object Bevel3: TBevel
    Left = 9
    Top = 130
    Width = 339
    Height = 2
  end
  object Bevel4: TBevel
    Left = 10
    Top = 246
    Width = 339
    Height = 2
  end
  object Label1: TLabel
    Left = 10
    Top = 56
    Width = 63
    Height = 13
    Caption = 'Data coding  '
    Color = clBtnFace
    ParentColor = False
    Transparent = False
  end
  object Label2: TLabel
    Left = 9
    Top = 123
    Width = 56
    Height = 13
    Caption = 'Delemiters  '
    Color = clBtnFace
    ParentColor = False
    Transparent = False
  end
  object Label3: TLabel
    Left = 9
    Top = 239
    Width = 45
    Height = 13
    Caption = 'Formats  '
    Color = clBtnFace
    ParentColor = False
    Transparent = False
  end
  object CheBoxExportTitle: TDBCheckBoxEh
    Left = 10
    Top = 8
    Width = 340
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Grid title'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 0
  end
  object Button1: TButton
    Left = 173
    Top = 299
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 10
  end
  object Button2: TButton
    Left = 256
    Top = 299
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 11
  end
  object CheBoxExportFooter: TDBCheckBoxEh
    Left = 10
    Top = 32
    Width = 340
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Grid footer'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 1
  end
  object CoBoxCodePage: TDBComboBoxEh
    Left = 229
    Top = 74
    Width = 120
    Height = 21
    ControlLabel.Width = 60
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Text coding:'
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 220
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
    TabOrder = 2
    Text = 'UTF8'
    Visible = True
  end
  object CheBoxWriteBOM: TDBCheckBoxEh
    Left = 9
    Top = 100
    Width = 340
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Write BOM (Byte Order Mark)'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 3
  end
  object CoBoxTextQuoteChar: TDBComboBoxEh
    Left = 229
    Top = 214
    Width = 120
    Height = 21
    ControlLabel.Width = 77
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Text quote char'
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 220
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      '"'
      #39)
    TabOrder = 7
    Text = '"'
    Visible = True
  end
  object CoBoxFieldsDelimiter: TDBComboBoxEh
    Left = 229
    Top = 189
    Width = 120
    Height = 21
    ControlLabel.Width = 60
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Cell delimiter'
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 220
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      '<Tab>'
      ','
      ';'
      '|')
    TabOrder = 6
    Text = '<Tab>'
    Visible = True
  end
  object CoBoxLineDelimiter: TDBComboBoxEh
    Left = 129
    Top = 141
    Width = 220
    Height = 21
    ControlLabel.Width = 62
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Line delimiter'
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 120
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      'CRLF (Carriage Return + Line Feed)'
      'LF (Line Feed)')
    TabOrder = 4
    Text = 'CRLF (Carriage Return + Line Feed)'
    Visible = True
  end
  object CheBoxTrailingLineDelimiter: TDBCheckBoxEh
    Left = 9
    Top = 167
    Width = 340
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Trailing line delimiter'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 5
  end
  object RadButEditFormat: TRadioButton
    Left = 8
    Top = 256
    Width = 140
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Use cell edit format'
    TabOrder = 8
  end
  object RadButDisplayFormat: TRadioButton
    Left = 209
    Top = 256
    Width = 140
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Use cell display format'
    Checked = True
    TabOrder = 9
    TabStop = True
  end
end
