object SelectComponentListFormEh: TSelectComponentListFormEh
  Left = 340
  Top = 226
  Caption = 'Select favorite components'
  ClientHeight = 396
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    348
    396)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 124
    Height = 13
    Caption = 'Register classes of ... type'
  end
  object Bevel1: TBevel
    Left = 9
    Top = 354
    Width = 328
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  object bOk: TButton
    Left = 184
    Top = 363
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object bCancel: TButton
    Left = 264
    Top = 363
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object clbComponentList: TCheckListBox
    Left = 8
    Top = 24
    Width = 329
    Height = 324
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    Items.Strings = (
      'ssss'
      'dddddd'
      'ffffff')
    TabOrder = 2
  end
end
