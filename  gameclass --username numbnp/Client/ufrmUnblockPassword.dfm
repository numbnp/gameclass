object frmUnblockPassword: TfrmUnblockPassword
  Left = 456
  Top = 305
  Width = 282
  Height = 84
  BorderIcons = [biSystemMenu]
  Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edtUnblockPassword: TEdit
    Left = 16
    Top = 16
    Width = 153
    Height = 20
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Wingdings'
    Font.Style = []
    MaxLength = 50
    ParentFont = False
    PasswordChar = 'l'
    TabOrder = 0
    OnKeyUp = edtUnblockPasswordKeyUp
  end
  object btnOk: TButton
    Left = 184
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    OnClick = btnOkClick
  end
end
