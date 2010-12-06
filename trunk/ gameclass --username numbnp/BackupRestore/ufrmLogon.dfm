object formLogon: TformLogon
  Left = 783
  Top = 793
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1082' SQL-'#1089#1077#1088#1074#1077#1088#1091
  ClientHeight = 174
  ClientWidth = 286
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
  object lblPass: TLabel
    Left = 29
    Top = 91
    Width = 38
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object lblLogin: TLabel
    Left = 29
    Top = 65
    Width = 22
    Height = 13
    Caption = #1048#1084#1103
  end
  object lblServer: TLabel
    Left = 29
    Top = 34
    Width = 55
    Height = 13
    Caption = 'SQL Server'
  end
  object editPass: TEdit
    Left = 93
    Top = 87
    Width = 156
    Height = 20
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Wingdings'
    Font.Style = []
    ParentFont = False
    PasswordChar = 'l'
    TabOrder = 0
  end
  object editLogin: TEdit
    Left = 93
    Top = 61
    Width = 156
    Height = 21
    TabOrder = 1
    Text = 'manager'
  end
  object editServer: TEdit
    Left = 93
    Top = 29
    Width = 156
    Height = 21
    TabOrder = 2
    Text = 'localhost'
  end
  object butOk: TButton
    Left = 101
    Top = 128
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object butCancel: TButton
    Left = 186
    Top = 128
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 4
  end
end
