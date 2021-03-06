object FormXlsxExportOptions: TFormXlsxExportOptions
  Left = 696
  Top = 245
  BorderStyle = bsDialog
  Caption = 'Export options ...'
  ClientHeight = 369
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    363
    369)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 10
    Top = 322
    Width = 339
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  object cbExportTitle: TDBCheckBoxEh
    Left = 11
    Top = 8
    Width = 338
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Grid Title'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 0
  end
  object Button1: TButton
    Left = 173
    Top = 333
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object Button2: TButton
    Left = 256
    Top = 333
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object cbFontFormat: TDBCheckBoxEh
    Left = 11
    Top = 55
    Width = 338
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Font format'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 2
  end
  object cbFillColors: TDBCheckBoxEh
    Left = 11
    Top = 77
    Width = 338
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Cell fill colors'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 3
  end
  object cbAutoFilter: TDBCheckBoxEh
    Left = 11
    Top = 100
    Width = 338
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'AutoFilter'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 4
  end
  object cbExportFooter: TDBCheckBoxEh
    Left = 11
    Top = 146
    Width = 338
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Grid Footer'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 1
  end
  object cbFreezeTitleRow: TDBCheckBoxEh
    Left = 11
    Top = 123
    Width = 338
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Freeze Title row/Frozen columns'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 5
  end
  object EditCaption: TDBEditEh
    Left = 128
    Top = 232
    Width = 221
    Height = 21
    ControlLabel.Caption = 'Grid caption:'
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 80
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    TabOrder = 8
    Text = 'Grid caption'
    Visible = True
  end
  object EditSubcaption: TDBEditEh
    Left = 128
    Top = 259
    Width = 221
    Height = 21
    ControlLabel.Caption = 'Grid subcaption:'
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 80
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    TabOrder = 9
    Text = 'Text after grid'
    Visible = True
  end
  object cbGridCaption: TDBCheckBoxEh
    Left = 11
    Top = 234
    Width = 105
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Text before grid'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 10
  end
  object cbSubcation: TDBCheckBoxEh
    Left = 11
    Top = 261
    Width = 105
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Text after grid'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 11
  end
  object cbSumsAsFormula: TDBCheckBoxEh
    Left = 11
    Top = 169
    Width = 338
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Footer sums as Formula'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 12
  end
  object cbDisplayFormat: TDBCheckBoxEh
    Left = 11
    Top = 32
    Width = 338
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Number/Date display format'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 13
  end
  object EditSheetName: TDBEditEh
    Left = 128
    Top = 286
    Width = 221
    Height = 21
    ControlLabel.Width = 61
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Sheet name:'
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 118
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    TabOrder = 14
    Text = 'Tabular data'
    Visible = True
  end
  object cbDataGrouping: TDBCheckBoxEh
    Left = 11
    Top = 193
    Width = 338
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Data grouping'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 15
  end
end
