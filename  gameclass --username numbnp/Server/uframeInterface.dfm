object frameInterface: TframeInterface
  Left = 0
  Top = 0
  Width = 445
  Height = 407
  TabOrder = 0
  object gbCommon: TGroupBox
    Left = 0
    Top = 0
    Width = 445
    Height = 57
    Align = alTop
    Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072
    TabOrder = 0
    object cbxActivateMessageTab: TCheckBox
      Left = 8
      Top = 32
      Width = 401
      Height = 17
      Caption = #1040#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1082#1083#1072#1076#1082#1091' "'#1057#1086#1086#1073#1097#1077#1085#1080#1103'" '#1087#1088#1080' '#1087#1086#1083#1091#1095#1077#1085#1080#1080' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      TabOrder = 0
      OnClick = cbxActivateMessageTabClick
    end
    object cbxDontHideIntoSysTray: TCheckBox
      Left = 8
      Top = 16
      Width = 361
      Height = 17
      Caption = #1053#1077' '#1089#1082#1088#1099#1074#1072#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1091' '#1074' SysTray'
      TabOrder = 1
      OnClick = cbxDontHideIntoSysTrayClick
    end
  end
  object gbStartSession: TGroupBox
    Left = 0
    Top = 57
    Width = 445
    Height = 56
    Align = alTop
    Caption = #1047#1072#1087#1091#1089#1082' '#1089#1077#1072#1085#1089#1072
    TabOrder = 1
    object cbxHideSessionChartWithoutReserve: TCheckBox
      Left = 8
      Top = 32
      Width = 401
      Height = 17
      Caption = #1042#1080#1079#1091#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1089#1077#1072#1085#1089#1099' '#1090#1086#1083#1100#1082#1086' '#1087#1088#1080' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1080
      TabOrder = 0
      OnClick = cbxHideSessionChartWithoutReserveClick
    end
    object cbxMultiActionsLimitedControl: TCheckBox
      Left = 8
      Top = 16
      Width = 361
      Height = 17
      Caption = #1043#1088#1091#1087#1087#1086#1074#1099#1077' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1090#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1086#1076#1080#1085#1072#1082#1086#1074#1099#1093' '#1089#1077#1072#1085#1089#1086#1074
      TabOrder = 1
      OnClick = cbxMultiActionsLimitedControlClick
    end
  end
end
