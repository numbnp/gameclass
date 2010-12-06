object frmMain: TfrmMain
  Left = 330
  Top = 396
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'GameClass SQL Utility'
  ClientHeight = 330
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object butClose: TButton
    Left = 368
    Top = 297
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 0
    OnClick = butCloseClick
  end
  object memoInfo: TMemo
    Left = 8
    Top = 8
    Width = 433
    Height = 281
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
