object fPrnDBGridEHSetupDialog: TfPrnDBGridEHSetupDialog
  Left = 331
  Top = 112
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Printer setup'
  ClientHeight = 210
  ClientWidth = 406
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = fPrnDBGridEHSetupDialogShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbPrintFields: TGroupBox
    Left = 8
    Top = 6
    Width = 149
    Height = 155
    Caption = ' &Margins '
    TabOrder = 0
    object Label5: TLabel
      Left = 14
      Top = 31
      Width = 18
      Height = 13
      Caption = '&Top'
    end
    object Label6: TLabel
      Left = 14
      Top = 59
      Width = 34
      Height = 13
      Caption = '&Bottom'
    end
    object Label7: TLabel
      Left = 14
      Top = 88
      Width = 19
      Height = 13
      Caption = '&Left'
    end
    object Label8: TLabel
      Left = 14
      Top = 117
      Width = 25
      Height = 13
      Caption = '&Right'
    end
    object seUpMargin: TEdit
      Left = 62
      Top = 28
      Width = 70
      Height = 21
      TabOrder = 0
      Text = '0'
      OnExit = seMarginExit
    end
    object seLowMargin: TEdit
      Left = 62
      Top = 56
      Width = 70
      Height = 21
      TabOrder = 1
      Text = '0'
      OnExit = seMarginExit
    end
    object seLeftMargin: TEdit
      Left = 62
      Top = 85
      Width = 70
      Height = 21
      TabOrder = 2
      Text = '0'
      OnExit = seMarginExit
    end
    object seRightMargin: TEdit
      Left = 62
      Top = 114
      Width = 70
      Height = 21
      TabOrder = 3
      Text = '0'
      OnExit = seMarginExit
    end
  end
  object ePrintFont: TEdit
    Left = 172
    Top = 140
    Width = 201
    Height = 21
    TabOrder = 6
    Text = 'ePrintFont'
  end
  object cbAutoStretch: TCheckBox
    Left = 172
    Top = 115
    Width = 226
    Height = 17
    Caption = '&Stretch long lines'
    TabOrder = 4
  end
  object bPrinterSetupDialog: TButton
    Left = 9
    Top = 177
    Width = 148
    Height = 25
    Caption = '&Printer setup'
    TabOrder = 8
    OnClick = bPrinterSetupDialogClick
  end
  object bPrintFont: TButton
    Left = 375
    Top = 140
    Width = 23
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = bPrintFontClick
  end
  object bOk: TButton
    Left = 228
    Top = 177
    Width = 80
    Height = 26
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 9
  end
  object bCancel: TButton
    Left = 316
    Top = 177
    Width = 80
    Height = 26
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 10
  end
  object cbColored: TCheckBox
    Left = 172
    Top = 93
    Width = 226
    Height = 17
    Caption = '&Colored'
    TabOrder = 5
  end
  object rgFitingType: TRadioGroup
    Left = 172
    Top = 12
    Width = 226
    Height = 55
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Scale whole &grid'
      'C&hange column widths')
    TabOrder = 2
  end
  object cbFitWidthToPage: TCheckBox
    Left = 184
    Top = 5
    Width = 201
    Height = 17
    Caption = '&Fits the width on one page'
    TabOrder = 1
    OnClick = cbFitWidthToPageClick
  end
  object cbOptimalColWidths: TCheckBox
    Left = 172
    Top = 70
    Width = 226
    Height = 17
    Caption = 'Optimal column &widths'
    TabOrder = 3
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 121
    Top = 65527
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 65522
    Top = 192
  end
end
