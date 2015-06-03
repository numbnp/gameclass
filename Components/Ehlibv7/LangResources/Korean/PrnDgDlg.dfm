object fPrnDBGridEHSetupDialog: TfPrnDBGridEHSetupDialog
  Left = 331
  Top = 112
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #54532#47536#53552' '#49444#51221
  ClientHeight = 223
  ClientWidth = 365
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #44404#47548
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = fPrnDBGridEHSetupDialogShow
  PixelsPerInch = 96
  TextHeight = 12
  object gbPrintFields: TGroupBox
    Left = 12
    Top = 16
    Width = 149
    Height = 130
    Caption = ' '#50668#48177'(&M) '
    TabOrder = 0
    object Label5: TLabel
      Left = 14
      Top = 26
      Width = 42
      Height = 12
      Caption = #49345#45800'(&T)'
    end
    object Label6: TLabel
      Left = 14
      Top = 51
      Width = 42
      Height = 12
      Caption = #54616#45800'(&B)'
    end
    object Label7: TLabel
      Left = 14
      Top = 77
      Width = 41
      Height = 12
      Caption = #51340#52769'(&L)'
    end
    object Label8: TLabel
      Left = 14
      Top = 102
      Width = 42
      Height = 12
      Caption = #50864#52769'(&R)'
    end
    object seUpMargin: TEdit
      Left = 62
      Top = 24
      Width = 70
      Height = 20
      TabOrder = 0
      Text = '0'
      OnExit = seMarginExit
    end
    object seLowMargin: TEdit
      Left = 62
      Top = 49
      Width = 70
      Height = 20
      TabOrder = 1
      Text = '0'
      OnExit = seMarginExit
    end
    object seLeftMargin: TEdit
      Left = 62
      Top = 73
      Width = 70
      Height = 20
      TabOrder = 2
      Text = '0'
      OnExit = seMarginExit
    end
    object seRightMargin: TEdit
      Left = 62
      Top = 98
      Width = 70
      Height = 20
      TabOrder = 3
      Text = '0'
      OnExit = seMarginExit
    end
  end
  object ePrintFont: TEdit
    Left = 168
    Top = 148
    Width = 161
    Height = 20
    TabOrder = 6
    Text = 'ePrintFont'
  end
  object cbAutoStretch: TCheckBox
    Left = 172
    Top = 124
    Width = 105
    Height = 17
    Alignment = taLeftJustify
    Caption = #44596' '#51460' '#45720#47532#44592'(&S)'
    TabOrder = 4
  end
  object bPrinterSetupDialog: TButton
    Left = 12
    Top = 180
    Width = 101
    Height = 29
    Caption = #54532#47536#53552#49444#51221'(&P)'
    TabOrder = 8
    OnClick = bPrinterSetupDialogClick
  end
  object bPrintFont: TButton
    Left = 332
    Top = 148
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
    Left = 200
    Top = 180
    Width = 77
    Height = 29
    Caption = #54869#51064'(&O)'
    Default = True
    ModalResult = 1
    TabOrder = 9
  end
  object bCancel: TButton
    Left = 280
    Top = 180
    Width = 77
    Height = 29
    Cancel = True
    Caption = #52712#49548'(&C)'
    ModalResult = 2
    TabOrder = 10
  end
  object cbColored: TCheckBox
    Left = 288
    Top = 124
    Width = 61
    Height = 17
    Alignment = taLeftJustify
    Caption = #52972#47084'(&L)'
    TabOrder = 5
  end
  object rgFitingType: TRadioGroup
    Left = 168
    Top = 32
    Width = 185
    Height = 61
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      #44536#47532#46300' '#51204#52404' '#49828#52992#51068'(&G)'
      #52972#47100' '#45331#51060' '#48320#44221'(&H)')
    TabOrder = 2
  end
  object cbFitWidthToPage: TCheckBox
    Left = 172
    Top = 16
    Width = 75
    Height = 17
    Alignment = taLeftJustify
    Caption = ' '#54253#47582#52644'(&F)'
    TabOrder = 1
    OnClick = cbFitWidthToPageClick
  end
  object cbOptimalColWidths: TCheckBox
    Left = 218
    Top = 100
    Width = 131
    Height = 17
    Alignment = taLeftJustify
    Caption = #52860#47100' '#45331#51060' '#52572#51201#54868'(&W)'
    TabOrder = 3
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 144
    Top = 180
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 116
    Top = 180
  end
end
