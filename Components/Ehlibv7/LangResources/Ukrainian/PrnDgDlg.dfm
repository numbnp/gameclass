object fPrnDBGridEHSetupDialog: TfPrnDBGridEHSetupDialog
  Left = 331
  Top = 112
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Налаштування принтера'
  ClientHeight = 183
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
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
    Caption = ' &Відступи '
    TabOrder = 0
    object Label5: TLabel
      Left = 14
      Top = 26
      Width = 38
      Height = 13
      Caption = '&Верхній'
    end
    object Label6: TLabel
      Left = 14
      Top = 51
      Width = 36
      Height = 13
      Caption = '&Нижній'
    end
    object Label7: TLabel
      Left = 14
      Top = 77
      Width = 28
      Height = 13
      Caption = '&Лівий'
    end
    object Label8: TLabel
      Left = 14
      Top = 102
      Width = 38
      Height = 13
      Caption = '&Правий'
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
    Left = 166
    Top = 115
    Width = 179
    Height = 21
    TabOrder = 6
    Text = 'ePrintFont'
  end
  object cbAutoStretch: TCheckBox
    Left = 164
    Top = 92
    Width = 157
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Перенесення &довгих рядків'
    TabOrder = 4
  end
  object bPrinterSetupDialog: TButton
    Left = 9
    Top = 151
    Width = 144
    Height = 25
    Caption = 'Н&алаштування принтера'
    TabOrder = 8
    OnClick = bPrinterSetupDialogClick
  end
  object bPrintFont: TButton
    Left = 346
    Top = 114
    Width = 23
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = bPrintFontClick
  end
  object bOk: TButton
    Left = 199
    Top = 151
    Width = 80
    Height = 26
    Caption = 'ОK'
    Default = True
    ModalResult = 1
    TabOrder = 9
  end
  object bCancel: TButton
    Left = 287
    Top = 151
    Width = 80
    Height = 26
    Cancel = True
    Caption = 'С&касувати'
    ModalResult = 2
    TabOrder = 10
  end
  object cbColored: TCheckBox
    Left = 322
    Top = 92
    Width = 47
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Кол&ір'
    TabOrder = 5
  end
  object rgFitingType: TRadioGroup
    Left = 166
    Top = 6
    Width = 203
    Height = 55
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Масштабувати всю таблицю'
      'Змінювати ширину стовпців')
    TabOrder = 2
  end
  object cbFitWidthToPage: TCheckBox
    Left = 176
    Top = 4
    Width = 129
    Height = 17
    Alignment = taLeftJustify
    Caption = '&За шириною сторінки'
    TabOrder = 1
    OnClick = cbFitWidthToPageClick
  end
  object cbOptimalColWidths: TCheckBox
    Left = 164
    Top = 68
    Width = 173
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Оптимальна ширина стовпців'
    TabOrder = 3
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 113
    Top = 65533
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 154
    Top = 148
  end
end
