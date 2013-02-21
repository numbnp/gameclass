object frameClientInterface: TframeClientInterface
  Left = 0
  Top = 0
  Width = 445
  Height = 403
  TabOrder = 0
  object gbNotofocation: TGroupBox
    Left = 0
    Top = 109
    Width = 445
    Height = 70
    Align = alTop
    Caption = #1054#1087#1086#1074#1077#1097#1077#1085#1080#1103
    TabOrder = 1
    object lblUseTextMessage: TLabel
      Left = 207
      Top = 47
      Width = 117
      Height = 13
      Caption = #1084#1080#1085#1091#1090' '#1076#1086' '#1082#1086#1085#1094#1072' '#1089#1077#1072#1085#1089#1072
    end
    object lblBracket: TLabel
      Left = 336
      Top = 47
      Width = 3
      Height = 13
      Caption = '('
    end
    object cbxUseSounds: TCheckBox
      Left = 8
      Top = 14
      Width = 329
      Height = 13
      Caption = #1043#1086#1083#1086#1089#1086#1074#1099#1077' '#1086#1087#1086#1074#1077#1097#1077#1085#1080#1103' '#1086#1073' '#1086#1082#1086#1085#1095#1072#1085#1080#1080' '#1089#1077#1072#1085#1089#1072
      TabOrder = 0
      OnClick = cbxUseSoundsClick
    end
    object cbxUseBaloons: TCheckBox
      Left = 8
      Top = 30
      Width = 433
      Height = 13
      Caption = 
        #1042#1080#1079#1091#1072#1083#1100#1085#1086#1077' '#1086#1087#1086#1074#1077#1097#1077#1085#1080#1077' '#1074' '#1074#1080#1076#1077' '#1087#1086#1076#1089#1082#1072#1079#1082#1080' '#1080#1079' SysTray '#1079#1072' 5 '#1084#1080#1085' '#1076#1086' '#1082#1086 +
        #1085#1094#1072' '#1089#1077#1072#1085#1089#1072
      TabOrder = 1
      OnClick = cbxUseBaloonsClick
    end
    object cbxUseTextMessage: TCheckBox
      Left = 8
      Top = 46
      Width = 171
      Height = 13
      Caption = #1042#1080#1079#1091#1072#1083#1100#1085#1086#1077' '#1086#1087#1086#1074#1077#1097#1077#1085#1080#1077' '#1079#1072
      TabOrder = 2
      OnClick = cbxUseTextMessageClick
    end
    object edtUseTextMessageMin: TEdit
      Left = 174
      Top = 43
      Width = 27
      Height = 21
      TabOrder = 3
      Text = '30'
      OnChange = edtUseTextMessageMinChange
    end
    object cbxUseTextMessageBlinking: TCheckBox
      Left = 344
      Top = 46
      Width = 97
      Height = 17
      Caption = #1072#1083#1100#1090'. '#1084#1077#1090#1086#1076' )'
      TabOrder = 4
      OnClick = cbxUseTextMessageBlinkingClick
    end
  end
  object gbMessages: TGroupBox
    Left = 0
    Top = 179
    Width = 445
    Height = 138
    Align = alTop
    Caption = #1042#1085#1077#1096#1085#1080#1081' '#1074#1080#1076
    TabOrder = 0
    object lblURLTop: TLabel
      Left = 8
      Top = 62
      Width = 191
      Height = 13
      Caption = 'URL '#1074#1077#1088#1093#1085#1077#1081' '#1095#1072#1089#1090#1080' '#1082#1083#1080#1077#1085#1090#1089#1082#1086#1075#1086' '#1086#1082#1085#1072
    end
    object lblURLCompFree: TLabel
      Left = 8
      Top = 20
      Width = 191
      Height = 13
      Caption = 'URL '#1101#1082#1088#1072#1085#1072' "'#1057#1074#1086#1073#1086#1076#1085#1099#1081' '#1082#1086#1084#1087#1100#1102#1090#1077#1088'"'
    end
    object lblURLAccount: TLabel
      Left = 8
      Top = 80
      Width = 187
      Height = 13
      Caption = 'URL '#1083#1077#1074#1086#1081' '#1095#1072#1089#1090#1080' '#1074' '#1088#1077#1078#1080#1084#1077' '#1072#1082#1082#1072#1091#1085#1090#1072
    end
    object lblURLAgreement: TLabel
      Left = 8
      Top = 114
      Width = 214
      Height = 13
      Caption = 'URL '#1101#1082#1088#1072#1085#1072' "'#1057#1086#1075#1083#1072#1096#1077#1085#1080#1077' '#1089' '#1087#1086#1089#1077#1090#1080#1090#1077#1083#1077#1084'"'
    end
    object Label1: TLabel
      Left = 8
      Top = 41
      Width = 231
      Height = 13
      Caption = 'URL '#1084#1072#1083#1086#1075#1086' '#1101#1082#1088#1072#1085#1072' "'#1057#1074#1086#1073#1086#1076#1085#1099#1081' '#1082#1086#1084#1087#1100#1102#1090#1077#1088'"'
    end
    object edtURLCompFree: TEdit
      Left = 240
      Top = 12
      Width = 199
      Height = 21
      TabOrder = 0
      Text = 'comp_free.html'
      OnChange = edtURLCompFreeChange
    end
    object edtURLTop: TEdit
      Left = 240
      Top = 60
      Width = 199
      Height = 21
      MaxLength = 250
      TabOrder = 2
      Text = 'top.html'
      OnChange = edtURLTopChange
    end
    object edtURLAccount: TEdit
      Left = 240
      Top = 84
      Width = 199
      Height = 21
      TabOrder = 3
      Text = 'account.html'
      OnChange = edtURLAccountChange
    end
    object edtURLAgreement: TEdit
      Left = 240
      Top = 108
      Width = 199
      Height = 21
      TabOrder = 4
      Text = 'agreement.html'
      OnChange = edtURLAgreementChange
    end
    object cbxAgreement: TCheckBox
      Left = 8
      Top = 96
      Width = 225
      Height = 17
      Caption = #1055#1088#1077#1076#1083#1072#1075#1072#1090#1100' '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1077
      TabOrder = 5
      OnClick = cbxAgreementClick
    end
    object edtURLLogonCompFree: TEdit
      Left = 240
      Top = 36
      Width = 199
      Height = 21
      TabOrder = 1
      Text = 'logon_comp_free.html'
      OnChange = edtURLLogonCompFreeChange
    end
  end
  object gbOther: TGroupBox
    Left = 0
    Top = 0
    Width = 445
    Height = 109
    Align = alTop
    Caption = #1044#1088#1091#1075#1086#1077
    TabOrder = 2
    object cbxShowSmallInfo: TCheckBox
      Left = 8
      Top = 16
      Width = 121
      Height = 17
      Caption = #1055#1083#1072#1074#1072#1102#1097#1077#1077' '#1086#1082#1085#1086
      TabOrder = 0
      OnClick = cbxShowSmallInfoClick
    end
    object gbShutdown: TGroupBox
      Left = 8
      Top = 36
      Width = 429
      Height = 61
      TabOrder = 1
      object lblDefAction: TLabel
        Left = 4
        Top = 20
        Width = 124
        Height = 13
        Caption = #1044#1077#1081#1089#1090#1074#1080#1077' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      end
      object cbDefAction: TComboBox
        Left = 132
        Top = 16
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Text = #1053#1077#1090
        OnChange = cbDefActionChange
        Items.Strings = (
          #1053#1077#1090
          #1042#1099#1082#1083#1102#1095#1077#1085#1080#1077
          #1055#1077#1088#1077#1079#1072#1075#1088#1091#1079#1082#1072
          #1042#1099#1093#1086#1076' '#1080#1079' '#1089#1080#1089#1090#1077#1084#1099)
      end
    end
    object cbxShutdownButton: TCheckBox
      Left = 13
      Top = 33
      Width = 128
      Height = 16
      Caption = #1050#1085#1086#1087#1082#1072' '#1074#1099#1082#1083#1102#1095#1077#1085#1080#1103
      TabOrder = 2
      OnClick = cbxShutdownButtonClick
    end
    object cbxFullScreenMainWindow: TCheckBox
      Left = 140
      Top = 16
      Width = 145
      Height = 17
      Caption = 'Full screen main window'
      TabOrder = 3
      OnClick = cbxShowSmallInfoClick
    end
  end
end
