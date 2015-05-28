object frameKKM: TframeKKM
  Left = 0
  Top = 0
  Width = 453
  Height = 415
  TabOrder = 0
  object gbTabs: TGroupBox
    Left = 0
    Top = 313
    Width = 453
    Height = 102
    Align = alClient
    Caption = '    '
    TabOrder = 0
    Visible = False
    object Panel1: TPanel
      Left = 2
      Top = 67
      Width = 449
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
  object gbUnixPro: TGroupBox
    Left = 0
    Top = 0
    Width = 453
    Height = 313
    Align = alTop
    Caption = #1051#1080#1094#1077#1085#1079#1080#1086#1085#1085#1099#1081' '#1082#1083#1102#1095' '#1086#1073#1085#1072#1088#1091#1078#1077#1085'. '#1056#1072#1073#1086#1090#1072' '#1084#1086#1076#1091#1083#1103' '#1074#1086#1079#1084#1086#1078#1085#1072'.'
    TabOrder = 1
    object cbxKKM: TCheckBox
      Left = 8
      Top = 14
      Width = 369
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100'  '#1050#1050#1052
      TabOrder = 0
      OnClick = cbxKKMClick
    end
    object gbKKMPlugin: TGroupBox
      Left = 8
      Top = 40
      Width = 433
      Height = 121
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1084#1086#1076#1091#1083#1100
      TabOrder = 1
      object lblKKMNotes: TLabel
        Left = 8
        Top = 48
        Width = 49
        Height = 13
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
      end
      object cboKKMPlugin: TComboBox
        Left = 8
        Top = 18
        Width = 337
        Height = 21
        TabOrder = 0
        OnChange = cboKKMPluginChange
      end
      object btnKKMConfig: TButton
        Left = 352
        Top = 16
        Width = 75
        Height = 25
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        TabOrder = 1
        OnClick = btnKKMConfigClick
      end
      object memKKMNotes: TMemo
        Left = 8
        Top = 64
        Width = 417
        Height = 48
        Color = clMenu
        ReadOnly = True
        TabOrder = 2
      end
    end
    object cbxDisconnectBlock: TCheckBox
      Left = 8
      Top = 184
      Width = 353
      Height = 17
      Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1088#1072#1073#1086#1090#1091' '#1086#1087#1077#1088#1072#1090#1086#1088#1072' '#1087#1088#1080' '#1087#1086#1090#1077#1088#1077' '#1089#1074#1103#1079#1080' '#1089' '#1050#1050#1052
      TabOrder = 3
      OnClick = cbxDisconnectBlockClick
    end
    object cbxPrintNonFiscal: TCheckBox
      Left = 8
      Top = 264
      Width = 329
      Height = 17
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1085#1077#1092#1080#1089#1082#1072#1083#1100#1085#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1076#1083#1103' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      TabOrder = 8
      OnClick = cbxPrintNonFiscalClick
    end
    object cbxZOrderByCloseShift: TCheckBox
      Left = 8
      Top = 248
      Width = 329
      Height = 17
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' Z-'#1054#1090#1095#1077#1090' '#1087#1088#1080' '#1079#1072#1082#1088#1099#1090#1080#1080' '#1089#1084#1077#1085#1099
      TabOrder = 7
      OnClick = cbxZOrderByCloseShiftClick
    end
    object cbxCustomOperatorName: TCheckBox
      Left = 8
      Top = 280
      Width = 305
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1085#1086#1077' '#1080#1084#1103' '#1086#1087#1077#1088#1072#1090#1086#1088#1072' '#1050#1050#1052
      TabOrder = 9
      OnClick = cbxCustomOperatorNameClick
    end
    object edtOperatorName: TEdit
      Left = 296
      Top = 278
      Width = 145
      Height = 21
      TabOrder = 10
      OnChange = edtOperatorNameChange
    end
    object cbxOnlyForOperator: TCheckBox
      Left = 8
      Top = 168
      Width = 273
      Height = 17
      Caption = #1055#1086#1076#1082#1083#1102#1095#1072#1090#1100#1089#1103' '#1082' '#1050#1050#1052' '#1090#1086#1083#1100#1082#1086' '#1087#1086#1076' '#1086#1087#1077#1088#1072#1090#1086#1088#1086#1084
      TabOrder = 2
      OnClick = cbxOnlyForOperatorClick
    end
    object rbtnOnlyResultCheck: TRadioButton
      Left = 8
      Top = 200
      Width = 409
      Height = 17
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1095#1077#1082#1080' '#1087#1086#1089#1083#1077' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1089#1077#1072#1085#1089#1072
      TabOrder = 4
      OnClick = rbtnOnlyResultCheckClick
    end
    object rbtnCashInForPrepay: TRadioButton
      Left = 8
      Top = 216
      Width = 417
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1074#1085#1077#1089#1077#1085#1080#1077' '#1076#1077#1085#1077#1075' '#1085#1072' '#1089#1095#1077#1090' '#1076#1083#1103' '#1087#1088#1077#1076#1086#1087#1083#1072#1090#1099
      TabOrder = 5
      OnClick = rbtnOnlyResultCheckClick
    end
    object rbtnRefundForChange: TRadioButton
      Left = 8
      Top = 232
      Width = 417
      Height = 17
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1095#1077#1082#1080' '#1089#1088#1072#1079#1091', '#1089#1076#1072#1095#1091' '#1086#1092#1086#1088#1084#1083#1103#1090#1100' '#1082#1072#1082' '#1074#1086#1079#1074#1088#1072#1090
      TabOrder = 6
      OnClick = rbtnOnlyResultCheckClick
    end
  end
end
