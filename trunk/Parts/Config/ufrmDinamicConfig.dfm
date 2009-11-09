object frmDinamicConfig: TfrmDinamicConfig
  Left = 344
  Top = 248
  BorderStyle = bsNone
  ClientHeight = 262
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lstParameters: TValueListEditor
    Left = 0
    Top = 0
    Width = 360
    Height = 202
    Align = alClient
    TabOrder = 0
    TitleCaptions.Strings = (
      #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
      #1047#1085#1072#1095#1077#1085#1080#1077)
    OnClick = lstParametersClick
    OnKeyPress = lstParametersKeyPress
    OnValidate = lstParametersValidate
    ColWidths = (
      247
      107)
  end
  object memoInfo: TMemo
    Left = 0
    Top = 202
    Width = 360
    Height = 60
    Align = alBottom
    TabOrder = 1
  end
end
