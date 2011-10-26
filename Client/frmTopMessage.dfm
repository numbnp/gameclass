object frmMessage: TfrmMessage
  Left = 527
  Top = 67
  AutoSize = True
  BorderStyle = bsNone
  Caption = 'frmMessage'
  ClientHeight = 75
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 249
    Height = 75
    Caption = 'test-test'
    Color = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -64
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object tmrBliking: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrBlikingTimer
    Left = 192
    Top = 96
  end
  object tmrStop: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrStopTimer
    Left = 224
    Top = 96
  end
end
