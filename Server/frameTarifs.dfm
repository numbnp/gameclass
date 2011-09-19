object framTarifs: TframTarifs
  Left = 0
  Top = 0
  Width = 576
  Height = 538
  TabOrder = 0
  object lblComputerGroup: TLabel
    Left = 8
    Top = 6
    Width = 80
    Height = 13
    Caption = 'Computers group'
  end
  object cbCalcTraffic: TCheckBox
    Left = 88
    Top = 5
    Width = 33
    Height = 17
    Caption = 'Calc traffic'
    TabOrder = 1
    Visible = False
    OnClick = cbInternetClick
  end
  object lvTarifs: TListView
    Left = 8
    Top = 48
    Width = 129
    Height = 233
    Columns = <
      item
        Caption = 'Tarif'
        Width = 125
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lvTarifsClick
  end
  object cbComputerGroup: TComboBox
    Left = 8
    Top = 22
    Width = 129
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    OnSelect = cbComputerGroupSelect
  end
  object pgctrlDetails: TPageControl
    Left = 0
    Top = 288
    Width = 453
    Height = 241
    ActivePage = tabTarifSelected
    Style = tsFlatButtons
    TabOrder = 3
    object tabNoTarif: TTabSheet
      Caption = 'tabNoTarif'
      TabVisible = False
      object panelFuck: TPanel
        Left = 0
        Top = 0
        Width = 445
        Height = 231
        Align = alClient
        Caption = '.......'
        TabOrder = 0
      end
    end
    object tabTarifSelected: TTabSheet
      Caption = 'tabTarifSelected'
      ImageIndex = 1
      TabVisible = False
      object gbTarifVariants: TGroupBox
        Left = 0
        Top = 0
        Width = 445
        Height = 231
        Align = alClient
        Caption = #1058#1072#1088#1080#1092#1085#1072#1103' '#1089#1077#1090#1082#1072' '#1087#1086' '#1074#1099#1073#1088#1072#1085#1085#1086#1084#1091' '#1090#1072#1088#1080#1092#1091
        TabOrder = 0
        object lblStart: TLabel
          Left = 151
          Top = 100
          Width = 22
          Height = 13
          Caption = 'Start'
        end
        object lblVariantsName: TLabel
          Left = 8
          Top = 100
          Width = 28
          Height = 13
          Caption = 'Name'
        end
        object lblVariantsCost: TLabel
          Left = 266
          Top = 100
          Width = 21
          Height = 13
          Caption = 'Cost'
        end
        object lblStop: TLabel
          Left = 209
          Top = 100
          Width = 22
          Height = 13
          Caption = 'Stop'
        end
        object butVariantsAdd: TButton
          Left = 216
          Top = 184
          Width = 70
          Height = 25
          Caption = 'add'
          TabOrder = 0
          OnClick = butVariantsAddClick
        end
        object butVariantsDelete: TButton
          Left = 366
          Top = 184
          Width = 70
          Height = 25
          Caption = 'delete'
          TabOrder = 1
          OnClick = butVariantsDeleteClick
        end
        object butVariantsUpdate: TButton
          Left = 291
          Top = 184
          Width = 70
          Height = 25
          Caption = 'update'
          TabOrder = 2
          OnClick = butVariantsUpdateClick
        end
        object cbFriday: TCheckBox
          Left = 152
          Top = 139
          Width = 35
          Height = 17
          Caption = #1055#1090
          TabOrder = 3
          OnClick = cbMondayClick
        end
        object editVariantsName: TEdit
          Left = 8
          Top = 114
          Width = 129
          Height = 21
          TabOrder = 4
          OnChange = editVariantsNameChange
        end
        object editVariantsCost: TEdit
          Left = 263
          Top = 114
          Width = 45
          Height = 21
          TabOrder = 5
          OnChange = editVariantsCostChange
        end
        object dtpVariantsStop: TDateTimePicker
          Left = 203
          Top = 114
          Width = 54
          Height = 21
          Date = 37684.022612083300000000
          Format = 'HH:mm'
          Time = 37684.022612083300000000
          DateMode = dmUpDown
          Kind = dtkTime
          TabOrder = 6
          OnChange = dtpVariantsStopChange
        end
        object dtpVariantsStart: TDateTimePicker
          Left = 144
          Top = 114
          Width = 53
          Height = 21
          Date = 37787.438875023100000000
          Format = 'HH:mm'
          Time = 37787.438875023100000000
          DateMode = dmUpDown
          Kind = dtkTime
          TabOrder = 7
          OnChange = dtpVariantsStartChange
        end
        object checkPacket: TCheckBox
          Left = 316
          Top = 146
          Width = 113
          Height = 17
          Caption = #1055#1072#1082#1077#1090#1085#1099#1081' '#1088#1077#1078#1080#1084
          TabOrder = 8
          OnClick = checkPacketClick
        end
        object cbWednesday: TCheckBox
          Left = 80
          Top = 139
          Width = 35
          Height = 17
          Caption = #1057#1088
          TabOrder = 10
          OnClick = cbMondayClick
        end
        object cbTuesday: TCheckBox
          Left = 44
          Top = 139
          Width = 35
          Height = 17
          Caption = #1042#1090
          TabOrder = 11
          OnClick = cbMondayClick
        end
        object cbThursday: TCheckBox
          Left = 116
          Top = 140
          Width = 35
          Height = 17
          Caption = #1063#1090
          TabOrder = 12
          OnClick = cbMondayClick
        end
        object cbSunday: TCheckBox
          Left = 224
          Top = 139
          Width = 35
          Height = 17
          Caption = #1042#1089
          TabOrder = 13
          OnClick = cbMondayClick
        end
        object cbSaturday: TCheckBox
          Left = 188
          Top = 139
          Width = 35
          Height = 17
          Caption = #1057#1073
          TabOrder = 14
          OnClick = cbMondayClick
        end
        object cbMonday: TCheckBox
          Left = 8
          Top = 139
          Width = 35
          Height = 17
          Caption = #1055#1085
          TabOrder = 15
          OnClick = cbMondayClick
        end
        object gbCondition: TGroupBox
          Left = 316
          Top = 100
          Width = 123
          Height = 44
          Caption = '   '
          TabOrder = 16
          object lblConditionHours: TLabel
            Left = 79
            Top = 19
            Width = 30
            Height = 13
            Caption = #1084#1080#1085#1091#1090
          end
          object seQuantityHours: TSpinEdit
            Left = 24
            Top = 15
            Width = 53
            Height = 22
            MaxValue = 1380
            MinValue = 1
            TabOrder = 0
            Value = 1
            OnChange = seQuantityHoursChange
          end
          object cbConditionType: TEdit
            Left = 5
            Top = 19
            Width = 18
            Height = 16
            AutoSize = False
            BorderStyle = bsNone
            Color = clBtnFace
            TabOrder = 1
            Text = '>='
          end
        end
        object gbTraffic: TGroupBox
          Left = 8
          Top = 155
          Width = 201
          Height = 56
          Caption = 'Traffic'
          TabOrder = 17
          object lblTrafficCost: TLabel
            Left = 8
            Top = 12
            Width = 21
            Height = 13
            Caption = 'Cost'
          end
          object gbTrafficSeparatePayment: TGroupBox
            Left = 64
            Top = 8
            Width = 129
            Height = 42
            Caption = '   '
            TabOrder = 2
            object lblKB: TLabel
              Left = 108
              Top = 19
              Width = 14
              Height = 13
              Caption = 'KB'
            end
            object lblTrafficFree: TLabel
              Left = 8
              Top = 18
              Width = 34
              Height = 13
              Caption = #1041#1077#1089#1087#1083'.'
            end
            object editTrafficFree: TEdit
              Left = 50
              Top = 16
              Width = 53
              Height = 21
              TabOrder = 0
              OnChange = editVariantsCostChange
            end
          end
          object editTrafficCost: TEdit
            Left = 8
            Top = 26
            Width = 49
            Height = 21
            TabOrder = 0
            OnChange = editVariantsCostChange
          end
          object cbTrafficSeparatePayment: TCheckBox
            Left = 74
            Top = 7
            Width = 87
            Height = 17
            Caption = #1054#1090#1076'. '#1086#1087#1083#1072#1090#1072
            TabOrder = 1
            OnClick = cbTrafficSeparatePaymentClick
          end
        end
        object lvVariants: TListView
          Left = 8
          Top = 16
          Width = 430
          Height = 81
          Columns = <
            item
              Caption = 'Name'
              Width = 65
            end
            item
              Caption = 'Start'
              Width = 40
            end
            item
              Caption = 'Stop'
              Width = 40
            end
            item
              Caption = 'Cost'
              Width = 45
            end
            item
              Width = 20
            end
            item
              Caption = 'Condition'
              Width = 60
            end
            item
              Caption = 'Days of Week'
              Width = 80
            end>
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          TabOrder = 18
          ViewStyle = vsReport
          OnClick = lvVariantsClick
        end
        object checkCondition: TCheckBox
          Left = 326
          Top = 99
          Width = 81
          Height = 14
          Caption = #1059#1089#1083#1086#1074#1080#1077
          TabOrder = 9
          OnClick = checkConditionClick
        end
        object cbxFreePacket: TCheckBox
          Left = 316
          Top = 162
          Width = 113
          Height = 17
          Caption = #1053#1077#1079#1072#1082#1088#1077#1087#1083#1077#1085#1085#1099#1081
          TabOrder = 19
          OnClick = cbxFreePacketClick
        end
      end
    end
  end
  object gbTarif: TGroupBox
    Left = 144
    Top = 6
    Width = 305
    Height = 283
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1090#1072#1088#1080#1092#1072
    TabOrder = 4
    object lblTarifName: TLabel
      Left = 8
      Top = 12
      Width = 28
      Height = 13
      Caption = 'Name'
    end
    object lblRoundT: TLabel
      Left = 222
      Top = 12
      Width = 42
      Height = 13
      Caption = 'Round T'
    end
    object lblRoundMoney: TLabel
      Left = 141
      Top = 12
      Width = 41
      Height = 13
      Caption = 'Round $'
    end
    object lblUserLevel: TLabel
      Left = 8
      Top = 53
      Width = 161
      Height = 13
      Caption = #1059#1088#1086#1074#1077#1085#1100' '#1076#1086#1089#1090#1091#1087#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    end
    object butMoveUp: TButton
      Left = 4
      Top = 249
      Width = 70
      Height = 25
      Caption = 'Move up'
      Enabled = False
      TabOrder = 0
      OnClick = butMoveUpClick
    end
    object butTarifUpdate: TButton
      Left = 155
      Top = 249
      Width = 70
      Height = 25
      Caption = 'update'
      Enabled = False
      TabOrder = 1
      OnClick = butTarifUpdateClick
    end
    object butTarifDelete: TButton
      Left = 230
      Top = 249
      Width = 70
      Height = 25
      Caption = 'delete'
      TabOrder = 2
      OnClick = butTarifDeleteClick
    end
    object butTarifAdd: TButton
      Left = 79
      Top = 249
      Width = 70
      Height = 25
      Caption = 'add'
      Enabled = False
      TabOrder = 3
      OnClick = butTarifAddClick
    end
    object gbInternet: TGroupBox
      Left = 8
      Top = 178
      Width = 289
      Height = 67
      Caption = '   '
      TabOrder = 4
      object lblBytesInMB: TLabel
        Left = 7
        Top = 20
        Width = 52
        Height = 13
        Caption = #1041#1072#1081#1090' '#1074' MB'
      end
      object editBytesInMB: TEdit
        Left = 8
        Top = 35
        Width = 73
        Height = 21
        TabOrder = 0
        OnChange = editRoundTimeChange
        OnExit = editBytesInMBExit
      end
      object gbPlugin: TGroupBox
        Left = 88
        Top = 8
        Width = 195
        Height = 53
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' Plug-In'#39#1072
        TabOrder = 1
        object lblPluginGroup: TLabel
          Left = 88
          Top = 12
          Width = 35
          Height = 13
          Caption = #1043#1088#1091#1087#1087#1072
        end
        object lblSpeedLimitInKB: TLabel
          Left = 8
          Top = 12
          Width = 69
          Height = 13
          Caption = #1054#1075#1088'. '#1089#1082#1086#1088'. KB'
        end
        object editPluginGroup: TEdit
          Left = 88
          Top = 26
          Width = 97
          Height = 21
          TabOrder = 0
          OnChange = editRoundTimeChange
          OnExit = editBytesInMBExit
        end
        object editSpeedLimitInKB: TEdit
          Left = 8
          Top = 26
          Width = 73
          Height = 21
          TabOrder = 1
          OnChange = editRoundTimeChange
          OnExit = editBytesInMBExit
        end
      end
    end
    object editTarifName: TEdit
      Left = 8
      Top = 27
      Width = 129
      Height = 21
      TabOrder = 5
      OnChange = editTarifNameChange
    end
    object editRoundTime: TEdit
      Left = 222
      Top = 27
      Width = 75
      Height = 21
      TabOrder = 6
      OnChange = editRoundTimeChange
    end
    object editRoundMoney: TEdit
      Left = 141
      Top = 27
      Width = 75
      Height = 21
      TabOrder = 7
      OnChange = editRoundMoneyChange
    end
    object cbInternet: TCheckBox
      Left = 18
      Top = 175
      Width = 77
      Height = 17
      Caption = 'Internet'
      TabOrder = 8
      OnClick = cbInternetClick
    end
    object cbUserLevel: TComboBox
      Left = 222
      Top = 53
      Width = 75
      Height = 21
      ItemHeight = 13
      TabOrder = 9
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
    object gbSum: TGroupBox
      Left = 8
      Top = 79
      Width = 289
      Height = 98
      TabOrder = 10
      object lblStartMoneyMin: TLabel
        Left = 8
        Top = 26
        Width = 64
        Height = 13
        Caption = #1052#1080#1085'. '#1086#1087#1083#1072#1090#1099
      end
      object lblStartMoneyMax: TLabel
        Left = 149
        Top = 26
        Width = 70
        Height = 13
        Caption = #1052#1072#1082#1089'. '#1086#1087#1083#1072#1090#1099
      end
      object lblAddMoneyMin: TLabel
        Left = 8
        Top = 50
        Width = 73
        Height = 13
        Caption = #1052#1080#1085'. '#1076#1086#1087#1083#1072#1090#1099' '
      end
      object lblAddMoneyMax: TLabel
        Left = 149
        Top = 50
        Width = 76
        Height = 13
        Caption = #1052#1072#1082#1089'. '#1076#1086#1087#1083#1072#1090#1099
      end
      object lblMaximumTrust: TLabel
        Left = 8
        Top = 74
        Width = 75
        Height = 13
        Caption = #1052#1072#1082#1089'. '#1076#1086#1074#1077#1088#1080#1103
      end
      object edtStartMoneyMin: TEdit
        Left = 88
        Top = 23
        Width = 49
        Height = 21
        TabOrder = 0
        Text = '1'
        OnKeyPress = edtStartMoneyMinKeyPress
      end
      object edtStartMoneyMax: TEdit
        Left = 229
        Top = 23
        Width = 49
        Height = 21
        TabOrder = 1
        Text = '100'
        OnKeyPress = edtStartMoneyMaxKeyPress
      end
      object edtAddMoneyMin: TEdit
        Left = 88
        Top = 47
        Width = 49
        Height = 21
        TabOrder = 2
        Text = '1'
        OnKeyPress = edtAddMoneyMinKeyPress
      end
      object edtAddMoneyMax: TEdit
        Left = 229
        Top = 47
        Width = 49
        Height = 21
        TabOrder = 3
        Text = '100'
        OnKeyPress = edtAddMoneyMaxKeyPress
      end
      object edtMaximumTrust: TEdit
        Left = 88
        Top = 71
        Width = 49
        Height = 21
        TabOrder = 4
        Text = '200'
        OnKeyPress = edtMaximumTrustKeyPress
      end
    end
    object cbSumm: TCheckBox
      Left = 18
      Top = 74
      Width = 238
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1086#1090#1076#1077#1083#1100#1085#1091#1102' '#1085#1072#1089#1090#1088#1086#1081#1082#1091' '#1089#1091#1084#1084
      TabOrder = 11
      OnClick = cbSummClick
    end
  end
end
