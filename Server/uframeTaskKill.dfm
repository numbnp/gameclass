object frameTaskKill: TframeTaskKill
  Left = 0
  Top = 0
  Width = 445
  Height = 407
  TabOrder = 0
  object gbCommon: TGroupBox
    Left = 0
    Top = 0
    Width = 445
    Height = 89
    Align = alTop
    Caption = #1056#1077#1078#1080#1084' '#1089#1085#1103#1090#1080#1103' '#1079#1072#1076#1072#1095
    TabOrder = 0
    object rbtnInclude: TRadioButton
      Left = 8
      Top = 16
      Width = 417
      Height = 17
      Caption = #1047#1072#1074#1077#1088#1096#1072#1090#1100' '#1087#1088#1086#1094#1077#1089#1089#1099', '#1087#1077#1088#1077#1095#1080#1089#1083#1077#1085#1085#1099#1077' '#1074' '#1089#1087#1080#1089#1082#1077
      TabOrder = 0
      OnClick = rbtnIncludeClick
    end
    object rbtnExclude: TRadioButton
      Left = 8
      Top = 32
      Width = 417
      Height = 17
      Caption = #1047#1072#1074#1077#1088#1096#1072#1090#1100' '#1074#1089#1077' '#1087#1088#1086#1094#1077#1089#1089#1099', '#1082#1088#1086#1084#1077' '#1087#1077#1088#1077#1095#1080#1089#1083#1077#1085#1085#1099#1093' '#1074' '#1089#1087#1080#1089#1082#1077
      TabOrder = 1
      OnClick = rbtnIncludeClick
    end
    object rbtnRunPad: TRadioButton
      Left = 8
      Top = 48
      Width = 417
      Height = 17
      Caption = #1057#1085#1080#1084#1072#1090#1100' '#1079#1072#1076#1072#1095#1080' '#1087#1088#1080' '#1087#1086#1084#1086#1097#1080' RunPad Shell'
      TabOrder = 2
      OnClick = rbtnIncludeClick
    end
    object rbtnNothing: TRadioButton
      Left = 8
      Top = 64
      Width = 417
      Height = 17
      Caption = #1053#1077' '#1089#1085#1080#1084#1072#1090#1100' '#1079#1072#1076#1072#1095#1080', '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1074#1099#1079#1099#1074' '#1074#1085#1077#1096#1085#1077#1075#1086' '#1089#1082#1088#1080#1087#1090#1072
      TabOrder = 3
      OnClick = rbtnIncludeClick
    end
  end
  object pnlTemplate: TGroupBox
    Left = 0
    Top = 89
    Width = 445
    Height = 318
    Align = alClient
    Caption = #1057#1087#1080#1089#1086#1082' '#1079#1072#1076#1072#1095
    TabOrder = 1
    object pnlTaskList: TPanel
      Left = 2
      Top = 15
      Width = 441
      Height = 301
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
end
