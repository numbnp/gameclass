object Form1: TForm1
  Left = 325
  Top = 176
  Width = 597
  Height = 467
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 72
    Width = 3
    Height = 13
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 53
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 40
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103':'
  end
  object Label4: TLabel
    Left = 8
    Top = 112
    Width = 62
    Height = 13
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099':'
  end
  object Label5: TLabel
    Left = 8
    Top = 184
    Width = 34
    Height = 13
    Caption = #1053#1086#1084#1077#1088
  end
  object Label6: TLabel
    Left = 192
    Top = 184
    Width = 22
    Height = 13
    Caption = #1048#1084#1103
  end
  object Label7: TLabel
    Left = 8
    Top = 280
    Width = 34
    Height = 13
    Caption = #1057#1091#1084#1084#1072
  end
  object Label8: TLabel
    Left = 184
    Top = 280
    Width = 23
    Height = 13
    Caption = #1057#1095#1077#1090
  end
  object Button1: TButton
    Left = 384
    Top = 8
    Width = 75
    Height = 25
    Caption = #1058#1077#1089#1090
    TabOrder = 0
    OnClick = Button1Click
  end
  object cbxIsKKMPlugin: TCheckBox
    Left = 8
    Top = 40
    Width = 121
    Height = 17
    Caption = #1050#1050#1052' '#1087#1083#1072#1075#1080#1085
    TabOrder = 1
  end
  object edtName: TEdit
    Left = 112
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtVersion: TEdit
    Left = 112
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object edtConfigParamaters: TEdit
    Left = 112
    Top = 112
    Width = 345
    Height = 21
    TabOrder = 4
  end
  object edtFileName: TFilenameEdit
    Left = 8
    Top = 8
    Width = 353
    Height = 21
    Filter = 'DLL files (*.*)|*.dll'
    NumGlyphs = 1
    TabOrder = 5
  end
  object Button2: TButton
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 6
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 248
    Top = 152
    Width = 97
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 7
  end
  object Button3: TButton
    Left = 88
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 168
    Top = 144
    Width = 75
    Height = 25
    Caption = 'CheckConn'
    TabOrder = 9
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 208
    Width = 97
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1089#1084#1077#1085#1091
    TabOrder = 10
    OnClick = Button5Click
  end
  object Button7: TButton
    Left = 112
    Top = 208
    Width = 75
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
    TabOrder = 11
    OnClick = Button7Click
  end
  object edtOpNum: TEdit
    Left = 48
    Top = 176
    Width = 121
    Height = 21
    TabOrder = 12
    Text = '7'
  end
  object edtOpName: TEdit
    Left = 240
    Top = 176
    Width = 121
    Height = 21
    TabOrder = 13
    Text = #1055#1077#1090#1088#1086#1074' '#1042'.'#1043'.'
  end
  object CheckBox2: TCheckBox
    Left = 200
    Top = 216
    Width = 97
    Height = 17
    Caption = #1057#1084#1077#1085#1072' '#1086#1090#1082#1088#1099#1090#1072
    TabOrder = 14
  end
  object btnXReport: TButton
    Left = 8
    Top = 240
    Width = 75
    Height = 25
    Caption = 'XReport'
    TabOrder = 15
    OnClick = btnXReportClick
  end
  object btnZReport: TButton
    Left = 88
    Top = 240
    Width = 75
    Height = 25
    Caption = 'ZReport'
    TabOrder = 16
    OnClick = btnZReportClick
  end
  object edtAccount: TEdit
    Left = 216
    Top = 272
    Width = 121
    Height = 21
    TabOrder = 17
    Text = 'MegaGamer'
  end
  object btnCasheIn: TButton
    Left = 352
    Top = 272
    Width = 75
    Height = 25
    Caption = 'CasheIn'
    TabOrder = 18
    OnClick = btnCasheInClick
  end
  object edtSum: TCurrencyEdit
    Left = 48
    Top = 272
    Width = 121
    Height = 21
    AutoSize = False
    TabOrder = 19
    Value = 130.500000000000000000
  end
  object Button6: TButton
    Left = 16
    Top = 304
    Width = 75
    Height = 25
    Caption = #1063#1077#1082
    TabOrder = 20
    OnClick = Button6Click
  end
  object Memo1: TMemo
    Left = 104
    Top = 304
    Width = 305
    Height = 121
    Lines.Strings = (
      #1088#1077#1084#1103' '#1086#1090' '#1074#1088#1077#1084#1077#1085#1080' '#1087#1086#1082#1091#1087#1072#1102' '#1074#1089#1103#1082#1080#1077' '#1078#1091#1088#1085#1072#1083#1099'. '
      #1041#1091#1076#1091#1095#1080' '#1090#1091#1087#1099#1084' '#1073#1099#1076#1083#1086#1084', '#1083#1102#1073#1083#1102' '#1082#1086#1075#1076#1072' '#1074#1089#1105' '#1085#1072'  sdf sd fsdf'
      #1073#1091#1084#1072#1075#1077', '#1095#1090#1086#1073#1099' '#1087#1086#1090#1088#1086#1075#1072#1090#1100' '#1080' '#1087#1086#1085#1102#1093#1072#1090#1100'. ')
    TabOrder = 21
  end
  object Button8: TButton
    Left = 376
    Top = 360
    Width = 161
    Height = 25
    Caption = #1053#1072#1087#1077#1095#1072#1090#1072#1090#1100' '#1085#1077#1092#1080#1089#1082#1072#1083#1100#1085#1099#1081
    TabOrder = 22
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 16
    Top = 336
    Width = 75
    Height = 25
    Caption = #1042#1086#1079#1074#1088#1072#1090
    TabOrder = 23
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 432
    Top = 272
    Width = 75
    Height = 25
    Caption = 'CasheOut'
    TabOrder = 24
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 408
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Button11'
    TabOrder = 25
    OnClick = Button11Click
  end
end
