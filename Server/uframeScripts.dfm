object frameScripts: TframeScripts
  Left = 0
  Top = 0
  Width = 449
  Height = 411
  TabOrder = 0
  object gbTabs: TGroupBox
    Left = 0
    Top = 257
    Width = 449
    Height = 154
    Align = alClient
    Caption = '    '
    TabOrder = 0
    Visible = False
    object Panel1: TPanel
      Left = 2
      Top = 119
      Width = 445
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
  object gbExternalScripts: TGroupBox
    Left = 0
    Top = 0
    Width = 449
    Height = 153
    Align = alTop
    Caption = #1047#1072#1087#1091#1089#1082' '#1074#1085#1077#1096#1085#1080#1093' '#1089#1082#1088#1080#1087#1090#1086#1074' '#1085#1072' '#1086#1087#1077#1088#1072#1090#1086#1088#1089#1082#1086#1081' '#1084#1072#1096#1080#1085#1077
    TabOrder = 1
    object gbSessionScript: TGroupBox
      Left = 2
      Top = 15
      Width = 445
      Height = 65
      Align = alTop
      Caption = '    '
      TabOrder = 0
      object cbxSessionScript: TCheckBox
        Left = 8
        Top = -2
        Width = 133
        Height = 17
        Caption = #1055#1088#1080' '#1088#1072#1073#1086#1090#1077' '#1089#1077#1072#1085#1089#1086#1074
        TabOrder = 0
        OnClick = cbxSessionScriptClick
        OnKeyUp = cbxSessionScriptKeyUp
      end
      object editSessionScriptPath: TFilenameEdit
        Left = 8
        Top = 18
        Width = 433
        Height = 21
        NumGlyphs = 1
        TabOrder = 1
        Text = ''
        OnChange = editSessionScriptPathChange
      end
      object cbxSessionScriptHideWindow: TCheckBox
        Left = 8
        Top = 42
        Width = 97
        Height = 17
        Caption = #1057#1082#1088#1099#1074#1072#1090#1100' '#1086#1082#1085#1086
        TabOrder = 2
        OnClick = cbxSessionScriptHideWindowClick
        OnKeyUp = cbxSessionScriptHideWindowKeyUp
      end
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 80
      Width = 445
      Height = 65
      Align = alTop
      Caption = '    '
      TabOrder = 1
      object cbxServerScript: TCheckBox
        Left = 8
        Top = -2
        Width = 133
        Height = 17
        Caption = #1055#1088#1080' '#1088#1072#1073#1086#1090#1077' '#1089#1077#1088#1074#1077#1088#1072
        TabOrder = 0
        OnClick = cbxServerScriptClick
      end
      object editServerScriptPath: TFilenameEdit
        Left = 8
        Top = 18
        Width = 433
        Height = 21
        NumGlyphs = 1
        TabOrder = 1
        Text = ''
        OnChange = editServerScriptPathChange
      end
      object cbxServerScriptHideWindow: TCheckBox
        Left = 8
        Top = 42
        Width = 97
        Height = 17
        Caption = #1057#1082#1088#1099#1074#1072#1090#1100' '#1086#1082#1085#1086
        TabOrder = 2
        OnClick = cbxServerScriptHideWindowClick
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 153
    Width = 449
    Height = 104
    Align = alTop
    Caption = #1047#1072#1087#1091#1089#1082' '#1074#1085#1077#1096#1085#1080#1093' '#1089#1082#1088#1080#1087#1090#1086#1074' '#1085#1072' '#1082#1083#1080#1077#1085#1090#1089#1082#1080#1093' '#1084#1072#1096#1080#1085#1072#1093
    TabOrder = 2
    object gbClient: TGroupBox
      Left = 2
      Top = 15
      Width = 445
      Height = 81
      Align = alTop
      Caption = '    '
      TabOrder = 0
      object cbxClient: TCheckBox
        Left = 8
        Top = -2
        Width = 133
        Height = 17
        Caption = #1055#1088#1080' '#1088#1072#1073#1086#1090#1077' '#1082#1083#1080#1077#1085#1090#1072
        TabOrder = 0
        OnClick = cbxClientClick
      end
      object editClientPath: TFilenameEdit
        Left = 8
        Top = 18
        Width = 433
        Height = 21
        NumGlyphs = 1
        TabOrder = 1
        Text = ''
        OnChange = editClientPathChange
      end
      object cbxClientHideWindow: TCheckBox
        Left = 8
        Top = 42
        Width = 97
        Height = 17
        Caption = #1057#1082#1088#1099#1074#1072#1090#1100' '#1086#1082#1085#1086
        TabOrder = 2
        OnClick = cbxClientHideWindowClick
      end
      object cbxClientSynchronizeFile: TCheckBox
        Left = 8
        Top = 58
        Width = 233
        Height = 17
        Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1089' '#1092#1072#1081#1083#1086#1084' '#1085#1072' '#1089#1077#1088#1074#1077#1088#1077
        TabOrder = 3
        OnClick = cbxClientSynchronizeFileClick
      end
    end
  end
end
