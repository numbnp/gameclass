object fPrnDBGridEHSetupDialog: TfPrnDBGridEHSetupDialog
  Left = 348
  Top = 221
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Options d'#39'impression'
  ClientHeight = 185
  ClientWidth = 368
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
    Caption = ' &Marges '
    TabOrder = 0
    object Label5: TLabel
      Left = 14
      Top = 26
      Width = 23
      Height = 13
      Caption = '&Haut'
    end
    object Label6: TLabel
      Left = 14
      Top = 51
      Width = 18
      Height = 13
      Caption = '&Bas'
    end
    object Label7: TLabel
      Left = 14
      Top = 77
      Width = 38
      Height = 13
      Caption = '&Gauche'
    end
    object Label8: TLabel
      Left = 14
      Top = 102
      Width = 28
      Height = 13
      Caption = '&Droite'
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
    Width = 105
    Height = 17
    Alignment = taLeftJustify
    Caption = '&Hauteur ligne auto'
    TabOrder = 4
  end
  object bPrinterSetupDialog: TButton
    Left = 9
    Top = 151
    Width = 96
    Height = 25
    Caption = 'Config. Imprimante'
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
    Font.Name = 'MS Sans Serif'
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
    Caption = '&Ok'
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
    Caption = '&Annuler'
    ModalResult = 2
    TabOrder = 10
  end
  object cbColored: TCheckBox
    Left = 300
    Top = 92
    Width = 57
    Height = 17
    Alignment = taLeftJustify
    Caption = '&Couleur'
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
      'Met la &grille '#224' l'#39#233'chelle'
      'C&hange largeur des colonnes')
    TabOrder = 2
  end
  object cbFitWidthToPage: TCheckBox
    Left = 184
    Top = 4
    Width = 149
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Ajuste largeur sur une page  '
    TabOrder = 1
    OnClick = cbFitWidthToPageClick
  end
  object cbOptimalColWidths: TCheckBox
    Left = 216
    Top = 68
    Width = 141
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Optimise largeur colonne'
    TabOrder = 3
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 121
    Top = 65527
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 322
    Top = 144
  end
end
