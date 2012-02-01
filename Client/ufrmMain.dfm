object frmMain: TfrmMain
  Left = 274
  Top = 175
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'GameClass3 Client'
  ClientHeight = 452
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlOldServerWarning: TPanel
    Left = 5
    Top = 104
    Width = 627
    Height = 342
    BevelInner = bvRaised
    TabOrder = 3
    Visible = False
    object lblWarning: TLabel
      Left = 144
      Top = 132
      Width = 332
      Height = 16
      Caption = #1044#1083#1103' '#1082#1086#1088#1088#1077#1082#1090#1085#1086#1081' '#1088#1072#1073#1086#1090#1099' '#1082#1083#1080#1077#1085#1090#1072' '#1085#1072' '#1054#1057' Linux '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 152
      Top = 156
      Width = 305
      Height = 16
      Caption = #1074#1077#1088#1089#1080#1103' '#1089#1077#1088#1074#1077#1088#1072' GameClass '#1076#1086#1083#1078#1085#1072' '#1073#1099#1090#1100' '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 216
      Top = 180
      Width = 177
      Height = 16
      Caption = '3.84 Release 5 '#1080#1083#1080' '#1074#1099#1096#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 637
    Height = 452
    BevelOuter = bvNone
    TabOrder = 0
    object pgctrlMain: TPageControl
      Left = 0
      Top = 91
      Width = 637
      Height = 361
      ActivePage = tabScreenClientInfo
      Style = tsFlatButtons
      TabOrder = 0
      object tabScreenAgreement: TTabSheet
        Caption = 'tabScreenAgreement'
        ImageIndex = 1
        TabVisible = False
        object pnlScreenAgreement: TPanel
          Left = 0
          Top = 0
          Width = 629
          Height = 351
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 8
          TabOrder = 0
          object butAgree: TButton
            Left = 208
            Top = 316
            Width = 100
            Height = 25
            Caption = #1057#1086#1075#1083#1072#1089#1077#1085
            TabOrder = 0
            OnClick = butAgreeClick
          end
          object butNotAgree: TButton
            Left = 328
            Top = 316
            Width = 100
            Height = 25
            Caption = #1053#1077' '#1089#1086#1075#1083#1072#1089#1077#1085
            TabOrder = 1
            OnClick = butNotAgreeClick
          end
          object pnlAgreement: TPanel
            Left = 8
            Top = 8
            Width = 613
            Height = 289
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            object wbAgreement: TWebBrowser
              Left = 0
              Top = 0
              Width = 613
              Height = 289
              Align = alClient
              TabOrder = 0
              OnNavigateComplete2 = wbAgreementNavigateComplete2
              ControlData = {
                4C0000005B3F0000DE1D00000000000000000000000000000000000000000000
                000000004C000000000000000000000001000000E0D057007335CF11AE690800
                2B2E126208000000000000004C0000000114020000000000C000000000000046
                8000000000000000000000000000000000000000000000000000000000000000
                00000000000000000100000000000000000000000000000000000000}
            end
          end
        end
      end
      object tabScreenClientInfo: TTabSheet
        Caption = 'tabScreenClientInfo'
        ImageIndex = 2
        TabVisible = False
        object pnlScreenClientInfo: TPanel
          Left = 0
          Top = 0
          Width = 629
          Height = 351
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 10
          TabOrder = 0
          object pcFunctions: TPageControl
            Left = 281
            Top = 10
            Width = 338
            Height = 331
            ActivePage = tabStartStop
            Align = alRight
            MultiLine = True
            TabOrder = 0
            object tabStartStop: TTabSheet
              Caption = #1057#1090#1072#1088#1090'/'#1057#1090#1086#1087
              object lblTariff: TLabel
                Left = 15
                Top = 28
                Width = 33
                Height = 13
                Caption = #1058#1072#1088#1080#1092
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblSumma: TLabel
                Left = 15
                Top = 76
                Width = 34
                Height = 13
                Caption = #1057#1091#1084#1084#1072
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblTime: TLabel
                Left = 98
                Top = 76
                Width = 33
                Height = 13
                Caption = #1042#1088#1077#1084#1103
              end
              object lblStart: TLabel
                Left = 15
                Top = 123
                Width = 37
                Height = 13
                Caption = #1053#1072#1095#1072#1083#1086
              end
              object lblStop: TLabel
                Left = 147
                Top = 123
                Width = 31
                Height = 13
                Caption = #1050#1086#1085#1077#1094
              end
              object cboTarifs: TComboBox
                Left = 15
                Top = 44
                Width = 278
                Height = 21
                Style = csDropDownList
                ItemHeight = 13
                TabOrder = 0
                OnChange = cboTarifsChange
                Items.Strings = (
                  #1048#1085#1090#1077#1088#1085#1077#1090
                  #1048#1075#1088#1099)
              end
              object btnSessionStart: TButton
                Left = 15
                Top = 179
                Width = 85
                Height = 25
                Caption = #1053#1072#1095#1072#1090#1100' '#1089#1077#1072#1085#1089
                TabOrder = 1
                OnClick = btnSessionStartClick
              end
              object btnSessionStop: TButton
                Left = 115
                Top = 179
                Width = 85
                Height = 25
                Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
                TabOrder = 2
                OnClick = btnSessionStopClick
              end
              object edtSum: TCurrencyEdit
                Left = 15
                Top = 92
                Width = 64
                Height = 21
                AutoSize = False
                DisplayFormat = ',0.00;-,0.00'
                MaxLength = 20
                TabOrder = 3
                OnChange = edtSumChange
                OnEnter = edtSumEnter
                OnExit = edtSumExit
              end
              object dtpTime: TDateTimePicker
                Left = 98
                Top = 92
                Width = 63
                Height = 21
                Date = 37620.000000000000000000
                Format = 'HH:mm'
                Time = 37620.000000000000000000
                DateMode = dmUpDown
                Kind = dtkTime
                TabOrder = 4
                OnChange = dtpTimeChange
                OnEnter = dtpTimeEnter
                OnExit = dtpTimeExit
              end
              object edtStart: TEdit
                Left = 15
                Top = 139
                Width = 116
                Height = 21
                Enabled = False
                TabOrder = 5
                Text = 'edtStart'
              end
              object edtStop: TEdit
                Left = 147
                Top = 139
                Width = 116
                Height = 21
                Enabled = False
                TabOrder = 6
                Text = 'Edit1'
              end
            end
            object tabAdd: TTabSheet
              BorderWidth = 10
              Caption = #1044#1086#1087#1083#1072#1090#1072
              ImageIndex = 1
              object gbTime: TGroupBox
                Left = 0
                Top = 0
                Width = 310
                Height = 121
                Align = alTop
                Caption = #1042#1088#1077#1084#1103
                TabOrder = 0
                object lblTimeSum: TLabel
                  Left = 15
                  Top = 28
                  Width = 34
                  Height = 13
                  Caption = #1057#1091#1084#1084#1072
                end
                object lblTimeLength: TLabel
                  Left = 112
                  Top = 28
                  Width = 33
                  Height = 13
                  Caption = #1042#1088#1077#1084#1103
                end
                object edtAddTimeSum: TCurrencyEdit
                  Left = 15
                  Top = 44
                  Width = 82
                  Height = 21
                  AutoSize = False
                  DisplayFormat = ',0.00;-,0.00'
                  MaxLength = 20
                  TabOrder = 0
                  OnChange = edtAddTimeSumChange
                  OnEnter = edtAddTimeSumEnter
                  OnExit = edtAddTimeSumExit
                end
                object btnAddTime: TButton
                  Left = 15
                  Top = 80
                  Width = 97
                  Height = 25
                  Caption = #1044#1086#1087#1083#1072#1090#1080#1090#1100
                  TabOrder = 1
                  OnClick = btnAddTimeClick
                end
                object dtpAddTimeLength: TDateTimePicker
                  Left = 111
                  Top = 44
                  Width = 63
                  Height = 21
                  Date = 37620.000000000000000000
                  Format = 'HH:mm'
                  Time = 37620.000000000000000000
                  DateMode = dmUpDown
                  Kind = dtkTime
                  TabOrder = 2
                  OnChange = dtpAddTimeLengthChange
                  OnEnter = dtpAddTimeLengthEnter
                  OnExit = dtpAddTimeLengthExit
                end
              end
              object gbTraffic: TGroupBox
                Left = 0
                Top = 121
                Width = 310
                Height = 126
                Align = alClient
                Caption = #1058#1088#1072#1092#1080#1082
                TabOrder = 1
                object lblTrafficSum: TLabel
                  Left = 15
                  Top = 28
                  Width = 34
                  Height = 13
                  Caption = #1057#1091#1084#1084#1072
                end
                object lblTraffic: TLabel
                  Left = 112
                  Top = 28
                  Width = 39
                  Height = 13
                  Caption = #1058#1088#1072#1092#1080#1082
                end
                object lblMB3: TLabel
                  Left = 208
                  Top = 48
                  Width = 14
                  Height = 13
                  Caption = #1050#1041
                end
                object butAddTraffic: TButton
                  Left = 15
                  Top = 80
                  Width = 97
                  Height = 25
                  Caption = #1044#1086#1087#1083#1072#1090#1080#1090#1100
                  TabOrder = 0
                  OnClick = butAddTrafficClick
                end
                object edtAddTrafficSum: TCurrencyEdit
                  Left = 15
                  Top = 44
                  Width = 82
                  Height = 21
                  AutoSize = False
                  DisplayFormat = ',0.00;-,0.00'
                  MaxLength = 20
                  TabOrder = 1
                  OnChange = edtAddTrafficSumChange
                  OnEnter = edtAddTrafficSumEnter
                  OnExit = edtAddTrafficSumExit
                end
                object edtAddTrafficSize: TCurrencyEdit
                  Left = 111
                  Top = 44
                  Width = 82
                  Height = 21
                  AutoSize = False
                  DisplayFormat = ',0;-,0'
                  MaxLength = 20
                  TabOrder = 2
                  OnChange = edtAddTrafficSizeChange
                  OnEnter = edtAddTrafficSizeEnter
                  OnExit = edtAddTrafficSizeExit
                end
              end
            end
            object tabSendMess: TTabSheet
              Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1091
              ImageIndex = 2
              object pnlSendMessageBottom: TPanel
                Left = 0
                Top = 226
                Width = 330
                Height = 41
                Align = alBottom
                BevelOuter = bvNone
                TabOrder = 0
                object edtMessage: TEdit
                  Left = 15
                  Top = 4
                  Width = 209
                  Height = 21
                  MaxLength = 255
                  TabOrder = 0
                  OnKeyUp = edtMessageKeyUp
                end
                object btnSendMessage: TButton
                  Left = 238
                  Top = 0
                  Width = 75
                  Height = 25
                  Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
                  TabOrder = 1
                  OnClick = btnSendMessageClick
                end
              end
              object pnlSendMessageClient: TPanel
                Left = 0
                Top = 0
                Width = 330
                Height = 226
                Align = alClient
                BevelOuter = bvNone
                BorderWidth = 15
                TabOrder = 1
                object memMessages: TMemo
                  Left = 15
                  Top = 15
                  Width = 300
                  Height = 196
                  Align = alClient
                  ReadOnly = True
                  ScrollBars = ssVertical
                  TabOrder = 0
                end
              end
            end
            object tabAccountInfo: TTabSheet
              Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1080' '#1089#1095#1077#1090#1072
              ImageIndex = 3
              object pnlAccountInfoClient: TPanel
                Left = 0
                Top = 0
                Width = 330
                Height = 267
                Align = alClient
                BevelOuter = bvNone
                BorderWidth = 15
                TabOrder = 0
                object memBalanceHistory: TMemo
                  Left = 15
                  Top = 15
                  Width = 300
                  Height = 237
                  Align = alClient
                  Lines.Strings = (
                    '')
                  ReadOnly = True
                  ScrollBars = ssVertical
                  TabOrder = 0
                end
              end
            end
          end
          object pnlClientInfoLeft: TPanel
            Left = 10
            Top = 10
            Width = 257
            Height = 331
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object memInfo: TMemo
              Left = 0
              Top = 138
              Width = 257
              Height = 193
              Align = alClient
              Color = clBtnFace
              Lines.Strings = (
                #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1087#1086' '#1089#1077#1072#1085#1089#1091
                ''
                #1058#1072#1088#1080#1092': '#1048#1085#1090#1077#1088#1085#1077#1090' (12:00 - 13:30)'
                #1054#1089#1090#1072#1083#1086#1089#1100' '#1074#1088#1077#1084#1077#1085#1080': 00:48'
                #1055#1086#1090#1088#1072#1095#1077#1085#1086' '#1085#1072' '#1074#1088#1077#1084#1103': 31 '#1088#1091#1073'.'
                #1048#1079#1088#1072#1089#1093#1086#1076#1086#1074#1072#1085#1086' '#1090#1088#1072#1092#1080#1082#1072': 1,6 '#1080#1079' 8 Mb'
                #1056#1072#1089#1087#1077#1095#1072#1090#1072#1085#1086' '#1089#1090#1088#1072#1085#1080#1094': 2 (4 '#1088#1091#1073'.)'
                #1054#1082#1072#1079#1072#1085#1086' '#1091#1089#1083#1091#1075' '#1085#1072': 15 '#1088#1091#1073'.'
                ''
                #1042#1085#1077#1089#1077#1085#1086': 60 '#1088#1091#1073'.'
                #1048#1079#1088#1072#1089#1093#1086#1076#1086#1074#1072#1085#1086': 50 '#1088#1091#1073'.')
              ReadOnly = True
              TabOrder = 0
              OnChange = memInfoChange
            end
            object pnlClientInfoAccount: TPanel
              Left = 0
              Top = 0
              Width = 257
              Height = 138
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              object gbAccount: TGroupBox
                Left = 0
                Top = 0
                Width = 257
                Height = 121
                Align = alTop
                Caption = ' '#1042#1072#1096' '#1072#1082#1082#1072#1091#1085#1090' '
                TabOrder = 0
                object lblLoggedAsCaption: TLabel
                  Left = 17
                  Top = 19
                  Width = 25
                  Height = 13
                  Caption = #1048#1084#1103':'
                end
                object lblLoggedAs: TLabel
                  Left = 56
                  Top = 19
                  Width = 35
                  Height = 13
                  Caption = 'Vasya'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object lblBalance: TLabel
                  Left = 69
                  Top = 37
                  Width = 22
                  Height = 13
                  Caption = '852'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object lblBalanceCaption: TLabel
                  Left = 17
                  Top = 37
                  Width = 43
                  Height = 13
                  Caption = #1041#1072#1083#1072#1085#1089': '
                end
                object lblSpentCaption: TLabel
                  Left = 17
                  Top = 57
                  Width = 60
                  Height = 13
                  Caption = #1055#1086#1090#1088#1072#1095#1077#1085#1086': '
                end
                object lblSpent: TLabel
                  Left = 79
                  Top = 57
                  Width = 50
                  Height = 13
                  Caption = '+100500'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object butLogoff: TButton
                  Left = 13
                  Top = 81
                  Width = 100
                  Height = 27
                  Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103
                  TabOrder = 0
                  OnClick = butLogoffClick
                end
                object butChangePass: TButton
                  Left = 136
                  Top = 80
                  Width = 100
                  Height = 27
                  Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
                  TabOrder = 1
                  OnClick = butChangePassClick
                end
              end
            end
          end
          object pnlClientInfoMiddle: TPanel
            Left = 267
            Top = 10
            Width = 14
            Height = 331
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 2
          end
        end
      end
      object tabScreenCompFree: TTabSheet
        Caption = 'tabScreenCompFree'
        ImageIndex = 3
        TabVisible = False
        object pnlScreenCompFree: TPanel
          Left = 0
          Top = 0
          Width = 629
          Height = 351
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 8
          TabOrder = 0
          object wbCompFree: TWebBrowser
            Left = 8
            Top = 10
            Width = 613
            Height = 329
            TabOrder = 0
            OnNavigateComplete2 = wbCompFreeNavigateComplete2
            ControlData = {
              4C0000005B3F0000012200000000000000000000000000000000000000000000
              000000004C000000000000000000000001000000E0D057007335CF11AE690800
              2B2E126208000000000000004C0000000114020000000000C000000000000046
              8000000000000000000000000000000000000000000000000000000000000000
              00000000000000000100000000000000000000000000000000000000}
          end
        end
      end
      object tabScreenLogin: TTabSheet
        Caption = 'tabScreenLogin'
        ImageIndex = 4
        TabVisible = False
        object pnlScreenLogin: TPanel
          Left = 0
          Top = 0
          Width = 629
          Height = 351
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object gbLogon: TGroupBox
            Left = 335
            Top = 6
            Width = 288
            Height = 154
            Caption = ' '#1042#1086#1081#1076#1080#1090#1077' '#1087#1086#1076' '#1089#1074#1086#1080#1084' '#1080#1084#1077#1085#1077#1084' '
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object lblLogin: TLabel
              Left = 23
              Top = 49
              Width = 22
              Height = 13
              Caption = #1048#1084#1103
            end
            object lblPassword: TLabel
              Left = 23
              Top = 81
              Width = 38
              Height = 13
              Caption = #1055#1072#1088#1086#1083#1100
            end
            object lblSecCode: TLabel
              Left = 214
              Top = 53
              Width = 47
              Height = 13
              Caption = 'Code #12'
              Visible = False
            end
            object lblWrongNameOrPassword: TLabel
              Left = 23
              Top = 20
              Width = 108
              Height = 13
              Caption = #1054#1096#1080#1073#1082#1072' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Visible = False
            end
            object edtLogin: TEdit
              Left = 72
              Top = 46
              Width = 127
              Height = 21
              MaxLength = 50
              TabOrder = 0
              OnKeyDown = edtLoginKeyDown
            end
            object edtPassword: TEdit
              Left = 72
              Top = 77
              Width = 127
              Height = 20
              Font.Charset = SYMBOL_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Wingdings'
              Font.Style = []
              MaxLength = 50
              ParentFont = False
              PasswordChar = 'l'
              TabOrder = 1
              OnKeyDown = edtPasswordKeyDown
            end
            object edtSecCode: TEdit
              Left = 214
              Top = 77
              Width = 53
              Height = 20
              Font.Charset = SYMBOL_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Wingdings'
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              PasswordChar = 'l'
              TabOrder = 2
              Visible = False
            end
            object pnl: TPanel
              Left = 2
              Top = 112
              Width = 284
              Height = 40
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 3
              object pnlButtonsLeft: TPanel
                Left = 0
                Top = 0
                Width = 62
                Height = 40
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
              end
              object pnlButtonsLogon: TPanel
                Left = 62
                Top = 0
                Width = 142
                Height = 40
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 1
                object butLogon: TButton
                  Left = 10
                  Top = 0
                  Width = 127
                  Height = 25
                  Caption = #1053#1072#1095#1072#1090#1100' '#1088#1072#1073#1086#1090#1091
                  TabOrder = 0
                  OnClick = butLogonClick
                end
              end
              object pnlButtonsGuest: TPanel
                Left = 204
                Top = 0
                Width = 80
                Height = 40
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 2
                object btnGuest: TButton
                  Left = 4
                  Top = 0
                  Width = 127
                  Height = 25
                  Caption = #1043#1086#1089#1090#1100
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                  OnClick = btnGuestClick
                end
              end
            end
          end
          object pnlAccount: TPanel
            Left = 8
            Top = 8
            Width = 316
            Height = 153
            BevelOuter = bvNone
            TabOrder = 1
            object wbAccount: TWebBrowser
              Left = 0
              Top = 0
              Width = 316
              Height = 153
              Align = alClient
              TabOrder = 0
              OnNavigateComplete2 = wbAccountNavigateComplete2
              ControlData = {
                4C000000A9200000D00F00000000000000000000000000000000000000000000
                000000004C000000000000000000000001000000E0D057007335CF11AE690800
                2B2E126208000000000000004C0000000114020000000000C000000000000046
                8000000000000000000000000000000000000000000000000000000000000000
                00000000000000000100000000000000000000000000000000000000}
            end
          end
          object pnlAccountCompFree: TPanel
            Left = 8
            Top = 174
            Width = 615
            Height = 165
            BevelOuter = bvNone
            TabOrder = 2
            object wbAccountCompFree: TWebBrowser
              Left = 0
              Top = 0
              Width = 615
              Height = 165
              Align = alClient
              TabOrder = 0
              OnNavigateComplete2 = wbAccountCompFreeNavigateComplete2
              ControlData = {
                4C000000903F00000E1100000000000000000000000000000000000000000000
                000000004C000000000000000000000001000000E0D057007335CF11AE690800
                2B2E126208000000000000004C0000000114020000000000C000000000000046
                8000000000000000000000000000000000000000000000000000000000000000
                00000000000000000100000000000000000000000000000000000000}
            end
          end
        end
      end
    end
    object pnlTop: TPanel
      Left = -2
      Top = 0
      Width = 639
      Height = 97
      Align = alCustom
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      object wbTop: TWebBrowser
        Left = 0
        Top = 0
        Width = 639
        Height = 97
        Align = alClient
        TabOrder = 0
        OnNavigateComplete2 = wbTopNavigateComplete2
        ControlData = {
          4C0000000B420000060A00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object pnlCompNumber: TPanel
        Left = 22
        Top = 8
        Width = 79
        Height = 79
        BevelOuter = bvNone
        BorderWidth = 1
        Caption = '188'
        Color = clWhite
        Ctl3D = False
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7566195
        Font.Height = -38
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
      end
      object pnlClock: TPanel
        Left = 550
        Top = 12
        Width = 57
        Height = 22
        BevelOuter = bvNone
        Caption = '18:29:01'
        Color = clWhite
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7566195
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object pnlBlocked: TPanel
        Left = 264
        Top = 0
        Width = 105
        Height = 25
        Caption = 'BLOCKED'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        Visible = False
      end
    end
  end
  object pnlUnblockByPassword: TPanel
    Left = 144
    Top = 192
    Width = 347
    Height = 121
    BevelInner = bvRaised
    TabOrder = 1
    Visible = False
    object lblWrongUnblockPassword: TLabel
      Left = 16
      Top = 20
      Width = 108
      Height = 13
      Caption = #1054#1096#1080#1073#1082#1072' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 16
      Top = 46
      Width = 38
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100
    end
    object btnBlock: TButton
      Left = 136
      Top = 80
      Width = 113
      Height = 25
      Caption = #1047#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100
      Enabled = False
      TabOrder = 0
      OnClick = btnBlockClick
    end
    object edtUnblockPassword: TEdit
      Left = 72
      Top = 44
      Width = 258
      Height = 20
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Wingdings'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      PasswordChar = 'l'
      TabOrder = 1
    end
    object btnUnblock: TButton
      Left = 16
      Top = 80
      Width = 113
      Height = 25
      Caption = #1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 2
      OnClick = btnUnblockClick
    end
    object btnUnblockCancel: TButton
      Left = 256
      Top = 80
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 3
      OnClick = btnUnblockCancelClick
    end
  end
  object pnlChangePassword: TPanel
    Left = 168
    Top = 144
    Width = 297
    Height = 185
    BevelInner = bvRaised
    TabOrder = 2
    Visible = False
    object lblChangePasswordError: TLabel
      Left = 16
      Top = 20
      Width = 108
      Height = 13
      Caption = #1054#1096#1080#1073#1082#1072' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblOldPass: TLabel
      Left = 16
      Top = 52
      Width = 80
      Height = 13
      Caption = #1057#1090#1072#1088#1099#1081' '#1087#1072#1088#1086#1083#1100':'
    end
    object lblNewPass: TLabel
      Left = 16
      Top = 84
      Width = 76
      Height = 13
      Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
    end
    object lblRepeat: TLabel
      Left = 16
      Top = 116
      Width = 84
      Height = 13
      Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077':'
    end
    object editOldPass: TEdit
      Left = 112
      Top = 48
      Width = 153
      Height = 21
      MaxLength = 50
      PasswordChar = '*'
      TabOrder = 0
      OnKeyDown = editOldPassKeyDown
    end
    object editNewPass: TEdit
      Left = 112
      Top = 80
      Width = 153
      Height = 21
      MaxLength = 50
      PasswordChar = '*'
      TabOrder = 1
      OnChange = editNewPassChange
      OnKeyDown = editNewPassKeyDown
    end
    object editRepeat: TEdit
      Left = 112
      Top = 112
      Width = 153
      Height = 21
      MaxLength = 50
      PasswordChar = '*'
      TabOrder = 2
      OnChange = editNewPassChange
      OnKeyDown = editRepeatKeyDown
    end
    object btnChangePasswordOk: TButton
      Left = 72
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 3
      OnClick = btnChangePasswordOkClick
    end
    object btnChangePasswordCancel: TButton
      Left = 160
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 4
      OnClick = btnChangePasswordCancelClick
    end
  end
  object modernTrayIcon: TModernTrayIcon
    Hint = 'GameClass3 Client'
    BalloonIcon = BalloonIcon_Information
    Icon.Data = {
      0000010001002020000001001800A80C00001600000028000000200000004000
      00000100180000000000800C0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000001F04041F0404000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000002E06062E06062E06062E0606000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000003D09093D09093D09093D09093D09093D0909000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004B0B0B4B0B0B4B0B0B4B0B0B4B0B0B4B0B0B4B0B0B4B0B0B000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000059
      0D0D590D0D590D0D590D0D590D0D590D0D590D0D590D0D590D0D590D0D000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000660E0E66
      0E0E660E0E660E0E660E0E660E0E660E0E660E0E660E0E660E0E660E0E660E0E
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000072101072
      1010721010721010721010721010721010721010721010721010721010721010
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000007E
      12127E12127E12127E12127E12127E12127E12127E12127E12127E1212000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000008A13138A131300000000000000
      00008A13138A13138A13138A13138A13138A13138A13138A1313000000000000
      0000008A13138A13130000000000000000000000000000000000000000000000
      0000000000000000000000000000000094151594151594151594151500000000
      0000000000941515941515941515941515941515941515000000000000000000
      9415159415159415159415150000000000000000000000000000000000000000
      000000000000000000000000009F16169F16169F16169F16169F16169F161600
      00000000000000009F16169F16169F16169F16160000000000000000009F1616
      9F16169F16169F16169F16169F16160000000000000000000000000000000000
      00000000000000000000A91818A91818A91818A91818A91818A91818A91818A9
      1818000000000000000000A91818A91818000000000000000000A91818A91818
      A91818A91818A91818A91818A91818A918180000000000000000000000000000
      00000000000000B21919B21919B21919B21919B21919B21919B21919B21919B2
      1919B21919000000000000000000000000000000000000B21919B21919B21919
      B21919B21919B21919B21919B21919B21919B219190000000000000000000000
      00000000BB1A1ABB1A1ABB1A1ABB1A1ABB1A1ABB1A1ABB1A1ABB1A1ABB1A1ABB
      1A1ABB1A1ABB1A1A000000000000000000000000BB1A1ABB1A1ABB1A1ABB1A1A
      BB1A1ABB1A1ABB1A1ABB1A1ABB1A1ABB1A1ABB1A1ABB1A1A0000000000000000
      00000000C31C1CC31C1CC31C1CC31C1CC31C1CC31C1CC31C1CC31C1CC31C1CC3
      1C1CC31C1CC31C1C000000000000000000000000C31C1CC31C1CC31C1CC31C1C
      C31C1CC31C1CC31C1CC31C1CC31C1CC31C1CC31C1CC31C1C0000000000000000
      00000000000000CB1D1DCB1D1DCB1D1DCB1D1DCB1D1DCB1D1DCB1D1DCB1D1DCB
      1D1DCB1D1D000000000000000000000000000000000000CB1D1DCB1D1DCB1D1D
      CB1D1DCB1D1DCB1D1DCB1D1DCB1D1DCB1D1DCB1D1D0000000000000000000000
      00000000000000000000D21E1ED21E1ED21E1ED21E1ED21E1ED21E1ED21E1ED2
      1E1E000000000000000000D21E1ED21E1E000000000000000000D21E1ED21E1E
      D21E1ED21E1ED21E1ED21E1ED21E1ED21E1E0000000000000000000000000000
      00000000000000000000000000D61E1ED91F1FD91F1FD61E1ED91F1FD91F1F00
      0000000000000000D91F1FD91F1FD91F1FD91F1F000000000000000000D91F1F
      D91F1FD91F1FD91F1FD91F1FD91F1F0000000000000000000000000000000000
      00000000000000000000000000000000DF1F1FDF1F1FDF1F1FDF1F1F00000000
      0000000000DF1F1FDF1F1FDF1F1FDF1F1FDF1F1FDF1F1F000000000000000000
      DF1F1FDF1F1FDF1F1FDF1F1F0000000000000000000000000000000000000000
      00000000000000000000000000000000000000E42020E4202000000000000000
      0000E42020E42020E42020E42020E42020E42020E42020E42020000000000000
      000000E42020E420200000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000E9
      2121E92121E92121E92121E92121E92121E92121E92121E92121E92121000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000EE2222EE
      2222EE2222EE2222EE2222EE2222EE2222EE2222EE2222EE2222EE2222EE2222
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000F22222F2
      2222F22222F22222F22222F22222F22222F22222F22222F22222F22222F22222
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000F5
      2323F52323F52323F52323F52323F52323F52323F52323F52323F52323000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F82323F82323F82323F82323F82323F82323F82323F82323000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF2424FB2323FB2323FB2323FF2424FF2424000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FD2424FD2424FF2424FF2424000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FE2424FF2424000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FFFFFFFFFFFFFFFE7FFFFFFC3FFFFFF81FFFFFF00FFFFFE007FFFFC003FFFFC0
      03FFFFE007FFFE700E7FFC381C3FF81C381FF00E700FE007E007C003C003C003
      C003E007E007F00E700FF81C381FFC381C3FFE700E7FFFE007FFFFC003FFFFC0
      03FFFFE007FFFFF00FFFFFF81FFFFFFC3FFFFFFE7FFFFFFFFFFFFFFFFFFF}
    OnDblClick = modernTrayIconDblClick
  end
  object tmrClock: TTimer
    OnTimer = tmrClockTimer
    Left = 192
    Top = 56
  end
  object tmrSafeOpearation: TTimer
    Enabled = False
    Interval = 30
    OnTimer = tmrSafeOpearationTimer
    Left = 222
    Top = 56
  end
  object tmrUnblockByPasswordHide: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = tmrUnblockByPasswordHideTimer
    Left = 84
    Top = 57
  end
  object tmrChangePasswordHide: TTimer
    Enabled = False
    Interval = 20000
    OnTimer = tmrChangePasswordHideTimer
    Left = 116
    Top = 57
  end
  object tmrOldServerWarningShow: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = tmrOldServerWarningShowTimer
    Left = 149
    Top = 56
  end
end
