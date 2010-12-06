object formAddKey: TformAddKey
  Left = 409
  Top = 302
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'formAddKey'
  ClientHeight = 170
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblEnterKey: TLabel
    Left = 12
    Top = 15
    Width = 53
    Height = 13
    Caption = 'lblEnterKey'
  end
  object butOk: TButton
    Left = 115
    Top = 136
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = butOkClick
  end
  object butCancel: TButton
    Left = 197
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object memoKey: TMemo
    Left = 11
    Top = 32
    Width = 262
    Height = 97
    Lines.Strings = (
      'difshduifhiusdhfihrkewhfkjewrhkfhjkrewhfjkhwerjkfhekj'
      'rhfjkerhjkfhejkrhfjkherkfhekrfhsadkfhksadhfkrhkehfker'
      'hjkfherkjhfiuehfiherif')
    TabOrder = 0
    WantReturns = False
  end
end
