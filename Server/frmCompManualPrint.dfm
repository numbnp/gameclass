object formCompManualPrint: TformCompManualPrint
  Left = 395
  Top = 333
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'formCompManualPrint'
  ClientHeight = 149
  ClientWidth = 278
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
  object lblSumma: TLabel
    Left = 168
    Top = 26
    Width = 34
    Height = 13
    Caption = #1057#1091#1084#1084#1072
  end
  object lblComputer: TLabel
    Left = 24
    Top = 26
    Width = 58
    Height = 13
    Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
  end
  object lblPages: TLabel
    Left = 104
    Top = 26
    Width = 42
    Height = 13
    Caption = #1057#1090#1088#1072#1085#1080#1094
  end
  object butOk: TButton
    Left = 99
    Top = 112
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = butOkClick
  end
  object butCancel: TButton
    Left = 181
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = butCancelClick
  end
  object editMoney: TEdit
    Left = 168
    Top = 42
    Width = 81
    Height = 41
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = editMoneyChange
  end
  object editComputer: TEdit
    Left = 24
    Top = 42
    Width = 70
    Height = 41
    BiDiMode = bdRightToLeft
    Ctl3D = True
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    Text = '2'
  end
  object sePages: TSpinEdit
    Left = 104
    Top = 42
    Width = 57
    Height = 43
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxValue = 100
    MinValue = 1
    ParentFont = False
    TabOrder = 4
    Value = 1
    OnChange = sePagesChange
  end
  object timerAdd: TTimer
    Enabled = False
    OnTimer = timerAddTimer
    Left = 240
    Top = 8
  end
end
