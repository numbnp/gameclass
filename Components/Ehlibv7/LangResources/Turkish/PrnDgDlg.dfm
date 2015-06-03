object fPrnDBGridEHSetupDialog: TfPrnDBGridEHSetupDialog
  Left = 331
  Top = 112
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Yaz'#305'c'#305' Ayar'#305
  ClientHeight = 185
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = fPrnDBGridEHSetupDialogShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbPrintFields: TGroupBox
    Left = 8
    Top = 6
    Width = 149
    Height = 130
    Caption = ' &Sayfa bo'#351'lu'#287'u'
    TabOrder = 0
    object Label5: TLabel
      Left = 14
      Top = 26
      Width = 16
      Height = 13
      Caption = #220's&t'
    end
    object Label6: TLabel
      Left = 14
      Top = 51
      Width = 13
      Height = 13
      Caption = 'A&lt'
    end
    object Label7: TLabel
      Left = 14
      Top = 77
      Width = 14
      Height = 13
      Caption = 'S&ol'
    end
    object Label8: TLabel
      Left = 14
      Top = 102
      Width = 18
      Height = 13
      Caption = '&Sa'#287
    end
    object seUpMargin: TEdit
      Left = 62
      Top = 24
      Width = 70
      Height = 21
      TabOrder = 0
      Text = '0'
      OnExit = seMarginExit
    end
    object seLowMargin: TEdit
      Left = 62
      Top = 49
      Width = 70
      Height = 21
      TabOrder = 1
      Text = '0'
      OnExit = seMarginExit
    end
    object seLeftMargin: TEdit
      Left = 62
      Top = 73
      Width = 70
      Height = 21
      TabOrder = 2
      Text = '0'
      OnExit = seMarginExit
    end
    object seRightMargin: TEdit
      Left = 62
      Top = 98
      Width = 70
      Height = 21
      TabOrder = 3
      Text = '0'
      OnExit = seMarginExit
    end
  end
  object ePrintFont: TEdit
    Left = 174
    Top = 115
    Width = 161
    Height = 21
    TabOrder = 6
    Text = 'ePrintFont'
  end
  object cbAutoStretch: TCheckBox
    Left = 174
    Top = 92
    Width = 101
    Height = 17
    Alignment = taLeftJustify
    Caption = '&Uzun sat'#305'rlar'#305' kes'
    TabOrder = 4
  end
  object bPrinterSetupDialog: TButton
    Left = 9
    Top = 151
    Width = 80
    Height = 25
    Caption = '&Yaz'#305'c'#305' Ayarlar'#305
    TabOrder = 8
    OnClick = bPrinterSetupDialogClick
  end
  object bPrintFont: TButton
    Left = 336
    Top = 115
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
    Left = 191
    Top = 151
    Width = 80
    Height = 26
    Caption = '&Tamam'
    Default = True
    ModalResult = 1
    TabOrder = 9
  end
  object bCancel: TButton
    Left = 279
    Top = 151
    Width = 80
    Height = 26
    Cancel = True
    Caption = '&Vazge'#231
    ModalResult = 2
    TabOrder = 10
  end
  object cbColored: TCheckBox
    Left = 300
    Top = 92
    Width = 57
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Renl&i'
    TabOrder = 5
  end
  object rgFitingType: TRadioGroup
    Left = 172
    Top = 6
    Width = 185
    Height = 55
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'T'#252'&m'#252'n'#252' '#246'l'#231'ekle'
      'S'#252'tun g&eni'#351'liklerini de'#287'i'#351'tir')
    TabOrder = 2
  end
  object cbFitWidthToPage: TCheckBox
    Left = 184
    Top = 4
    Width = 145
    Height = 17
    Alignment = taLeftJustify
    Caption = '&Eni bir sayfaya s'#305#287'd'#305'r'
    TabOrder = 1
    OnClick = cbFitWidthToPageClick
  end
  object cbOptimalColWidths: TCheckBox
    Left = 234
    Top = 68
    Width = 123
    Height = 17
    Alignment = taLeftJustify
    Caption = 'En uyg&un geni'#351'lik '
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
    Left = 322
    Top = 144
  end
end
