object framCustomers: TframCustomers
  Left = 0
  Top = 0
  Width = 449
  Height = 409
  TabOrder = 0
  object gbOptions: TGroupBox
    Left = 0
    Top = 4
    Width = 449
    Height = 305
    Align = alTop
    Caption = 
      '                                                                ' +
      '                        '
    TabOrder = 0
    object gbBalanceOptions: TGroupBox
      Left = 2
      Top = 189
      Width = 445
      Height = 71
      Align = alTop
      Caption = #1055#1086#1087#1086#1083#1085#1077#1085#1080#1077' '#1089#1095#1077#1090#1072
      TabOrder = 1
      object lblMinAddedSumma: TLabel
        Left = 8
        Top = 17
        Width = 165
        Height = 13
        Caption = #1052#1080#1085#1080#1084'.'#1089#1091#1084#1084#1072' '#1087#1086#1087#1086#1083#1085#1077#1085#1080#1103' '#1089#1095#1077#1090#1072
      end
      object lblWarningAddedSumma: TLabel
        Left = 8
        Top = 43
        Width = 161
        Height = 13
        Caption = #1057#1091#1084#1084#1072' '#1079#1072#1087#1088#1086#1089#1072' '#1087#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1103
      end
      object editWarningAddedSumma: TEdit
        Left = 192
        Top = 40
        Width = 89
        Height = 21
        TabOrder = 0
        OnChange = editWarningAddedSummaChange
      end
      object editMinAddedSumma: TEdit
        Left = 192
        Top = 14
        Width = 89
        Height = 21
        TabOrder = 1
        Text = '34234'
        OnChange = editMinAddedSummaChange
      end
    end
    object pnlOptions: TPanel
      Left = 2
      Top = 15
      Width = 445
      Height = 174
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblSec1: TLabel
        Left = 250
        Top = 72
        Width = 18
        Height = 13
        Caption = #1089#1077#1082
      end
      object lblUserLevel: TLabel
        Left = 269
        Top = 115
        Width = 90
        Height = 13
        Caption = #1059#1088#1086#1074#1077#1085#1100' '#1076#1086#1089#1090#1091#1087#1072':'
      end
      object lblMin1: TLabel
        Left = 294
        Top = 139
        Width = 20
        Height = 13
        Caption = #1084#1080#1085
      end
      object cbxAutoLogoff: TCheckBox
        Left = 8
        Top = 71
        Width = 209
        Height = 17
        Caption = #1040#1074#1090#1086#1083#1086#1075#1086#1092#1092' '#1087#1088#1080' '#1086#1090#1089#1091#1090#1089#1090#1074#1080#1080' '#1079#1072#1082#1072#1079#1072
        TabOrder = 3
        OnClick = cbxAutoLogoffClick
      end
      object cbAutoBlockComp: TCheckBox
        Left = 8
        Top = 0
        Width = 361
        Height = 17
        Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1082#1086#1084#1087#1100#1102#1090#1077#1088' '#1087#1088#1080' '#1086#1096#1080#1073#1086#1095#1085#1086#1081' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080' > 2 '#1088#1072#1079
        TabOrder = 0
        OnClick = cbAutoBlockCompClick
      end
      object cbSecCodes: TCheckBox
        Left = 8
        Top = 17
        Width = 361
        Height = 17
        Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1082#1086#1076#1099' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080
        TabOrder = 1
        OnClick = cbSecCodesClick
      end
      object cbAlwaysAllowAuthentication: TCheckBox
        Left = 8
        Top = 34
        Width = 313
        Height = 17
        Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1086#1089#1090#1086#1103#1085#1085#1091#1102' '#1072#1091#1090#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1102
        TabOrder = 2
        OnClick = cbAlwaysAllowAuthenticationClick
      end
      object cbxBlockDisplayByStandby: TCheckBox
        Left = 8
        Top = 92
        Width = 345
        Height = 16
        Caption = #1042#1099#1082#1083#1102#1095#1072#1090#1100' '#1084#1086#1085#1080#1090#1086#1088' '#1074' '#1089#1086#1089#1090#1086#1103#1085#1080#1080' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080' '#1087#1088#1080' '#1087#1088#1086#1089#1090#1086#1077
        TabOrder = 5
        OnClick = cbxBlockDisplayByStandbyClick
      end
      object edtAutoLogoffSec: TEdit
        Left = 219
        Top = 69
        Width = 26
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Text = '10'
        OnChange = edtAutoLogoffSecChange
      end
      object cbAuthenticationIfReserved: TCheckBox
        Left = 8
        Top = 52
        Width = 361
        Height = 17
        Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1072#1091#1090#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1102' '#1076#1083#1103' '#1079#1072#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1086#1074
        TabOrder = 6
        OnClick = cbAuthenticationIfReservedClick
      end
      object cbTarifsLimit: TDBCheckBoxEh
        Left = 8
        Top = 109
        Width = 213
        Height = 25
        Caption = #1054#1075#1088#1072#1085#1080#1095#1080#1090#1100' '#1085#1086#1074#1099#1093' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
        State = cbGrayed
        TabOrder = 7
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = cbTarifsLimitClick
      end
      object cbUserLevel: TComboBox
        Left = 365
        Top = 112
        Width = 73
        Height = 21
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 8
        Text = '1'
        OnChange = cbUserLevelChange
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cbBlockAfterTime: TCheckBox
        Left = 8
        Top = 137
        Width = 257
        Height = 16
        Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1072#1082#1082#1072#1091#1085#1090' '#1087#1088#1080' '#1085#1077#1072#1082#1090#1080#1074#1085#1086#1089#1090#1080' '#1095#1077#1088#1077#1079
        TabOrder = 9
        OnClick = cbBlockAfterTimeClick
      end
    end
    object cbActive: TCheckBox
      Left = 8
      Top = -2
      Width = 265
      Height = 17
      Caption = #1040#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1073#1072#1079#1091' '#1091#1095#1077#1090#1085#1099#1093' '#1079#1072#1087#1080#1089#1077#1081' '#1082#1083#1080#1077#1085#1090#1086#1074
      TabOrder = 3
      OnClick = cbActiveClick
    end
    object pnlCheckAccounts: TGroupBox
      Left = 2
      Top = 260
      Width = 445
      Height = 39
      Align = alTop
      Caption = 
        '                                                                ' +
        '                                   '
      TabOrder = 2
      object lblDays: TLabel
        Left = 216
        Top = 16
        Width = 32
        Height = 13
        Caption = #1076#1085#1103#1084#1080
      end
      object cbxUseCheckAccounts: TCheckBox
        Left = 8
        Top = -2
        Width = 297
        Height = 17
        Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1091#1095#1077#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080' '#1076#1083#1103' '#1088#1072#1073#1086#1090#1099' '#1089' '#1095#1077#1082#1072#1084#1080
        TabOrder = 0
        OnClick = cbxUseCheckAccountsClick
      end
      object cbxUsePeriodOfValidity: TCheckBox
        Left = 8
        Top = 16
        Width = 177
        Height = 17
        Caption = #1054#1075#1088#1072#1085#1080#1095#1080#1074#1072#1090#1100' '#1089#1088#1086#1082' '#1076#1077#1081#1089#1090#1074#1080#1103' '
        TabOrder = 1
        OnClick = cbxUsePeriodOfValidityClick
      end
      object edtPeriodOfValidityInDays: TEdit
        Left = 184
        Top = 14
        Width = 25
        Height = 21
        TabOrder = 2
        Text = '888'
        OnChange = edtPeriodOfValidityInDaysChange
      end
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 309
    Width = 449
    Height = 100
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object butGoAccounts: TButton
      Left = 158
      Top = 5
      Width = 115
      Height = 25
      Caption = #1059#1095#1077#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080
      TabOrder = 0
      OnClick = butGoAccountsClick
    end
  end
  object panelTop: TPanel
    Left = 0
    Top = 0
    Width = 449
    Height = 4
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
  end
  object editBlockAfterTimeSec: TEdit
    Left = 267
    Top = 155
    Width = 26
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = '10'
    OnChange = editBlockAfterTimeSecChange
  end
end
