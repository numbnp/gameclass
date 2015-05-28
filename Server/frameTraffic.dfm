object frameTraffic: TframeTraffic
  Left = 0
  Top = 0
  Width = 449
  Height = 409
  TabOrder = 0
  object gbWindows: TGroupBox
    Left = 0
    Top = 0
    Width = 449
    Height = 226
    Align = alTop
    Caption = #1051#1080#1094#1077#1085#1079#1080#1086#1085#1085#1099#1081' '#1082#1083#1102#1095' '#1086#1073#1085#1072#1088#1091#1078#1077#1085'. '#1056#1072#1073#1086#1090#1072' '#1084#1086#1076#1091#1083#1103' '#1074#1086#1079#1084#1086#1078#1085#1072'.'
    TabOrder = 0
    object gbOuterPlugin: TGroupBox
      Left = 2
      Top = 18
      Width = 449
      Height = 71
      Align = alCustom
      Caption = 'gbOuterPlugin'
      TabOrder = 3
      object cbOuterPluginSetLimit: TCheckBox
        Left = 8
        Top = 14
        Width = 233
        Height = 17
        Caption = #1054#1075#1088#1072#1085#1080#1095#1080#1074#1072#1090#1100' '#1076#1086#1089#1090#1091#1087#1085#1099#1081' '#1090#1088#1072#1092#1080#1082
        TabOrder = 0
        OnClick = cbOuterPluginSetLimitClick
      end
      object cbOuterPluginSetSpeed: TCheckBox
        Left = 8
        Top = 30
        Width = 145
        Height = 17
        Caption = #1054#1075#1088#1072#1085#1080#1095#1080#1074#1072#1090#1100' '#1089#1082#1086#1088#1086#1089#1090#1100
        TabOrder = 1
        OnClick = cbOuterPluginSetSpeedClick
      end
      object cbOuterPluginSetGroup: TCheckBox
        Left = 8
        Top = 46
        Width = 145
        Height = 17
        Caption = #1059#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
        TabOrder = 2
        OnClick = cbOuterPluginSetGroupClick
      end
    end
    object gbTCPMappings: TGroupBox
      Left = 2
      Top = 34
      Width = 449
      Height = 190
      Align = alCustom
      Caption = '                                            '
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 2
      object lblReadyMappings: TLabel
        Left = 8
        Top = 14
        Width = 147
        Height = 13
        Caption = #1053#1072#1089#1090#1088#1086#1077#1085#1085#1099#1077' TCP - '#1084#1072#1087#1087#1080#1085#1075#1080
      end
      object lvMappings: TListView
        Left = 8
        Top = 29
        Width = 239
        Height = 121
        Columns = <
          item
            Caption = 'id'
            Width = 0
          end
          item
            Caption = 'Listen Port'
            Width = 62
          end
          item
            Caption = 'Proxy IP'
            Width = 111
          end
          item
            Caption = 'Proxy Port'
            Width = 62
          end>
        GridLines = True
        HideSelection = False
        Items.ItemData = {
          05630000000100000000000000FFFFFFFFFFFFFFFF03000000FFFFFFFF000000
          000135000536003500350035003500000000000F3200350035002E0032003500
          35002E003200350035002E003200350035000000000005360035003500330035
          0000000000FFFFFFFFFFFF}
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = lvMappingsClick
      end
      object butAddMapping: TButton
        Left = 104
        Top = 156
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 1
        OnClick = butAddMappingClick
      end
      object butDeleteMapping: TButton
        Left = 240
        Top = 157
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 2
        OnClick = butDeleteMappingClick
      end
      object gbClientSettings: TGroupBox
        Left = 256
        Top = 21
        Width = 185
        Height = 62
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1088#1086#1075#1088#1072#1084#1084' '#1082#1083#1080#1077#1085#1090#1072
        TabOrder = 3
        object lblListenPort: TLabel
          Left = 129
          Top = 14
          Width = 51
          Height = 13
          Caption = 'Listen Port'
        end
        object Label5: TLabel
          Left = 111
          Top = 33
          Width = 4
          Height = 13
          Caption = ':'
        end
        object lblClientIP: TLabel
          Left = 12
          Top = 33
          Width = 84
          Height = 13
          Caption = '255.255.255.255'
        end
        object editListenPort: TEdit
          Left = 126
          Top = 30
          Width = 49
          Height = 21
          TabOrder = 0
          OnChange = editListenPortChange
        end
      end
      object gbProxyServer: TGroupBox
        Left = 256
        Top = 84
        Width = 185
        Height = 62
        Caption = 'Proxy Server'
        TabOrder = 4
        object lblProxyIP: TLabel
          Left = 30
          Top = 14
          Width = 41
          Height = 13
          Caption = 'Proxy IP'
        end
        object lblPort: TLabel
          Left = 132
          Top = 14
          Width = 20
          Height = 13
          Caption = 'Port'
        end
        object Label6: TLabel
          Left = 111
          Top = 33
          Width = 4
          Height = 13
          Caption = ':'
        end
        object editMappedIP: TEdit
          Left = 8
          Top = 30
          Width = 92
          Height = 21
          TabOrder = 0
          Text = '255.255.255.255'
          OnChange = editMappedIPChange
        end
        object editMappedPort: TEdit
          Left = 126
          Top = 30
          Width = 49
          Height = 21
          TabOrder = 1
          OnChange = editMappedPortChange
        end
      end
    end
    object cbActiveOuterPlugIn: TCheckBox
      Left = 8
      Top = 14
      Width = 333
      Height = 17
      Caption = #1040#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1076#1089#1095#1077#1090'/'#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1088#1072#1092#1080#1082#1072' '#1095#1077#1088#1077#1079' Plug-in'
      TabOrder = 0
      OnClick = cbActiveOuterPlugInClick
    end
    object cbActiveInnerProxy: TCheckBox
      Left = 8
      Top = 30
      Width = 401
      Height = 17
      Caption = 
        #1040#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1076#1089#1095#1077#1090'/'#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1088#1072#1092#1080#1082#1072' '#1095#1077#1088#1077#1079' '#1074#1089#1090#1088#1086#1077#1085#1085#1099#1081' '#1087#1088#1086#1082#1089 +
        #1080
      TabOrder = 1
      OnClick = cbActiveInnerProxyClick
    end
  end
  object gbUnixFree: TGroupBox
    Left = 0
    Top = 226
    Width = 449
    Height = 36
    Align = alTop
    Caption = #1056#1072#1073#1086#1090#1072' '#1084#1086#1076#1091#1083#1103' '#1074#1086#1079#1084#1086#1078#1085#1072
    TabOrder = 1
    object cbActiveLinuxFree: TCheckBox
      Left = 8
      Top = 14
      Width = 369
      Height = 17
      Caption = #1040#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1088#1072#1092#1080#1082#1072' '#1085#1072' UNIX-'#1089#1077#1088#1074#1077#1088#1077
      TabOrder = 0
      OnClick = cbActiveLinuxFreeClick
    end
  end
  object gbUnixPro: TGroupBox
    Left = 0
    Top = 262
    Width = 449
    Height = 36
    Align = alTop
    Caption = #1051#1080#1094#1077#1085#1079#1080#1086#1085#1085#1099#1081' '#1082#1083#1102#1095' '#1086#1073#1085#1072#1088#1091#1078#1077#1085'. '#1056#1072#1073#1086#1090#1072' '#1084#1086#1076#1091#1083#1103' '#1074#1086#1079#1084#1086#1078#1085#1072'.'
    TabOrder = 2
    object cbActiveLinuxPro: TCheckBox
      Left = 8
      Top = 14
      Width = 369
      Height = 17
      Caption = #1040#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1076#1089#1095#1077#1090'/'#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1088#1072#1092#1080#1082#1072' '#1085#1072' UNIX-'#1089#1077#1088#1074#1077#1088#1077
      TabOrder = 0
      OnClick = cbActiveLinuxProClick
    end
  end
  object gbModuleSettings: TGroupBox
    Left = 0
    Top = 298
    Width = 449
    Height = 44
    Align = alTop
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1084#1086#1076#1091#1083#1103' '#1082#1086#1085#1090#1088#1086#1083#1103' '#1090#1088#1072#1092#1080#1082#1072
    TabOrder = 3
    object lblIPAddress: TLabel
      Left = 8
      Top = 19
      Width = 44
      Height = 13
      Caption = 'IP-'#1072#1076#1088#1077#1089
    end
    object lblFrequency: TLabel
      Left = 160
      Top = 19
      Width = 80
      Height = 13
      Caption = #1063#1072#1089#1090#1086#1090#1072' '#1086#1087#1088#1086#1089#1072
    end
    object lblSec: TLabel
      Left = 288
      Top = 19
      Width = 17
      Height = 13
      Caption = #1089#1077#1082
    end
    object edtIPAddress: TEdit
      Left = 64
      Top = 16
      Width = 81
      Height = 21
      TabOrder = 0
      Text = '127.0.0.1'
      OnChange = edtIPAddressChange
    end
    object edtFrequency: TEdit
      Left = 248
      Top = 16
      Width = 33
      Height = 21
      TabOrder = 1
      Text = '5'
      OnChange = edtFrequencyChange
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 342
    Width = 449
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object gbTariffing: TGroupBox
      Left = 0
      Top = 0
      Width = 449
      Height = 67
      Align = alClient
      Caption = #1057#1087#1086#1089#1086#1073' '#1090#1072#1088#1080#1092#1080#1082#1072#1094#1080#1080' '#1090#1088#1072#1092#1080#1082#1072
      TabOrder = 0
      object rbtnTariffingOnlyIbound: TRadioButton
        Left = 8
        Top = 14
        Width = 169
        Height = 17
        Caption = #1058#1086#1083#1100#1082#1086' '#1074#1093#1086#1076#1103#1097#1080#1081
        TabOrder = 0
        OnClick = rbtnTariffingModeClick
      end
      object rbtnTariffingSummary: TRadioButton
        Left = 8
        Top = 30
        Width = 193
        Height = 17
        Caption = #1057#1091#1084#1084#1072' '#1074#1093#1086#1076#1103#1097#1077#1075#1086' '#1080' '#1080#1089#1093#1086#1076#1103#1097#1077#1075#1086
        TabOrder = 1
        OnClick = rbtnTariffingModeClick
      end
      object rbtnTariffingMaximum: TRadioButton
        Left = 8
        Top = 46
        Width = 161
        Height = 17
        Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
        TabOrder = 2
        OnClick = rbtnTariffingModeClick
      end
    end
  end
end
