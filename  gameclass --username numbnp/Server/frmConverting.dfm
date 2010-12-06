object formConverting: TformConverting
  Left = 372
  Top = 236
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Converting database'
  ClientHeight = 251
  ClientWidth = 406
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
  object labelConverting: TLabel
    Left = 16
    Top = 16
    Width = 98
    Height = 13
    Caption = 'Converting database'
  end
  object butStart: TButton
    Left = 240
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = butStartClick
  end
  object butCancel: TButton
    Left = 320
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object memoInfo: TMemo
    Left = 16
    Top = 32
    Width = 377
    Height = 177
    TabOrder = 2
  end
end
