object frmSmallInfo: TfrmSmallInfo
  Left = 1056
  Top = 668
  AlphaBlend = True
  AlphaBlendValue = 125
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmSmallInfo'
  ClientHeight = 104
  ClientWidth = 115
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -8
  Font.Name = 'Small Fonts'
  Font.Style = [fsBold]
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 10
  object tmrRedraw: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrRedrawTimer
    Left = 64
    Top = 8
  end
end
