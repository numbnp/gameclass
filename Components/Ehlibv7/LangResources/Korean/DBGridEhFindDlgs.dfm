object DBGridEhFindDlg: TDBGridEhFindDlg
  Left = 273
  Top = 305
  BorderStyle = bsDialog
  Caption = #47928#51088#50676' '#44160#49353
  ClientHeight = 163
  ClientWidth = 518
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #44404#47548
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 12
    Top = 16
    Width = 75
    Height = 12
    Caption = #52286#51012' '#45236#50857'(&N):'
  end
  object Label2: TLabel
    Left = 12
    Top = 40
    Width = 57
    Height = 12
    Caption = #52286#51012' '#44275'(&I):'
  end
  object cbMatchType: TLabel
    Left = 12
    Top = 64
    Width = 46
    Height = 12
    Caption = #48276#50948'(&H):'
  end
  object Label3: TLabel
    Left = 12
    Top = 88
    Width = 74
    Height = 12
    Caption = #44160#49353' '#48169#54693'(&R):'
  end
  object Label4: TLabel
    Left = 12
    Top = 136
    Width = 80
    Height = 12
    Caption = #53944#47532#50640#49436' '#52286#44592':'
  end
  object cbText: TDBComboBoxEh
    Left = 96
    Top = 12
    Width = 317
    Height = 20
    DynProps = <>
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 0
    Text = 'cbText'
    Visible = True
    OnChange = cbTextChange
  end
  object bFind: TButton
    Left = 424
    Top = 12
    Width = 82
    Height = 28
    Caption = #52286#44592'(&F)'
    TabOrder = 6
    OnClick = bFindClick
  end
  object bCancel: TButton
    Left = 424
    Top = 44
    Width = 82
    Height = 28
    Cancel = True
    Caption = #45803#44592'(&X)'
    ModalResult = 2
    TabOrder = 7
    OnClick = bCancelClick
  end
  object cbFindIn: TDBComboBoxEh
    Left = 96
    Top = 36
    Width = 197
    Height = 20
    DynProps = <>
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 1
    Text = 'cbFindIn'
    Visible = True
    OnChange = cbFindInChange
  end
  object cbMatchinType: TDBComboBoxEh
    Left = 96
    Top = 60
    Width = 161
    Height = 20
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      #54596#46300#51032' '#50612#45712' '#54620' '#48512#48516#48512#53552
      #51204#52404' '#54596#46300
      #54596#46300#51032' '#49884#51089#48512#53552)
    KeyItems.Strings = (
      #54596#46300#51032' '#50612#45712' '#54620' '#48512#48516#48512#53552
      #51204#52404' '#54596#46300
      #54596#46300#51032' '#49884#51089#48512#53552)
    TabOrder = 2
    Text = #51204#52404' '#54596#46300
    Visible = True
  end
  object cbFindDirection: TDBComboBoxEh
    Left = 96
    Top = 84
    Width = 161
    Height = 20
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      #50948#47196
      #50500#47000#47196
      #51204#52404)
    KeyItems.Strings = (
      #50948#47196
      #50500#47000#47196
      #51204#52404)
    TabOrder = 3
    Text = #51204#52404
    Visible = True
    OnChange = cbTextChange
  end
  object cbCharCase: TDBCheckBoxEh
    Left = 100
    Top = 112
    Width = 144
    Height = 14
    Caption = #45824'/'#49548#47928#51088' '#51068#52824'(&C)'
    DynProps = <>
    TabOrder = 4
  end
  object cbUseFormat: TDBCheckBoxEh
    Left = 264
    Top = 112
    Width = 144
    Height = 14
    Caption = #54805#49885' '#51068#52824'(&O)'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 5
  end
  object dbcTreeFindRange: TDBComboBoxEh
    Left = 96
    Top = 132
    Width = 161
    Height = 20
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      #47784#46304' '#45432#46300
      #54869#51109' '#45432#46300
      #54788#51116' '#49688#51456
      #54788#51116' '#45432#46300)
    KeyItems.Strings = (
      #47784#46304' '#45432#46300
      #54869#51109' '#45432#46300
      #54788#51116' '#49688#51456
      #54788#51116' '#45432#46300)
    TabOrder = 8
    Text = #47784#46304' '#45432#46300
    Visible = True
    OnChange = cbTextChange
  end
end
