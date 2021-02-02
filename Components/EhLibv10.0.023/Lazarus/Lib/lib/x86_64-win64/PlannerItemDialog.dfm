object PlannerItemForm: TPlannerItemForm
  Left = 529
  Top = 312
  AutoScroll = False
  Caption = 'Planner Item'
  ClientHeight = 346
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    480
    346)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 24
    Height = 13
    Caption = 'Title:'
  end
  object Label2: TLabel
    Left = 8
    Top = 51
    Width = 51
    Height = 13
    Caption = 'Start time:'
  end
  object Label3: TLabel
    Left = 8
    Top = 82
    Width = 45
    Height = 13
    Caption = 'End time:'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 33
    Width = 461
    Height = 12
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object bvlAfterResource: TBevel
    Left = 8
    Top = 153
    Width = 461
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Bevel3: TBevel
    Left = 11
    Top = 304
    Width = 458
    Height = 9
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object bevelAfterDateTime: TBevel
    Left = 8
    Top = 108
    Width = 461
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object AllDayCheck: TCheckBox
    Left = 335
    Top = 79
    Width = 97
    Height = 17
    Caption = 'All day event'
    TabOrder = 0
  end
  object OKButton: TButton
    Left = 296
    Top = 315
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 376
    Top = 315
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object eTitle: TDBEditEh
    Left = 80
    Top = 8
    Width = 391
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DynProps = <>
    EditButtons = <>
    TabOrder = 3
    Text = 'ItemTitle'
    Visible = True
  end
  object cbStartTimeEdit: TDBComboBoxEh
    Left = 232
    Top = 48
    Width = 98
    Height = 21
    DynProps = <>
    DropDownBox.Rows = 20
    DropDownBox.Sizable = True
    EditButtons = <>
    Items.Strings = (
      '00:00'
      '00:30'
      '01:00'
      '01:30'
      '02:00'
      '02:30'
      '03:00'
      '03:30'
      '04:00'
      '04:30'
      '05:00'
      '05:30'
      '06:00'
      '06:30'
      '07:00'
      '07:30'
      '08:00'
      '08:30'
      '09:00'
      '09:30'
      '10:00'
      '10:30'
      '11:00'
      '11:30'
      '12:00'
      '12:30'
      '13:00'
      '13:30'
      '14:00'
      '14:30'
      '15:00'
      '15:30'
      '16:00'
      '16:30'
      '17:00'
      '17:30'
      '18:00'
      '18:30'
      '19:00'
      '19:30'
      '20:00'
      '20:30'
      '21:00'
      '21:30'
      '22:00'
      '22:30'
      '23:00'
      '23:30')
    TabOrder = 4
    Text = 'cbStartTimeEdit'
    Visible = False
    OnChange = cbStartTimeEditChange
    OnEnter = cbStartTimeEditEnter
  end
  object cbFinishTimeEdit: TDBComboBoxEh
    Left = 231
    Top = 79
    Width = 98
    Height = 21
    DynProps = <>
    DropDownBox.Rows = 20
    DropDownBox.Sizable = True
    EditButtons = <>
    Items.Strings = (
      '00:00'
      '00:30'
      '01:00'
      '01:30'
      '02:00'
      '02:30'
      '03:00'
      '03:30'
      '04:00'
      '04:30'
      '05:00'
      '05:30'
      '06:00'
      '06:30'
      '07:00'
      '07:30'
      '08:00'
      '08:30'
      '09:00'
      '09:30'
      '10:00'
      '10:30'
      '11:00'
      '11:30'
      '12:00'
      '12:30'
      '13:00'
      '13:30'
      '14:00'
      '14:30'
      '15:00'
      '15:30'
      '16:00'
      '16:30'
      '17:00'
      '17:30'
      '18:00'
      '18:30'
      '19:00'
      '19:30'
      '20:00'
      '20:30'
      '21:00'
      '21:30'
      '22:00'
      '22:30'
      '23:00'
      '23:30')
    TabOrder = 5
    Visible = False
  end
  object eBody: TDBMemoEh
    Left = 8
    Top = 161
    Width = 461
    Height = 135
    Lines.Strings = (
      'eBody')
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    DynProps = <>
    EditButtons = <>
    TabOrder = 6
    Visible = True
    WantReturns = True
  end
  object cbxRecource: TDBComboBoxEh
    Left = 60
    Top = 120
    Width = 409
    Height = 21
    ControlLabel.Width = 49
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Resource:'
    ControlLabel.Visible = True
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    Anchors = [akLeft, akTop, akRight]
    DynProps = <>
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 7
    Text = 'cbxRecource'
    Visible = True
  end
  object StartDateEdit: TDBDateTimeEditEh
    Left = 97
    Top = 48
    Width = 113
    Height = 21
    DynProps = <>
    EditButtons = <>
    Kind = dtkDateEh
    TabOrder = 8
    Visible = True
    OnChange = StartDateEditChange
    OnEnter = StartDateEditEnter
  end
  object EndDateEdit: TDBDateTimeEditEh
    Left = 97
    Top = 79
    Width = 113
    Height = 21
    DynProps = <>
    EditButtons = <>
    Kind = dtkDateEh
    TabOrder = 9
    Visible = True
  end
  object StartTimeEdit: TDBDateTimeEditEh
    Left = 216
    Top = 48
    Width = 98
    Height = 21
    DynProps = <>
    EditButtons = <>
    TabOrder = 10
    Visible = True
    OnChange = StartTimeEditChange
    OnEnter = StartTimeEditEnter
    EditFormat = 'HH:NN'
  end
  object FinishTimeEdit: TDBDateTimeEditEh
    Left = 216
    Top = 79
    Width = 98
    Height = 21
    DynProps = <>
    EditButtons = <>
    TabOrder = 11
    Visible = True
    OnChange = StartTimeEditChange
    OnEnter = StartTimeEditEnter
    EditFormat = 'HH:NN'
  end
end
