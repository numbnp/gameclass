object frmChangePass: TfrmChangePass
  Left = 291
  Top = 295
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Change user password'
  ClientHeight = 146
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblOldPass: TLabel
    Left = 16
    Top = 20
    Width = 80
    Height = 13
    Caption = #1057#1090#1072#1088#1099#1081' '#1087#1072#1088#1086#1083#1100':'
  end
  object lblNewPass: TLabel
    Left = 16
    Top = 52
    Width = 76
    Height = 13
    Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
  end
  object lblRepeat: TLabel
    Left = 16
    Top = 84
    Width = 84
    Height = 13
    Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077':'
  end
  object editOldPass: TEdit
    Left = 112
    Top = 16
    Width = 153
    Height = 21
    MaxLength = 50
    PasswordChar = '*'
    TabOrder = 0
  end
  object editNewPass: TEdit
    Left = 112
    Top = 48
    Width = 153
    Height = 21
    MaxLength = 50
    PasswordChar = '*'
    TabOrder = 1
    OnChange = editNewPassChange
  end
  object editRepeat: TEdit
    Left = 112
    Top = 80
    Width = 153
    Height = 21
    MaxLength = 50
    PasswordChar = '*'
    TabOrder = 2
    OnChange = editNewPassChange
  end
  object butOk: TButton
    Left = 104
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 3
    OnClick = butOkClick
  end
  object butCancel: TButton
    Left = 192
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = butCancelClick
  end
end
