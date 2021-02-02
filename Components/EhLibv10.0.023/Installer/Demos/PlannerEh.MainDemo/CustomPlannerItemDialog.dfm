object CustomPlannerItemForm: TCustomPlannerItemForm
  Left = 578
  Top = 209
  Width = 433
  Height = 452
  Caption = 'Planner Item'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    417
    414)
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
    Width = 403
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Bevel2: TBevel
    Left = 8
    Top = 153
    Width = 398
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Bevel3: TBevel
    Left = 11
    Top = 332
    Width = 398
    Height = 9
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object Bevel4: TBevel
    Left = 8
    Top = 108
    Width = 398
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label4: TLabel
    Left = 8
    Top = 350
    Width = 115
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Category (Custom field)'
  end
  object StartDateEdit: TDateTimePicker
    Left = 64
    Top = 48
    Width = 113
    Height = 21
    Date = 0.746743055562546900
    Time = 0.746743055562546900
    TabOrder = 0
    OnChange = StartDateEditChange
    OnEnter = StartDateEditEnter
  end
  object EndDateEdit: TDateTimePicker
    Left = 64
    Top = 79
    Width = 113
    Height = 21
    Date = 0.747894490741600700
    Time = 0.747894490741600700
    TabOrder = 1
  end
  object AllDayCheck: TCheckBox
    Left = 302
    Top = 79
    Width = 97
    Height = 17
    Caption = 'All day event'
    TabOrder = 2
  end
  object OKButton: TButton
    Left = 253
    Top = 382
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object CancelButton: TButton
    Left = 333
    Top = 382
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object eTitle: TDBEditEh
    Left = 38
    Top = 8
    Width = 371
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DynProps = <>
    EditButtons = <>
    TabOrder = 5
    Text = 'ItemTitle'
    Visible = True
  end
  object cbStartTimeEdit: TDBComboBoxEh
    Left = 183
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
    TabOrder = 6
    Text = 'cbStartTimeEdit'
    Visible = True
    OnChange = cbStartTimeEditChange
    OnEnter = cbStartTimeEditEnter
  end
  object cbFinishTimeEdit: TDBComboBoxEh
    Left = 183
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
    TabOrder = 7
    Visible = True
  end
  object eBody: TDBMemoEh
    Left = 8
    Top = 161
    Width = 401
    Height = 165
    Lines.Strings = (
      'eBody')
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    DynProps = <>
    EditButtons = <>
    TabOrder = 8
    Visible = True
    WantReturns = True
  end
  object cbxRecource: TDBComboBoxEh
    Left = 60
    Top = 120
    Width = 349
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
    TabOrder = 9
    Text = 'cbxRecource'
    Visible = True
  end
  object cmbCategory: TDBComboBoxEh
    Left = 144
    Top = 347
    Width = 262
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      'Category One'
      'Category Two'
      'Category Three')
    KeyItems.Strings = (
      '1'
      '2'
      '3')
    TabOrder = 10
    Visible = True
  end
end
