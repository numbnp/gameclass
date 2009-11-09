object frmKKMConfig: TfrmKKMConfig
  Left = 430
  Top = 320
  Width = 408
  Height = 344
  BorderIcons = [biSystemMenu]
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1050#1050#1052
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 276
    Width = 400
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 104
      Top = 8
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 224
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object gbConfig: TGroupBox
    Left = 8
    Top = 0
    Width = 385
    Height = 209
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
    TabOrder = 1
    object pnlDynamicConfig: TPanel
      Left = 2
      Top = 15
      Width = 381
      Height = 192
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
  object gbTestConnect: TGroupBox
    Left = 8
    Top = 216
    Width = 385
    Height = 57
    Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103' '#1089' '#1050#1050#1052
    TabOrder = 2
    object btnTestConnect: TButton
      Left = 16
      Top = 24
      Width = 97
      Height = 25
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
      TabOrder = 0
      OnClick = btnTestConnectClick
    end
    object edtTestResult: TEdit
      Left = 128
      Top = 24
      Width = 241
      Height = 21
      Color = clMenu
      ReadOnly = True
      TabOrder = 1
    end
  end
end
