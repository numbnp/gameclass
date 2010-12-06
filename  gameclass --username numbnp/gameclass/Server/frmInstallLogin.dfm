object formInstallLogin: TformInstallLogin
  Left = 479
  Top = 278
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1051#1086#1075#1080#1085#1086#1074' '
  ClientHeight = 151
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object labelInstalLoginTop: TLabel
    Left = 16
    Top = 96
    Width = 325
    Height = 13
    Caption = 'Windows-'#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088' ('#1076#1086#1083#1078#1077#1085' '#1073#1099#1090#1100' '#1085#1072' '#1082#1072#1078#1076#1086#1084' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1077')'
    WordWrap = True
  end
  object butOk: TButton
    Left = 208
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 0
    OnClick = butOkClick
  end
  object butCancel: TButton
    Left = 288
    Top = 120
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = butCancelClick
  end
  object gbPass: TGroupBox
    Left = 8
    Top = 8
    Width = 353
    Height = 81
    TabOrder = 1
    object labelPassword: TLabel
      Left = 92
      Top = 44
      Width = 38
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1072#1088#1086#1083#1100
    end
    object labelUser: TLabel
      Left = 20
      Top = 16
      Width = 109
      Height = 13
      Alignment = taRightJustify
      Caption = #1048#1084#1103' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072
    end
    object editPassword: TEdit
      Left = 140
      Top = 44
      Width = 193
      Height = 21
      PasswordChar = '*'
      TabOrder = 0
    end
    object editUser: TEdit
      Left = 140
      Top = 16
      Width = 193
      Height = 21
      TabOrder = 1
    end
  end
end
