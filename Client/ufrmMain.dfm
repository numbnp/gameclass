object frmMain: TfrmMain
  Left = 355
  Top = 208
  BiDiMode = bdLeftToRight
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
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object wbFullScreen: TWebBrowser
    Left = 0
    Top = 0
    Width = 639
    Height = 451
    Align = alClient
    TabOrder = 5
    ControlData = {
      4C0000000B4200009D2E00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
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
      object tbActions: TToolBar
        Left = 579
        Top = 53
        Width = 51
        Height = 37
        Align = alNone
        ButtonHeight = 37
        ButtonWidth = 38
        Caption = 'tbActions'
        Color = clBtnFace
        EdgeBorders = []
        Flat = True
        Images = ilActions
        ParentColor = False
        TabOrder = 3
        Transparent = True
        Visible = False
        object tbCompShutdown: TToolButton
          Left = 0
          Top = 0
          AutoSize = True
          Caption = 'Shutdown'
          DropdownMenu = popShutDown
          ImageIndex = 1
          Style = tbsDropDown
          OnClick = tbCompShutdownClick
        end
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
    TabOrder = 4
    Visible = False
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
    Top = 61
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
      494C01010300040004001F001F0000000000FF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000007C0000001F0000000100200000000000103C
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FFFDFDFDFFE0E0E0FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7
      D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7
      D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFE0E0E0FFFDFDFDFF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF000000FFC2C2C2FF727272FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF5959
      59FF595959FF727272FFC2C2C2FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FFFDFDFDFF909090FF1C1C1CFF030801FF050E00FF050E
      00FF050D00FF050D00FF050D00FF050D00FF050C00FF050C00FF050C00FF050C
      00FF040B00FF040B00FF040B00FF040B00FF040A00FF040A00FF040A00FF040A
      00FF020501FF1C1C1CFF909090FFFDFDFDFF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FFC2C2C2FF727272FF595959FF595959FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF7272
      72FFC2C2C2FF000000FF000000FF000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FFF7F7
      F7FF595959FF010101FF000013FF000034FF000039FF00003CFF000040FF0000
      43FF000046FF000049FF00004CFF00004FFF00004FFF00004CFF000048FF0000
      45FF000042FF00003FFF00003BFF000038FF000033FF000012FF010101FF5959
      59FFF7F7F7FF000000FF000000FF000000FF000000FFFEFEFEFF5E5E5EFF0B1E
      00FF2D7800FF3A9B00FF3A9A00FF3A9700FF399500FF399200FF389000FF388D
      00FF388B00FF378800FF378600FF368300FF368100FF357E00FF357C00FF3479
      00FF347700FF347400FF337200FF336F00FF326C00FF255100FF091300FF5E5E
      5EFFFEFEFEFF000000FF000000FF000000FF000000FFF7F7F7FF595959FF0101
      01FF00111DFF002E4DFF003351FF003551FF003851FF003A51FF003D51FF003F
      51FF004251FF004551FF004551FF004351FF004051FF003D51FF003B51FF0038
      51FF003651FF003351FF002F4DFF00111DFF010101FF595959FFF7F7F7FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF5E5E5EFF000001FF000058FF0000A0FF0000
      ABFF0000B5FF0000BEFF0000C8FF0000D2FF0000DCFF0000E6FF0000EFFF0000
      F8FF0000F9FF0000EFFF0000E4FF0000D9FF0000CFFF0000C5FF0000BAFF0000
      B1FF0000A8FF00009EFF000058FF000001FF5E5E5EFF000000FF000000FF0000
      00FF000000FFA7A7A7FF081801FF369904FF3BA100FF3B9F00FF3B9D00FF3A9A
      00FF3A9700FF399500FF399200FF389000FF388D00FF388B00FF378800FF3786
      00FF368300FF368100FF357E00FF357C00FF347900FF347700FF347400FF3372
      00FF336F00FF326D00FF2E6400FF070F00FFA7A7A7FF000000FF000000FF0000
      00FF000000FF5E5E5EFF000103FF004F92FF008FFBFF0099FFFF00A0FFFF00A8
      FFFF00B0FFFF00B7FFFF00BFFFFF00C8FFFF00D0FFFF00D8FFFF00D9FFFF00D1
      FFFF00CAFFFF00C1FFFF00B9FFFF00B1FFFF00AAFFFF00A2FFFF009AFFFF0091
      FBFF005092FF000103FF5E5E5EFF000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FFCCCCCCFF0101
      01FF000046FF000098FF0000A8FF0000B5FF0000BDFF0000C4FF0000CCFF0000
      D4FF0000DCFF0000E3FF0000EBFF0000F2FF0000F4FF0000EDFF0000E6FF0000
      DFFF0000D9FF0000D2FF0000CCFF0000C6FF0000C0FF0000AEFF000098FF0000
      47FF010101FFCCCCCCFF000000FF000000FF000000FF444444FF226707FF39A5
      08FF3AA304FF3A9C00FF378500FF368100FF368000FF357F00FF357E00FF357D
      00FF357C00FF357B00FF347A00FF347900FF347800FF347700FF347600FF3474
      00FF337300FF337200FF337100FF337100FF337100FF336F00FF326D00FF1E42
      00FF444444FF000000FF000000FF000000FFCCCCCCFF010101FF003F7BFF0089
      FEFF0095FFFF00A0FFFF00A6FFFF00ACFFFF00B2FFFF00B8FFFF00BEFFFF00C5
      FFFF00CBFFFF00D2FFFF00D3FFFF00CFFFFF00CAFFFF00C4FFFF00BFFFFF00BB
      FFFF00B6FFFF00B1FFFF00ACFFFF009DFFFF008BFEFF00407BFF010101FFCCCC
      CCFF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF797979FF000000FF000085FF0000B9FF0000C9FF0000
      CCFF0000CEFF0000D1FF0000D4FF0000D6FF0000D9FF0000DCFF0000DEFF0000
      E1FF0000E4FF0000E6FF0000E9FF0000EBFF0000EEFF0000F1FF0000F4FF0000
      F6FF0000F9FF0000FBFF0000E2FF00008CFF000000FF797979FF000000FF0000
      00FF000000FF1E1E1EFF2C890DFF38A70CFF39A408FF347A00FF337300FF3373
      00FF337300FF337300FF337300FF337300FF337300FF337300FF2A6E00FF296D
      00FF337300FF337300FF337300FF337300FF337300FF337300FF337300FF3373
      00FF337300FF337200FF336F00FF295900FF1E1E1EFF000000FF000000FF0000
      00FF797979FF000001FF0078E5FF00A2FFFF00ADFFFF00B0FFFF00B2FFFF00B4
      FFFF00B6FFFF00B9FFFF00BBFFFF00BDFFFF00BFFFFF00C2FFFF00C4FFFF00C7
      FFFF00C9FFFF00CBFFFF00CEFFFF00D0FFFF00D2FFFF00D4FFFF00D6FFFF00D8
      FFFF00C5FFFF007EE4FF000001FF797979FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF5A5A5AFF0000
      10FF0000B5FF0000C3FF0000C6FF0000C9FF0000CCFF0000CEFF0000D1FF0000
      D4FF0000D6FF0000D9FF0000DCFF0000DEFF0000E1FF0000E4FF0000E6FF0000
      E9FF0000EBFF0000EEFF0000F1FF0000F4FF0000F6FF0000F9FF0000FCFF0000
      E5FF000010FF5A5A5AFF000000FF000000FF000000FF1C1C1CFF2C8D10FF36A9
      10FF37A10BFF347800FF347800FF347800FF347800FF347800FF347800FF3478
      00FF347800FF347800FFB6CFAEFFC5DAC1FF357800FF347800FF347800FF3478
      00FF347800FF347800FF347800FF347800FF347800FF347500FF337200FF2A5C
      00FF1C1C1CFF000000FF000000FF000000FF5A5A5AFF000E1CFF009EFEFF00A9
      FFFF00ABFFFF00ADFFFF00B0FFFF00B2FFFF00B4FFFF00B6FFFF00B9FFFF00BB
      FFFF00BDFFFF00BFFFFF00C2FFFF00C4FFFF00C7FFFF00C9FFFF00CBFFFF00CE
      FFFF00D0FFFF00D2FFFF00D4FFFF00D6FFFF00D9FFFF00C6FEFF000E1CFF5A5A
      5AFF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF5B5B5BFF000036FF0000BDFF0000C0FF0000C3FF0000
      C6FF0000C9FF0000CCFF0000CEFF0000D1FF0000D3FF0000D6FF0000D9FF0000
      DBFF0000DEFF0000E0FF0000E3FF0000E6FF0000E8FF0000EBFF0000EEFF0000
      F1FF0000F4FF0000F6FF0000F9FF0000FCFF000046FF5B5B5BFF000000FF0000
      00FF000000FF1C1C1CFF2B8E13FF35AB13FF36A30EFF357E00FF357E00FF357E
      00FF357E00FF317B00FF357E00FF357E00FF357E00FF357E00FFEEF4EAFFF8FB
      F7FF388004FF357E00FF357E00FF357E00FF2F7A00FF347D00FF357E00FF357E
      00FF357E00FF347800FF347400FF2A5E00FF1C1C1CFF000000FF000000FF0000
      00FF5B5B5BFF002F4CFF00A5FFFF00A7FFFF00A9FFFF00ABFFFF00ADFFFF00AF
      FFFF00B1FFFF00B3FFFF00B5FFFF00B7FFFF00BAFFFF00BCFFFF00BEFFFF00C0
      FFFF00C2FFFF00C5FFFF00C8FFFF00CAFFFF00CCFFFF00D0FFFF00D2FFFF00D4
      FFFF00D6FFFF00D9FFFF003C4CFF5B5B5BFF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF646464FF0000
      4BFF0000BBFF0000BDFF0000C0FF0000C3FF0000C8FF0000C9FF0000C9FF0000
      C9FF0000C9FF0000C9FF0000C9FF0000C9FF0000C9FF0000C9FF0000C9FF0000
      C9FF0000C9FF0000CAFF0000CAFF0000D4FF0000EDFF0000F4FF0000F6FF0000
      F9FF000066FF646464FF000000FF000000FF000000FF1C1C1CFF2A9016FF34AD
      17FF35A611FF368300FF368300FF368300FF4E9127FFAACAA7FF438A22FF3683
      00FF368300FF368300FFF1F6EDFFF8FBF7FF398504FF368300FF368300FF3F87
      1DFFB4D0B2FF609C3FFF368300FF368300FF368300FF357B00FF347700FF2A60
      00FF1C1C1CFF000000FF000000FF000000FF646464FF004167FF00A2FFFF00A5
      FFFF00A7FFFF00A5FFFF008DFFFF0082FFFF0081FFFF0081FFFF0081FFFF0081
      FFFF0081FFFF0081FFFF0081FFFF0082FFFF0082FFFF0082FFFF0082FFFF0082
      FFFF0083FFFF0097FFFF00C8FFFF00D2FFFF00D4FFFF00D6FFFF005867FF6464
      64FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF6C6C6CFF000045FF0000B8FF0000BBFF0000BDFF0000
      C9FF0000CBFF0000CBFF0000CBFF0000CBFF0000CBFF2525D2FF6868E0FF8888
      E6FF8888E6FF6868E0FF2525D2FF0000CBFF0000CBFF0000CBFF0000CBFF0000
      CBFF0000D3FF0000F1FF0000F4FF0000F6FF00005FFF6C6C6CFF000000FF0000
      00FF000000FF1C1C1CFF29911AFF33AE1BFF34A814FF378900FF378900FF3789
      00FF63A338FFF9FCF8FFE4EEE3FF489029FF378900FF378900FFF1F7EDFFF7FA
      F5FF388A01FF378900FF458E25FFE0ECDFFFFAFCF9FF6DA944FF378900FF3789
      00FF378900FF357D00FF347900FF2B6200FF1C1C1CFF000000FF000000FF0000
      00FF6C6C6CFF003C61FF00A0FFFF00A2FFFF00A5FFFF008DFFFF0085FFFF0085
      FFFF0085FFFF0085FFFF0085FFFF0085FFFF0085FFFF0085FFFF0085FFFF0085
      FFFF0085FFFF0085FFFF0085FFFF0085FFFF0085FFFF0085FFFF0096FFFF00D0
      FFFF00D2FFFF00D4FFFF005161FF6C6C6CFF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF767676FF0000
      3DFF0000B5FF0000B8FF0000BDFF0000CEFF0000CEFF0000CEFF0000CEFF2626
      D5FFB6B6F0FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFB6B6
      F0FF2626D5FF0000CEFF0000CEFF0000CEFF0000CEFF0000EBFF0000F1FF0000
      F4FF000054FF757575FF000000FF000000FF000000FF1C1C1CFF28931DFF31B0
      20FF33AA18FF388F00FF388F00FF388F00FF388F00FF71AF48FFF7FAF5FFE9F1
      E9FF51992FFF388F00FFECF4E6FFF0F7ECFF388F00FF4E982AFFE7F0E6FFF7FB
      F5FF74B14CFF388F00FF388F00FF388F00FF388F00FF368000FF357C00FF2B64
      00FF1C1C1CFF000000FF000000FF000000FF767676FF003557FF009EFFFF00A0
      FFFF00A0FFFF008AFFFF008AFFFF008AFFFF088EFFFF008AFFFF008AFFFF008A
      FFFF008AFFFF008AFFFF008AFFFF008AFFFF008AFFFF008AFFFF008AFFFF008A
      FFFF008AFFFF008AFFFF008AFFFF00C6FFFF00D0FFFF00D2FFFF004857FF7575
      75FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF7E7E7EFF000036FF0000B3FF0000B5FF0000BBFF0000
      D1FF0000D1FF0000D1FF4343DDFFF1F1FCFFFFFFFFFFEFEFFEFF9D9DF8FF6D6D
      F0FF6D6DF0FF9D9DF8FFEFEFFEFFFFFFFFFFF1F1FCFF4343DDFF0000D1FF0000
      D1FF0000D1FF0000E8FF0000EEFF0000F1FF00004AFF7E7E7EFF000000FF0000
      00FF000000FF1C1C1CFF279420FF30B224FF32AD1CFF399500FF399500FF3995
      00FF399500FF399500FF6BB040FFF4F9F1FFA8D08FFF399500FF5FA930FF60AA
      31FF399500FF98C77AFFF3F9F0FF6CB041FF399500FF399500FF399500FF3995
      00FF399500FF368300FF357E00FF2B6600FF1C1C1CFF000000FF000000FF0000
      00FF7E7E7EFF002F4EFF009CFFFF009EFFFF009EFFFF0090FFFF0090FFFF2CA4
      FFFFF9FCFFFFE6F4FFFFB5DEFFFF61BAFFFF57B6FFFF0090FFFF0090FFFF0090
      FFFF0090FFFF0090FFFF0090FFFF0090FFFF0090FFFF0090FFFF0090FFFF00C4
      FFFF00CEFFFF00D0FFFF00404EFF7E7E7EFF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF868686FF0000
      2FFF0000B0FF0000B3FF0000B8FF0000D4FF0000D4FF2727DAFFF2F2FCFFFEFE
      FFFFA5A5F6FF1111DEFF0000D4FF7777E7FF6969E5FF0000D4FF1111DEFFA5A5
      F6FFFEFEFFFFF2F2FCFF2727DAFF0000D4FF0000D4FF0000E7FF0000EBFF0000
      EEFF000041FF868686FF000000FF000000FF000000FF1C1C1CFF269624FF2FB4
      28FF31AF1FFF3A9A00FF3A9A00FF379600FF369600FF369600FF369600FF459F
      10FF3E9C04FF3A9A00FF3A9A00FF3A9A00FF3A9A00FF3B9B00FF3F9B08FF3493
      00FF349300FF349300FF349300FF3A9A00FF3A9A00FF378600FF368100FF2C68
      00FF1C1C1CFF000000FF000000FF000000FF868686FF002945FF009AFFFF009C
      FFFF009DFFFF0096FFFF0096FFFF20A5FFFFFBFEFFFF2CBBFFFF9FE4FFFFECFB
      FFFFEAFAFFFF69C0FFFF0096FFFF0096FFFF0096FFFF0096FFFF0096FFFF0096
      FFFF0096FFFF0096FFFF0096FFFF00C4FFFF00CBFFFF00CEFFFF003845FF8686
      86FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF8F8F8FFF000028FF0000AEFF0000B0FF0000B5FF0000
      D6FF0000D6FFB7B7F3FFFFFFFFFFA9A9F5FF0101D9FF0000D6FF0F0FD9FFFEFE
      FEFFF3F3FDFF0000D6FF0000D6FF0101D9FFA9A9F5FFFFFFFFFFB7B7F3FF0000
      D6FF0000D6FF0000E5FF0000E9FF0000EBFF000037FF8F8F8FFF000000FF0000
      00FF000000FF1C1C1CFF259727FF2EB62CFF30B123FF3BA000FF61A941FFAACA
      A5FFABCAA6FFABCAA6FFABCAA6FF82B572FF3BA000FF3BA000FF3BA000FF3BA0
      00FF3BA000FF3BA000FF89BA7BFFB8D2B4FFB8D2B4FFB8D2B4FFB7D2B3FF68AC
      4AFF3BA000FF378900FF368300FF2C6B00FF1C1C1CFF000000FF000000FF0000
      00FF8F8F8FFF00233BFF0097FFFF009AFFFF009CFFFF009BFFFF009BFFFF08A0
      FFFFEBF9FFFF67C3FFFF01A0FFFF0AABFFFFB8E7FFFFCCF0FFFF009BFFFF009B
      FFFF009BFFFF009BFFFF009BFFFF009BFFFF009BFFFF009BFFFF009BFFFF00C4
      FFFF00C9FFFF00CBFFFF002F3BFF8F8F8FFF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF989898FF0000
      21FF0000ABFF0000AEFF0000B2FF0000D9FF2323DEFFFDFDFEFFF5F5FEFF1616
      DEFF0000D9FF0000D9FF1111DBFFFFFFFFFFF4F4FDFF0000D9FF0000D9FF0000
      D9FF1616DEFFF5F5FEFFFDFDFEFF2323DEFF0000D9FF0000E3FF0000E5FF0000
      E5FF00002DFF989898FF000000FF000000FF000000FF1C1C1CFF24992BFF2CB8
      30FF2FB427FF39A506FFA8D792FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFF0
      D8FF39A507FF39A506FF39A506FF39A506FF39A506FF39A507FFDDEFD5FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFA2D48AFF39A506FF378C00FF378600FF2D6D
      00FF1C1C1CFF000000FF000000FF000000FF989898FF001D32FF0095FFFF0097
      FFFF009AFFFF00A1FFFF00A1FFFF00A1FFFF30BBFFFFE8F8FFFF6CC8FFFF00A1
      FFFF90DCFFFFD6F0FFFF18A9FFFF00A1FFFF00A1FFFF00A1FFFF00A1FFFF00A1
      FFFF00A1FFFF00A1FFFF00A1FFFF00C2FFFF00C4FDFF00C1FAFF002631FF9898
      98FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FFA0A0A0FF00001BFF0000A8FF0000ABFF0000AFFF0000
      DBFF6060E9FFFFFFFFFFB1B1F5FF0000DCFF0000DCFF0000DCFF1111DEFFFFFF
      FFFFF4F4FDFF0000DCFF0000DCFF0000DCFF0000DCFFB1B1F5FFFFFFFFFF6060
      E6FF0000D5FF0000D7FF0000D8FF0000DBFF000023FFA0A0A0FF000000FF0000
      00FF000000FF1C1C1CFF239B2EFF2BBA34FF2EB62CFF36A910FF39AA13FF55B6
      35FF56B736FF53B533FF51B430FF40AD1BFF36A910FF36A910FF36A910FF36A9
      10FF36A910FF36A910FF3DAC18FF4CB229FF4CB229FF4CB229FF4BB228FF37A9
      11FF36A910FF378F02FF378800FF2D6F00FF1C1C1CFF000000FF000000FF0000
      00FFA0A0A0FF001729FF0093FFFF0095FFFF0098FFFF00A6FFFF00A6FFFF00A6
      FFFF00A6FFFF2EBBFFFFE6F7FFFF70CDFFFF01A8FFFF8EDCFFFFDDF3FFFFBAE6
      FFFFB3E4FFFF6FCCFFFF0AAAFEFF00A4FDFF00A1FBFF009EF9FF009AF6FF00AE
      F3FF00ADF2FF00AFF2FF001C27FFA0A0A0FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FFA8A8A8FF0000
      14FF0000A6FF0000A8FF0000ABFF0000DDFF7676EDFFFFFFFFFF9090F1FF0000
      DFFF0000DFFF0000DFFF1111E1FFFFFFFFFFF4F4FDFF0000DCFF0000DBFF0000
      D9FF0000D7FF9090EDFFFFFFFFFF7676E9FF0000D7FF0000D6FF0000D9FF0000
      DCFF00001BFFA8A8A8FF000000FF000000FF000000FF1C1C1CFF229C31FF2ABB
      38FF2CB831FF34AD18FF34AD18FF34AD18FF34AD18FF34AD18FF30A416FF6BA9
      5FFF4FA73CFF34AD18FF2EA214FF2EA214FF34AD18FF48A335FF56A146FF32A9
      17FF34AD18FF34AD18FF34AD18FF34AD18FF34AD18FF379103FF388B00FF2E71
      00FF1C1C1CFF000000FF000000FF000000FFA8A8A8FF00111FFF0091FFFF0093
      FFFF0095FFFF00ABFFFF00ACFFFF00ACFFFF00ACFFFF00ACFFFF2ABBFFFFE5F6
      FFFF74D1FFFF00ADFEFF65CCFDFF5AC7FCFF5EC8FCFFBAE8FEFFD5EFFDFF1AA8
      F6FF009EF6FF009EF6FF009FF6FF00B0F6FF00B2F6FF00B4F6FF00161EFFA8A8
      A8FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FFB1B1B1FF00000EFF0000A3FF0000A6FF0000A8FF0000
      DFFF6C6CEEFFFFFFFFFFA0A0F4FF0000E1FF0000E0FF0000DFFF1111E0FFFFFF
      FFFFF4F4FDFF0000DCFF0000DCFF0000DCFF0000DCFFA0A0F2FFFFFFFFFF6C6C
      EBFF0000DCFF0000D7FF0000D9FF0000DCFF000013FFB1B1B1FF000000FF0000
      00FF000000FF1C1C1CFF219D35FF29BD3CFF2BBA35FF31B121FF31B121FF31B1
      21FF31B121FF2DA51DFF98C292FFFEFEFEFFA2DC9CFF31B121FFA9CCA5FFA7CB
      A2FF31B121FFB7E3B2FFFCFDFCFF75B16DFF2EAB1FFF31B121FF31B121FF31B1
      21FF31B121FF379404FF388D00FF2E7300FF1C1C1CFF000000FF000000FF0000
      00FFB1B1B1FF000C16FF008EFFFF0091FFFF0093FFFF00B0FFFF00B1FFFF00B1
      FFFF00B1FEFF00B0FDFF00AEFCFF26B7FCFFEEF9FEFF4DC3FAFF00A8F8FF00A8
      F8FF00A8F8FF01A9F9FF95DBFDFFB8E6FDFF00A8F8FF00A8F8FF00A8F8FF00B3
      F8FF00B5F8FF00B7F8FF001016FFB1B1B1FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FFBABABAFF0000
      08FF0000A0FF0000A3FF0000A5FF0000DEFF3A3AE8FFFFFFFFFFE3E3FBFF0404
      E1FF0000E0FF0000E0FF1111E2FFFFFFFFFFF4F4FDFF0000E0FF0000E0FF0000
      E0FF0404E1FFE3E3FBFFFFFFFFFF3A3AE7FF0000DFFF0000D6FF0000D9FF0000
      DBFF00000BFFBABABAFF000000FF000000FF000000FF1C1C1CFF209F38FF27BF
      40FF29BC3AFF2EB52BFF2EB52BFF2EB52BFF2CAA28FFA3C8A0FFFFFFFFFFBEE8
      BDFF35B832FF2EB52BFFF6FBF6FFF1FAF0FF2EB52BFF41BC3EFFD8F1D8FFFDFE
      FDFF7EB57AFF2CAF28FF2EB52BFF2EB52BFF2EB52BFF379705FF389000FF2E75
      00FF1C1C1CFF000000FF000000FF000000FFBABABAFF00070DFF008CFEFF008E
      FEFF0090FEFF00B2FDFF00B3FCFF00B2FBFF00B1FBFF00B1FBFF00B1FBFF01B1
      FBFFEEF9FEFF34C0FCFF00B1FBFF00B1FBFF33C0FBFF10B5FBFF0FB4FBFFF8FC
      FEFF1DB9FBFF00B1FBFF00B1FBFF00B4FBFF00B6FBFF00B8FAFF00090DFFBABA
      BAFF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FFC2C2C2FF000005FF000099FF00009FFF0000A2FF0000
      DEFF0303E4FFDCDCFAFFFFFFFFFF6E6EEFFF0000E4FF0000E4FF1111E6FFFFFF
      FFFFF4F4FDFF0000E4FF0000E4FF0000E4FF6E6EEFFFFFFFFFFFDCDCFAFF0303
      E4FF0000E3FF0000D4FF0000D7FF0000D5FF000007FFC2C2C2FF000000FF0000
      00FF000000FF1C1C1CFF1FA13CFF26C145FF28BE3FFF2BB934FF2BB934FF2BB9
      34FF75CD79FFFFFFFFFFB3E6B7FF2FBB38FF2BB934FF2EBA37FFF8FCF8FFF0FA
      F1FF2BB934FF2BB934FF3BBF43FFD2F0D4FFFEFEFEFF5AC360FF2BB934FF2BB9
      34FF2BB934FF379A07FF399200FF2F7700FF1C1C1CFF000000FF000000FF0000
      00FFC2C2C2FF000408FF0085F7FF0089FCFF008BFCFF00B4FCFF00B9FCFF00B9
      FCFF00B9FCFF00B9FCFF00B9FCFF01B9FCFFE7F7FEFF39C8FDFF00B9FCFF35C7
      FCFFFEFEFEFFBEEDFEFF00B9FCFFEBF9FEFF34C7FCFF00B9FCFF00B8FCFF00B4
      FCFF00B7FCFF00B5F7FF000608FFC2C2C2FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FFCBCBCBFF0000
      02FF000094FF00009DFF00009FFF0000DFFF0000E8FF5454EBFFFEFEFEFFF8F8
      FEFF5656EFFF0000E8FF0404E8FFC9C9F6FFB7B7F4FF0000E8FF0000E8FF5656
      EFFFF8F8FEFFFEFEFEFF5454EBFF0000E8FF0000E5FF0000D2FF0000D5FF0000
      D0FF000003FFCBCBCBFF000000FF000000FF000000FF1C1C1CFF1EA23FFF25C3
      49FF26C144FF28BE3DFF28BE3DFF28BE3DFF33C147FF69D279FF2ABE3FFF28BE
      3DFF28BE3DFF2CBF40FFF8FDF9FFF0FAF1FF28BE3DFF28BE3DFF28BE3DFF34C1
      48FF7DD88BFF31C045FF28BE3DFF28BE3DFF28BE3DFF379C08FF399500FF2F79
      00FF1C1C1CFF000000FF000000FF000000FFCBCBCBFF000204FF0081F4FF0088
      FDFF008AFDFF00B9FDFF00C0FDFF00C0FDFF00C0FDFF00C0FDFF00C0FDFF00C0
      FDFF97DFFEFFA8E9FEFF00C0FDFF0BBFFDFFA2D9FEFF6ECFFEFF3BCEFDFFF5FB
      FEFF0FC1FDFF00C0FDFF00BEFDFF00B4FDFF00B6FDFF00B2F4FF000304FFCBCB
      CBFF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FFD4D4D4FF000000FF00008EFF00009AFF00009DFF0000
      DFFF0000EBFF0000EBFF8A8AEEFFFFFFFFFFFEFEFEFFADADF8FF4A4AF1FF1B1B
      E9FF1B1BEAFF4A4AF1FFADADF8FFFEFEFEFFFFFFFFFF8A8AEEFF0000EBFF0000
      EBFF0000E7FF0000D0FF0000D3FF0000C8FF000000FFD4D4D4FF000000FF0000
      00FF000000FF1C1C1CFF1DA442FF24C54DFF25C349FF26C246FF26C246FF26C2
      46FF26C246FF26C246FF26C246FF26C246FF26C246FF28C249FFF6FCF7FFE7F8
      EBFF26C246FF26C246FF26C246FF26C246FF26C246FF26C246FF26C246FF26C2
      46FF26C246FF379F09FF3A9700FF2F7B00FF1C1C1CFF000000FF000000FF0000
      00FFD4D4D4FF000000FF007DEEFF0087FEFF0089FEFF00BDFEFF00C7FEFF00C7
      FEFF00C7FEFF00C7FEFF00C7FEFF00C7FEFF13C3FEFFD7EEFEFFA7EBFEFF31D1
      FEFF17CAFEFF57D8FEFFE6F9FEFF7BD4FEFF00C7FEFF00C7FEFF00C3FEFF00B3
      FEFF00B5FEFF00ACEEFF000000FFD4D4D4FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FFDDDDDDFF0000
      00FF000088FF000098FF00009BFF0000DFFF0000EFFF0000EFFF0000EDFF6C6C
      EAFFF3F3FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3
      FCFF6C6CEAFF0000EDFF0000EFFF0000EFFF0000E8FF0000CEFF0000D1FF0000
      BFFF000000FFDDDDDDFF000000FF000000FF000000FF1C1C1CFF1BA646FF22C7
      51FF24C54DFF23C64FFF23C750FF23C750FF23C750FF23C750FF23C750FF23C7
      50FF23C750FF23C750FF63D784FF5AD57DFF23C750FF23C750FF23C750FF23C7
      50FF23C750FF23C750FF23C750FF23C750FF24C54CFF399F04FF3A9A00FF2F7D
      00FF1C1C1CFF000000FF000000FF000000FFDDDDDDFF000000FF0076E6FF0085
      FEFF0087FEFF00C0FEFF00CDFEFF00CDFEFF00CDFEFF00CDFEFF00CDFEFF00CD
      FEFF00CDFEFF11C3FEFF8ED1FFFFE3F1FFFFFAFCFFFFD4E9FFFF64C9FFFF00C9
      FEFF00CDFEFF00CDFEFF00C8FEFF00B1FEFF00B3FEFF00A4E6FF000000FFDDDD
      DDFF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FFE5E5E5FF000000FF000080FF000096FF000098FF0000
      D0FF0000F2FF0000F2FF0000F2FF0000F2FF1616E7FF7676E9FFBBBBEFFFDCDC
      F6FFDCDCF6FFBBBBEFFF7676E9FF1616E7FF0000F2FF0000F2FF0000F2FF0000
      F2FF0000E2FF0000CCFF0000CEFF0000B6FF000000FFE5E5E5FF000000FF0000
      00FF000000FF1C1C1CFF1BA648FF21C955FF22C751FF23C750FF21C955FF21CA
      56FF21C955FF21C955FF21C954FF21C954FF22C953FF22C853FF22C853FF22C8
      52FF22C852FF22C751FF22C751FF23C750FF23C750FF23C74FFF23C64FFF25C3
      48FF33AE1BFF3B9F00FF3B9D00FF2F8004FF1C1C1CFF000000FF000000FF0000
      00FFE5E5E5FF000000FF0070DDFF0083FFFF0085FFFF00B6FFFF00D4FFFF00D4
      FFFF00D4FFFF00D4FFFF00D4FFFF00D4FFFF00D4FFFF00D4FFFF00D3FFFF00C2
      FFFF00BBFFFF00C7FFFF00D4FFFF00D4FFFF00D4FFFF00D4FFFF00C5FFFF00AF
      FFFF00B2FFFF009CDDFF000000FFE5E5E5FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FFFAFAFAFF0909
      09FF000072FF000093FF000096FF0000A3FF0000E9FF0000F5FF0000F5FF0000
      F5FF0000F5FF0000F5FF0000F2FF0000ECFF0000ECFF0000F2FF0000F5FF0000
      F5FF0000F5FF0000F5FF0000F5FF0000EEFF0000CBFF0000C9FF0000CCFF0000
      A1FF090909FFFAFAFAFF000000FF000000FF000000FF1E1E1EFF1D9037FF20CB
      59FF21C955FF22C751FF24C54DFF25C349FF26C145FF27BF40FF29BD3CFF2ABB
      38FF2BBA34FF2CB830FF2EB62CFF2FB428FF30B224FF31B020FF33AE1BFF34AD
      17FF35AB13FF36A910FF38A70CFF39A508FF3AA304FF3BA100FF3B9F00FF297B
      0FFF1E1E1EFF000000FF000000FF000000FFFAFAFAFF090909FF0064C7FF0081
      FFFF0083FFFF008FFFFF00CFFFFF00DAFFFF00DAFFFF00DAFFFF00DAFFFF00DA
      FFFF00DAFFFF00DAFFFF00DAFFFF00DAFFFF00DAFFFF00DAFFFF00DAFFFF00DA
      FFFF00DAFFFF00D3FFFF00B0FFFF00ADFFFF00B0FFFF008BC7FF090909FFFAFA
      FAFF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF535353FF00003DFF000091FF000093FF0000
      96FF00009EFF0000BEFF0000C8FF0000CAFF0000CBFF0000CCFF0000CEFF0000
      CFFF0000D0FF0000D2FF0000D3FF0000D5FF0000D6FF0000D7FF0000D3FF0000
      C3FF0000C3FF0000C6FF0000C9FF000056FF535353FF000000FF000000FF0000
      00FF000000FF444444FF1C4C0AFF20C456FF20CB59FF21C955FF22C751FF24C5
      4DFF25C349FF26C145FF27BF40FF29BD3CFF2ABB38FF2BBA34FF2CB830FF2EB6
      2CFF2FB428FF30B224FF31B020FF33AE1BFF34AD17FF35AB13FF36A910FF38A7
      0CFF39A508FF3AA304FF33A617FF1D4C08FF444444FF000000FF000000FF0000
      00FF000000FF535353FF00356CFF007FFEFF0081FFFF0083FFFF008AFFFF00A8
      FFFF00B1FFFF00B2FFFF00B4FFFF00B5FFFF00B6FFFF00B7FFFF00B8FFFF00B9
      FFFF00BAFFFF00BCFFFF00BDFFFF00BEFFFF00BAFFFF00AAFFFF00A9FFFF00AB
      FFFF00ADFEFF004B6CFF535353FF000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FFD8D8
      D8FF0D0D0DFF000055FF000090FF000093FF000096FF000098FF00009BFF0000
      9EFF0000A0FF0000A3FF0000A6FF0000A8FF0000ABFF0000AEFF0000B0FF0000
      B3FF0000B5FF0000B8FF0000BBFF0000BDFF0000C0FF0000C2FF000077FF0D0D
      0EFFD8D8D8FF000000FF000000FF000000FF000000FFA7A7A7FF070F00FF2D73
      0CFF25AE40FF20C758FF20C958FF21C855FF22C653FF23C550FF24C44DFF25C3
      4AFF25C247FF26C145FF27C042FF28BE3FFF29BD3CFF2ABC39FF2BBA37FF2BB9
      34FF2CB731FF2DB62EFF2EB52CFF2FB329FF2FB128FF2EA224FF2D740BFF070F
      00FFA7A7A7FF000000FF000000FF000000FF000000FFD8D8D8FF0D0D0EFF004B
      99FF007EFEFF0081FFFF0083FFFF0086FFFF0088FFFF008AFFFF008CFFFF008E
      FFFF0091FFFF0093FFFF0095FFFF0097FFFF009AFFFF009CFFFF009EFFFF00A0
      FFFF00A2FFFF00A5FFFF00A7FFFF00A8FEFF006798FF0D0D0EFFD8D8D8FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FFC1C1C1FF191919FF00001DFF0000
      44FF00004FFF000050FF000051FF000053FF000054FF000056FF000057FF0000
      58FF00005AFF00005BFF00005DFF00005EFF00005FFF000061FF000062FF0000
      64FF000059FF000027FF191919FFC1C1C1FF000000FF000000FF000000FF0000
      00FF000000FFFEFEFEFF5C5C5CFF091400FF275700FF337600FF347C01FF357F
      01FF368301FF368701FF378B01FF388F01FF389301FF399701FF3A9B01FF3A9E
      01FF3BA101FF3A9D01FF399801FF389301FF388F01FF378A01FF368501FF3580
      01FF347900FF275900FF091500FF5C5C5CFFFEFEFEFF000000FF000000FF0000
      00FF000000FF000000FFC1C1C1FF191919FF001933FF003B77FF004587FF0046
      87FF004787FF004887FF004A87FF004B87FF004C87FF004D87FF004E87FF004F
      87FF005187FF005287FF005387FF005487FF005587FF005787FF004D77FF0022
      33FF191919FFC1C1C1FF000000FF000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FFF2F2F2FF979797FF606060FF595959FF595959FF595959FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF5959
      59FF595959FF595959FF595959FF595959FF606060FF979797FFF2F2F2FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FFFDFDFDFF8F8F
      8FFF1C1C1CFF020601FF040B00FF040B00FF050C00FF050C00FF050C00FF050D
      00FF050D00FF050D00FF050E00FF050E00FF050E00FF050E00FF050E00FF050D
      00FF050D00FF050C00FF050C00FF040B00FF020601FF1C1C1CFF8F8F8FFFFDFD
      FDFF000000FF000000FF000000FF000000FF000000FF000000FF000000FFF2F2
      F2FF979797FF606060FF595959FF595959FF595959FF595959FF595959FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF5959
      59FF595959FF595959FF606060FF979797FFF2F2F2FF000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FFFDFDFDFFE0E0E0FFD7D7D7FFD7D7
      D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7
      D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7
      D7FFE0E0E0FFFDFDFDFF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E000000280000007C0000001F00000001000100
      00000000F00100000000000000000000000000000000000000000000FFFFFF00
      FFFFFFFFF000003FFFFFFFF800000000F800001FC000000FE000007800000000
      E0000007800000078000001800000000E0000007800000078000001800000000
      C0000003800000070000000800000000C0000003800000070000000800000000
      C0000003800000070000000800000000C0000003800000070000000800000000
      C0000003800000070000000800000000C0000003800000070000000800000000
      C0000003800000070000000800000000C0000003800000070000000800000000
      C0000003800000070000000800000000C0000003800000070000000800000000
      C0000003800000070000000800000000C0000003800000070000000800000000
      C0000003800000070000000800000000C0000003800000070000000800000000
      C0000003800000070000000800000000C0000003800000070000000800000000
      C0000003800000070000000800000000C0000003800000070000000800000000
      C0000003800000070000000800000000C0000003800000070000000800000000
      C0000003800000070000000800000000E0000007800000078000001800000000
      E0000007800000078000001800000000F000000F80000007C000003800000000
      F800001FC000000FE000007800000000FFFFFFFFF000003FFFFFFFF800000000
      FFFFFFFFFFFFFFFFFFFFFFF80000000000000000000000000000000000000000
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
