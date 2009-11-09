object frmClearStatistic: TfrmClearStatistic
  Left = 530
  Top = 285
  BorderStyle = bsDialog
  Caption = #1054#1095#1080#1089#1090#1082#1072' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080
  ClientHeight = 324
  ClientWidth = 522
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlWarning: TGroupBox
    Left = 0
    Top = 0
    Width = 522
    Height = 73
    Align = alTop
    Caption = #1055#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1077
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 518
      Height = 56
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 8
      TabOrder = 0
      object Memo1: TMemo
        Left = 8
        Top = 8
        Width = 502
        Height = 40
        Align = alClient
        BorderStyle = bsNone
        Color = clBtnFace
        Lines.Strings = (
          #1042#1085#1080#1084#1072#1085#1080#1077'!'
          
            #1055#1086#1083#1085#1072#1103' '#1086#1095#1080#1089#1090#1082#1072' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080' '#1041#1045#1047#1042#1054#1047#1042#1056#1040#1058#1053#1054' '#1091#1076#1072#1083#1103#1077#1090' '#1042#1057#1070' '#1085#1072#1082#1086#1087#1083#1077#1085#1085#1091#1102' '#1089 +
            #1090#1072#1090#1080#1089#1090#1080#1082#1091', '#1074' '#1090#1086#1084' '#1095#1080#1089#1083#1077' '
          #1092#1080#1085#1072#1085#1089#1086#1074#1091#1102', '#1082#1088#1086#1084#1077' '#1073#1072#1079#1099' '#1091#1095#1077#1090#1085#1099#1093' '#1079#1072#1087#1080#1089#1077#1081'!')
        TabOrder = 0
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 73
    Width = 522
    Height = 216
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object GroupBox2: TGroupBox
      Left = 233
      Top = 0
      Width = 289
      Height = 216
      Align = alClient
      Caption = #1054#1095#1080#1097#1072#1077#1084#1099#1077' '#1090#1072#1073#1083#1080#1094#1099
      TabOrder = 0
      object lblLogs: TLabel
        Left = 232
        Top = 16
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblJournalOp: TLabel
        Left = 232
        Top = 32
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblSessions: TLabel
        Left = 232
        Top = 48
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblUnControl: TLabel
        Left = 232
        Top = 80
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblHardware: TLabel
        Left = 232
        Top = 96
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblServices: TLabel
        Left = 232
        Top = 112
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPrinter: TLabel
        Left = 232
        Top = 128
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblAutoUpdate: TLabel
        Left = 232
        Top = 144
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblProcesses: TLabel
        Left = 232
        Top = 160
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblAccountsHistory: TLabel
        Left = 232
        Top = 176
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblShrinkDatabase: TLabel
        Left = 232
        Top = 192
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblRemovedMoney: TLabel
        Left = 232
        Top = 64
        Width = 47
        Height = 13
        Caption = #1054#1096#1080#1073#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbxAutoUpdate: TCheckBox
        Left = 9
        Top = 144
        Width = 200
        Height = 17
        Caption = #1046#1091#1088#1085#1072#1083' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1085#1072#1089#1090#1088#1086#1077#1082
        TabOrder = 0
      end
      object cbxPrinter: TCheckBox
        Left = 9
        Top = 128
        Width = 200
        Height = 17
        Caption = #1055#1077#1095#1072#1090#1100
        TabOrder = 1
      end
      object cbxServices: TCheckBox
        Left = 9
        Top = 112
        Width = 200
        Height = 17
        Caption = #1059#1089#1083#1091#1075#1080
        TabOrder = 2
      end
      object cbxHardware: TCheckBox
        Left = 9
        Top = 96
        Width = 200
        Height = 17
        Caption = #1046#1091#1088#1085#1072#1083' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
        TabOrder = 3
      end
      object cbxUnControl: TCheckBox
        Left = 9
        Top = 80
        Width = 224
        Height = 17
        Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1086#1089#1090#1091#1090#1089#1090#1074#1080#1080' '#1082#1086#1085#1090#1088#1086#1083#1103
        TabOrder = 4
      end
      object cbxSessions: TCheckBox
        Left = 9
        Top = 48
        Width = 200
        Height = 17
        Caption = #1057#1077#1072#1085#1089#1099
        TabOrder = 5
      end
      object cbxJournalOp: TCheckBox
        Left = 9
        Top = 32
        Width = 200
        Height = 17
        Caption = #1046#1091#1088#1085#1072#1083' '#1086#1087#1077#1088#1072#1090#1086#1088#1086#1074
        TabOrder = 6
      end
      object cbxLogs: TCheckBox
        Left = 9
        Top = 16
        Width = 200
        Height = 17
        Caption = #1042#1072#1078#1085#1099#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
        TabOrder = 7
      end
      object cbxAccountsHistory: TCheckBox
        Left = 9
        Top = 176
        Width = 200
        Height = 17
        Caption = #1048#1089#1090#1086#1088#1080#1103' '#1091#1095#1077#1090#1085#1099#1093' '#1079#1072#1087#1080#1089#1077#1081
        TabOrder = 8
      end
      object cbxProcesses: TCheckBox
        Left = 9
        Top = 160
        Width = 200
        Height = 17
        Caption = #1055#1088#1086#1094#1077#1089#1089#1099
        TabOrder = 9
      end
      object cbxShrinkDatabase: TCheckBox
        Left = 9
        Top = 192
        Width = 200
        Height = 17
        Caption = #1046#1091#1088#1085#1072#1083' '#1090#1088#1072#1085#1079#1072#1082#1094#1080' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
        TabOrder = 10
      end
      object cbxRemovedMoney: TCheckBox
        Left = 9
        Top = 64
        Width = 200
        Height = 17
        Caption = #1057#1091#1084#1084#1072' '#1080#1079#1098#1103#1090#1072#1103' '#1084#1077#1085#1077#1076#1078#1077#1088#1086#1084
        TabOrder = 11
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 233
      Height = 216
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object GroupBox3: TGroupBox
        Left = 0
        Top = 105
        Width = 233
        Height = 111
        Align = alClient
        Caption = #1060#1080#1083#1100#1090#1088' '#1087#1086' '#1074#1088#1077#1084#1077#1085#1080
        TabOrder = 0
        object lblInclusive: TLabel
          Left = 144
          Top = 40
          Width = 78
          Height = 13
          Caption = '('#1074#1082#1083#1102#1095#1080#1090#1077#1083#1100#1085#1086')'
        end
        object dtpBefore: TDateTimePicker
          Left = 56
          Top = 36
          Width = 81
          Height = 21
          Date = 39660.775871481480000000
          Time = 39660.775871481480000000
          TabOrder = 0
        end
        object rbtnAll: TRadioButton
          Left = 8
          Top = 16
          Width = 97
          Height = 17
          Caption = #1074#1089#1077' '#1079#1072#1087#1080#1089#1080
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object rbtnBefore: TRadioButton
          Left = 8
          Top = 38
          Width = 41
          Height = 17
          Caption = #1087#1086
          TabOrder = 2
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 233
        Height = 105
        Align = alTop
        Caption = #1056#1077#1078#1080#1084' '#1086#1095#1080#1089#1090#1082#1080
        TabOrder = 1
        object rbtnModeFull: TRadioButton
          Left = 8
          Top = 16
          Width = 185
          Height = 17
          Caption = #1055#1086#1083#1085#1072#1103' '#1086#1095#1080#1089#1090#1082#1072
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbtnModeClick
        end
        object rbtnModeExcludeLastMonth: TRadioButton
          Left = 8
          Top = 32
          Width = 185
          Height = 17
          Caption = #1042#1089#1105' '#1082#1088#1086#1084#1077' '#1087#1086#1089#1083#1077#1076#1085#1080#1093' 30 '#1076#1085#1077#1081
          TabOrder = 1
          OnClick = rbtnModeClick
        end
        object rbtnModeExcludeLastYear: TRadioButton
          Left = 8
          Top = 48
          Width = 185
          Height = 17
          Caption = #1042#1089#1105' '#1082#1088#1086#1084#1077' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1075#1086#1076#1072
          TabOrder = 2
          OnClick = rbtnModeClick
        end
        object rbtnModeCustom: TRadioButton
          Left = 8
          Top = 64
          Width = 185
          Height = 17
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1072#1103' '#1085#1072#1089#1090#1088#1086#1081#1082#1072
          TabOrder = 3
          OnClick = rbtnModeClick
        end
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 289
    Width = 522
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnCancel: TButton
      Left = 312
      Top = 6
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Default = True
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnClear: TButton
      Left = 120
      Top = 6
      Width = 161
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093
      TabOrder = 1
      OnClick = btnClearClick
    end
  end
  object cmdLogs: TADOCommand
    CommandText = 'DELETE FROM Logs WHERE moment <= :dtMoment'
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end>
    Left = 10
    Top = 7
  end
  object cmdJournalOp: TADOCommand
    CommandText = 'DELETE FROM JournalOp WHERE moment <= :dtMoment'
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        Size = -1
        Value = Null
      end>
    Left = 40
    Top = 8
  end
  object cmdSessions: TADOCommand
    CommandText = 'DELETE FROM Sessions WHERE started <= :dtMoment'
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        Size = -1
        Value = Null
      end>
    Left = 72
    Top = 8
  end
  object cmdUnControl: TADOCommand
    CommandText = 'DELETE FROM Uncontrol WHERE stop <= :dtMoment'
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        Size = -1
        Value = Null
      end>
    Left = 136
    Top = 8
  end
  object cmdHardware: TADOCommand
    CommandText = 'DELETE FROM Hardware WHERE moment <= :dtMoment'
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        Size = -1
        Value = Null
      end>
    Left = 170
    Top = 7
  end
  object cmdServices: TADOCommand
    CommandText = 'DELETE FROM Services WHERE moment <= :dtMoment'
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        Size = -1
        Value = Null
      end>
    Left = 200
    Top = 8
  end
  object cmdPrinter: TADOCommand
    CommandText = 'DELETE FROM _pm_jobs WHERE dt <= :dtMoment'
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        Size = -1
        Value = Null
      end>
    Left = 232
    Top = 8
  end
  object cmdAutoUpdate: TADOCommand
    CommandText = 'DELETE FROM AutoUpdate WHERE moment <= :dtMoment'
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        Size = -1
        Value = Null
      end>
    Left = 264
    Top = 8
  end
  object cmdProcesses: TADOCommand
    CommandText = 'DELETE FROM Process WHERE StopTime <= :dtMoment'
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        Size = -1
        Value = Null
      end>
    Left = 298
    Top = 7
  end
  object cmdAccountsHistory: TADOCommand
    CommandText = 'DELETE FROM AccountsHistory WHERE moment <= :dtMoment'
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        Size = -1
        Value = Null
      end>
    Left = 328
    Top = 8
  end
  object cmdShrinkDatabase: TADOCommand
    CommandText = ' DBCC SHRINKDATABASE (Gameclass)'
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        Size = -1
        Value = Null
      end>
    Left = 360
    Top = 8
  end
  object cmdRemovedMoney: TADOCommand
    CommandText = 'UPDATE Registry SET [value] = '#39'0'#39' WHERE [key]='#39'RemovedMoney'#39
    Connection = dmMain.cnnMain
    Parameters = <
      item
        Name = 'dtMoment'
        Value = Null
      end>
    Left = 104
    Top = 8
  end
end
