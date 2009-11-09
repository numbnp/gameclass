object frmAddCheckAccount: TfrmAddCheckAccount
  Left = 341
  Top = 284
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1085#1086#1074#1086#1081' '#1091#1095#1077#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080' '#1089' '#1087#1077#1095#1072#1090#1100#1102' '#1095#1077#1082#1072
  ClientHeight = 165
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblSumma: TLabel
    Left = 16
    Top = 16
    Width = 34
    Height = 13
    Caption = #1057#1091#1084#1084#1072
  end
  object lblAccountNumber: TLabel
    Left = 166
    Top = 22
    Width = 34
    Height = 13
    Caption = #1053#1086#1084#1077#1088
  end
  object lblAccountName: TLabel
    Left = 166
    Top = 53
    Width = 22
    Height = 13
    Caption = #1048#1084#1103
  end
  object lblAccountPassword: TLabel
    Left = 166
    Top = 83
    Width = 38
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object btnOk: TButton
    Left = 88
    Top = 128
    Width = 75
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 200
    Top = 128
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object edtMoney: TCurrencyEdit
    Left = 16
    Top = 34
    Width = 126
    Height = 41
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnChange = edtMoneyChange
  end
  object editAccountNumber: TEdit
    Left = 224
    Top = 16
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object editAccountName: TEdit
    Left = 224
    Top = 48
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object edtAccountPassword: TEdit
    Left = 224
    Top = 80
    Width = 121
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 5
    Text = #1055#1077#1095#1072#1090#1072#1077#1090#1089#1103' '#1085#1072' '#1095#1077#1082#1077
  end
end
