object formCompAdd: TformCompAdd
  Left = 865
  Top = 133
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 10
  Caption = 'formCompAdd'
  ClientHeight = 183
  ClientWidth = 445
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
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 445
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object pnlComputers: TPanel
      Left = 0
      Top = 0
      Width = 121
      Height = 97
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'pnlComputers'
      TabOrder = 0
    end
    object pnlStartTime: TPanel
      Left = 121
      Top = 0
      Width = 121
      Height = 97
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'pnlStartTime'
      TabOrder = 1
      object gbStartTime: TGroupBox
        Left = 0
        Top = 0
        Width = 111
        Height = 86
        Caption = ' '#1053#1072#1095#1072#1083#1086' '#1089#1077#1072#1085#1089#1072' '
        TabOrder = 0
        object dtpStartDate: TDateTimePicker
          Left = 10
          Top = 17
          Width = 90
          Height = 21
          Date = 37647.816767893500000000
          Format = 'd MMMM'
          Time = 37647.816767893500000000
          Enabled = False
          TabOrder = 0
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
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Tahoma'
          Font.Style = []
          Kind = dtkTime
          ParentFont = False
          TabOrder = 1
        end
      end
    end
    object pnlEndTime: TPanel
      Left = 242
      Top = 0
      Width = 161
      Height = 97
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
      object gbEndTime: TGroupBox
        Left = 0
        Top = 0
        Width = 151
        Height = 86
        Caption = '                               '
        TabOrder = 0
        object dtpEndDate: TDateTimePicker
          Left = 11
          Top = 17
          Width = 90
          Height = 21
          Date = 37647.816879976900000000
          Format = 'd MMMM'
          Time = 37647.816879976900000000
          Enabled = False
          TabOrder = 0
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
          TabOrder = 1
          OnChange = dtpEndTimeChange
        end
        object butEndTimeMinutes: TButton
          Left = 100
          Top = 60
          Width = 40
          Height = 18
          Caption = 'min'
          PopupMenu = popupEndTimeMinuts
          TabOrder = 2
          OnMouseDown = butTimeMouseDown
        end
        object butEndTimeHours: TButton
          Left = 100
          Top = 42
          Width = 40
          Height = 18
          Caption = 'hour'
          PopupMenu = popupEndTimeHours
          TabOrder = 3
          OnMouseDown = butTimeMouseDown
        end
      end
      object cbxEndTimeMode: TCheckBox
        Left = 11
        Top = -2
        Width = 87
        Height = 17
        Caption = #1047#1072#1082#1086#1085#1095#1080#1090#1100' '#1074
        TabOrder = 1
        OnClick = cbxEndTimeModeClick
      end
    end
    object pnlSessionInfo: TPanel
      Left = 403
      Top = 0
      Width = 42
      Height = 97
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 3
      object lblStart: TLabel
        Left = 0
        Top = 20
        Width = 37
        Height = 13
        Caption = #1053#1072#1095#1072#1083#1086
      end
      object lblTarif: TLabel
        Left = 152
        Top = 20
        Width = 33
        Height = 13
        Caption = #1058#1072#1088#1080#1092
      end
      object dtpStart: TDateTimePicker
        Left = 0
        Top = 36
        Width = 140
        Height = 21
        Date = 37647.816767893500000000
        Format = 'd MMMM HH:mm:ss'
        Time = 37647.816767893500000000
        Enabled = False
        TabOrder = 0
      end
      object edtTarif: TEdit
        Left = 152
        Top = 36
        Width = 177
        Height = 21
        Enabled = False
        TabOrder = 1
      end
    end
  end
  object pnlMiddle: TPanel
    Left = 0
    Top = 97
    Width = 445
    Height = 0
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object grdDetailInfo: TStringGrid
      Left = 0
      Top = 0
      Width = 445
      Height = 0
      Align = alClient
      ColCount = 6
      DefaultColWidth = 50
      DefaultRowHeight = 16
      RowCount = 11
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      TabOrder = 0
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 61
    Width = 445
    Height = 122
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      445
      122)
    object btnCancel: TButton
      Left = 369
      Top = 97
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object cbxSummaryEndTime: TCheckBox
      Left = 0
      Top = 96
      Width = 193
      Height = 17
      Caption = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1086#1082#1086#1085#1095#1072#1085#1080#1077' '#1089#1077#1072#1085#1089#1072
      TabOrder = 1
      Visible = False
      OnClick = cbxSummaryEndTimeClick
    end
    object btnOk: TButton
      Left = 287
      Top = 97
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      TabOrder = 2
      OnClick = btnOkClick
    end
    object pnlMoney: TPanel
      Left = 0
      Top = 0
      Width = 445
      Height = 86
      BevelOuter = bvNone
      TabOrder = 3
      object gbMoneyTimeLength: TGroupBox
        Left = 0
        Top = 0
        Width = 277
        Height = 86
        Align = alClient
        Caption = #1044#1086#1087#1083#1072#1090#1072
        TabOrder = 0
        object pnlTotalCost: TPanel
          Left = 144
          Top = 15
          Width = 0
          Height = 69
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
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -27
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = Change
            OnEnter = cbxSummaryEndTimeClick
          end
        end
        object pnlCost: TPanel
          Left = 2
          Top = 15
          Width = 142
          Height = 69
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
          object edtMoney: TCurrencyEdit
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
            OnChange = Change
            OnEnter = edtMoneyEnter
          end
        end
        object pnlTimeLength: TPanel
          Left = 127
          Top = 15
          Width = 148
          Height = 69
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
            OnClick = butTimeLengthClick
            OnMouseDown = butTimeMouseDown
          end
          object butTimeLengthMinutes: TButton
            Left = 100
            Top = 41
            Width = 40
            Height = 20
            Caption = 'min'
            PopupMenu = popupTimeLengthMinuts
            TabOrder = 2
            OnClick = butTimeLengthClick
            OnMouseDown = butTimeMouseDown
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
            TabOrder = 1
            OnChange = Change
            OnEnter = dtpTimeLengthClick
          end
        end
      end
      object pnlHideTotalCost: TPanel
        Left = 294
        Top = 0
        Width = 151
        Height = 86
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
      end
      object pnlShowTotalCost: TPanel
        Left = 277
        Top = 0
        Width = 17
        Height = 86
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
        Visible = False
      end
    end
  end
  object tmrCheck: TTimer
    Enabled = False
    OnTimer = tmrCheckTimer
    Left = 8
  end
  object popupTimeLengthHours: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 72
    Top = 45
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
  object popupTimeLengthMinuts: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 32
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
  object popupEndTimeHours: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 72
    Top = 5
    object hours0: TMenuItem
      Caption = '0:00'
      OnClick = EndTimeHourClick
    end
    object hours1: TMenuItem
      Caption = '1:00'
      OnClick = EndTimeHourClick
    end
    object hours2: TMenuItem
      Caption = '2:00'
      OnClick = EndTimeHourClick
    end
    object hours3: TMenuItem
      Caption = '3:00'
      OnClick = EndTimeHourClick
    end
    object hours4: TMenuItem
      Caption = '4:00'
      OnClick = EndTimeHourClick
    end
    object hours5: TMenuItem
      Caption = '5:00'
      OnClick = EndTimeHourClick
    end
    object hours6: TMenuItem
      Caption = '6:00'
      OnClick = EndTimeHourClick
    end
    object hours7: TMenuItem
      Caption = '7:00'
      OnClick = EndTimeHourClick
    end
    object hours8: TMenuItem
      Caption = '8:00'
      OnClick = EndTimeHourClick
    end
    object hours9: TMenuItem
      Caption = '9:00'
      OnClick = EndTimeHourClick
    end
    object hours10: TMenuItem
      Caption = '10:00'
      OnClick = EndTimeHourClick
    end
    object hours11: TMenuItem
      Caption = '11:00'
      OnClick = EndTimeHourClick
    end
    object hours12: TMenuItem
      Break = mbBarBreak
      Caption = '12:00'
      OnClick = EndTimeHourClick
    end
    object hours13: TMenuItem
      Caption = '13:00'
      OnClick = EndTimeHourClick
    end
    object hours14: TMenuItem
      Caption = '14:00'
      OnClick = EndTimeHourClick
    end
    object hours15: TMenuItem
      Caption = '15:00'
      OnClick = EndTimeHourClick
    end
    object hours16: TMenuItem
      Caption = '16:00'
      OnClick = EndTimeHourClick
    end
    object hours17: TMenuItem
      Caption = '17:00'
      OnClick = EndTimeHourClick
    end
    object hours18: TMenuItem
      Caption = '18:00'
      OnClick = EndTimeHourClick
    end
    object hours19: TMenuItem
      Caption = '19:00'
      OnClick = EndTimeHourClick
    end
    object hours20: TMenuItem
      Caption = '20:00'
      OnClick = EndTimeHourClick
    end
    object hours21: TMenuItem
      Caption = '21:00'
      OnClick = EndTimeHourClick
    end
    object hours22: TMenuItem
      Caption = '22:00'
      OnClick = EndTimeHourClick
    end
    object hours23: TMenuItem
      Caption = '23:00'
      OnClick = EndTimeHourClick
    end
  end
  object popupEndTimeMinuts: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 40
    Top = 5
    object EndTimeMinuts10: TMenuItem
      Caption = '10'
      OnClick = EndTimeMinClick
    end
    object EndTimeMinuts15: TMenuItem
      Caption = '15'
      OnClick = EndTimeMinClick
    end
    object EndTimeMinuts20: TMenuItem
      Caption = '20'
      OnClick = EndTimeMinClick
    end
    object EndTimeMinuts25: TMenuItem
      Caption = '25'
      OnClick = EndTimeMinClick
    end
    object EndTimeMinuts30: TMenuItem
      Caption = '30'
      OnClick = EndTimeMinClick
    end
    object EndTimeMinuts35: TMenuItem
      Caption = '35'
      OnClick = EndTimeMinClick
    end
    object EndTimeMinuts40: TMenuItem
      Caption = '40'
      OnClick = EndTimeMinClick
    end
    object EndTimeMinuts45: TMenuItem
      Caption = '45'
      OnClick = EndTimeMinClick
    end
    object EndTimeMinuts50: TMenuItem
      Caption = '50'
      OnClick = EndTimeMinClick
    end
    object EndTimeMinuts55: TMenuItem
      Caption = '55'
      OnClick = EndTimeMinClick
    end
  end
end
