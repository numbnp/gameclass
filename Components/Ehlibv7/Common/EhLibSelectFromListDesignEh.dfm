object SelectFromListDesignForm: TSelectFromListDesignForm
  Left = 0
  Top = 0
  Width = 423
  Height = 448
  BorderIcons = [biMaximize]
  Caption = 'SelectFromListDesignForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    407
    410)
  PixelsPerInch = 96
  TextHeight = 13
  object lDescription: TLabel
    Left = 16
    Top = 16
    Width = 371
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'lDescription'
    WordWrap = True
  end
  object ListBox1: TListBox
    Left = 16
    Top = 80
    Width = 379
    Height = 282
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object bOk: TButton
    Left = 226
    Top = 377
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'bOk'
    ModalResult = 1
    TabOrder = 1
  end
  object bCancel: TButton
    Left = 307
    Top = 377
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'bCancel'
    ModalResult = 2
    TabOrder = 2
  end
end
