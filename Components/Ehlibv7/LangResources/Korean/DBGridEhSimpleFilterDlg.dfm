object DBGridEhSimpleFilterDialog: TDBGridEhSimpleFilterDialog
  Left = 734
  Top = 312
  BorderStyle = bsDialog
  Caption = #49324#50857#51088' '#51221#51032' '#54596#53552
  ClientHeight = 213
  ClientWidth = 436
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #44404#47548
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 12
    Top = 16
    Width = 56
    Height = 12
    Caption = #52286#51012' '#51312#44148':'
  end
  object Bevel1: TBevel
    Left = 12
    Top = 36
    Width = 409
    Height = 8
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 12
    Top = 136
    Width = 408
    Height = 12
    Caption = #52286#51004#47140#45716' '#47928#51088#50676#51032' '#51068#48512#48516#51060' '#54869#49892#54616#51648' '#50506#51004#47732' '#39'_'#39' '#46608#45716' '#39'%'#39#47484' '#50024#49436' '#52286#49845#45768#45796'.'
  end
  object Label3: TLabel
    Left = 12
    Top = 156
    Width = 244
    Height = 12
    Caption = #39'_'#39#45716' '#54620' '#44544#51088', '#39'%'#39#45716' '#50668#47084' '#44544#51088#47484' '#45208#53440#45253#45768#45796'.'
  end
  object ComboBox2: TComboBox
    Left = 12
    Top = 100
    Width = 201
    Height = 20
    Style = csDropDownList
    DropDownCount = 13
    TabOrder = 4
    Items.Strings = (
      ''
      'equals'
      'does not equal'
      'is greate than'
      'is greate than or equall to'
      'is less than'
      'is less than or equall to'
      'like'
      'not like'
      'in'
      'not in'
      'is blank'
      'is not blank')
  end
  object ComboBox1: TComboBox
    Left = 12
    Top = 48
    Width = 201
    Height = 20
    Style = csDropDownList
    DropDownCount = 13
    TabOrder = 0
    Items.Strings = (
      ''
      'equals'
      'does not equal'
      'is greate than'
      'is greate than or equall to'
      'is less than'
      'is less than or equall to'
      'like'
      'not like'
      'in'
      'not in'
      'is blank'
      'is not blank')
  end
  object Edit2: TEdit
    Left = 220
    Top = 100
    Width = 201
    Height = 20
    TabOrder = 5
    Visible = False
  end
  object Edit1: TEdit
    Left = 220
    Top = 48
    Width = 201
    Height = 20
    TabOrder = 1
    Visible = False
  end
  object rbOr: TRadioButton
    Left = 120
    Top = 76
    Width = 68
    Height = 17
    Caption = #46608#45716'(&R)'
    TabOrder = 3
  end
  object rbAnd: TRadioButton
    Left = 28
    Top = 76
    Width = 75
    Height = 17
    Caption = #44536#47532#44256'(&A)'
    Checked = True
    TabOrder = 2
    TabStop = True
  end
  object bOk: TButton
    Left = 256
    Top = 176
    Width = 81
    Height = 28
    Caption = #54869#51064'(&O)'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object bCancel: TButton
    Left = 340
    Top = 176
    Width = 81
    Height = 28
    Cancel = True
    Caption = #52712#49548'(&X)'
    ModalResult = 2
    TabOrder = 7
  end
  object DBComboBoxEh1: TDBComboBoxEh
    Left = 224
    Top = 52
    Width = 201
    Height = 20
    DynProps = <>
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 8
    Text = 'DBComboBoxEh1'
    Visible = False
    OnChange = DBComboBoxEh1Change
  end
  object DBComboBoxEh2: TDBComboBoxEh
    Left = 224
    Top = 104
    Width = 201
    Height = 20
    DynProps = <>
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 9
    Text = 'DBComboBoxEh2'
    Visible = False
    OnChange = DBComboBoxEh1Change
  end
  object DBDateTimeEditEh1: TDBDateTimeEditEh
    Left = 228
    Top = 56
    Width = 201
    Height = 20
    DynProps = <>
    EditButtons = <>
    Kind = dtkDateEh
    TabOrder = 10
    Visible = False
  end
  object DBDateTimeEditEh2: TDBDateTimeEditEh
    Left = 228
    Top = 108
    Width = 201
    Height = 20
    DynProps = <>
    EditButtons = <>
    Kind = dtkDateEh
    TabOrder = 11
    Visible = False
  end
  object DBNumberEditEh1: TDBNumberEditEh
    Left = 232
    Top = 60
    Width = 201
    Height = 20
    DynProps = <>
    EditButtons = <>
    TabOrder = 12
    Visible = False
  end
  object DBNumberEditEh2: TDBNumberEditEh
    Left = 232
    Top = 112
    Width = 201
    Height = 20
    DynProps = <>
    EditButtons = <>
    TabOrder = 13
    Visible = False
  end
end
