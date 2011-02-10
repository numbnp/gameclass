object frameSound: TframeSound
  Left = 0
  Top = 0
  Width = 451
  Height = 411
  TabOrder = 0
  object gbSounds: TGroupBox
    Left = 0
    Top = 0
    Width = 451
    Height = 89
    Align = alTop
    Caption = #1048#1079#1076#1072#1074#1072#1090#1100' '#1079#1074#1091#1082#1086#1074#1086#1081' '#1089#1080#1075#1085#1072#1083' ...'
    TabOrder = 0
    object cbSoundNegativeBalance: TCheckBox
      Left = 8
      Top = 32
      Width = 353
      Height = 18
      Caption = #1077#1089#1083#1080' '#1089#1077#1072#1085#1089' '#1079#1072#1074#1077#1088#1096#1077#1085' '#1089' '#1086#1090#1088#1080#1094#1072#1090#1077#1083#1100#1085#1099#1084' '#1073#1072#1083#1072#1085#1089#1086#1084
      TabOrder = 0
      OnClick = cbSoundNegativeBalanceClick
    end
    object cbSoundLostLink: TCheckBox
      Left = 8
      Top = 50
      Width = 353
      Height = 17
      Caption = #1077#1089#1083#1080' '#1087#1086#1090#1077#1088#1103#1085#1072' '#1089#1074#1103#1079#1100' '#1089' '#1082#1083#1080#1077#1085#1090#1089#1082#1080#1084' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1086#1084
      TabOrder = 1
      OnClick = cbSoundLostLinkClick
    end
    object cbxSoundGuestSession: TCheckBox
      Left = 8
      Top = 66
      Width = 353
      Height = 17
      Caption = #1087#1088#1080' '#1079#1072#1087#1091#1089#1082#1077' '#1089#1077#1072#1085#1089#1072' '#1082#1085#1086#1087#1082#1086#1081' "'#1043#1086#1089#1090#1100'"'
      TabOrder = 2
      OnClick = cbxSoundGuestSessionClick
    end
  end
  object gbAction: TGroupBox
    Left = 0
    Top = 89
    Width = 451
    Height = 40
    Align = alTop
    Caption = #1042#1099#1087#1086#1083#1085#1103#1090#1100' ...'
    TabOrder = 1
    object cbSwitchToGC3Win: TCheckBox
      Left = 8
      Top = 16
      Width = 353
      Height = 17
      Caption = #1087#1077#1088#1077#1082#1083#1102#1095#1077#1085#1080#1077' '#1085#1072' '#1086#1082#1085#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1087#1088#1080' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1080' '#1089#1077#1072#1085#1089#1086#1074
      TabOrder = 0
      OnClick = cbSwitchToGC3WinClick
    end
  end
  object cbSoundEndSession: TCheckBox
    Left = 8
    Top = 14
    Width = 353
    Height = 18
    Caption = #1077#1089#1083#1080' '#1089#1077#1072#1085#1089' '#1079#1072#1074#1077#1088#1096#1077#1085' '#1089' '#1086#1090#1088#1080#1094#1072#1090#1077#1083#1100#1085#1099#1084' '#1073#1072#1083#1072#1085#1089#1086#1084
    TabOrder = 2
    OnClick = cbSoundEndSessionClick
  end
end
