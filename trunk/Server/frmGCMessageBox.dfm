object formGCMessageBox: TformGCMessageBox
  Left = 663
  Top = 399
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'formGCMessageBoxCaption'
  ClientHeight = 206
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object memoInfo: TMemo
    Left = 9
    Top = 28
    Width = 304
    Height = 126
    TabStop = False
    Align = alClient
    Lines.Strings = (
      'memoInfo')
    ReadOnly = True
    TabOrder = 1
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 322
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblReadThis: TLabel
      Left = 8
      Top = 10
      Width = 183
      Height = 13
      Caption = #1055#1086#1078#1072#1083#1091#1081#1089#1090#1072', '#1087#1088#1086#1095#1090#1080#1090#1077' '#1074#1085#1080#1084#1072#1090#1077#1083#1100#1085#1086
    end
  end
  object pnBottomOk: TPanel
    Left = 0
    Top = 171
    Width = 322
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    OnResize = pnBottomOkResize
    object butOk: TButton
      Left = 124
      Top = 4
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = butOkClick
    end
  end
  object pnBottomDontShow: TPanel
    Left = 0
    Top = 158
    Width = 322
    Height = 13
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object cbNotShowAgain: TCheckBox
      Left = 8
      Top = 0
      Width = 305
      Height = 13
      Caption = #1041#1086#1083#1100#1096#1077' '#1085#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1101#1090#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
      TabOrder = 0
    end
  end
  object pnLeft: TPanel
    Left = 0
    Top = 28
    Width = 9
    Height = 126
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 4
  end
  object pnRight: TPanel
    Left = 313
    Top = 28
    Width = 9
    Height = 126
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 5
  end
  object pnBottomSpace: TPanel
    Left = 0
    Top = 154
    Width = 322
    Height = 4
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
  end
end
