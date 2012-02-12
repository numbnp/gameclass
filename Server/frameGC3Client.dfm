object framGC3Client: TframGC3Client
  Left = 0
  Top = 0
  Width = 509
  Height = 404
  TabOrder = 0
  object pnlTop2: TPanel
    Left = 0
    Top = 126
    Width = 509
    Height = 139
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object gbSessionStop: TGroupBox
      Left = 0
      Top = 0
      Width = 169
      Height = 139
      Align = alLeft
      Caption = #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077' '#1089#1077#1072#1085#1089#1072
      TabOrder = 0
      object lblSec3: TLabel
        Left = 95
        Top = 17
        Width = 18
        Height = 13
        Caption = #1089#1077#1082
      end
      object cbxAfterStop: TCheckBox
        Left = 8
        Top = 16
        Width = 57
        Height = 17
        Caption = #1095#1077#1088#1077#1079
        TabOrder = 0
        OnClick = cbxAfterStopClick
      end
      object edtAfterStopSec: TEdit
        Left = 62
        Top = 14
        Width = 27
        Height = 21
        TabOrder = 1
        Text = '30'
        OnChange = edtAfterStopSecChange
      end
      object rbtnAfterStopType_KillTask: TRadioButton
        Left = 24
        Top = 32
        Width = 137
        Height = 17
        Caption = #1057#1085#1080#1084#1072#1090#1100' '#1079#1072#1076#1072#1095#1080
        TabOrder = 2
        OnClick = rbtnAfterStopType_KillTaskClick
      end
      object rbtnAfterStopType_Logoff: TRadioButton
        Left = 24
        Top = 48
        Width = 137
        Height = 17
        Caption = 'Logoff'
        TabOrder = 3
        OnClick = rbtnAfterStopType_LogoffClick
      end
      object rbtnAfterStopType_Restart: TRadioButton
        Left = 24
        Top = 64
        Width = 137
        Height = 17
        Caption = 'Restart'
        TabOrder = 4
        OnClick = rbtnAfterStopType_RestartClick
      end
      object rbtnAfterStopType_Shutdown: TRadioButton
        Left = 24
        Top = 80
        Width = 137
        Height = 17
        Caption = 'Shutdown'
        TabOrder = 5
        OnClick = rbtnAfterStopType_ShutdownClick
      end
    end
    object pnlTop2RightTop: TPanel
      Left = 169
      Top = 0
      Width = 340
      Height = 139
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object gbOther: TGroupBox
        Left = 0
        Top = 52
        Width = 340
        Height = 87
        Align = alClient
        Caption = #1044#1088#1091#1075#1086#1077
        TabOrder = 0
        object cbxSyncTime: TCheckBox
          Left = 8
          Top = 18
          Width = 225
          Height = 13
          Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1074#1088#1077#1084#1103' '#1089' '#1089#1077#1088#1074#1077#1088#1086#1084
          TabOrder = 0
          OnClick = cbxSyncTimeClick
        end
        object cbxTaskKillBeforeStart: TCheckBox
          Left = 8
          Top = 32
          Width = 257
          Height = 17
          Caption = #1057#1085#1080#1084#1072#1090#1100' '#1079#1072#1076#1072#1095#1080' '#1087#1077#1088#1077#1076' '#1085#1072#1095#1072#1083#1086#1084' '#1089#1077#1072#1085#1089#1072
          TabOrder = 1
          OnClick = cbxTaskKillBeforeStartClick
        end
        object cbxUseWOL: TCheckBox
          Left = 8
          Top = 48
          Width = 265
          Height = 17
          Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1074#1082#1083#1102#1095#1072#1090#1100' '#1086#1087#1083#1072#1095#1077#1085#1099#1081' '#1082#1086#1084#1087#1100#1102#1090#1077#1088
          TabOrder = 2
          OnClick = cbxUseWOLClick
        end
        object cbShowSummOnClient: TCheckBox
          Left = 8
          Top = 63
          Width = 268
          Height = 17
          Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1085#1072#1082#1086#1087#1083#1077#1085#1085#1091#1102' '#1089#1091#1084#1084#1091' '#1085#1072' '#1082#1083#1080#1077#1085#1090#1077
          TabOrder = 3
          OnClick = cbShowSummOnClientClick
        end
      end
      object gbShell: TGroupBox
        Left = 0
        Top = 0
        Width = 340
        Height = 52
        Align = alTop
        Caption = #1048#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1081' '#1096#1077#1083#1083
        TabOrder = 1
        object rbtnShellMode_Runpad: TRadioButton
          Left = 8
          Top = 16
          Width = 105
          Height = 17
          Caption = 'Runpad Shell'
          TabOrder = 0
          OnClick = rbtnShellMode_RunpadClick
        end
        object rbtnShellMode_Unknown: TRadioButton
          Left = 8
          Top = 32
          Width = 105
          Height = 17
          Caption = #1044#1088#1091#1075#1086#1081
          TabOrder = 1
          OnClick = rbtnShellMode_UnknownClick
        end
      end
    end
  end
  object pnlTop1: TPanel
    Left = 0
    Top = 0
    Width = 509
    Height = 126
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object gbBlockAction: TGroupBox
      Left = 225
      Top = 0
      Width = 284
      Height = 126
      Align = alClient
      Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1080' '#1089#1088#1072#1073#1072#1090#1099#1074#1072#1102#1090
      TabOrder = 0
      object GroupBox1: TPanel
        Left = 8
        Top = 16
        Width = 210
        Height = 57
        BevelOuter = bvNone
        TabOrder = 0
        object lblSec2: TLabel
          Left = 95
          Top = 19
          Width = 18
          Height = 13
          Caption = #1089#1077#1082
        end
        object rbtnStartBlockTime: TRadioButton
          Left = 29
          Top = 19
          Width = 41
          Height = 17
          Caption = #1085#1072
          TabOrder = 1
          OnClick = rbtnStartBlockTimeClick
        end
        object rbtnStartBlockPermanently: TRadioButton
          Left = 29
          Top = 35
          Width = 113
          Height = 17
          Caption = #1087#1086#1089#1090#1086#1103#1085#1085#1072#1103
          TabOrder = 2
          OnClick = rbtnStartBlockPermanentlyClick
        end
        object edtStartBlockSec: TEdit
          Left = 64
          Top = 17
          Width = 25
          Height = 21
          TabOrder = 0
          Text = '10'
          OnChange = edtStartBlockSecChange
        end
        object cbxStartBlock: TCheckBox
          Left = 8
          Top = 0
          Width = 193
          Height = 17
          Caption = #1057#1088#1072#1079#1091' '#1087#1086#1089#1083#1077' '#1089#1090#1072#1088#1090#1072' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072
          TabOrder = 3
          OnClick = cbxStartBlockClick
        end
      end
      object GroupBox2: TPanel
        Left = 8
        Top = 68
        Width = 210
        Height = 53
        BevelOuter = bvNone
        TabOrder = 1
        object lblMin: TLabel
          Left = 111
          Top = 19
          Width = 20
          Height = 13
          Caption = #1084#1080#1085
        end
        object rbtnOfflineBlockType_Immediately: TRadioButton
          Left = 29
          Top = 18
          Width = 55
          Height = 17
          Caption = #1095#1077#1088#1077#1079
          TabOrder = 0
          OnClick = rbtnOfflineBlockType_ImmediatelyClick
        end
        object rbtnOfflineBlockType_AfterSessionStop: TRadioButton
          Left = 29
          Top = 34
          Width = 172
          Height = 17
          Caption = #1087#1086#1089#1083#1077' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1089#1077#1072#1085#1089#1072
          TabOrder = 1
          OnClick = rbtnOfflineBlockType_AfterSessionStopClick
        end
        object cbxOfflineBlock: TCheckBox
          Left = 8
          Top = 0
          Width = 137
          Height = 17
          Caption = #1055#1088#1080' '#1086#1073#1088#1099#1074#1077' '#1089#1074#1103#1079#1080
          TabOrder = 2
          OnClick = cbxOfflineBlockClick
        end
        object editOfflineBlock: TEdit
          Left = 80
          Top = 17
          Width = 25
          Height = 21
          TabOrder = 3
          Text = '0'
          OnChange = editOfflineBlockChange
        end
      end
    end
    object pnlTop1Left: TPanel
      Left = 0
      Top = 0
      Width = 225
      Height = 126
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object gbBlocking: TGroupBox
        Left = 0
        Top = 0
        Width = 225
        Height = 91
        Align = alTop
        Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072
        TabOrder = 0
        object cbxKeyboard: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 13
          Caption = #1050#1083#1072#1074#1080#1072#1090#1091#1088#1072
          TabOrder = 0
          OnClick = cbxKeyboardClick
        end
        object cbxMouse: TCheckBox
          Left = 8
          Top = 32
          Width = 89
          Height = 13
          Caption = #1052#1099#1096#1100
          TabOrder = 1
          OnClick = cbxMouseClick
        end
        object cbxTasks: TCheckBox
          Left = 94
          Top = 32
          Width = 115
          Height = 13
          Caption = #1057#1074#1086#1088#1072#1095#1080#1074#1072#1090#1100' '#1086#1082#1085#1072
          TabOrder = 2
          OnClick = cbxTasksClick
        end
        object cbxDisplay: TCheckBox
          Left = 94
          Top = 16
          Width = 128
          Height = 13
          Caption = #1042#1099#1082#1083#1102#1095#1072#1090#1100' '#1084#1086#1085#1080#1090#1086#1088
          TabOrder = 3
          OnClick = cbxDisplayClick
        end
        object cbxUnblockPassword: TCheckBox
          Left = 8
          Top = 48
          Width = 163
          Height = 13
          Caption = #1055#1072#1088#1086#1083#1100' '#1088#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085#1080#1103
          TabOrder = 4
          OnClick = cbxUnblockPasswordClick
        end
        object edtUnblockPassword: TEdit
          Left = 24
          Top = 64
          Width = 169
          Height = 20
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Wingdings'
          Font.Style = []
          HideSelection = False
          ParentFont = False
          PasswordChar = 'l'
          TabOrder = 5
          Text = '12345678912345678912'
          OnChange = edtUnblockPasswordChange
          OnEnter = edtUnblockPasswordEnter
          OnExit = edtUnblockPasswordExit
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 91
        Width = 225
        Height = 35
        Align = alClient
        Caption = #1055#1088#1080' '#1086#1073#1088#1099#1074#1077' '#1089#1074#1103#1079#1080' '#1087#1086#1089#1083#1077' '#1087#1077#1088#1077#1079#1072#1075#1088#1091#1079#1082#1080
        TabOrder = 1
        object cbxRestoreClientInfo: TCheckBox
          Left = 8
          Top = 16
          Width = 209
          Height = 17
          Caption = #1042#1086#1089#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1090#1100' '#1089#1077#1072#1085#1089
          TabOrder = 0
          OnClick = cbxRestoreClientInfoClick
        end
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 265
    Width = 509
    Height = 139
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlTop2Right: TPanel
      Left = 0
      Top = 0
      Width = 509
      Height = 139
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object gbSessionScript: TGroupBox
        Left = 0
        Top = 0
        Width = 509
        Height = 50
        Align = alTop
        Caption = '    '
        TabOrder = 0
        object lblDistribPath: TLabel
          Left = 16
          Top = 19
          Width = 104
          Height = 13
          Caption = #1055#1091#1090#1100' '#1082' '#1076#1080#1089#1090#1088#1080#1073#1091#1090#1080#1074#1091
        end
        object cbxAutoInstall: TCheckBox
          Left = 8
          Top = -2
          Width = 169
          Height = 17
          Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1091#1089#1090#1072#1085#1086#1074#1082#1072
          TabOrder = 0
          OnClick = cbxAutoInstallClick
        end
        object editInstallPath: TFilenameEdit
          Left = 136
          Top = 18
          Width = 297
          Height = 21
          NumGlyphs = 1
          TabOrder = 1
          OnChange = editInstallPathChange
        end
      end
    end
  end
end
