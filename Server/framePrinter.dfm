object framePrinter: TframePrinter
  Left = 0
  Top = 0
  Width = 449
  Height = 409
  TabOrder = 0
  object gbOptions: TGroupBox
    Left = 0
    Top = 73
    Width = 449
    Height = 336
    Align = alClient
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 0
    object lblCost: TLabel
      Left = 16
      Top = 40
      Width = 106
      Height = 13
      Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1089#1090#1088#1072#1085#1080#1094#1099
    end
    object lblCurrency: TLabel
      Left = 128
      Top = 62
      Width = 54
      Height = 13
      Caption = 'lblCurrency'
    end
    object editCost: TEdit
      Left = 16
      Top = 56
      Width = 107
      Height = 21
      TabOrder = 0
      OnChange = editCostChange
    end
    object cbxUsePMCosts: TCheckBox
      Left = 16
      Top = 88
      Width = 249
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1094#1077#1085#1099' PrintMonitor'
      TabOrder = 1
      OnClick = cbxUsePMCostsClick
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 449
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object cbActive: TCheckBox
      Left = 0
      Top = 6
      Width = 353
      Height = 17
      Caption = #1040#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1082#1086#1085#1090#1088#1086#1083#1100' '#1087#1088#1080#1085#1090#1077#1088#1072
      TabOrder = 0
      OnClick = cbActiveClick
    end
    object memoActiveInfo: TMemo
      Left = 0
      Top = 27
      Width = 452
      Height = 41
      ReadOnly = True
      TabOrder = 1
    end
  end
end
