object frmManageOptionsFrame: TfrmManageOptionsFrame
  Left = 329
  Top = 175
  BorderStyle = bsNone
  Caption = 'Manage'
  ClientHeight = 375
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    405
    375)
  PixelsPerInch = 96
  TextHeight = 13
  object cbxOneClickSelect: TCheckBox
    Left = 16
    Top = 104
    Width = 363
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'One Click Select'
    TabOrder = 0
    OnClick = ControlValueChange
  end
  object btnClearTempData: TButton
    Left = 16
    Top = 152
    Width = 129
    Height = 25
    Caption = 'Clear Database Settings'
    TabOrder = 2
    OnClick = btnClearTempDataClick
  end
  object cbxAutoclearDatabaseSettings: TCheckBox
    Left = 16
    Top = 128
    Width = 371
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Autoclear Database Settings'
    TabOrder = 1
    OnClick = cbxAutoclearDatabaseSettingsClick
  end
  object pnlUpdateSettings: TGroupBox
    Left = 8
    Top = 8
    Width = 391
    Height = 89
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Update'
    TabOrder = 3
    DesignSize = (
      391
      89)
    object lblUpdateURL: TLabel
      Left = 16
      Top = 25
      Width = 63
      Height = 13
      Caption = 'Update URL:'
    end
    object lblHTTP: TLabel
      Left = 128
      Top = 25
      Width = 31
      Height = 13
      Caption = 'http://'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object cbxAutocheckUpdates: TCheckBox
      Left = 16
      Top = 48
      Width = 279
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Autocheck Updates'
      TabOrder = 0
      OnClick = ControlValueChange
    end
    object edtUpdateURL: TEdit
      Left = 164
      Top = 21
      Width = 214
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'www.tkz.su'
      OnChange = ControlValueChange
    end
  end
end
