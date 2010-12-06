object formCompChangeTarif: TformCompChangeTarif
  Left = 417
  Top = 199
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 10
  Caption = 'formCompChangeTarifCaption'
  ClientHeight = 374
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblComputer: TLabel
    Left = 0
    Top = 5
    Width = 58
    Height = 13
    Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
  end
  object lblMoneyLeft: TLabel
    Left = 88
    Top = 5
    Width = 74
    Height = 13
    Caption = #1054#1089#1090#1072#1090#1086#1082' '#1076#1077#1085#1077#1075
  end
  object lblTimeLeft: TLabel
    Left = 208
    Top = 5
    Width = 96
    Height = 13
    Caption = #1054#1089#1090#1072#1083#1086#1089#1100' '#1074#1088#1077#1084#1077#1085#1080
  end
  object butOk: TButton
    Left = 158
    Top = 346
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    Enabled = False
    TabOrder = 1
    OnClick = butOkClick
  end
  object butCancel: TButton
    Left = 238
    Top = 346
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = butCancelClick
  end
  object editMoneyLeft: TEdit
    Left = 88
    Top = 21
    Width = 105
    Height = 41
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object editComputer: TEdit
    Left = 0
    Top = 21
    Width = 73
    Height = 41
    BiDiMode = bdRightToLeft
    Ctl3D = True
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    Text = '2'
  end
  object cbPostPay: TCheckBox
    Left = 0
    Top = 68
    Width = 163
    Height = 14
    Caption = 'Pay after job'
    Enabled = False
    TabOrder = 4
  end
  object gbCurrentTariff: TGroupBox
    Left = 0
    Top = 96
    Width = 329
    Height = 113
    Caption = ' '#1058#1077#1082#1091#1097#1080#1081' '#1090#1072#1088#1080#1092' '
    TabOrder = 5
    object lblCurStart: TLabel
      Left = 8
      Top = 20
      Width = 37
      Height = 13
      Caption = #1053#1072#1095#1072#1083#1086
    end
    object lblCurStop: TLabel
      Left = 8
      Top = 60
      Width = 31
      Height = 13
      Caption = #1050#1086#1085#1077#1094
    end
    object lblCurTariff: TLabel
      Left = 168
      Top = 20
      Width = 33
      Height = 13
      Caption = #1058#1072#1088#1080#1092
    end
    object dtpCurStart: TDateTimePicker
      Left = 8
      Top = 36
      Width = 140
      Height = 21
      Date = 37647.816767893500000000
      Format = 'd MMMM HH:mm:ss'
      Time = 37647.816767893500000000
      Enabled = False
      TabOrder = 0
    end
    object dtpCurStop: TDateTimePicker
      Left = 8
      Top = 76
      Width = 140
      Height = 21
      Date = 37647.816879976900000000
      Format = 'd MMMM HH:mm:ss'
      Time = 37647.816879976900000000
      Enabled = False
      TabOrder = 1
    end
    object editCurTariff: TEdit
      Left = 160
      Top = 36
      Width = 161
      Height = 21
      Enabled = False
      TabOrder = 2
    end
  end
  object gbNewTariff: TGroupBox
    Left = 0
    Top = 216
    Width = 329
    Height = 121
    Caption = ' '#1053#1086#1074#1099#1081' '#1090#1072#1088#1080#1092' '
    TabOrder = 6
    object lblNewStop: TLabel
      Left = 8
      Top = 68
      Width = 31
      Height = 13
      Caption = #1050#1086#1085#1077#1094
    end
    object lblNewStart: TLabel
      Left = 8
      Top = 20
      Width = 37
      Height = 13
      Caption = #1053#1072#1095#1072#1083#1086
    end
    object lblNewTariff: TLabel
      Left = 168
      Top = 20
      Width = 33
      Height = 13
      Caption = #1058#1072#1088#1080#1092
    end
    object dtpNewStart: TDateTimePicker
      Left = 8
      Top = 36
      Width = 140
      Height = 21
      Date = 37647.816767893500000000
      Format = 'd MMMM HH:mm:ss'
      Time = 37647.816767893500000000
      Enabled = False
      TabOrder = 0
    end
    object dtpNewStop: TDateTimePicker
      Left = 8
      Top = 84
      Width = 140
      Height = 21
      Date = 37647.816879976900000000
      Format = 'd MMMM HH:mm:ss'
      Time = 37647.816879976900000000
      Enabled = False
      TabOrder = 1
    end
    object lvTarifs: TListView
      Left = 160
      Top = 37
      Width = 161
      Height = 68
      Columns = <
        item
          Caption = 'Tarif'
          Width = 150
        end>
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      ShowColumnHeaders = False
      TabOrder = 2
      ViewStyle = vsReport
      OnClick = lvTarifsClick
    end
  end
  object editTimeLeft: TEdit
    Left = 208
    Top = 21
    Width = 121
    Height = 41
    BiDiMode = bdRightToLeft
    Ctl3D = True
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
    Text = '00:00:00'
  end
  object timerFrmCompChangeTarif: TTimer
    Enabled = False
    OnTimer = timerFrmCompChangeTarifTimer
    Left = 65534
    Top = 65533
  end
end
