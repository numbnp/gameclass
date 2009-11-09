object frmVolume: TfrmVolume
  Left = 391
  Top = 221
  BorderStyle = bsDialog
  Caption = 'frmVolume'
  ClientHeight = 353
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlVolume: TPanel
    Left = 8
    Top = 8
    Width = 313
    Height = 305
    TabOrder = 0
    object lblMain: TLabel
      Left = 200
      Top = 40
      Width = 23
      Height = 13
      Caption = 'Main'
    end
    object lblWave: TLabel
      Left = 256
      Top = 40
      Width = 29
      Height = 13
      Caption = 'Wave'
    end
    object tbMain: TTrackBar
      Left = 192
      Top = 56
      Width = 41
      Height = 201
      Max = 25
      Orientation = trVertical
      TabOrder = 0
      TickMarks = tmBoth
      OnChange = OnChangeMain
    end
    object tbWave: TTrackBar
      Left = 256
      Top = 56
      Width = 41
      Height = 201
      Max = 25
      Orientation = trVertical
      TabOrder = 1
      TickMarks = tmBoth
      OnChange = OnChangeWave
    end
    object cbMute: TCheckBox
      Left = 200
      Top = 272
      Width = 97
      Height = 17
      Caption = 'Mute'
      TabOrder = 2
      OnClick = OnClickMute
    end
    object cbCustom: TCheckBox
      Left = 200
      Top = 8
      Width = 105
      Height = 17
      Caption = 'Custom Volume'
      TabOrder = 3
      OnClick = OnClickCustomVolume
    end
    object ListViewVolume: TListView
      Left = 16
      Top = 16
      Width = 153
      Height = 249
      Columns = <>
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 4
      ViewStyle = vsSmallIcon
      OnSelectItem = ListViewVolumeSelectItem
    end
    object cbOnlyLimit: TCheckBox
      Left = 16
      Top = 272
      Width = 169
      Height = 17
      Caption = 'Only limit'
      TabOrder = 5
      OnClick = cbOnlyLimitClick
    end
  end
  object butClose: TButton
    Left = 246
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = butCloseClick
  end
end
