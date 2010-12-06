object frmServerName: TfrmServerName
  Left = 331
  Top = 293
  Width = 334
  Height = 109
  Caption = 'IP-'#1072#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 165
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1080#1083#1080' IP-'#1072#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072':'
  end
  object edtServerName: TEdit
    Left = 184
    Top = 13
    Width = 105
    Height = 21
    TabOrder = 0
    Text = '888.888.888.888'
  end
  object btnOk: TButton
    Left = 64
    Top = 48
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 160
    Top = 48
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnServerList: TButton
    Left = 296
    Top = 13
    Width = 24
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = btnServerListClick
  end
end
