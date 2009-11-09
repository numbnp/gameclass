object formRemontLong: TformRemontLong
  Left = 383
  Top = 245
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'formRemontLong'
  ClientHeight = 182
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblInputReason: TLabel
    Left = 16
    Top = 58
    Width = 212
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1088#1080#1095#1080#1085#1091' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1088#1077#1084#1086#1085#1090#1072
  end
  object lblComputer: TLabel
    Left = 15
    Top = 24
    Width = 58
    Height = 13
    Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
  end
  object butOk: TButton
    Left = 126
    Top = 146
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object butCancel: TButton
    Left = 210
    Top = 146
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object editRemontReason: TEdit
    Left = 16
    Top = 74
    Width = 265
    Height = 21
    TabOrder = 0
    OnChange = editRemontReasonChange
  end
end
