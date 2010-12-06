object frmOptions: TfrmOptions
  Left = 306
  Top = 164
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 452
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    554
    452)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TButton
    Left = 394
    Top = 422
    Width = 75
    Height = 25
    Action = actOk
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 0
  end
  object btnApply: TButton
    Left = 313
    Top = 422
    Width = 75
    Height = 25
    Action = actApply
    Anchors = [akRight, akBottom]
    TabOrder = 1
  end
  object btnDefault: TButton
    Left = 8
    Top = 422
    Width = 81
    Height = 25
    Action = actDefault
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object tvNavigator: TVirtualStringTree
    Left = 7
    Top = 7
    Width = 154
    Height = 408
    Cursor = crHandPoint
    Anchors = [akLeft, akTop, akBottom]
    BevelKind = bkFlat
    BorderStyle = bsNone
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = -1
    Header.Options = [hoColumnResize, hoDrag]
    TabOrder = 3
    OnClick = tvNavigatorClick
    OnGetText = tvNavigatorGetText
    OnKeyDown = tvNavigatorKeyDown
    Columns = <>
  end
  object pnlMain: TPanel
    Left = 168
    Top = 7
    Width = 380
    Height = 408
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
  end
  object btnCancel: TButton
    Left = 472
    Top = 422
    Width = 75
    Height = 25
    Action = actCancel
    Anchors = [akRight, akBottom]
    Cancel = True
    TabOrder = 5
  end
  object actlstOptions: TActionList
    Left = 504
    Top = 15
    object actApply: TAction
      Caption = 'Apply'
      OnExecute = actApplyExecute
    end
    object actOk: TAction
      Caption = 'Close'
      OnExecute = actOkExecute
    end
    object actDefault: TAction
      Caption = 'Default'
      OnExecute = actDefaultExecute
    end
    object actCancel: TAction
      Caption = 'Cancel'
      ShortCut = 27
      OnExecute = actCancelExecute
    end
  end
end
