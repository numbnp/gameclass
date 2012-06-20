object formInputSumm: TformInputSumm
  Left = 372
  Top = 328
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1087#1080#1096#1080' '#1095#1090#1086' '#1085#1072#1076#1086
  ClientHeight = 155
  ClientWidth = 268
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lblAccount: TLabel
    Left = 24
    Top = 24
    Width = 44
    Height = 13
    Caption = #1040#1082#1082#1072#1091#1085#1090':'
  end
  object lblAccountInfo: TLabel
    Left = 72
    Top = 24
    Width = 65
    Height = 13
    Caption = '1012 (Alex)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblInputSumm: TLabel
    Left = 24
    Top = 68
    Width = 77
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1089#1091#1084#1084#1091
  end
  object editSumma: TEdit
    Left = 112
    Top = 63
    Width = 81
    Height = 21
    TabOrder = 0
    OnChange = editSummaChange
    OnKeyDown = editSummaKeyDown
  end
  object butOK: TButton
    Left = 102
    Top = 120
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = butOKClick
  end
  object butCancel: TButton
    Left = 182
    Top = 120
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
end
