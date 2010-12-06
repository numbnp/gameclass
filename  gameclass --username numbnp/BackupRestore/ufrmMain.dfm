object frmMain: TfrmMain
  Left = 385
  Top = 328
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1056#1077#1079#1077#1088#1074#1085#1086#1077' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077'/'#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1073#1072#1079#1099' GameClass'
  ClientHeight = 349
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 5
    Width = 473
    Height = 148
    Caption = ' '#1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077' '
    TabOrder = 1
  end
  object butClose: TButton
    Left = 408
    Top = 321
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 0
    OnClick = butCloseClick
  end
  object rbtnRestore: TRadioButton
    Left = 16
    Top = 44
    Width = 225
    Height = 17
    Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
    TabOrder = 2
    OnClick = rbtnRestoreClick
  end
  object rbtnBackup: TRadioButton
    Left = 16
    Top = 27
    Width = 225
    Height = 17
    Caption = #1056#1077#1079#1077#1088#1074#1085#1086#1077' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
    Checked = True
    TabOrder = 3
    TabStop = True
    OnClick = rbtnBackupClick
  end
  object Panel1: TPanel
    Left = 16
    Top = 62
    Width = 457
    Height = 81
    BevelOuter = bvNone
    TabOrder = 4
    object lblCaptionFile: TLabel
      Left = 2
      Top = 2
      Width = 91
      Height = 13
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1092#1072#1081#1083' ...'
    end
    object lblBackupFilename: TLabel
      Left = 4
      Top = 42
      Width = 208
      Height = 13
      Caption = #1040#1074#1090#1086'-'#1075#1077#1085#1077#1088#1080#1088#1091#1077#1084#1086#1077' '#1080#1084#1103' backup-'#1092#1072#1081#1083#1072' ...'
    end
    object edtBackupPath: TEdit
      Left = 3
      Top = 17
      Width = 422
      Height = 21
      TabOrder = 0
    end
    object butBrowse: TButton
      Left = 431
      Top = 17
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = butBrowseClick
    end
    object edtBackupName: TEdit
      Left = 3
      Top = 58
      Width = 214
      Height = 21
      Enabled = False
      TabOrder = 2
    end
  end
  object butBackup: TButton
    Left = 8
    Top = 320
    Width = 201
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1088#1077#1079#1077#1088#1074#1085#1086#1077' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077
    TabOrder = 5
    OnClick = butBackupClick
  end
  object butRestore: TButton
    Left = 216
    Top = 320
    Width = 89
    Height = 25
    Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
    TabOrder = 6
    OnClick = butRestoreClick
  end
  object memInfo: TMemo
    Left = 8
    Top = 192
    Width = 473
    Height = 121
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object editVersion: TEdit
    Left = 408
    Top = 19
    Width = 65
    Height = 17
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    TabOrder = 8
    Text = #1042#1077#1088#1089#1080#1103' 1.6'
  end
  object directoryEdit: TDirectoryEdit
    Left = 344
    Top = 48
    Width = 121
    Height = 21
    DialogText = 'dfgdfg'
    NumGlyphs = 1
    TabOrder = 9
    Visible = False
  end
  object btnCreateEmptyDB: TButton
    Left = 8
    Top = 160
    Width = 473
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1087#1091#1089#1090#1091#1102' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093' GameClass '#1085#1072' '#1087#1077#1088#1077#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1085#1086#1084' MSDE'
    TabOrder = 10
    OnClick = btnCreateEmptyDBClick
  end
  object openDialog: TOpenDialog
    Filter = 'GameClass Backups  (*.gcb)|*.gcb'
    Options = [ofOverwritePrompt, ofPathMustExist, ofNoNetworkButton, ofEnableSizing]
    Left = 366
    Top = 109
  end
  object tmrName: TTimer
    OnTimer = tmrNameTimer
    Left = 240
    Top = 114
  end
end
