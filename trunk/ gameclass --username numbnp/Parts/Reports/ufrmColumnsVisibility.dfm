object frmColumnsVisibility: TfrmColumnsVisibility
  Left = 322
  Top = 182
  BorderStyle = bsDialog
  Caption = 'Columns Visibility'
  ClientHeight = 300
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    400
    300)
  PixelsPerInch = 96
  TextHeight = 13
  object imgMain: TImage
    Left = 8
    Top = 8
    Width = 121
    Height = 252
    Anchors = [akLeft, akTop, akBottom]
  end
  object lblColumns: TLabel
    Left = 136
    Top = 8
    Width = 43
    Height = 13
    Caption = 'Columns:'
  end
  object lbxColumns: TCheckListBox
    Left = 136
    Top = 24
    Width = 257
    Height = 237
    OnClickCheck = lbxColumnsClickCheck
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    Style = lbOwnerDrawFixed
    TabOrder = 0
  end
  object btnClose: TButton
    Left = 320
    Top = 269
    Width = 75
    Height = 25
    Action = actClose
    Anchors = [akRight, akBottom]
    TabOrder = 1
  end
  object btnApply: TButton
    Left = 240
    Top = 269
    Width = 75
    Height = 25
    Action = actApply
    Anchors = [akRight, akBottom]
    TabOrder = 2
  end
  object actlstColumnsVisibility: TActionList
    OnUpdate = actlstColumnsVisibilityUpdate
    Left = 360
    Top = 8
    object actApply: TAction
      Caption = 'Apply'
      OnExecute = actApplyExecute
    end
    object actClose: TAction
      Caption = 'Close'
      ShortCut = 27
      OnExecute = actCloseExecute
    end
  end
end
