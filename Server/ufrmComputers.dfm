object frmComputers: TfrmComputers
  Left = 426
  Top = 604
  BorderStyle = bsNone
  Caption = 'frmComputers'
  ClientHeight = 117
  ClientWidth = 197
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblComputer: TLabel
    Left = 0
    Top = 0
    Width = 58
    Height = 13
    Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
  end
  object lblNumber: TLabel
    Left = 0
    Top = 66
    Width = 59
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
  end
  object btnSelect: TSpeedButton
    Left = 96
    Top = 16
    Width = 11
    Height = 41
    Caption = '6'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Webdings'
    Font.Style = []
    ParentFont = False
    OnClick = btnSelectClick
  end
  object edtCount: TAlignEdit
    Left = 67
    Top = 63
    Width = 29
    Height = 21
    Alignment = eaRight
    Enabled = False
    TabOrder = 0
    Text = '22'
  end
  object memComputers: TMemo
    Left = 0
    Top = 16
    Width = 97
    Height = 41
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      '1')
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    OnChange = memComputersChange
  end
end
