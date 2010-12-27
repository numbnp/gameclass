object frmOperatorOpt: TfrmOperatorOpt
  Left = 221
  Top = 158
  BorderStyle = bsDialog
  Caption = 'frmOperatorOpt'
  ClientHeight = 413
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object gbMainOptions: TGroupBox
    Left = 8
    Top = 8
    Width = 417
    Height = 81
    Caption = #1054#1089#1085#1086#1074#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 135
      Height = 13
      Caption = #1054#1089#1085#1086#1074#1085#1086#1081' '#1096#1088#1080#1092#1090' '#1090#1072#1073#1083#1080#1094#1099':'
    end
    object pnlTableFont: TPanel
      Left = 16
      Top = 40
      Width = 241
      Height = 33
      Caption = 'Text'
      TabOrder = 0
    end
    object btTableFont: TButton
      Left = 340
      Top = 40
      Width = 65
      Height = 33
      Caption = 'Font'
      TabOrder = 1
      OnClick = btTableFontClick
    end
    object btTableColor: TButton
      Left = 267
      Top = 40
      Width = 65
      Height = 33
      Caption = 'Color'
      TabOrder = 2
      OnClick = btTableColorClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 96
    Width = 417
    Height = 273
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1088#1072#1079#1083#1080#1095#1085#1099#1093' '#1089#1086#1089#1090#1086#1103#1085#1080#1081' '#1082#1083#1080#1077#1085#1090#1086#1074':'
    TabOrder = 1
    object btBlocked: TButton
      Left = 339
      Top = 24
      Width = 65
      Height = 33
      Caption = 'Font'
      TabOrder = 0
      OnClick = btBlockedClick
    end
    object pnlBlocked: TPanel
      Left = 16
      Top = 24
      Width = 241
      Height = 33
      Caption = 'Blocked'
      TabOrder = 1
    end
    object pnlnotBusy: TPanel
      Left = 16
      Top = 64
      Width = 241
      Height = 33
      Caption = 'notBusy'
      TabOrder = 2
    end
    object btnotBusy: TButton
      Left = 339
      Top = 64
      Width = 65
      Height = 33
      Caption = 'Font'
      TabOrder = 3
      OnClick = btnotBusyClick
    end
    object pnlAuthenticated: TPanel
      Left = 16
      Top = 104
      Width = 241
      Height = 33
      Caption = 'Authenticated'
      TabOrder = 4
    end
    object btAuthenticated: TButton
      Left = 339
      Top = 104
      Width = 65
      Height = 33
      Caption = 'Font'
      TabOrder = 5
      OnClick = btAuthenticatedClick
    end
    object pnlReserve: TPanel
      Left = 16
      Top = 144
      Width = 241
      Height = 33
      Caption = 'Reserve'
      TabOrder = 6
    end
    object btReserve: TButton
      Left = 339
      Top = 144
      Width = 65
      Height = 33
      Caption = 'Font'
      TabOrder = 7
      OnClick = btReserveClick
    end
    object pnlAccupied: TPanel
      Left = 16
      Top = 184
      Width = 241
      Height = 33
      Caption = 'Accupied'
      TabOrder = 8
    end
    object btAccupied: TButton
      Left = 339
      Top = 184
      Width = 65
      Height = 33
      Caption = 'Font'
      TabOrder = 9
      OnClick = btAccupiedClick
    end
    object pnlPrevented: TPanel
      Left = 16
      Top = 224
      Width = 241
      Height = 33
      Caption = 'Prevented'
      TabOrder = 10
    end
    object btPrevented: TButton
      Left = 339
      Top = 224
      Width = 65
      Height = 33
      Caption = 'Font'
      TabOrder = 11
      OnClick = btPreventedClick
    end
    object btBlockedColor: TButton
      Left = 267
      Top = 24
      Width = 65
      Height = 33
      Caption = 'Color'
      TabOrder = 12
      OnClick = btBlockedColorClick
    end
    object btnotBusyColor: TButton
      Left = 267
      Top = 64
      Width = 65
      Height = 33
      Caption = 'Color'
      TabOrder = 13
      OnClick = btnotBusyColorClick
    end
    object btAuthenticatedColor: TButton
      Left = 267
      Top = 104
      Width = 65
      Height = 33
      Caption = 'Color'
      TabOrder = 14
      OnClick = btAuthenticatedColorClick
    end
    object btReserveColor: TButton
      Left = 267
      Top = 144
      Width = 65
      Height = 33
      Caption = 'Color'
      TabOrder = 15
      OnClick = btReserveColorClick
    end
    object btAccupiedColor: TButton
      Left = 267
      Top = 184
      Width = 65
      Height = 33
      Caption = 'Color'
      TabOrder = 16
      OnClick = btAccupiedColorClick
    end
    object btPreventedColor: TButton
      Left = 267
      Top = 224
      Width = 65
      Height = 33
      Caption = 'Color'
      TabOrder = 17
      OnClick = btPreventedColorClick
    end
  end
  object butCancel: TButton
    Left = 351
    Top = 379
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = butCancelClick
  end
  object butOK: TButton
    Left = 271
    Top = 379
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = butOKClick
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 486
    Top = 8
  end
  object ColorDialog: TColorDialog
    Left = 640
    Top = 200
  end
end
