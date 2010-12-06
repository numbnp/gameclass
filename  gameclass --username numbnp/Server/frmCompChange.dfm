object formCompChange: TformCompChange
  Left = 346
  Top = 273
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'formCompChange'
  ClientHeight = 130
  ClientWidth = 263
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
  object lblComputer: TLabel
    Left = 24
    Top = 26
    Width = 58
    Height = 13
    Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
  end
  object lblComputer2: TLabel
    Left = 144
    Top = 26
    Width = 58
    Height = 13
    Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
  end
  object lblVs: TLabel
    Left = 112
    Top = 46
    Width = 12
    Height = 13
    Caption = '<>'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object butOk: TButton
    Left = 83
    Top = 88
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = butOkClick
  end
  object butCancel: TButton
    Left = 165
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = butCancelClick
  end
  object editComputer: TEdit
    Left = 24
    Top = 42
    Width = 70
    Height = 21
    BiDiMode = bdRightToLeft
    Ctl3D = True
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    Text = '2'
  end
  object cbComputer: TComboBox
    Left = 144
    Top = 42
    Width = 89
    Height = 21
    Style = csDropDownList
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 3
    OnSelect = cbComputerSelect
  end
  object timerChange: TTimer
    Enabled = False
    OnTimer = timerChangeTimer
  end
end
