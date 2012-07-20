object frmMain: TfrmMain
  Left = 1724
  Top = 212
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'GameClass3 Client'
  ClientHeight = 451
  ClientWidth = 639
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
      ActivePage = tabScreenLogin
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
            ActivePage = tabAccountInfo
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
        OnClick = pnlCompNumberClick
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
        OnClick = pnlClockClick
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
  object pnlChangePassword: TPanel
    Left = 176
    Top = 116
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
  object tbActions: TToolBar
    Left = 579
    Top = 53
    Width = 38
    Height = 37
    Align = alNone
    AutoSize = True
    ButtonHeight = 37
    ButtonWidth = 38
    Caption = 'tbActions'
    Color = clBtnFace
    EdgeBorders = []
    Flat = True
    Images = ilActions
    ParentColor = False
    TabOrder = 4
    Transparent = True
    Visible = False
    object tbCompShutdown: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = 'Shutdown'
      DropdownMenu = popShutDown
      ImageIndex = 0
      Style = tbsDropDown
    end
  end
  object pnlUnblockByPassword: TPanel
    Left = 144
    Top = 160
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
  object ilActions: TImageList
    BlendColor = clBlack
    BkColor = clBlack
    DrawingStyle = dsFocus
    Height = 31
    Width = 31
    Left = 464
    Top = 380
    Bitmap = {
      494C01010100040004001F001F0000000000FF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000007C0000001F0000000100200000000000103C
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFDFFD2D2D3FFC4C4C6FFC5C5C6FFC5C5C6FFC5C5C5FFC5C5C5FFC5C5
      C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C6FFC5C5C6FFC5C5
      C6FFC5C5C6FFC5C5C6FFC5C5C6FFC5C5C7FFC5C5C7FFC5C5C7FFD8D8D8FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B7B7C1FF4554B6FF3948DDFF3946D8FF3641
      CBFF343DC1FF3439B6FF3336ACFF3334ACFF3337B1FF3438B4FF3439B7FF343A
      BBFF343BBEFF343DC1FF363EC4FF363FC8FF3641CBFF3642CEFF3743D1FF3744
      D5FF3846D9FF3A49DFFF3546D0FF505BA0FFCFCFCFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B1B1BFFF2F45
      EEFF8189FFFF9594FFFF9392FFFF9392FFFF9392FFFF9393FFFF9393FFFF9393
      FFFF9393FFFF9393FFFF9393FFFF9393FFFF9393FFFF9392FFFF9392FFFF9392
      FFFF9392FFFF9392FFFF9392FFFF9392FFFF9392FFFF9493FFFF9394FFFF6877
      FFFF2B3BB8FFD2D2D2FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F8F8F8FF394AC4FF7B81FFFF8D88FCFF7F7EFAFF7E7EFBFF7E7E
      FBFF7E7EFBFF7E7EFBFF7E7EFBFF7E7EFCFF7F7FFCFF7F7FFEFF8080FFFF8080
      FFFF8080FFFF8080FEFF7F7FFEFF7F7FFCFF7E7EFBFF7E7EFBFF7E7EFBFF7E7E
      FBFF7E7EFBFF7E7EFAFF817FFAFF918DFFFF5665FFFF61669BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C4C4CCFF3949EEFF7B7A
      FFFF6F6FF4FF6E6EF4FF6E6EF4FF6E6EF4FF6E6EF4FF6E6EF4FF6F6FF5FF7171
      F7FF6C6CF6FF6262EDFF5A5AE4FF5555DEFF5555DEFF5B5BE3FF6565EDFF6F6F
      F6FF7171F7FF6F6FF5FF6E6EF4FF6E6EF4FF6E6EF4FF6E6EF4FF6E6EF4FF7572
      F4FF6E73FFFF3442BBFFE9E9E9FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B1B1BFFF3B46E8FF6B68F6FF6060EDFF6060EDFF6060EDFF6060
      EDFF6060EDFF6262F0FF5E5EEEFF4C4CDDFF4646C8FF5C5CC2FF7272C3FF7F7F
      C5FF7A7AC1FF6868BBFF4D4DB5FF3E3EBEFF4E4EDAFF6161EFFF6161F0FF6060
      EDFF6060EDFF6060EDFF6060EDFF6362ECFF6266FFFF303EC5FFDDDDDDFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B3B3BEFF3039D9FF5B5A
      F1FF5353E7FF5353E7FF5353E7FF5353E7FF5555EAFF4949E3FF3737C9FF6565
      C1FFBFBFDEFFF1F1F4FFFFFFFDFFFFFFFFFFFFFFFFFFFFFFF9FFE2E2E9FF9A9A
      C5FF4141A4FF3030BAFF4D4DE2FF5555EAFF5353E7FF5353E7FF5353E7FF5554
      E6FF5557FDFF2D3CC0FFDFDFDFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B3BDFF282FCDFF4C4BECFF4545E1FF4545E1FF4545E1FF4747
      E4FF3636DAFF3B39C3FFA0A1D1FFFAFCF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E6EBFF7070B2FF2121A8FF3D3D
      D9FF4747E4FF4545E1FF4545E1FF4746E0FF4649F7FF2B38BEFFDFDFDFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B3B3BBFF2023BEFF3C3C
      E6FF3737DBFF3737DBFF3838DCFF2B2BD6FF3333C2FFB2B7D2FFFAFFEBFFECF1
      EBFFECF1ECFFFFFFF4FFFFFFF9FFFFFFF9FFFFFFFEFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF8686B9FF1515A3FF3232D6FF3737DDFF3737DBFF3938
      D9FF383AF1FF2834BCFFDFDFDFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B3BAFF1819B5FF2D2DDFFF2929D4FF2929D5FF2323D5FF1B1B
      C3FF999CC9FFE8F1D8FFD2DAD7FFDFE6DCFFEBF3E2FFAAADD6FF6466CDFF4D4D
      CFFF5253D2FF7F80DBFFDCDDF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6262
      ACFF0A0AABFF2A2AD7FF2929D5FF2A29D2FF2A2CEAFF2631B9FFDFDFDFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B3B3BBFF1113B6FF1D1D
      D9FF1C1CCEFF1C1CD0FF0808C8FF5353C0FFD3D8C9FFC9CEC8FFD3D9CEFFD0D5
      D0FF6062BFFF0505BAFF0000B3FF0000AAFF0000A6FF0000AFFF1C1CC3FFA0A1
      DFFFFFFFF6FFFBFDF8FFFFFFFFFFDEDEE7FF1B1B99FF0E0EC2FF1C1CD1FF1C1B
      CCFF1D1EE3FF232EB8FFDFDFDFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B3BCFF0C0EB5FF1212D2FF1111C9FF0B0BC9FF0D0CBEFF9597
      BAFFC8CBB9FFBEC2BDFFC9CDC3FF4B4AB2FF0000B5FF0C0CC4FF7376C1FF9296
      B8FF969ABBFF4D4EACFF0000B1FF0000BFFF989AD7FFFBFFEDFFEFF3EFFFFFFF
      FBFF6C6DB3FF0000A4FF1111CCFF1111C7FF1114DDFF212BB6FFDFDFDFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B3B3BDFF0A0EB5FF0F0E
      C9FF0E0EC2FF0000BFFF3131B8FFB5B5B2FFB3B4ACFFC2C3B4FF7A7BADFF0000
      A9FF0000C1FF1C1CBDFFC0C4C8FFE4EACDFFF2F8D9FF8689B3FF0000A4FF0000
      C0FF1A1ABCFFC8CFDAFFE6EEE1FFF8FEEEFFAEB1CAFF030398FF0707BFFF0E0E
      C0FF0E11D6FF202AB3FFDFDFDFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B4BDFF090EB4FF0D0CC2FF0C0CBCFF0000B8FF4E4EB4FFBCBE
      AFFFB0B1ACFFB8B9B0FF3C3C9EFF0000ADFF0202BDFF1818B7FFA6A8BAFFC2C5
      B9FFCFD3C4FF7677A9FF00009FFF0707BEFF0000B4FF8689C6FFE4EDD7FFE0E9
      DEFFC5CCD0FF191998FF0000B2FF0C0CBBFF0C0ED0FF1F29B1FFDFDFDFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B3B4BEFF080FB5FF0909
      BBFF0808B6FF0000B2FF5B5CB1FFBEBEAEFFB3B4ADFFAAABACFF212194FF0000
      ACFF0000B6FF1616B1FFA0A2B2FFB9B9AFFFC4C6B8FF7071A3FF00009AFF0808
      B9FF0000AEFF5F60B9FFD8DDCCFFD3D9CFFFC8CECBFF252697FF0000AAFF0909
      B4FF0A0BC8FF1F27B0FFDFDFDFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B4BFFF070EB4FF0606B2FF0505AEFF0000AAFF5A5AAEFFBDBD
      ADFFB2B2ACFFA9AAABFF1E1E8CFF0000A2FF0000AFFF1313ABFF9FA0B0FFB6B7
      ABFFBFC0B2FF6B6C9CFF000095FF0404B0FF0000A7FF595AB0FFCCD0BFFFC6CB
      C3FFBEC1C1FF232493FF0000A4FF0606ADFF0708C1FF1E26AFFFDFDFDFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B3B5BFFF060EB4FF0403
      AAFF0403A6FF0000A3FF4C4BACFFC1C1B3FFB0B0ABFFB7B7AFFF343487FF0000
      92FF0000A9FF1111A4FF9E9EAFFFB5B6ADFFBFC0B2FF6A6B99FF00008EFF0000
      AAFF00009DFF7374ABFFC2C4B4FFBEC0B7FFABADB3FF13138FFF0000A1FF0403
      A5FF0506BAFF1D24ACFFDFDFDFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B5C0FF050EB4FF0200A3FF0202A1FF00009CFF2829A5FFC2C2
      C0FFBEBEB8FFC6C6BAFF76769AFF000077FF00009CFF1011A4FFADADB1FFC6C6
      ADFFD1D0B3FF74749DFF00008EFF00009CFF111297FFA7A8B0FFB4B5AEFFBEC0
      B2FF8A8AA4FF00008BFF0000A0FF02019FFF0204B5FF1C23AAFFDFDFDFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B3B5C1FF0510B9FF0103
      A7FF0104A5FF0000A4FF0001A2FF9E9FC2FFDADACAFFC5C5C2FFC9C9C1FF4142
      89FF000079FF0103A0FF7073B5FF8E8FB1FF9092B4FF4648A7FF000095FF0000
      91FF7B7CA7FFBFC0B1FFACADACFFC1C1B2FF4F529AFF000095FF0103A7FF0103
      A3FF0206B9FF1C22AAFFDFDFDFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B5C1FF0412C0FF0106B1FF0108ADFF0107ADFF0000A6FF464B
      B8FFE8E6D7FFD2D2CDFFD2D2CDFFCBCCC8FF4B4C90FF000079FF00008CFF0000
      97FF000097FF000090FF070A90FF7779A7FFBEBEB1FFABABABFFBCBBAEFFA1A2
      ADFF0B1098FF0000A8FF0108AEFF0108ABFF0109C0FF1C22AAFFDFDFDFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B4B5C1FF0313C6FF0002
      B6FF000AB4FF010CB4FF0007B3FF0000ADFF959ACDFFFAF9E0FFD5D5D4FFDBDB
      D5FFD9D9D2FF9192B0FF4C5097FF2F3492FF353897FF6061A3FFA3A4B4FFC5C4
      B8FFAFAFADFFB5B3ABFFC1C1B2FF4248A3FF0000A6FF000AB6FF010BB4FF000B
      B2FF0009C6FF1A21AAFFDFDFDFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B4C1FF2B3DD8FF1C28C8FF0002B9FF0002B9FF0005BAFF0000
      B6FF0005B4FF9EA3D4FFF9F7E5FFE1E1DDFFDCDCDAFFE7E7DCFFE2E2D7FFD8D8
      CFFFD5D5CBFFD8D8CBFFCECDC4FFBBBBBBFFC4C3BBFFC4C2B9FF4E56ABFF0000
      A9FF0001BAFF0006BBFF0004BAFF0006B9FF0515D1FF2127ADFFDFDFDFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B3B3C1FF485AE6FF7A84
      E5FF4954D4FF2F3CCEFF2A3ACDFF2C3BCEFF2029C9FF2937C8FFA9AEE0FFF8F8
      EFFFF9F8EEFFECEBE7FFE7E7E4FFE5E5E2FFE1E1DDFFDDDDDAFFDFDED7FFE4E3
      D5FFCFCFD2FF6972C3FF1823BFFF222FCBFF2535CDFF2333CCFF2432CCFF3543
      CEFF4F5BE8FF2E32B0FFDFDFDFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B3C1FF495CEAFF8F99EDFF8792E6FF8691E7FF848FE6FF838E
      E6FF838FE6FF7681E4FF6875DEFF99A1E7FFD5D8F1FFF0F0F5FFFAFAF5FFFBFA
      F4FFF9F8F2FFF2F2EFFFE0E1EAFFBABEE4FF7B85DBFF5F6CDCFF6F7DE3FF727F
      E3FF717DE3FF707CE3FF6E7BE2FF7380E1FF6A77F3FF2D31B0FFDFDFDFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B2B2C2FF5569F3FF9DA6
      F0FF8B96E9FF8C97E9FF8C96E9FF8B95E9FF8A94E8FF8994E8FF8691E8FF7985
      E5FF7B87E3FF8D98E6FFA0A8E8FFA7AFE9FFA4ABE8FF97A0E5FF828DE3FF727E
      E0FF7582E5FF7D89E7FF7C88E6FF7B87E6FF7A87E6FF7986E5FF7684E5FF7A86
      E4FF7884F7FF2E33B3FFDDDDDDFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C8C8D0FF4F64F1FFB3BAF8FFA2A9ECFF9BA4ECFF9AA3EBFF99A2
      EBFF98A1EBFF97A0EBFF969FEBFF959FEBFF919CEAFF8B95E9FF8690E8FF848F
      E8FF838EE7FF838FE7FF8893E9FF8C96E9FF8C96E9FF8A94E8FF8993E8FF8892
      E8FF8691E8FF8590E7FF8893E8FF96A1E9FF848FFDFF3437A9FFF1F1F1FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFBFF4050C8FFACB9
      FFFFCDD0F0FFBAC1F1FFB4BBF0FFB4BAF0FFB3BAF0FFB2B9F0FFB1B8F0FFB0B7
      F0FFB0B7EFFFAFB6EFFFAEB5EFFFADB4EFFFACB4EFFFACB3EFFFABB2EFFFAAB2
      EFFFA9B1EEFFA8B0EEFFA7AFEEFFA6AEEEFFA5ADEEFFA6AEEEFFB0B8EFFFB8C3
      F6FF5F66FBFF6F6F9FFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BCBCC9FF3C51EAFFAFBCFFFFD7DCFFFFDADEFFFFD7DC
      FFFFD6DCFFFFD5DBFFFFD4DAFFFFD3D9FFFFD3D8FFFFD2D8FFFFD0D7FFFFD0D6
      FFFFCFD5FFFFCED4FFFFCDD4FFFFCCD3FFFFCBD2FFFFCBD1FFFFCAD0FFFFC9D0
      FFFFC9CFFFFFC9D0FFFFB9C1FFFF737BFFFF3739A7FFE7E7E7FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C9C9
      D0FF5761B9FF505FDBFF5160DDFF4E5CD9FF4E5BDAFF4D5AD9FF4C59D7FF4C58
      D6FF4B57D5FF4A55D4FF4A54D4FF4953D2FF4852D2FF4751D1FF474FD0FF464E
      CFFF464DCEFF454CCEFF454ACEFF4449CCFF4449CCFF4549CEFF4244BFFF6E6E
      A5FFECECECFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDEDEDFFE3E3E4FFE4E4
      E5FFE4E4E5FFE4E4E5FFE4E4E5FFE4E4E5FFE4E4E5FFE4E4E5FFE4E4E4FFE4E4
      E5FFE4E4E5FFE4E4E5FFE4E4E5FFE4E4E5FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4
      E4FFE4E4E4FFE4E4E4FFF5F5F5FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E000000280000007C0000001F00000001000100
      00000000F00100000000000000000000000000000000000000000000FFFFFF00
      F000001E000000000000000000000000E0000006000000000000000000000000
      C000000200000000000000000000000080000002000000000000000000000000
      8000000000000000000000000000000080000000000000000000000000000000
      8000000000000000000000000000000080000000000000000000000000000000
      8000000000000000000000000000000080000000000000000000000000000000
      8000000000000000000000000000000080000000000000000000000000000000
      8000000000000000000000000000000080000000000000000000000000000000
      8000000000000000000000000000000080000000000000000000000000000000
      8000000000000000000000000000000080000000000000000000000000000000
      8000000000000000000000000000000080000000000000000000000000000000
      8000000000000000000000000000000080000000000000000000000000000000
      8000000000000000000000000000000080000000000000000000000000000000
      8000000000000000000000000000000080000000000000000000000000000000
      80000002000000000000000000000000C0000002000000000000000000000000
      E0000006000000000000000000000000F800001E000000000000000000000000
      FFFFFFFE00000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object popShutDown: TPopupMenu
    Left = 500
    Top = 379
    object mnuShutdown: TMenuItem
      Caption = #1042#1099#1082#1083#1102#1095#1080#1090#1100
      OnClick = mnuShutdownClick
    end
    object mnuReboot: TMenuItem
      Caption = #1055#1077#1088#1077#1079#1072#1075#1088#1091#1079#1082#1072
      OnClick = mnuRebootClick
    end
    object mnuLogoff: TMenuItem
      Caption = #1042#1099#1093#1086#1076' '#1080#1079' '#1089#1080#1089#1090#1077#1084#1099
      OnClick = mnuLogoffClick
    end
  end
end
