object formTrial: TformTrial
  Left = 346
  Top = 213
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'GameClass3'
  ClientHeight = 227
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 22
    Top = 192
    Width = 152
    Height = 13
    Cursor = crHandPoint
    Caption = 'www.gameclass.ru/products/gc'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = Label1Click
  end
  object lblBuy: TLabel
    Left = 22
    Top = 178
    Width = 94
    Height = 13
    Caption = #1050#1091#1087#1080#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1091
  end
  object lblLeft: TLabel
    Left = 21
    Top = 136
    Width = 85
    Height = 13
    Caption = #1055#1088#1086#1073#1085#1099#1081' '#1087#1077#1088#1080#1086#1076
  end
  object lblInfo: TLabel
    Left = 21
    Top = 17
    Width = 66
    Height = 13
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
  end
  object butOK: TButton
    Left = 238
    Top = 182
    Width = 73
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object memoInfo: TMemo
    Left = 22
    Top = 32
    Width = 289
    Height = 89
    Color = clBtnFace
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
  end
  object pbLeft: TProgressBar
    Left = 22
    Top = 152
    Width = 289
    Height = 17
    BorderWidth = 1
    Min = 0
    Max = 100
    ParentShowHint = False
    Step = 1
    ShowHint = False
    TabOrder = 2
  end
end
