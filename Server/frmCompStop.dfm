object formCompStop: TformCompStop
  Left = 568
  Top = 131
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 10
  Caption = 'formCompStopCaption'
  ClientHeight = 501
  ClientWidth = 425
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 221
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblTarif: TLabel
      Left = 121
      Top = 47
      Width = 33
      Height = 13
      Caption = #1058#1072#1088#1080#1092
    end
    object lblClient: TLabel
      Left = 121
      Top = 0
      Width = 36
      Height = 13
      Caption = #1050#1083#1080#1077#1085#1090
    end
    object lblStart: TLabel
      Left = 287
      Top = 0
      Width = 37
      Height = 13
      Caption = #1053#1072#1095#1072#1083#1086
    end
    object lblStop: TLabel
      Left = 287
      Top = 47
      Width = 31
      Height = 13
      Caption = #1050#1086#1085#1077#1094
    end
    object lblSummaryBill: TLabel
      Left = 0
      Top = 91
      Width = 99
      Height = 13
      Caption = #1048#1090#1086#1075#1086' '#1089#1095#1077#1090' '#1082#1083#1080#1077#1085#1090#1072
    end
    object dtpStop: TDateTimePicker
      Left = 287
      Top = 63
      Width = 140
      Height = 21
      Date = 37647.816879976900000000
      Format = 'd MMMM HH:mm:ss'
      Time = 37647.816879976900000000
      Enabled = False
      TabOrder = 0
    end
    object editClient: TEdit
      Left = 121
      Top = 16
      Width = 156
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object editTarif: TEdit
      Left = 121
      Top = 63
      Width = 156
      Height = 21
      Enabled = False
      TabOrder = 2
    end
    object dtpStart: TDateTimePicker
      Left = 287
      Top = 16
      Width = 140
      Height = 21
      Date = 37647.816767893500000000
      Format = 'd MMMM HH:mm:ss'
      Time = 37647.816767893500000000
      Enabled = False
      TabOrder = 3
    end
    object pnlComputers: TPanel
      Left = 0
      Top = 0
      Width = 111
      Height = 85
      BevelOuter = bvNone
      Caption = 'pnlComputers'
      TabOrder = 4
    end
    object memoBill: TMemo
      Left = 0
      Top = 107
      Width = 425
      Height = 102
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 5
      WantReturns = False
      WordWrap = False
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 221
    Width = 425
    Height = 208
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel3'
    TabOrder = 2
    object grdDetailInfo: TStringGrid
      Left = 0
      Top = 0
      Width = 425
      Height = 208
      Align = alClient
      ColCount = 12
      DefaultColWidth = 50
      DefaultRowHeight = 16
      RowCount = 11
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      TabOrder = 0
      OnClick = grdDetailInfoClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 429
    Width = 425
    Height = 72
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      425
      72)
    object lblCompStopAction: TLabel
      Left = 0
      Top = 5
      Width = 154
      Height = 21
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089' '#1082#1083#1080#1077#1085#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCurrency: TLabel
      Left = 184
      Top = 32
      Width = 15
      Height = 33
      Caption = '$'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object butCancel: TButton
      Left = 350
      Top = 47
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = butCancelClick
    end
    object butOk: TButton
      Left = 260
      Top = 47
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = butOkClick
    end
    object editResult: TAlignEdit
      Left = 0
      Top = 29
      Width = 177
      Height = 41
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = '1024,24'
      OnChange = editResultChange
      Alignment = eaRight
    end
  end
  object timerStop: TTimer
    Enabled = False
    OnTimer = timerStopTimer
    Left = 440
  end
end
