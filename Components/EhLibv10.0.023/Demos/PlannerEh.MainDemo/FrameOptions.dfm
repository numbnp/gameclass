inherited frFrameOptions: TfrFrameOptions
  Width = 736
  Height = 613
  object PaintBox2: TPaintBox
    Left = 249
    Top = 107
    Width = 121
    Height = 17
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnPaint = PaintBox2Paint
  end
  object Label2: TLabel
    Left = 19
    Top = 108
    Width = 96
    Height = 13
    Caption = 'Holydays  Font color'
  end
  object pbCurDateTimeFrame: TPaintBox
    Left = 249
    Top = 255
    Width = 121
    Height = 17
    OnPaint = pbCurDateTimeFramePaint
  end
  object Label3: TLabel
    Left = 19
    Top = 256
    Width = 163
    Height = 13
    Caption = 'Current Date and Time frame Color'
  end
  object Label4: TLabel
    Left = 19
    Top = 139
    Width = 61
    Height = 13
    Caption = 'Work week: '
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 719
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 719
      Height = 36
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnPaint = PaintBox1Paint
    end
    object Label1: TLabel
      Left = 19
      Top = 7
      Width = 75
      Height = 23
      Caption = 'Options'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object chbHighlightWeekend: TDBCheckBoxEh
    Left = 19
    Top = 56
    Width = 134
    Height = 17
    Caption = 'Highlight weekend'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 1
    OnClick = chbHighlightWeekendClick
  end
  object chbHighlightHolidays: TDBCheckBoxEh
    Left = 19
    Top = 82
    Width = 110
    Height = 17
    Caption = 'Highlight holidays'
    DynProps = <>
    TabOrder = 2
    OnClick = chbHighlightHolidaysClick
  end
  object cbxCountryCode: TDBComboBoxEh
    Left = 249
    Top = 80
    Width = 121
    Height = 21
    ControlLabel.Width = 78
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Holidays country'
    ControlLabel.Visible = True
    ControlLabelLocation.Spacing = 10
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      'US'
      'FR')
    KeyItems.Strings = (
      'US'
      'FR')
    TabOrder = 3
    Text = 'US'
    Visible = True
    OnChange = cbxCountryCodeChange
  end
  object Button1: TButton
    Left = 376
    Top = 106
    Width = 57
    Height = 20
    Caption = '...'
    TabOrder = 4
    OnClick = Button1Click
  end
  object MonthCalendar1: TMonthCalendar
    Left = 282
    Top = 524
    Width = 184
    Height = 160
    Date = 42572.433022662040000000
    ShowTodayCircle = False
    TabOrder = 5
    WeekNumbers = True
  end
  object PlannerControlEh1: TPlannerControlEh
    Left = 280
    Top = 325
    Width = 257
    Height = 193
    ActivePlannerView = PlannerDayViewEh1
    PrintService.ColorSchema = pcsFullColorEh
    TabOrder = 6
    object PlannerDayViewEh1: TPlannerDayViewEh
      Left = 0
      Top = 41
      Width = 253
      Height = 148
    end
  end
  object PlannerCalendarPickerEh1: TPlannerCalendarPickerEh
    Left = 19
    Top = 327
    Width = 220
    Height = 191
    PlannerControl = PlannerControlEh1
    ParentCtl3D = False
    ParentColor = False
    TabOrder = 7
  end
  object bDefaultHolidayFontColor: TButton
    Left = 439
    Top = 106
    Width = 57
    Height = 20
    Caption = 'Default'
    TabOrder = 8
    OnClick = bDefaultHolidayFontColorClick
  end
  object bCurDateTimeFrame: TButton
    Left = 376
    Top = 254
    Width = 57
    Height = 20
    Caption = '...'
    TabOrder = 9
    OnClick = bCurDateTimeFrameClick
  end
  object bCurDateTimeFrameDefault: TButton
    Left = 439
    Top = 254
    Width = 57
    Height = 20
    Caption = 'Default'
    TabOrder = 10
    OnClick = bCurDateTimeFrameDefaultClick
  end
  object cbHighlightToday: TDBCheckBoxEh
    Left = 19
    Top = 228
    Width = 134
    Height = 17
    Caption = 'Highlight today'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 11
    OnClick = cbHighlightTodayClick
  end
  object cbShowRefToToday: TDBCheckBoxEh
    Left = 19
    Top = 287
    Width = 302
    Height = 17
    Caption = 'Show Ref To Today In PlannerCalendarPicker'
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 12
    OnClick = cbShowRefToTodayClick
  end
  object cbHideNotworkHours: TDBCheckBoxEh
    Left = 19
    Top = 176
    Width = 132
    Height = 17
    Caption = 'Hide not work time'
    DynProps = <>
    TabOrder = 13
    OnClick = cbHideNotworkHoursClick
  end
  object dteStartWorkTime: TDBDateTimeEditEh
    Left = 249
    Top = 174
    Width = 68
    Height = 21
    ControlLabel.Width = 70
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Start work time'
    ControlLabel.Visible = True
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    TabOrder = 14
    Visible = True
    EditFormat = 'HH:NN'
  end
  object dteEndWorkTime: TDBDateTimeEditEh
    Left = 249
    Top = 199
    Width = 68
    Height = 21
    ControlLabel.Width = 67
    ControlLabel.Height = 13
    ControlLabel.Caption = 'End work time'
    ControlLabel.Visible = True
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    TabOrder = 15
    Visible = True
    EditFormat = 'HH:NN'
  end
  object chbSun: TDBCheckBoxEh
    Left = 100
    Top = 138
    Width = 39
    Height = 17
    Caption = 'Sun'
    DynProps = <>
    TabOrder = 16
    OnClick = chbSunClick
  end
  object chbMon: TDBCheckBoxEh
    Left = 150
    Top = 138
    Width = 39
    Height = 17
    Caption = 'Mon'
    DynProps = <>
    TabOrder = 17
    OnClick = chbSunClick
  end
  object chbTue: TDBCheckBoxEh
    Left = 200
    Top = 138
    Width = 39
    Height = 17
    Caption = 'Tue'
    DynProps = <>
    TabOrder = 18
    OnClick = chbSunClick
  end
  object chbWed: TDBCheckBoxEh
    Left = 250
    Top = 138
    Width = 39
    Height = 17
    Caption = 'Wed'
    DynProps = <>
    TabOrder = 19
    OnClick = chbSunClick
  end
  object chbThu: TDBCheckBoxEh
    Left = 300
    Top = 138
    Width = 39
    Height = 17
    Caption = 'Thu'
    DynProps = <>
    TabOrder = 20
    OnClick = chbSunClick
  end
  object chbFri: TDBCheckBoxEh
    Left = 350
    Top = 138
    Width = 39
    Height = 17
    Caption = 'Fri'
    DynProps = <>
    TabOrder = 21
    OnClick = chbSunClick
  end
  object chbSat: TDBCheckBoxEh
    Left = 400
    Top = 138
    Width = 39
    Height = 17
    Caption = 'Sat'
    DynProps = <>
    TabOrder = 22
    OnClick = chbSunClick
  end
  object ColorDialog1: TColorDialog
    Left = 371
    Top = 269
  end
end
