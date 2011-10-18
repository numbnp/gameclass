object formCompStart: TformCompStart
  Left = 259
  Top = 327
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 10
  Caption = 'formCompStartCaption'
  ClientHeight = 402
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    628
    402)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 180
    Width = 628
    Height = 222
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    TabStop = True
    object lblDescription: TLabel
      Left = 0
      Top = 100
      Width = 53
      Height = 13
      Caption = 'Description'
    end
    object lblTarif: TLabel
      Left = 438
      Top = 0
      Width = 33
      Height = 13
      Caption = #1058#1072#1088#1080#1092
    end
    object pnlComputers: TPanel
      Left = 0
      Top = 8
      Width = 111
      Height = 91
      BevelOuter = bvNone
      Caption = 'pnlComputers'
      TabOrder = 4
    end
    object gbStartTime: TGroupBox
      Left = 118
      Top = 11
      Width = 150
      Height = 86
      Caption = ' '#1053#1072#1095#1072#1083#1086' '#1089#1077#1072#1085#1089#1072' '
      TabOrder = 7
      object dtpStartDate: TDateTimePicker
        Left = 10
        Top = 17
        Width = 90
        Height = 21
        Date = 37647.816767893500000000
        Format = 'd MMMM'
        Time = 37647.816767893500000000
        TabOrder = 0
        OnChange = dtpStartDateChange
      end
      object dtpStartTime: TDateTimePicker
        Left = 10
        Top = 42
        Width = 90
        Height = 37
        Date = 37787.000000000000000000
        Format = 'HH:mm'
        Time = 37787.000000000000000000
        DateMode = dmUpDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        Kind = dtkTime
        ParentFont = False
        TabOrder = 1
        OnChange = dtpStartTimeChange
      end
      object butStartTimeHours: TButton
        Left = 100
        Top = 42
        Width = 40
        Height = 18
        Caption = 'hour'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = popupTimeHours
        TabOrder = 2
        OnMouseDown = butTimeHoursMouseDown
      end
      object butStartTimeMinutes: TButton
        Left = 100
        Top = 60
        Width = 40
        Height = 18
        Caption = 'min'
        PopupMenu = popupTimeMinuts
        TabOrder = 3
        OnMouseDown = butStartTimeMinutesMouseDown
      end
    end
    object gbEndTime: TGroupBox
      Left = 277
      Top = 11
      Width = 151
      Height = 86
      Caption = '                               '
      TabOrder = 8
      object dtpEndDate: TDateTimePicker
        Left = 11
        Top = 17
        Width = 90
        Height = 21
        Date = 37647.816879976900000000
        Format = 'd MMMM'
        Time = 37647.816879976900000000
        Enabled = False
        TabOrder = 2
        OnChange = dtpEndDateChange
      end
      object dtpEndTime: TDateTimePicker
        Left = 11
        Top = 42
        Width = 90
        Height = 37
        Date = 37787.000000000000000000
        Format = 'HH:mm'
        Time = 37787.000000000000000000
        DateMode = dmUpDown
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        Kind = dtkTime
        ParentFont = False
        TabOrder = 3
        OnChange = dtpEndTimeChange
      end
      object butEndTimeMinutes: TButton
        Left = 100
        Top = 60
        Width = 40
        Height = 18
        Caption = 'min'
        PopupMenu = popupTimeMinuts
        TabOrder = 0
        OnMouseDown = butEndTimeMinutesMouseDown
      end
      object butEndTimeHours: TButton
        Left = 100
        Top = 42
        Width = 40
        Height = 18
        Caption = 'hour'
        PopupMenu = popupTimeHours
        TabOrder = 1
        OnMouseDown = butTimeHoursMouseDown
      end
    end
    object cbEndTimeMode: TCheckBox
      Left = 289
      Top = 9
      Width = 87
      Height = 17
      Caption = #1047#1072#1082#1086#1085#1095#1080#1090#1100' '#1074
      TabOrder = 6
      OnKeyUp = cbEndTimeModeKeyUp
      OnMouseUp = cbEndTimeModeMouseUp
    end
    object editDescription: TEdit
      Left = 0
      Top = 116
      Width = 428
      Height = 21
      TabOrder = 5
      OnChange = editDescriptionChange
    end
    object lvTarifs: TListView
      Left = 438
      Top = 16
      Width = 193
      Height = 121
      Columns = <
        item
          Caption = 'Tarif'
          Width = 170
        end>
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      ShowColumnHeaders = False
      TabOrder = 1
      ViewStyle = vsReport
      OnClick = lvTarifsClick
      OnKeyPress = lvTarifsKeyPress
    end
    object cbPostPay: TCheckBox
      Left = 438
      Top = 143
      Width = 150
      Height = 14
      Caption = 'Pay after job'
      TabOrder = 9
      OnKeyUp = cbPostPayKeyUp
      OnMouseUp = cbPostPayMouseUp
    end
    object butCancel: TButton
      Left = 539
      Top = 197
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
      OnClick = butCancelClick
    end
    object butOk: TButton
      Left = 456
      Top = 197
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 3
      OnClick = butOkClick
    end
    object cbReserve: TCheckBox
      Left = 438
      Top = 160
      Width = 118
      Height = 17
      Caption = 'Reserve'
      TabOrder = 10
      OnKeyUp = cbReserveKeyUp
      OnMouseUp = cbReserveMouseUp
    end
    object pnlMoney: TPanel
      Left = 0
      Top = 140
      Width = 428
      Height = 81
      BevelOuter = bvNone
      TabOrder = 0
      object gbMoneyTimeLength: TGroupBox
        Left = 0
        Top = 0
        Width = 294
        Height = 81
        Align = alClient
        Caption = ' '#1044#1083#1080#1085#1072' '#1089#1077#1072#1085#1089#1072' '
        TabOrder = 0
        object pnlTotalCost: TPanel
          Left = 144
          Top = 15
          Width = 0
          Height = 64
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 2
          object lblTotalCost: TLabel
            Left = 0
            Top = 3
            Width = 71
            Height = 13
            Caption = #1054#1073#1097#1072#1103' '#1089#1091#1084#1084#1072
          end
          object edtTotalCost: TCurrencyEdit
            Left = 0
            Top = 20
            Width = 126
            Height = 41
            AutoSize = False
            DisplayFormat = ',0.00;-,0.00'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -27
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            OnChange = editMoneyChange
            OnClick = editMoneyClick
          end
        end
        object pnlCost: TPanel
          Left = 2
          Top = 15
          Width = 142
          Height = 64
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object lblSumma: TLabel
            Left = 8
            Top = 3
            Width = 34
            Height = 13
            Caption = #1057#1091#1084#1084#1072
          end
          object editMoney: TCurrencyEdit
            Left = 8
            Top = 20
            Width = 126
            Height = 41
            AutoSize = False
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -27
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = editMoneyChange
            OnClick = editMoneyClick
            OnKeyUp = editMoneyKeyUp
          end
        end
        object pnlTimeLength: TPanel
          Left = 144
          Top = 15
          Width = 148
          Height = 64
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object lblTimeLength: TLabel
            Left = 0
            Top = 3
            Width = 33
            Height = 13
            Caption = #1042#1088#1077#1084#1103
          end
          object butTimeLengthHours: TButton
            Left = 100
            Top = 20
            Width = 40
            Height = 20
            Caption = 'hour'
            PopupMenu = popupTimeLengthHours
            TabOrder = 0
            TabStop = False
            OnClick = butTimeLengthHoursClick
            OnMouseDown = butTimeLengthHoursMouseDown
          end
          object butTimeLengthMinutes: TButton
            Left = 100
            Top = 41
            Width = 40
            Height = 20
            Caption = 'min'
            PopupMenu = popupTimeLengthMinuts
            TabOrder = 1
            TabStop = False
            OnClick = butTimeLengthMinutesClick
            OnMouseDown = butTimeLengthMinutesMouseDown
          end
          object dtpTimeLength: TDateTimePicker
            Left = 0
            Top = 20
            Width = 100
            Height = 41
            Date = 37787.000000000000000000
            Format = 'HH:mm'
            Time = 37787.000000000000000000
            DateMode = dmUpDown
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -27
            Font.Name = 'Tahoma'
            Font.Style = []
            Kind = dtkTime
            ParentFont = False
            TabOrder = 2
            TabStop = False
            OnChange = dtpTimeLengthChange
            OnEnter = dtpTimeLengthClick
          end
        end
      end
      object pnlHideTotalCost: TPanel
        Left = 294
        Top = 0
        Width = 134
        Height = 81
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
      end
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 180
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
  end
  object pnlScale: TPanel
    Left = 576
    Top = 1
    Width = 36
    Height = 49
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 0
    object radio12Hours: TRadioButton
      Left = 3
      Top = 0
      Width = 37
      Height = 17
      Caption = '12'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = radioHoursClick
    end
    object radio24Hours: TRadioButton
      Left = 3
      Top = 16
      Width = 37
      Height = 17
      Caption = '24'
      TabOrder = 1
      OnClick = radioHoursClick
    end
    object radio48Hours: TRadioButton
      Left = 3
      Top = 32
      Width = 37
      Height = 17
      Caption = '48'
      TabOrder = 2
      OnClick = radioHoursClick
    end
  end
  object timerFrmCompStart: TTimer
    Enabled = False
    OnTimer = timerFrmCompStartTimer
    Left = 6
    Top = 133
  end
  object popupTimeLengthMinuts: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 8
    Top = 37
    object min10: TMenuItem
      Caption = '10'
      OnClick = TimeLengthMinClick
    end
    object min15: TMenuItem
      Caption = '15'
      OnClick = TimeLengthMinClick
    end
    object min20: TMenuItem
      Caption = '20'
      OnClick = TimeLengthMinClick
    end
    object min25: TMenuItem
      Caption = '25'
      OnClick = TimeLengthMinClick
    end
    object min30: TMenuItem
      Caption = '30'
      OnClick = TimeLengthMinClick
    end
    object min35: TMenuItem
      Caption = '35'
      OnClick = TimeLengthMinClick
    end
    object min40: TMenuItem
      Caption = '40'
      OnClick = TimeLengthMinClick
    end
    object min45: TMenuItem
      Caption = '45'
      OnClick = TimeLengthMinClick
    end
    object min50: TMenuItem
      Caption = '50'
      OnClick = TimeLengthMinClick
    end
    object min55: TMenuItem
      Caption = '55'
      OnClick = TimeLengthMinClick
    end
  end
  object popupTimeLengthHours: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 8
    Top = 5
    object hour1: TMenuItem
      Caption = '1:00'
      OnClick = TimeLengthHourClick
    end
    object hour2: TMenuItem
      Caption = '1:30'
      OnClick = TimeLengthHourClick
    end
    object hour3: TMenuItem
      Caption = '2:00'
      OnClick = TimeLengthHourClick
    end
    object hour4: TMenuItem
      Caption = '2:30'
      OnClick = TimeLengthHourClick
    end
    object hour5: TMenuItem
      Caption = '3:00'
      OnClick = TimeLengthHourClick
    end
    object hour6: TMenuItem
      Caption = '3:30'
      OnClick = TimeLengthHourClick
    end
    object hour7: TMenuItem
      Caption = '4:00'
      OnClick = TimeLengthHourClick
    end
  end
  object popupTimeHours: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 8
    Top = 69
    object hours0: TMenuItem
      Caption = '0:00'
      OnClick = TimeHourClick
    end
    object hours1: TMenuItem
      Caption = '1:00'
      OnClick = TimeHourClick
    end
    object hours2: TMenuItem
      Caption = '2:00'
      OnClick = TimeHourClick
    end
    object hours3: TMenuItem
      Caption = '3:00'
      OnClick = TimeHourClick
    end
    object hours4: TMenuItem
      Caption = '4:00'
      OnClick = TimeHourClick
    end
    object hours5: TMenuItem
      Caption = '5:00'
      OnClick = TimeHourClick
    end
    object hours6: TMenuItem
      Caption = '6:00'
      OnClick = TimeHourClick
    end
    object hours7: TMenuItem
      Caption = '7:00'
      OnClick = TimeHourClick
    end
    object hours8: TMenuItem
      Caption = '8:00'
      OnClick = TimeHourClick
    end
    object hours9: TMenuItem
      Caption = '9:00'
      OnClick = TimeHourClick
    end
    object hours10: TMenuItem
      Caption = '10:00'
      OnClick = TimeHourClick
    end
    object hours11: TMenuItem
      Caption = '11:00'
      OnClick = TimeHourClick
    end
    object hours12: TMenuItem
      Break = mbBarBreak
      Caption = '12:00'
      OnClick = TimeHourClick
    end
    object hours13: TMenuItem
      Caption = '13:00'
      OnClick = TimeHourClick
    end
    object hours14: TMenuItem
      Caption = '14:00'
      OnClick = TimeHourClick
    end
    object hours15: TMenuItem
      Caption = '15:00'
      OnClick = TimeHourClick
    end
    object hours16: TMenuItem
      Caption = '16:00'
      OnClick = TimeHourClick
    end
    object hours17: TMenuItem
      Caption = '17:00'
      OnClick = TimeHourClick
    end
    object hours18: TMenuItem
      Caption = '18:00'
      OnClick = TimeHourClick
    end
    object hours19: TMenuItem
      Caption = '19:00'
      OnClick = TimeHourClick
    end
    object hours20: TMenuItem
      Caption = '20:00'
      OnClick = TimeHourClick
    end
    object hours21: TMenuItem
      Caption = '21:00'
      OnClick = TimeHourClick
    end
    object hours22: TMenuItem
      Caption = '22:00'
      OnClick = TimeHourClick
    end
    object hours23: TMenuItem
      Caption = '23:00'
      OnClick = TimeHourClick
    end
  end
  object popupTimeMinuts: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 8
    Top = 101
    object EndTimeMinuts10: TMenuItem
      Caption = '10'
      OnClick = TimeMinClick
    end
    object EndTimeMinuts15: TMenuItem
      Caption = '15'
      OnClick = TimeMinClick
    end
    object EndTimeMinuts20: TMenuItem
      Caption = '20'
      OnClick = TimeMinClick
    end
    object EndTimeMinuts25: TMenuItem
      Caption = '25'
      OnClick = TimeMinClick
    end
    object EndTimeMinuts30: TMenuItem
      Caption = '30'
      OnClick = TimeMinClick
    end
    object EndTimeMinuts35: TMenuItem
      Caption = '35'
      OnClick = TimeMinClick
    end
    object EndTimeMinuts40: TMenuItem
      Caption = '40'
      OnClick = TimeMinClick
    end
    object EndTimeMinuts45: TMenuItem
      Caption = '45'
      OnClick = TimeMinClick
    end
    object EndTimeMinuts50: TMenuItem
      Caption = '50'
      OnClick = TimeMinClick
    end
    object EndTimeMinuts55: TMenuItem
      Caption = '55'
      OnClick = TimeMinClick
    end
  end
  object popupSession: TPopupMenu
    Left = 8
    Top = 168
    object mnuCancel: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    end
  end
end
