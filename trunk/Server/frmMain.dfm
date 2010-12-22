object formMain: TformMain
  Left = 236
  Top = 325
  AlphaBlendValue = 0
  AutoScroll = False
  BiDiMode = bdRightToLeftNoAlign
  BorderWidth = 5
  Caption = 'GameClass3 Server'
  ClientHeight = 571
  ClientWidth = 919
  Color = clBtnFace
  Constraints.MinHeight = 360
  Constraints.MinWidth = 480
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = menuMain
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  PrintScale = poNone
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseMove = FormMouseMove
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 919
    Height = 54
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object tbActions: TToolBar
      Left = 0
      Top = 0
      Width = 797
      Height = 54
      Align = alClient
      ButtonHeight = 51
      ButtonWidth = 55
      Caption = 'tbActions'
      Color = clBtnFace
      EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
      Flat = True
      Images = ilActions
      ParentColor = False
      ShowCaptions = True
      TabOrder = 0
      object tbCompStart: TToolButton
        Left = 0
        Top = 0
        Caption = 'Start'
        ImageIndex = 0
        OnClick = tbCompStartClick
      end
      object tbCompAdd: TToolButton
        Left = 55
        Top = 0
        Caption = 'Add'
        ImageIndex = 5
        OnClick = tbCompAddClick
      end
      object tbCompStop: TToolButton
        Left = 110
        Top = 0
        Caption = 'Stop'
        ImageIndex = 1
        OnClick = tbCompStopClick
      end
      object tbCompMove: TToolButton
        Left = 165
        Top = 0
        Caption = 'Move'
        ImageIndex = 2
        OnClick = tbCompMoveClick
      end
      object tbCompReset: TToolButton
        Left = 220
        Top = 0
        Caption = 'Reset'
        ImageIndex = 7
        OnClick = tbCompResetClick
      end
      object tbCompShutdown: TToolButton
        Left = 275
        Top = 0
        Caption = 'Shutdown'
        DropdownMenu = PopupMenuShutdown
        ImageIndex = 8
        Style = tbsDropDown
        OnClick = tbCompShutdownClick
      end
      object ToolButton9: TToolButton
        Left = 343
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object tbSideline: TToolButton
        Left = 351
        Top = 0
        Caption = #1059#1089#1083#1091#1075#1080
        ImageIndex = 6
        OnClick = tbSidelineClick
      end
      object ToolButton1: TToolButton
        Left = 406
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 5
        Style = tbsSeparator
      end
    end
    object pnlTimer: TPanel
      Left = 797
      Top = 0
      Width = 122
      Height = 54
      Align = alRight
      BevelOuter = bvNone
      BorderWidth = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object dtpIntTime: TDateTimePicker
        Left = 3
        Top = 0
        Width = 118
        Height = 31
        BevelInner = bvNone
        BevelOuter = bvNone
        BiDiMode = bdRightToLeftNoAlign
        Date = 37945.000000000000000000
        Format = 'HH:mm:ss'
        Time = 37945.000000000000000000
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = []
        Kind = dtkTime
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        OnChange = dtpIntDateChange
      end
      object dtpIntDate: TDateTimePicker
        Left = 3
        Top = 32
        Width = 93
        Height = 21
        Date = 37622.988824849500000000
        Format = 'dd MMM yyy'
        Time = 37622.988824849500000000
        DateFormat = dfLong
        Enabled = False
        TabOrder = 1
        OnChange = dtpIntDateChange
      end
      object butResetTime: TButton
        Left = 99
        Top = 33
        Width = 21
        Height = 19
        Hint = 'Reset time'
        Caption = 'l'
        Enabled = False
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = butResetTimeClick
      end
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 54
    Width = 919
    Height = 517
    ActivePage = tabComputers
    Align = alClient
    TabOrder = 1
    OnChange = PageControlChange
    object tabComputers: TTabSheet
      Caption = 'Computers'
      object splitComps: TSplitter
        Left = 0
        Top = 357
        Width = 911
        Height = 6
        Cursor = crVSplit
        Align = alBottom
      end
      object gridComps: TDBGridEh
        Left = 0
        Top = 0
        Width = 911
        Height = 357
        Align = alClient
        AutoFitColWidths = True
        DataSource = dsComps
        EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        MinAutoFitWidth = 50
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind]
        PopupMenu = PopupMenuComps
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        FilterStringColor = clWindow
        OnCellClick = gridCompsCellClick
        OnContextPopup = gridCompsContextPopup
        OnDblClick = gridCompsDblClick
        OnKeyDown = gridCompsKeyDown
        OnKeyUp = gridCompsKeyUp
        OnMouseDown = gridCompsMouseDown
        OnSortMarkingChanged = gridCompsSortMarkingChanged
        Columns = <
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'Ping'
            Footers = <>
            ImageList = ilSmall
            KeyList.Strings = (
              '0'
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              ''
              '')
            MinWidth = 10
            Title.Alignment = taCenter
            Title.Caption = '  '
            Title.TitleButton = True
            Width = 14
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'Computer'
            Footers = <>
            Title.SortIndex = 1
            Title.SortMarker = smDownEh
            Title.TitleButton = True
            Width = 75
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'State'
            Footers = <>
            Title.TitleButton = True
            Width = 80
            WordWrap = True
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'Tarif'
            Footers = <>
            Title.TitleButton = True
            Width = 100
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'Balance'
            Footers = <>
            Title.TitleButton = True
            Width = 110
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'Start'
            Footers = <>
            Title.TitleButton = True
            Width = 55
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'End'
            Footers = <>
            Title.TitleButton = True
            Width = 55
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'Time'
            Footers = <>
            Title.TitleButton = True
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'TimeLeft'
            Footers = <>
            Title.TitleButton = True
            Width = 65
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'Printed'
            Footers = <>
            Title.TitleButton = True
            Width = 75
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'Traffic'
            Footers = <>
            Title.TitleButton = True
            Width = 75
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'Client'
            Footers = <>
            Title.TitleButton = True
            Width = 100
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'Description'
            Footers = <>
            Title.TitleButton = True
            Width = 50
          end>
      end
      object pnlBottom: TPanel
        Left = 0
        Top = 363
        Width = 911
        Height = 126
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object lvConsole: TListView
          Left = 0
          Top = 0
          Width = 911
          Height = 126
          Align = alClient
          BiDiMode = bdRightToLeftNoAlign
          Columns = <
            item
              AutoSize = True
              Caption = 'Events list'
            end>
          FlatScrollBars = True
          HideSelection = False
          IconOptions.Arrangement = iaLeft
          IconOptions.WrapText = False
          ReadOnly = True
          RowSelect = True
          ParentBiDiMode = False
          SmallImages = ilEvents
          TabOrder = 0
          ViewStyle = vsReport
        end
        object memoClientInfo: TMemo
          Left = 911
          Top = 0
          Width = 0
          Height = 126
          Align = alRight
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
    end
    object tabReports: TTabSheet
      Caption = 'Reports'
      ImageIndex = 3
      object pnlReports: TPanel
        Left = 0
        Top = 0
        Width = 911
        Height = 489
        Align = alClient
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 0
      end
    end
    object tabMessages: TTabSheet
      Caption = 'Messages'
      ImageIndex = 2
      inline frameMessages: TframeMessages
        Left = 0
        Top = 0
        Width = 911
        Height = 489
        Align = alClient
        TabOrder = 0
        inherited Panel1: TPanel
          Top = 448
          Width = 911
          DesignSize = (
            911
            41)
          inherited edtMessage: TEdit
            Width = 800
          end
          inherited btnSend: TButton
            Left = 822
            OnClick = frameMessagesbtnSendClick
          end
        end
        inherited Panel2: TPanel
          Width = 911
          Height = 448
          inherited memMessages: TMemo
            Width = 749
            Height = 446
            Lines.Strings = ()
          end
          inherited Panel3: TPanel
            Height = 446
            inherited lvUsers: TListView
              Height = 444
            end
          end
        end
      end
    end
  end
  object menuMain: TMainMenu
    Left = 376
    object subSystem: TMenuItem
      Tag = 1
      Caption = #1057#1080#1089#1090#1077#1084#1072
      object mnuLogon: TMenuItem
        Action = dmActions.actConnect
        SubMenuImages = ilSmall
      end
      object mnuLogout: TMenuItem
        Action = dmActions.actDisconnect
      end
      object sep2: TMenuItem
        Caption = '-'
      end
      object mnuChangePass: TMenuItem
        Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
        OnClick = mnuChangePassClick
      end
      object mnuLanguage: TMenuItem
        Tag = 1
        Caption = #1071#1079#1099#1082
        object mnuLangRussian: TMenuItem
          Action = dmActions.actLangRussian
        end
        object mnuLangEnglish: TMenuItem
          Action = dmActions.actLangEnglish
        end
      end
      object sep1: TMenuItem
        Caption = '-'
      end
      object mnuExit: TMenuItem
        Action = dmActions.actExit
      end
    end
    object subWork: TMenuItem
      Tag = 1
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      object mnuStart: TMenuItem
        Caption = #1053#1072#1095#1072#1090#1100' '#1088#1072#1073#1086#1090#1091
        ShortCut = 45
        OnClick = mnuStartClick
      end
      object mnuStop: TMenuItem
        Caption = #1047#1072#1074#1077#1088#1096#1080#1090#1100' '#1088#1072#1073#1086#1090#1091
        ShortCut = 46
        OnClick = mnuStopClick
      end
      object mnuMove: TMenuItem
        Caption = #1055#1077#1088#1077#1089#1072#1076#1080#1090#1100' '#1082#1083#1080#1077#1085#1090#1072
        ShortCut = 16461
        OnClick = mnuMoveClick
      end
      object mnuAdd: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1073#1072#1073#1083#1072
        ShortCut = 16429
        OnClick = mnuAddClick
      end
      object mnuTrafiicAdd: TMenuItem
        Caption = #1044#1086#1087#1083#1072#1090#1080#1090#1100' '#1079#1072' '#1090#1088#1072#1092#1092#1080#1082
        OnClick = mnuTrafiicAddClick
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object mnuService: TMenuItem
        Caption = #1059#1089#1083#1091#1075#1080
        OnClick = mnuServiceClick
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object mnuActivateReserve: TMenuItem
        Caption = #1040#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1073#1088#1086#1085#1100
        OnClick = mnuActivateReserveClick
      end
      object mnuCancelReserve: TMenuItem
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1073#1088#1086#1085#1100
        OnClick = mnuCancelReserveClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mnuManualPrint: TMenuItem
        Caption = #1042#1085#1077#1089#1090#1080' '#1076#1072#1085#1085#1099#1077' '#1086' '#1088#1072#1089#1087#1077#1095#1072#1090#1082#1077
        OnClick = mnuManualPrintClick
      end
      object subPenalty: TMenuItem
        Tag = 1
        Caption = #1064#1090#1088#1072#1092
        object mnuPenalty1: TMenuItem
          Caption = '1 '#1084#1080#1085#1091#1090#1072
          OnClick = mnuPenalty1Click
        end
        object mnuPenalty2: TMenuItem
          Caption = '2 '#1084#1080#1085#1091#1090#1099
          OnClick = mnuPenalty2Click
        end
        object mnuPenalty5: TMenuItem
          Caption = '5 '#1084#1080#1085#1091#1090
          OnClick = mnuPenalty5Click
        end
        object mnuPenalty10: TMenuItem
          Caption = '10 '#1084#1080#1085#1091#1090
          OnClick = mnuPenalty10Click
        end
        object mnuPenalty15: TMenuItem
          Caption = '15 '#1084#1080#1085#1091#1090
          OnClick = mnuPenalty15Click
        end
      end
      object subTimeBonus: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1073#1077#1089#1087#1083#1072#1090#1085#1086#1077' '#1074#1088#1077#1084#1103
        object mnuTimeBonus1: TMenuItem
          Caption = '1 '#1084#1080#1085#1091#1090#1072
          OnClick = mnuTimeBonus1Click
        end
        object mnuTimeBonus2: TMenuItem
          Caption = '2 '#1084#1080#1085#1091#1090#1099
          OnClick = mnuTimeBonus2Click
        end
        object mnuTimeBonus5: TMenuItem
          Caption = '5 '#1084#1080#1085#1091#1090
          OnClick = mnuTimeBonus5Click
        end
        object mnuTimeBonus10: TMenuItem
          Caption = '10 '#1084#1080#1085#1091#1090
          OnClick = mnuTimeBonus10Click
        end
        object mnuTimeBonus15: TMenuItem
          Caption = '15 '#1084#1080#1085#1091#1090
          OnClick = mnuTimeBonus15Click
        end
      end
      object mnuChangeTarif: TMenuItem
        Caption = #1057#1084#1077#1085#1080#1090#1100' '#1090#1072#1088#1080#1092
        OnClick = mnuChangeTarifClick
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object mnuAllowAuthorization: TMenuItem
        Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1102
        Enabled = False
        ShortCut = 16449
        OnClick = mnuAllowAuthorizationClick
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object subExtendedFunctions: TMenuItem
        Tag = 1
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1092#1091#1085#1082#1094#1080#1080
        object mnuRemont1: TMenuItem
          Caption = #1041#1077#1089#1087#1083#1072#1090#1085#1072#1103' '#1084#1080#1085#1091#1090#1072
          OnClick = mnuRemont1Click
        end
        object N3: TMenuItem
          Caption = '-'
        end
        object mnuRemontLong: TMenuItem
          Caption = #1056#1077#1084#1086#1085#1090
          OnClick = mnuRemontLongClick
        end
        object N5: TMenuItem
          Caption = '-'
        end
        object mnuRestart: TMenuItem
          Caption = #1055#1077#1088#1077#1079#1072#1075#1088#1091#1079#1082#1072
          OnClick = mnuRestartClick
        end
        object mnuShutdown: TMenuItem
          Caption = #1042#1099#1082#1083#1102#1095#1077#1085#1080#1077
          OnClick = mnuShutdownClick
        end
        object mnuWakeUp: TMenuItem
          Caption = #1042#1082#1083#1102#1095#1077#1085#1080#1077
          OnClick = mnuWakeUpClick
        end
        object mnuKillTask: TMenuItem
          Caption = #1057#1085#1103#1090#1100' '#1079#1072#1076#1072#1095#1080
          ShortCut = 16430
          OnClick = mnuKillTaskClick
        end
        object mnuKillTasksTemplate: TMenuItem
          Caption = #1057#1085#1103#1090#1100' '#1079#1072#1076#1072#1095#1080' '#1087#1086' '#1096#1072#1073#1083#1086#1085#1091
          ShortCut = 8238
          OnClick = mnuKillTasksTemplateClick
        end
        object N7: TMenuItem
          Caption = '-'
        end
        object mnuShellMode: TMenuItem
          Tag = 1
          Caption = #1064#1077#1083#1083' '#1088#1077#1078#1080#1084
          Enabled = False
          object mnuShellModeOn: TMenuItem
            Caption = #1040#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100
            OnClick = mnuShellModeOnClick
          end
          object mnuShellModeOff: TMenuItem
            Caption = #1054#1090#1084#1077#1085#1080#1090#1100
            OnClick = mnuShellModeOffClick
          end
        end
        object mnuInstall: TMenuItem
          Caption = #1048#1085#1089#1090#1072#1083#1083#1103#1094#1080#1103'('#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077')'
          ShortCut = 16469
          OnClick = mnuInstallClick
        end
      end
      object mnuCompVolume: TMenuItem
        Caption = #1043#1088#1086#1084#1082#1086#1089#1090#1100
        ShortCut = 16470
        OnClick = mnuCompVolumeClick
      end
    end
    object subOperator: TMenuItem
      Tag = 1
      Caption = #1054#1087#1077#1088#1072#1090#1086#1088
      object mnuCloseShift: TMenuItem
        Caption = #1047#1072#1082#1086#1085#1095#1080#1090#1100' '#1089#1084#1077#1085#1091
        ShortCut = 116
        OnClick = mnuCloseShiftClick
      end
      object sep3: TMenuItem
        Caption = '-'
      end
      object mnuSideline: TMenuItem
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1091#1089#1083#1091#1075#1080
        ShortCut = 120
        OnClick = mnuSidelineClick
      end
      object mnuAccounts: TMenuItem
        Caption = #1059#1095#1077#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080' '#1082#1083#1080#1077#1085#1090#1086#1074
        ShortCut = 118
        OnClick = mnuAccountsClick
      end
      object mnuAddCheckAccount: TMenuItem
        Action = dmActions.actAddCheckAccount
      end
      object mnuSessionLast: TMenuItem
        Caption = #1055#1086#1089#1083#1077#1076#1085#1080#1077' '#1089#1077#1089#1089#1080#1080
        OnClick = mnuSessionLastClick
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object mnuVolumes: TMenuItem
        Caption = #1043#1088#1086#1084#1082#1086#1089#1090#1100
        OnClick = mnuVolumesClick
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object mnuClientInfo: TMenuItem
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1086' '#1082#1083#1080#1077#1085#1090#1077
        ShortCut = 16457
        OnClick = mnuClientInfoClick
      end
      object mnuColor: TMenuItem
        Caption = #1062#1074#1077#1090' '#1092#1086#1085#1072
        Enabled = False
        OnClick = mnuColorClick
      end
      object mnuFont: TMenuItem
        Caption = #1064#1088#1080#1092#1090' '#1090#1072#1073#1083#1080#1094
        Enabled = False
        OnClick = mnuFontClick
      end
    end
    object subBoss: TMenuItem
      Tag = 1
      Caption = #1041#1086#1089#1089
      object mnuGetMoney: TMenuItem
        Caption = #1047#1072#1073#1088#1072#1090#1100' '#1095#1072#1089#1090#1100' '#1076#1077#1085#1077#1075
        OnClick = mnuGetMoneyClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuXReport: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100' X-'#1086#1090#1095#1077#1090#1072
        OnClick = mnuXReportClick
      end
      object mnuZReport: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100' Z-'#1086#1090#1095#1077#1090#1072
        OnClick = mnuZReportClick
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object mnuRemoteManage: TMenuItem
        Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' GC3 '#1082#1083#1080#1077#1085#1090#1072#1084#1080
        OnClick = mnuRemoteManageClick
      end
      object mnuAccounts2: TMenuItem
        Caption = #1059#1095#1077#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080
        OnClick = mnuAccounts2Click
      end
      object mnuBossOptions: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1080#1089#1090#1077#1084#1099
        OnClick = mnuBossOptionsClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object mnuClearStat: TMenuItem
        Caption = #1054#1095#1080#1089#1090#1082#1072' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080
        OnClick = mnuClearStatClick
      end
    end
    object subHelp: TMenuItem
      Tag = 1
      Caption = #1055#1086#1084#1086#1097#1100
      object mnuHelp: TMenuItem
        Action = dmActions.actHelp
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object mnuRunPadShell: TMenuItem
        Caption = #1056#1077#1082#1086#1084#1077#1085#1076#1091#1077#1084' '#1096#1077#1083#1083
        OnClick = mnuRunPadShellClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mnuRestrictions: TMenuItem
        Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103' '#1085#1077#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1085#1086#1081' '#1074#1077#1088#1089#1080#1080
        OnClick = mnuRestrictionsClick
      end
      object mnuAbout: TMenuItem
        Action = dmActions.actAbout
      end
    end
  end
  object ilActions: TImageList
    BlendColor = clBlack
    BkColor = clBlack
    DrawingStyle = dsFocus
    Height = 31
    Width = 31
    Left = 408
    Bitmap = {
      494C010109000E0004001F001F0000000000FF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000007C0000007C000000010020000000000040F0
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
      00000000000000000000F2EEF000DDD5D900A990970098777F009B767B009F7C
      8100A7858800A6838700A5818400A57F820094696E008E646A00865F68008663
      6E00A39AB200595A980063649E007279B3008997CC008997CD008897CE008797
      CE008596CF008495D0008393CE008293CF008192CE0093A1CF00000000000000
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
      000000000000000000000000000000000000FCFCFC00EBE6E800AF939900A786
      8900C9B8B800D4CBCB00D9D3D300D9D1D100D7CDCD00D7CACA00D4C3C300D2BB
      BB00CCAFAF00CCACAC00C5A0A000EADDDD002547CB001539CA001F41CC002446
      CE002445CD002345CE002045CE001C44D1001742D300123FD4000C3BD3000636
      D400002FD0000028BE0093A1CF00000000000000000000000000000000000000
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
      0000EFEAED00C9B5BA00BAA1A300CCBFC000D9D4D400DBD8D800DBD8D800DBD6
      D600D8D1D100D8CECE00D3C2C200C5A7A700B08A8A00B38A8A00C39E9E00ECDF
      DF001039D8001F46DC002E50DE003356DE003356DF003155DF002E56E0002954
      E1002151E3001B4DE4001248E4000B42E4000339E000002FD0008191CD000000
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
      000000000000000000000000000000000000D2BCBD00C4ACAD00E0E0E000E4E4
      E400E5E5E500E5E5E500E2E2E200DFDEDE00DBD7D700DAD3D300CCB4B400CCB3
      B300BCB6B600A4979700A07F7F00E0D3D3001940DE002D51E0003B5CE2004162
      E4006B85EA00AEBCF300E6EBFB00EFF2FD00CFDAF9008BA6F300295CEB00114A
      E900073FE5000334D5008193CF00000000000000000000000000000000000000
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
      0000C6A7A800D1C4C400E5E5E500E8E8E800EBEBEB00EBEBEB00E6E6E600E3E2
      E200DBD9D900DAD5D500C8ADAD00D4BDBD00BCADAD00A8949400A4888800E0D7
      D7002046DF003759E2004563E4006881E900E1E6FA00D4DCF90088A0EF007190
      EE009FB4F400E0E7FB009EB6F6002459EA000C43E5000838D5008394CF000000
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
      000000000000000000000000000000000000CEB4B400DDD6D600ECECEC00F0F0
      F000F5F5F500F4F4F400EDEDED00E8E8E800DFDEDE00DBD7D700C39F9F00DAC4
      C400B4929200AD888800AE838300E3D5D500294DE0004161E3005D78E700CFD7
      F700B2C0F4005472E7005778E9007C97EF002F5EE8004771EB00DEE5FB0085A1
      F3001448E500113FD5007F8DC800000000000000000000000000000000000000
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
      0000D4B9B900DDD3D300EEEEEE00F3F3F300F9F9F900F8F8F800EEEEEE00EAEA
      EA00DFDEDE00DBD5D500C49C9C00D7BCBC00B1848400B0818100B27F7F00E5D4
      D4003054E1004967E4007C92EC00E7EBFB006E87EA004A6AE6008299EE00FFFF
      FF00305CE7002757E70097AEF300CDD8F900194BE3001743D4006A6EA9000000
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
      000000000000000000000000000000000000F2EBEB00D8C0C000E9E4E400EEEB
      EB00E5CECE00E9D7D700E9E2E200E7E3E300DDD9D900D2BEBE00CEA5A500CFA4
      A400B9787800B9777700BC747400E8D0D0003A5BE300526EE6008FA1EF00E5E9
      FB00506DE6004A68E5008197ED00FFFFFF002E58E4002653E5006082EC00EDF1
      FD00204DE2001F46D3004D4F9400000000000000000000000000000000000000
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
      0000FBFAFA00EEE3E300DCC7C700E2D2D200CD999900C88B8B00D6B2B200DCC7
      C700DBD5D500CEB0B000CEA3A300CB979700BD747400BD737300C0707000EACF
      CF004060E3005974E7008EA0EE00E7EBFB005B75E6004A68E5008197ED00FFFF
      FF002E55E3002651E3007590ED00E3E8FB00244EE1002448D2003E408B000000
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
      0000000000000000000000000000000000000000000000000000F8F8F800DBC1
      C300D09B9000ECB78200E5BAA500DBA59600CB8B8800CA908F00C9878700C678
      7800C66A6A00C6696900C8666600ECCCCC004967E500647DE8007A90EB00DFE4
      FA009BABF0004F6BE5006C84EA00BEC8F5003054E200365AE300CCD6F800A5B5
      F200294FDF00284AD1003E449000000000000000000000000000000000000000
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
      00000000000000000000F8F8F800DBC2C300D0937D00F3A33700F9AF4600F4BA
      7000E4BAA800D8A7A300C87B7B00C6707000C7666600C7646400C5616100EBCB
      CB004F6CE5006C85E9006D86EA00A5B3F200E6EAFB009AA9F0004E69E5003E5D
      E3005975E700A7B5F200DBE1FA005976E7002C51DF00294BD0003F4490000000
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
      0000000000000000000000000000000000000000000000000000F3F2F300D3B6
      B800DA976000F7A32900FFA92000FFAA2200FDAC2A00FBB23F00F1BF8600E5B1
      9000D28B8000CA777100BE646400E9CCCC005874E7007C93EB00768DEB006A83
      E900A5B4F200DFE4FA00E4E8FB00E2E7FB00E4E8FB00CED6F7005875E7003356
      E1003053DF002A4BD0003F438F00000000000000000000000000000000000000
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
      00000000000000000000E3DADE00C5A0A300DB975800F7A72E00FFAD2800FFAE
      2A00FEB02E00FEB13300FBB44400F8B24A00EAAF7400E0A68500CC888800EDD4
      D400647EE8008EA2EF00869BED00758DEB006D86EA007B90EC0090A2EF0093A5
      EF007F95EC00607AE8004766E4004060E3003457E0002849D0003B3E8B000000
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
      0000000000000000000000000000000000000000000000000000DAC6C700D1AE
      AF00E29D4D00F8AE3800FFB53700FFB63900FFB83C00FFB83E00FFB93F00FFB9
      4000FEB83E00FEB83D00F7B54E00FAE5C9007088EA0094A7F0008B9EEF007890
      EB006D86E9006781E900637CE800607AE8005C77E8005773E7004F6CE5004565
      E4003457DF002345CE0044468E00000000000000000000000000000000000000
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
      00000000000000000000D2B9B900D1AEAD00ECA74900FAB23D00FFB93F00FFBA
      4100FFBC4500FFBC4600FFBD4800FFBD4800FFBC4600FFBC4500FDB94600FEEE
      D300ADBBF3006E86EA005F7AE8005571E6004D6AE5004766E5004664E4004362
      E4003E5FE3003A5BE2003558E2002F53E1002247DC003151D000A49AB4000000
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
      00000000000000000000000000000000000000000000FEFEFE00CAADAD00C8A5
      A400F7B64A00FDBC4800FFC04E00FFC15100FFC45500FFC45600FFC65900FFC6
      5900FFC45500FFC45500FFC15100FFC04E00FFEFD500FFE8C200FAE2C200F0D3
      CC00F2E8E800F2E7E700F1E5E500EFE2E200E3D2D200E4D3D300E8D7D700EAD9
      D900ECDBDB00E8D8D800A1717300000000000000000000000000000000000000
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
      0000FEFEFE00FCFBFC00C9AAA900C7A39D00FDBE4D00FEC05000FFC45700FFC5
      5900FFC85D00FFC85E00FFCA6200FFCA6200FFC85E00FFC85D00FFC55900FFC4
      5600FFC05000FFBE4B00F0A84F00D2806E00DABCBC00D9B9B900D6B3B300CFA8
      A800AA767600A9767600AE7B7B00B8858500C7949400B7848400A16F72000000
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
      000000000000000000000000000000000000FCFCFC00EEE9EA00D4B7B200CDA6
      8C00FFC55900FFC75D00FFCB6500FFCC6900FFD06D00FFD06F00FFD16F00FFD1
      6F00FFD06E00FFD06C00FFCC6800FFCB6400FFC75C00FEC45800E8A25F00D089
      7B00DABCBC00D9B9B900D6B3B300D0A7A700AE767600B8848400B3808000AB78
      7800A26F6F00A7747400A46D7000000000000000000000000000000000000000
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
      0000FAFAFB00E2DADB00DCC1BA00D1A98400FFC96100FFCB6500FFCF6D00FFD0
      7100FFD47600FFD47700FFD57800FFD57800FFD47600FFD47400FFD07000FFCE
      6C00FFCB6400FEC86000E19D6700D08D8300DABCBC00D9B9B900D6B3B300D0A7
      A700AE757500B6828200A6737300A6737300B4818100AF7C7C00A46B6F000000
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
      000000000000000000000000000000000000F7F5F500D5C9CA00DCC4BA00DBB4
      8200FFCF6D00FFD17200FFD67B00FFD87F00FFDC8500FFDC8700FFDE8A00FFDE
      8A00FFDC8700FFDB8500FFD87E00FFD57A00FFD17100FECD6C00DC9A7200D199
      9000DABCBC00D9B9B900D6B1B100CFA1A100B0737300B8838300C6939300C38F
      8F00BA878700B4808000A5686B00000000000000000000000000000000000000
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
      0000EFE2E300CBB3B400D8C0B400E3BC8000FFD27300FFD57800FFDA8300FFDC
      8700FFE08D00FFE08F00FFE29200FFE29200FFE08F00FFDF8D00FFDC8600FFD9
      8200FFD57700FED17200D4937600D19D9700DABCBC00D9B9B900D6B0B000CE9A
      9A00B0707000AC767600BD8A8A00C5929200C4919100B6828200A6676A000000
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
      000000000000000000000000000000000000E2DBDD00C9BCBC00CEB8A600F5CD
      7D00FFD77E00FFDB8400FFE08F00FFE29400FFE79C00FFE89F00FFEAA300FFEA
      A300FFE89F00FFE69B00FFE29300FFDF8F00FFDA8300FED77D00CD8D7C00D3A7
      A300DABCBC00D9B9B900D6AFAF00CF979700C5727200C5727200B66D6D00AF6D
      6D00AE767600AB747400A8636700000000000000000000000000000000000000
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
      0000DAD2D400D4C9CA00CDB49E00F5CE7F00FFDA8300FFDE8900FFE39600FFE6
      9B00FFEBA400FFECA700FFEEAB00FFEEAB00FFECA700FFEAA300FFE69A00FFE3
      9500FFDD8800FED98200C3817E00D1A7A600DABCBC00D9B9B900D6AFAF00CF96
      9600C5707000C5707000C36F6F00C26F6F00BD6F6F00B56D6D00A96265000000
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
      000000000000000000000000000000000000C7C0C000E3DDDE00C3AB8900EFCC
      8200FFDE8B00FFE29300FFE8A000FFECA700FFF1B200FFF3B600FFF6B900FFF6
      B900FFF3B500FFF0B100FFEBA600FFE89F00FEE19100FBDA8A00C1868600DBBD
      BD00E7D3D300EBDBDB00F3EBEB00F8F3F300EFD8D800E3B9B900D5919100CF81
      8100CC767600CA727200AA616400000000000000000000000000000000000000
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
      0000C2BCBD00E3DEDE00C3AC8900E3C48600FFE08F00FFE49700FFEBA400FFEF
      AB00FFF4B800FFF7BC00FFFAC100FFFAC100FFF7BC00FFF4B700FFEEAA00FFEA
      A300FCDF9500F1CE8A00C58E8E00E7D0D000F0E3E300F1E4E400F3E7E700F4E9
      E900F2E4E400EFDDDD00ECD3D300E7C6C600DA9D9D00D2868600AC6265000000
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
      000000000000000000000000000000000000BAB8B800DFDDDD00ABA1A100A99F
      9F00AB9B9900B4A29900C5B19A00CDBA9E00E0D3AE00EDE5BB00F3EFC300F5F2
      C400F9F4C200FAF2BD00FFF2B100FFEEA900FADF9900E9C48D00C9999900E0C2
      C200E6CDCD00E6CDCD00E4CACA00E3C9C900E1C9C900E1C7C700DDC4C500DBC0
      C100CEB1B200C09F9F00CEBBBE00000000000000000000000000000000000000
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
      0000B5B4B400D7D5D500E0DDDD00D9D3D300C8BCBC00C4B6B500B6A5A000AE9A
      9400B19A9200B49D9400C6B2A000D0BEA700E1D4B200EADEB400FFF2B400FFEE
      AC00F8DE9900E1BA8C00C5959500D9B6B600DEBFBF00DEBFBF00D4B1B100D0AC
      AC00D1B1B200CDAEAF00CEB4B500D6C1C300E0D3D300DFD4D400F7F7F8000000
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
      000000000000000000000000000000000000F6F6F600E8E8E800D3D2D200CDCB
      CB00CECACB00CEC8CA00D3C8C800D6CACA00DCCDCD00D8C6C600C6B0B000C0A5
      A600B99A9A00B5929200B6908E00BE988F00CAA38D00C3968600B1838500B590
      9400D2BEC100DFCFD000EEE7E900F6F5F6000000000000000000000000000000
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
      0000FDFDFD00FCFCFC00F9F9F900F7F8F800F6F7F700F5F6F700E0DCDC00DAD2
      D300CCC0C000CCBDBE00C8B4B400C6AEAF00D0B6B600D5BABA00D2B3B300CDAC
      AA00C59E9900B88B8800A5808600BDA8AF00EDE9ED00F8F7F800FCFCFD00FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
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
      0000F0EBEB00E9E2E300D9CCCC00D5C5C500D2BDBD00C7ACAD00E8E1E300F6F4
      F500000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000FCFCFD00FBFBFC00F9F9F900F7F8
      F800F6F6F700F5F5F500FCFCFC00FEFEFE000000000000000000000000000000
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
      000000000000D6CECE00BDA59C00000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000004A4A4A003131
      31003131310031313100313131002929290063636300DEB5B500C6736B007339
      3100101818003131310039393900313131003131310031313100313131003131
      3100313131003131310031313100313131003131310029312900525252000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C9C8C00428442008CBD94000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B594A500947B84009473
      7B008C636B008C636B0094637300945A6B008C5A6B008C5A63008C5A63009463
      6B00946B73008C636B009C738400AD8C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008C8C8C00DEDEDE00D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6CE00EFD6D600DEAD9400BD6B6B00634A4200636B73009CA5A500CECE
      CE00D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600BDBDBD0031393100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084948400298C390010A531005AAD
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009452
      6300A56B7300AD737B00B57B8400BD8C8C00CE9C9C00C68C9400C6949C00D6AD
      AD00CE9C9C00C6949400BD8C8C00B5848400AD7B7B009C636B00945A6300945A
      5A008C525A008C4A5A00844A5A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000EFE7E700EFDEDE00E7C6
      C600B56B6B009C6331007B736B00ADB5B500FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000CED6CE00313131000000
      00000000000000000000000000000000000000000000CEC6C600B59CA500A58C
      94009C848C009C849400AD949C00C6B5BD000000000000000000000000008494
      8400298C390031CE630031CE5A0063AD63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000945A6300AD847B00B58C8C00BD8C8C00C69C9C00D6AD
      A500CEA5AD00BD946B00BD945200C6949400D6ADAD00CE9C9C00BD949400B58C
      8C00B5848400A57373009C6B6B009C6363009C6B63009C6B6B009C6363007B42
      5200000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CEC6C600B59CA500A58C94009C848C009C848C00A58C
      9400B59CA500CEBDBD0000000000000000000000000000000000000000000000
      000000000000428C4200428C4200428C4200428C4200428C4200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A50000000000BDC6BD00D6D6D600D6D6D600CECE
      CE00BDBDBD00D6D6D600D6D6D600E7CEBD00BD7B6300CE5A0000C66B1800635A
      4A008C8C9400C6C6C600CECECE00C6C6C600CEC6CE00C6C6C600CEC6CE00C6C6
      C600DEDEDE00D6D6D6003131310000000000000000000000000000000000B59C
      A5009C737B009C7B8400AD8C8C00AD848C00AD848400AD848C00A5848400AD94
      9C00CEB5BD00000000007B947B00298C390029C65A0042E77B0031C6520063AD
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A56B7300B584
      8400B5848C00C6949400CE9CA500DEB5B500C69CA500C69C4A00DEC63900CEAD
      4A00C6948C00D6ADAD00CE9C9C00BD949400B5848400AD7B7B00A56B6B009C63
      63009C6363009C6B63009C6363007B4252000000000000000000000000000000
      000000000000000000000000000000000000B59CA5009C737B009C7B8400AD8C
      8C00AD848C00AD848400A57B8400946B73008C636B008C6B7300A5848C00CEBD
      C600000000000000000000000000428C4200428C420084FFB50084FFB5007BFF
      A5007BF79C0073EF9400428C4200428C42000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000CECECE000000000000000000FFFFFF00CECECE000000000000000000E7CE
      B500C65A0800D6843100DE6B0800BD5A08004A3931005A5A6300949494009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C00E7E7E700D6D6D600313131000000
      00000000000000000000AD8C9400BDA5A500D6CECE00DED6D600DED6D600DECE
      CE00DECECE00DEC6C600DECECE00EFDEDE00DED6D6007B8C7B002184310029BD
      520039D66B0042DE730031C65A0042944A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5737300B5848400BD8C8C00C69C9C00CEA5A500DEB5
      B500C69CA500D6BD6300E7CE5A00EFD66300CEAD8C00BD949C00D6ADAD00BD94
      9400B5848400B5848400A57373009C636B009C6363009C6B6B00945A5A008C63
      7300000000000000000000000000000000000000000000000000D6CECE00AD8C
      9400BDA5A500D6CECE00DED6D600DED6D600DECECE00DECECE00D6BDBD00CEAD
      AD00CEB5B500CEADAD00C6A5A500CEBDC6000000000000000000428C42008CFF
      BD00ADFFD600C6FFE700C6FFDE00A5FFD6008CFFBD007BFFA50073F79C0073EF
      8C00428C420000000000428C4200428C42000000000000000000000000000000
      00000000000000000000A5A5A50000000000C6C6C600E7E7E700DEDEDE00DEDE
      DE00C6C6C600E7E7E700DEDEDE00DEE7E700C69C6300D66B0800D6843100D663
      0000C65A08006B5A52005A5A6300CECECE00CECECE00DEDEDE009C9C9C00CECE
      CE0000000000CED6CE00313131000000000000000000BD9CA500DED6D600E7E7
      E700E7E7E700DEDEDE00DEDEDE00DED6D600DED6D600D6C6BD00E7D6D600DECE
      D6007B8C7B00218C310021BD420031CE5A0039CE6B0042DE730042D66B0029A5
      4200399C4A00429C5200429C520039944A0000000000398C420031944200399C
      4A00318C39006BAD730000000000000000000000000000000000C69CA500A573
      7300BD949400CE9C9C00D6ADAD00D6ADAD00CEADB500EFE7CE00E7D66B00F7E7
      8C00FFF7E700C69CA500C6949400C6949400B58C8C00B5848400A57373009C63
      6B009C6363009C6B6B0084425200B5A5A5000000000000000000000000000000
      00000000000000000000BD9CA500DED6D600E7E7E700E7E7E700DEDEDE00DED6
      D600DED6D600D6CECE00BDA5A500B5949400BD9C9C00D6BDBD00EFDEDE00EFE7
      E70000000000428C42008CFFBD006BE78C005ABD5A005ABD5A005ABD5A006BD6
      6B00CEFFE7008CFFBD007BFFA5007BF79C0073EF9400428C42005ADE7B00428C
      420000000000BDA5A500BDA59C00BDB5B500CECECE00DEDEDE0084848400EFEF
      EF00BDC6BD00EFEFEF00EFEFEF00EFEFEF00CECECE00EFEFEF00EFEFEF00E7E7
      E700CECECE00E79C5200CE6B0800D6843100D6630000C66308004A392900848C
      8C00BDBDBD00DEE7DE009C9C9C00CECECE0000000000CED6CE00313131000000
      0000CEB5B500DED6D600EFEFEF00EFEFEF00EFEFEF00E7E7E700E7E7E700E7DE
      DE00DECECE00EFE7E700DED6DE00738C7B00188C290018B5390029C64A0031CE
      5A0039CE6B0039D6730042DE7B004AE77B004AE77B0052EF84005AFF940039D6
      630052A55A0029B54A0042EF7B0052FF8C0031D65A00429C4A00000000000000
      0000000000000000000000000000AD737B00B5848400CE9C9C00D6ADAD00CEA5
      A500D6ADAD00FFFFFF00F7E78C00EFC63900FFF7D600FFF7F700C6948C00BD8C
      8C00BD8C8C00B5848400A56B73009C6B6B009C6B63008C4A5200A5737B000000
      00000000000000000000000000000000000000000000CEB5B500DED6D600EFEF
      EF00EFEFEF00EFEFEF00E7E7E700E7DEDE00DEDEDE00CEBDBD00D6BDBD00C6BD
      C600B5A5AD00CEBDBD00EFDEDE00EFE7E70000000000428C42005ABD5A005ABD
      5A00EFF7F700EFF7F700EFF7F700EFF7F7005ABD5A00CEFFE7008CFFBD007BFF
      A5007BF79C0073EF940073E78C00428C4200BDADA500B5846B00CE8C7B00B573
      63009C736300947B73006B5A52008C8484008C8C8C00C6CECE00DEDEDE00EFEF
      EF00CECECE000000000000000000FFFFFF00CECECE0000000000D6843900D66B
      1000DE843100D6630000BD6308006B5A4A00737B7B00CECECE0094949400CECE
      CE0000000000CED6CE003131310000000000CEB5B500EFEFEF00EFEFEF00F7F7
      F700F7F7F700EFEFEF00E7E7E700E7E7E700E7D6D600DECED6005A735A001884
      210018B5290021BD390029C64A0031CE5A0039CE6B0042D6730042DE7B004AE7
      84005AEF8C005AF794006BFFA5004ADE730063AD630039BD520052F78C0063FF
      9C0042DE73004AA5520000000000000000000000000000000000000000000000
      0000B58C8C00B5848400CEA5A500D6ADAD00D6A5A500FFF7F700CEDECE00ADAD
      7300ADBDB500BDE7FF00BDCED600B5847B00BD847B00AD7B7B00A5737300945A
      5A008C4A5200B5848C0000000000000000000000000000000000000000000000
      000000000000CEB5B500EFEFEF00EFEFEF00F7F7F700F7F7F700EFEFEF00E7E7
      E700DEE7E700C6ADAD00DECECE00C6ADAD00C6B5B500E7D6D600EFDEDE00EFE7
      E700428C420052BD5200EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7
      F700EFF7F70042B54200CEFFE7008CFFBD0084FFAD007BFFA50073F79C00428C
      4200C6948400FFC6AD00FFD6B500FFC6A500EFA58C00EFA58400DE9C8400C684
      7300A56B630084635A00736363006B6B6B0073737300A5A5A500CECEC600CECE
      CE00BDBDBD00D6D6D600EFF7EF00CE8C3900D6731000DE843100D6630000C673
      1800635242006B6B630052525200ADADAD0000000000D6D6D600313131000000
      0000DEC6C600E7EFEF00F7F7F700FFFFFF00FFFFFF00F7F7F700EFEFEF00EFE7
      E700E7E7E7006B8C6B000884180010AD180018B5290021B5390029C64A0031CE
      5A0039CE6B0039D6730042DE7B004AE77B0052EF84005AF78C0063FF9C0042D6
      6B005AAD630039BD520052F78C005AFF9C0042DE6B004AA55200000000000000
      00000000000000000000000000000000000000000000CEADB500B5848C00CE8C
      8400BD9CA50084BDEF005AB5FF0052B5FF004AB5FF004AADFF005ABDFF006BA5
      DE009C848C00B5736300945A5A00A5737B000000000000000000000000000000
      00000000000000000000000000000000000000000000DEC6C600E7EFEF00F7F7
      F7000000000000000000F7F7F700E7E7E700DEDEDE00C6A5A500DEBDBD00BD9C
      9C00D6B5B500EFDEDE00EFDEDE00F7EFEF0039AD3900EFF7F700EFF7F700EFF7
      F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F7005ABD5A008CFF
      BD0084FFB50084FFAD007BFFA500428C4200C69C8C00FFC6AD00FFD6B500E7A5
      8C00D68C7B00DE947B00FFC6A500E7A58C00E79C7B00F7AD8C00DE9C8400C684
      6B00A5736300847B7300D6D6D600FFFFFF00CECECE000000000000000000FFFF
      FF00D6843900D67B2100DE7B2900CE5A0000BD633100C6846300736B52004A52
      5200ADADAD00C6C6C600313931000000000000000000DECECE00F7F7F700EFD6
      D600EFD6DE00EFE7E700EFEFEF00E7DEDE00D6D6CE00398C420008A5100010AD
      180018B5290021B5390029C64A0031CE5A0039CE6B0039D6730042DE7B004AE7
      7B0052EF84005AF7940063FF9C0042D66B005AAD630039BD520052F78C005AFF
      9C0042DE6B004AA5520000000000000000000000000000000000000000000000
      0000000000000000000000000000AD94A50063ADE70063C6FF0073C6FF006BC6
      FF006BBDFF0063BDFF005AB5FF0052BDFF005AB5F7007B738400A57373000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DECECE00F7F7F700EFD6D600EFD6DE00EFE7E700EFEF
      EF00DECECE00CEADAD00D6ADAD00C6949400D6ADAD00EFDEDE00EFDEDE00F7EF
      EF004A52E700424294004242940042429400424294004242940042429400EFF7
      F700EFF7F7005ABD5A00CEFFE700C6FFE700C6FFE700C6FFE700C6FFE700428C
      4200C69C8C00FFC6AD00FFCEB500E7AD9400FFDEC600FFCEA500D69C8400DE9C
      8400DE9C7B00EFAD9400E7A58400D6947300FFBD9400C69C8400ADADAD00EFEF
      EF00CECECE00F7F7F7000000000000000000FFFFF700D67B3100D67B2100DE8C
      5A00C67B8400CE733100CE735200AD6B6B005A5A5A007B7B7B00393939000000
      00000000000000000000DECECE00CE9C9C00CE8C8400D6ADBD00DEBDC600D6BD
      BD00E7CECE00B5BDAD002994390008A5180018B5290021BD390029C64A0031CE
      5A0039D66B0042D6730042DE7B004AE77B0052EF84005AF7940063FF9C0042D6
      6B005AAD630039BD520052F78C005AFF9C0042DE6B004AA55200000000000000
      00000000000000000000000000000000000000000000000000000000000084CE
      FF0073CEFF008CCEFF0084CEFF0084CEFF007BC6FF0073C6FF006BBDFF005AB5
      FF0052BDFF004AA5E700738C9400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DECE
      CE00CE9C9C00CE8C8400D6ADBD00D6BDBD00CEA5A500CE9C9C00CE8C8C00CE84
      8400DEA5A500EFCECE00EFDEDE00F7EFEF004A52E700C6CEFF006B6BFF005A63
      FF005252FF004A4AFF0042429400EFF7F700EFF7F7005ABD5A005ABD5A005ABD
      5A005ABD5A005ABD5A005ABD5A005ABD5A00C6948C00FFC6AD00FFD6B500F7BD
      9C00EFCEB500EFD6B500E7AD8C00EFCEB500FFE7C600DEA58C00DEA58C00F7B5
      9400EFAD8C00D6A594008C949400D6D6D600C6C6C600D6D6D600FFFFFF000000
      000000000000DEC6BD00CE8C7300EFD6D600E7AD8400CE5A0000C65A1000A573
      73007B6B6B003942420029292900000000000000000000000000E7CECE00C694
      9400FFBD5A00F7BD7B00E7B59C00D6B5B500DEADAD00EFBDBD00B5BDA5003194
      420010A5210021BD390029C64A0031CE5A0039D66B0042D6730042DE7B004AE7
      7B0052EF84005AF7940063FF9C0042D673005AAD630039BD520052F78C0063FF
      9C0042DE6B004AA5520000000000000000000000000000000000000000000000
      00000000000000000000BDE7FF007BC6FF0094D6FF0094D6FF0094D6FF008CCE
      FF008CCEFF0084CEFF0073C6FF0063BDFF005AB5FF0052BDFF004A8CBD00B5B5
      AD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E7CECE00C6949400FFBD5A00F7BD7B00DEAD
      9400CEA5A500C6848C00C66B6B00CE737300D68C8C00E7ADAD00EFDEDE00F7EF
      EF004A52E700BDC6FF007B84FF006B73FF006363FF0042429400EFF7F700EFF7
      F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F7004242
      9400D6A59400FFC6B500FFD6B500FFC6A500CE947B00DEA58C00FFCEAD00EFBD
      9C00E7C6AD00EFB59C00EFBDA500FFEFCE00EFBD9C00D6A59400B5BDB5000000
      0000CECECE000000000000000000FFFFFF00D6D6D60000000000FFE7DE00D67B
      2900E78C2900E79C4A00D66300008452180084636300846B7300101018000000
      00000000000000000000E7CECE00CE8C7B00FF9C0800FFAD1800FFBD4A00F7BD
      6B00EFBD9C00E7BDBD00F7C6CE00C6C6B50042A5520010AD310029C64A0031CE
      5A0039CE6B0039D66B0042DE7B004AE784005AEF8C005AF794006BFFA50042DE
      73005AAD630031BD4A0052F78C0063FF9C0042DE6B004AA55200000000000000
      0000000000000000000000000000000000000000000000000000ADD6FF0094D6
      FF00A5DEFF00ADDEFF00A5DEFF009CD6FF0094D6FF008CD6FF0084CEFF0073C6
      FF0063BDFF005ABDFF004AA5E70094A5AD000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7CE
      CE00CE8C7B00FF9C0800FFAD1800FFBD4200F7BD6300EFB58C00D69C9C00D67B
      8400CE737B00D68C8C00EFDEDE00F7EFEF004A52E700BDC6FF008C8CFF007B8C
      FF00737BFF006B6BFF0042429400EFF7F700EFF7F700EFF7F700EFF7F700EFF7
      F700EFF7F700EFF7F7004242940042429400D6A59400FFCEB500FFD6BD00DEA5
      8C00E7A58400DE9C7B00F7BD9C00CE947B00C6846B00FFC6A500F7BD9C00D6A5
      8C00FFC6A500CEA58C008C949400D6D6D600C6C6C600DEDEDE00DEDEDE00D6D6
      D600C6C6C600DEDEDE00DEDEE700CECEB500C6732900E78C3100E7944200D663
      00007B5229007B6363005A4A4A00000000000000000000000000DEC6C600D68C
      7300FFA52100FFAD2900FFAD2900FFB53100FFBD4A00FFC66B00F7CEA500FFDE
      D600CED6C6004AA55A0018AD390031CE5A0039CE6B0042D6730042D66B0039C6
      5A0039C65A0042C663004ACE6B0031B54A005AAD6B00B5DEB50039CE630042CE
      630029B542004AA55A0000000000000000000000000000000000000000000000
      00000000000000000000ADDEFF00ADDEFF00B5DEFF00B5DEFF00B5DEFF00B5DE
      FF00A5DEFF0094D6FF008CCEFF007BC6FF006BBDFF005ABDFF0052B5F7008C9C
      B500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEC6C600D68C7300FFA52100FFAD2900FFAD
      2100FFB52900FFBD3900FFB55200EFB57B00DEAD9400DEADA500EFDEDE00F7EF
      EF004A52E700B5BDFF008C94FF00C6CEFF00848CFF007B84FF006B73FF004242
      9400EFF7F700EFF7F700EFF7F700EFF7F7004242940042429400424294000000
      0000D6A59400FFCEBD00FFD6B500E7B59C00FFE7CE00FFD6BD00D69C8400E7B5
      9C00F7BD9C00E7AD8C00D69C8400D68C7300EFB59400D6AD94009C9C9C00EFEF
      EF00CECECE00F7F7F700EFEFEF00EFEFEF00CECECE00F7F7F700EFEFEF00EFEF
      F700CECED600E7945200E78C3100E78C3900CE63080094523900AD7373000000
      00000000000000000000DEBDC600DE9C6300FFAD3100FFB53100FFBD3900FFBD
      4200FFBD4200FFBD4A00FFC66300FFCE8400FFE7BD00D6D6C6004AA55A0021B5
      420039D66B0042DE730031C65A00429C4A00B5CEAD00BDD6BD00BDD6B500B5CE
      B500CEDEC600CEB5AD00ADC6AD00BDD6BD00B5D6B50000000000000000000000
      0000000000000000000000000000000000000000000000000000B5E7FF00BDEF
      FF00D6F7FF00DEFFFF00D6FFFF00CEF7FF00B5EFFF00A5DEFF008CD6FF0084CE
      FF0073BDFF0063C6FF0052A5DE00525A6300E7DED60000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEBD
      C600DE9C6300FFAD3100FFB53100FFBD3900FFBD3900FFBD3900FFBD3900FFBD
      4200FFBD4200FFCE7B00FFE7CE00F7EFE7004A52E700B5BDFF004A52E7008C94
      FF00C6CEFF008C8CFF007B8CFF00737BFF004242940042429400424294004242
      94004A52FF00424AFF004A52E70000000000D6A59400FFD6BD00FFDEB500FFC6
      A500E7C6AD00E7CEAD00EFBD9C00EFCEB500FFEFCE00DEAD9400E7B59C00FFDE
      C600EFB59C00D6AD9400ADADA500FFFFFF00CED6CE000000000000000000FFFF
      FF00CECECE000000000000000000FFFFFF00CECECE0000000000DE944200DE84
      2900DE842900CE630800C6A59C00000000000000000000000000CEADB500EFAD
      5A00FFBD3900FFBD4200FFBD4A00FFBD4A00FFC65200FFC65200FFC65A00FFCE
      6B00FFD68400FFE7AD00DEDEBD0052A5630021B54A0042DE730031C6520063AD
      6300EFDEDE00F7E7E700F7DEDE00E7C6C600CEADAD00BD9494009C7B8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B5DEFF008CA5B500737373005A63630063636300737B
      7B00949CA5008CBDDE0094D6FF008CD6FF0073CEFF006BCEFF00314A63001008
      0000CECECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CEADB500EFAD5A00FFBD3900FFBD4200FFBD
      4A00FFBD4A00FFC65200FFC65200FFBD4A00FFBD4A00FFCE7300FFDEA500FFF7
      D6007B7BE7005252E700F7EFEF004A52E700848CFF00C6CEFF00C6CEFF00848C
      FF007B84FF006B73FF006363FF005A5AFF008C94FF004A52E700000000000000
      0000DEAD9400FFD6C600FFDEBD00F7C6A500C6846B00DE9C8400FFD6B500EFBD
      9C00D6AD9400F7CEAD00F7C6AD00F7DEBD00F7C6A500D6AD940084848400CECE
      CE00BDBDBD00CECECE00CECECE00CECECE00BDBDBD00CECECE00CECECE00CECE
      CE00BDBDBD00CED6D600BDC6C600C69C5A00DE8C2100E77B1800A56342000000
      000000000000EFDEDE00CEADA500F7B55A00FFC64A00FFC65200FFC65A00FFC6
      5A00FFCE5A00FFCE6300FFCE6300FFCE6300FFCE7300FFD68C00FFE7AD00DEDE
      BD0052A5630029BD520029C6520063AD6300DED6CE00D6BDBD00D6ADAD00DEB5
      B500CE9C9C00B5848400947B8400000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B0052525A000000
      00000808080010101000212121003939390042393900423939005A5A6300637B
      94005A94C60029526B000000000008080800CECECE0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C69C
      A500F7B55A00FFC64A00FFC65200FFC65A00FFC65A00FFCE5A00FFCE5A00FFC6
      5A00FFC65A00FFD66300FFDE9400FFE7CE00F7E7DE00EFE7E700F7E7E700F7EF
      EF004A52E7004A52E7008C94FF00C6CEFF00BDC6FF00A5ADFF008C94FF004A52
      E7004A52E700000000000000000000000000DEA59400FFD6C600FFDEBD00D6A5
      8C00EFB59C00EFA58C00EFBD9C00D69C7B00D68C7300F7BDA500CEB5AD008484
      9C00EFCEB500D6B59C00ADADAD00FFFFFF00CED6CE000000000000000000FFFF
      FF00CECECE000000000000000000FFFFFF00CECECE000000000000000000FFFF
      FF00C6AD7300CE9452006B524A000000000000000000E7D6D600CEAD9C00F7BD
      5A00FFCE5A00FFCE6300FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFCE
      6B00FFCE6B00FFD67300FFD68C00FFDEB500D6CECE0063AD7300109C290052A5
      6300D6BDBD00CEADAD00BD949400B5848400AD848400AD737B0094737B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00181818004A4A4A0073737300848484008C8C8C007373
      73006B6B6B005A5A5A004239390010080800312929008C848400A5A5A5004A4A
      4A008C8C8C000000000000000000000000000000000000000000000000000000
      00000000000000000000E7D6D600C69C9C00F7BD5A00FFCE5A00FFCE6300FFCE
      6B00FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFD66300FFDE9400F7DE
      CE00EFDEDE00EFE7E700EFE7E700EFE7E700EFE7E700F7EFEF004A52E7004A52
      E7004A52E7004A52E7004A52E700DEDEE7000000000000000000000000000000
      0000DEA59400FFDECE00FFDEBD00E7BD9C00FFEFD600FFDEC600D6A58C00EFC6
      AD00FFDEBD00E7B59400638CCE004A7BFF0094A5C600DEB594009C9C9C00E7E7
      E700CECECE00EFF7EF00EFEFEF00E7EFE700C6CEC600EFF7EF00EFEFEF00E7EF
      E700C6CEC600EFF7EF00EFEFEF00E7E7E700D6D6D600CECECE00313131000000
      000000000000E7CECE00DEB59400F7C66300FFCE6B00FFD66B00FFD67300FFD6
      7B00FFD67B00FFD67B00FFD67B00FFD67B00FFD67300FFD67300FFD67B00EFBD
      9C00EFCECE00E7E7DE0094C69C00ADCEAD00CEADAD00C69C9C00AD7B7B00AD7B
      7B00AD7B7B00AD6B73008C737B00000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00525252006B6B
      6B00848484008C8C8C00949494009C9C9C008C8C8C0073737300525252003131
      3100B5B5B5000000000000000000DEDEDE009C9C9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000DECED600DEB5
      9400F7C66300FFCE6B00FFD66B00FFD67300FFD67B00FFD67B00FFD67B00FFD6
      7B00FFD67300FFD67300FFD67B00FFDEA500F7D6B500E7BDC600EFDEDE00EFDE
      DE00EFDEDE00F7E7E700F7E7E700F7EFEF00F7EFEF00F7EFEF00F7EFEF00EFE7
      E70000000000000000000000000000000000DEA59400FFDED600FFDEBD00FFCE
      AD00E7C6AD00E7C6AD00F7C6A500E7C6B500F7E7C600E7BD9C0084ADCE008CBD
      FF008CADD600D6B59400948C8C00D6DED600C6C6C600DEDEDE00DEDEDE00D6DE
      D600C6C6C600DEDEDE00DEDEDE00D6DED600C6C6C600DEDEDE00DEDEDE00D6D6
      D600D6D6D600D6D6D600313131000000000000000000DEC6C600DEBD9400F7C6
      6B00FFD67300FFD67B00FFDE8400FFDE8400FFDE8C00FFDE8C00FFDE8400FFDE
      8400FFD67B00FFD67B00FFD67300E7AD8400DEBDBD00EFD6D600EFD6D600E7C6
      C600C6949400C69C9C00CE9C9C00C68C8C00B5848400AD6B73008C737B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B005A5A5A008484840094949400ADADAD00ADAD
      B5009C9C9C008C8C8C006B6B6B005A5A5A00DEDEDE0000000000FFFFFF00FFFF
      FF00CECECE000000000000000000000000000000000000000000000000000000
      00000000000000000000D6C6C600DEB59400F7C66B00FFD67300FFD67B00FFDE
      8400FFDE8400FFDE8C00FFDE8C00FFDE8400FFDE8400FFD67B00FFD67300FFD6
      7300E7A57B00DEADAD00E7CECE00E7CECE00DEBDBD00EFDEDE00EFDEDE00F7E7
      E700EFE7E700EFDEDE00E7CECE00EFDEDE000000000000000000000000000000
      0000DEA59400FFDED600FFDEBD00FFDEBD00FFCEAD00FFCEB500FFDEBD00F7D6
      B500EFC6A500FFDEB500D6CEBD008CB5CE00CEC6C600DEB5A500ADADAD00FFFF
      FF00CECECE000000000000000000FFFFFF00CECECE000000000000000000FFFF
      FF00CECECE000000000000000000FFFFFF00D6D6D600D6D6D600313131000000
      000000000000D6C6BD00E7BD8C00FFD67300FFDE7B00FFDE8C00FFE78C00FFE7
      9400FFE79C00FFE79C00FFE79400FFE79400FFDE8C00FFDE8400FFD67B00DE9C
      7B00DEB5BD00E7CECE00E7C6C600D6ADAD00C6848400B57B7B00BD848400C694
      9400B5848400AD6B6B008C737B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007373
      73007B7B7B009C949C00ADA5AD00ADADAD009C9C9C008C8C8C00737373005A5A
      5A009C9C9C00EFEFEF0000000000EFEFEF00DEDEDE0000000000000000000000
      0000000000000000000000000000000000000000000000000000C6B5BD00EFB5
      8C00FFD67300FFDE7B00FFDE8C00FFE78C00FFE79400FFE79C00FFE79C00FFE7
      9400FFE79400FFDE8C00FFDE8400FFD67300D6947300D6ADAD00DEBDBD00DEBD
      BD00D6A5A500CE949400CEA5A500D6B5B500DEC6C600D6BDBD00CEA5A500AD94
      9C0000000000000000000000000000000000DEAD9400FFE7DE00FFDEC600F7C6
      A500E7B58C00EFB59400E7B59400E7BD9C00EFC6A500EFC6AD00EFC6A500F7CE
      AD00FFEFC600DEBDA50084848400CECECE00BDBDBD00D6D6D600D6D6D600D6D6
      D600BDBDBD00D6D6D600D6D6D600D6D6D600BDBDBD00D6D6D600D6D6D600CECE
      CE00D6D6D600D6D6D6003131310000000000EFE7E700CEBDBD00E7C68C00FFDE
      7B00FFDE8C00FFE79400FFE79C00FFEFA500FFEFAD00FFEFAD00FFEFA500FFEF
      9C00FFE79400FFDE8C00FFD67B00CE8C7B00DEB5BD00DEBDBD00DEBDBD00CE94
      9400C6737300C6737300BD6B6B00B5737300B5737300AD6363008C737B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000949494007B847B00949494009494
      94008C8C8C007B7B7B00636363004A4A4A0039393900A5A5A500DEDEDE00ADAD
      AD00A5A5A500ADADAD00BDBDBD00000000000000000000000000000000000000
      00000000000000000000C6B5BD00EFC68400FFDE7B00FFDE8C00FFE79400FFE7
      9C00FFEFA500FFEFAD00FFEFAD00FFEFA500FFEF9C00FFE79400FFDE8C00FFD6
      7B00CE8C7B00D6B5B500DEBDBD00D6B5B500CE949400CE737300CE848400C684
      8400C68C8C00C6949400BD8484009C848C000000000000000000000000000000
      0000DEA59400FFEFE700FFDEC600EFA57B00FFB58400FFB58C00FFBD8C00FFBD
      9400FFB58C00F7B59400F7B59400EFB59400EFC6AD00DEBDA5009C9C9C00F7F7
      F700FFFFFF00F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000D6D6D600313131000000
      0000E7DEDE00D6C6BD00E7C68C00FFDE8400FFE79400FFEF9C00FFEFAD00FFF7
      AD00FFF7B500FFF7B500FFF7B500FFEFAD00FFEFA500FFE79400FFDE8400C684
      8400E7C6C600E7CECE00EFD6D600EFDEDE00E7BDBD00D68C8C00CE737300CE6B
      6B00C66B6B00B56363008C737B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600A5A5A5009C9C9C009494940084848400848484008484
      840000000000D6D6D600D6CECE00E7E7E700EFEFEF00E7E7E700A5A5A5008C8C
      8C00000000000000000000000000000000000000000000000000D6C6C600E7C6
      7B00FFDE8400FFE79400FFEF9C00FFEFAD00FFF7AD00FFF7B500FFF7B500FFF7
      B500FFEFAD00FFEFA500FFE79400FFDE8400BD848400DEC6C600E7CECE00EFD6
      D600EFDEDE00E7BDBD00D6949400CE7B7B00CE737300CE737300BD6B6B009473
      840000000000000000000000000000000000DEA59400FFEFE700FFDEC600E79C
      7300FF945200FF9C6300FFA56300FFA56B00FFA56B00FFAD7300FFAD7B00FFB5
      7B00EFAD7B00D6AD9C00ADADA500FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700DEDEDE00DEDEDE00DEDE
      DE00E7E7E700CECECE004A4A4A0000000000D6D6D600D6C6BD00D6B58C00FFDE
      8C00FFE79C00FFEFA500FFF7B500FFFFBD00FFFFC600FFFFC600FFFFBD00FFF7
      B500FFEFAD00FFE79C00EFCE8400C68C8C00F7E7EF00F7E7E700F7EFEF00F7F7
      F700F7EFEF00F7E7E700EFD6D600E7B5B500D68C8C00B56B6B00AD949C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFE7E700FFFFFF000000
      0000E77B7300FFFFFF0000000000BDB5BD008C8C8C0000000000000000000000
      00000000000000000000D6CEC600CEAD7B00FFDE8C00FFE79C00FFEFA500FFF7
      B500FFFFBD00FFFFC600FFFFC600FFFFBD00FFF7B500FFEFAD00FFE79C00EFCE
      8400C6948C00F7E7E700F7E7E700F7EFEF00FFF7F700F7EFEF00F7E7E700EFD6
      D600E7B5B500D68C8C00B56B6B00AD949C000000000000000000000000000000
      0000DEA59400FFEFEF00FFE7CE00EFBD9C00EF845200F7844A00F7844200F784
      4200F7844A00FF8C4A00FF944A00FF8C4A00F7946300D6B59C00A5ADA500FFFF
      FF00F7F7F700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700EFEFEF00FFFF
      FF008C848C009C9C9C009C9C9C00949494008C8C8C00525252007B7B7B000000
      0000CECECE00CEC6C600BDADA500AD9C9C00BDA59400C6B59C00D6C6A500EFDE
      B500F7F7C600FFF7C600FFFFC600FFFFBD00FFF7B500FFEFA500EFC68C00CE9C
      9C00EFD6D600EFCECE00E7CECE00E7C6C600E7CECE00E7CECE00E7CECE00DECE
      CE00D6B5B500D6B5B50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7F7F700F7F7F700FFFFFF0000000000F7DED600FFFFFF0000000000FFFF
      FF009C9C9C000000000000000000000000000000000000000000D6CECE00AD9C
      9C00AD9C9C00BDA59400CEB59C00D6C6A500EFDEB500F7F7C600FFF7C600FFFF
      C600FFFFBD00FFF7B500FFEFA500EFC68C00CE9C9C00EFD6D600EFCECE00E7CE
      CE00E7C6C600E7CECE00E7CECE00E7CECE00DECECE00D6B5B500D6B5B5000000
      000000000000000000000000000000000000E7AD9C00FFF7F700FFE7CE00FFE7
      BD00F7D6B500EFBD9C00EFB59400EFAD9400E7AD8C00E7A57300E7946300E784
      5A00EFBD9400DEC6AD00A5A5A500FFFFFF00F7F7F700DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00E7E7E700FFFFFF00A5A5A50000000000FFFFFF00DEDE
      DE007373730073737300000000000000000000000000E7DEDE00D6CED600CEC6
      C600C6BDBD00C6B5B500C6ADAD00C6ADAD00BDA59C00C6AD9C00CEB59C00D6BD
      A500E7CEA500EFD69400D6AD8C00C68C8C00D6B5AD00DEBDBD00DEBDBD00DEBD
      BD00DEC6C600DEC6C600E7D6D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00000000000000
      0000E77B7300FFFFFF000000000000000000C6C6C60000000000000000000000
      00000000000000000000CECECE00CECECE00CEC6C600C6B5BD00BDADAD00B5A5
      A500B59CA500BDA59C00C6AD9C00CEB59C00D6BDA500E7CEA500EFD69400D6AD
      8C00C68C8C00D6B5AD00DEBDBD00DEBDBD00DEBDBD00DEC6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFD6BD00FFFFF700FFFFE700FFFFD600FFFFDE00FFFFDE00FFF7DE00FFF7
      D600FFF7D600FFEFCE00FFEFCE00FFE7C600FFEFD600E7CEB500ADA5A500FFFF
      FF0000000000000000000000000000000000000000000000000000000000F7F7
      F700A5A5A50000000000D6D6D6006B6B6B007373730000000000000000000000
      0000000000000000000000000000E7DEDE00E7DEDE00E7DEDE00DED6D600DECE
      CE00CEBDBD00C6ADAD00C6ADAD00BD9CA500C69C9C00C69C9400BD8C8400AD7B
      7B00D6BDBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF000000000000000000E77B730000000000000000000000
      0000CECECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E7D6D600DECECE00CEB5B500C6A5A500BDA5
      A500BD9CA500C69C9C00C69C9400BD8C8400AD7B7B00D6BDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFE7D600F7E7D600F7DE
      C600F7E7C600FFE7C600FFE7C600F7E7BD00F7E7BD00FFEFC600FFF7CE00FFF7
      CE00FFFFCE00DECEAD00C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000F7F7F7009C9C9C00DEDEDE006B6B6B007373
      7300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFE7E700E7DEDE00E7D6
      D600D6B5B500CEADAD00B58C8C00CEBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F7F7F700FFFFFF000000
      0000E7847300FFFFFF0000000000F7F7F700DEDEDE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7D6D600D6B5B500CEADAD00B58C
      8C00CEBDBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000948C8C00F7F7
      EF00F7EFEF00F7E7D600EFDECE00EFDEC600F7DECE00EFDEDE00FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00949494006B736B007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00E7948C00FFF7F700FFFFFF00EFEF
      EF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A500A5A5A500A5A5A500A59CA5009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00A5A5A500525252007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00F7F7
      F700FFFFFF00F7F7F700EFEFEF00000000000000000000000000000000000000
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
      00005242AD00524AAD00524AAD00524AAD00524AAD00524AAD00524AAD00524A
      AD00524AAD00524AAD00524AAD00524AAD005242AD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5524A00AD39
      2900AD5A4200B5634A00B5634A00B5736300C68C7B00CE9C8C00D6B5A500DEC6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B5BDB5005284520063A5630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A42AD005A4AB5005A4AB5005A4AB5005A4A
      B5005A4AB5005A4AB5005A4AB5005A4AB5005A4AB5005A4AB5005A4AB5005A4A
      B5005A4AB5004A42AD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006BAD73000894210042A5
      5A00000000000000000000000000000000000000000000000000000000000000
      000000000000E7DEDE00AD635200BD523900D66B3900D66B3100BD5A3900B55A
      3900B55A4200BD634200BD735A00BD847300C68C7B00CE9C8C00D6B5A500DEC6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ADADAD0042844A0018A5
      390031A54200A5CEA50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005242AD005A4A
      B500635AC6005A52CE005252C6005A5ACE00635ACE00635ACE00635ACE00635A
      CE00635ACE005A5ACE005252C6005A52CE00635AC6005A4AB500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006BB5730021BD4A0018C6520039A54A0000000000000000000000
      00000000000000000000000000000000000000000000E7D6DE00AD6B5A00C663
      5200CE633100D66B3900D66B3900D66B3900D66B3900C65A3100BD5A3900B55A
      3900B55A4200BD634200BD735A00BD847300C6948C00D6ADA500DEC6BD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEC6C600B59CA500A58C94009C848C009C848C00A58C9400B59C
      A500CEBDBD000000000000000000000000000000000000000000000000000000
      00009CA59C003984420029B54A0039D66B0042B55200A5CEA500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEC6C600B59CA500A58C94009C848C009C848C00AD9CA500D6C6
      CE0000000000000000005A4AB500635ACE005A52CE007B7BDE00A5A5E700736B
      D6005A52CE006363D6006363D6006363D6005A52CE00736BD600A5A5E7007B7B
      DE005A52CE00635ACE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073B57B0021BD4A0039DE
      730018BD4A0039A54A0000000000000000000000000000000000000000000000
      000000000000DECED600B5635200CE7B6300C65A3900D66B3900D66B3900D66B
      3900CE6B3900CE6B3900CE6B3900CE633100CE633100C6633100BD5A3900BD5A
      3900BD634200C6735200C6846B00BD847B00C6948C00D6ADA500DEC6BD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B59CA5009C737B009C7B8400AD8C8C00AD84
      8C00AD848400A57B8400946B73008C636B008C6B7300A5848C00CEBDC6000000
      000000000000000000000000000094A594003184390029B54A0039DE730039D6
      6B0039AD4A00BDD6BD0000000000000000000000000000000000000000000000
      0000000000000000000000000000B59CA5009C737B009C7B8400AD8C8C00AD84
      8C00AD848400A57B8400A57B8400BDA5A500DED6D600E7DEDE00524AAD006363
      D6004242AD009C9CBD0000000000D6D6F7006B63D6005A5AD6006363D6005A5A
      D6006B63D600D6D6F700000000009C9CBD004242AD006363D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000529C520021BD4A0039DE6B0031D6630018BD4200319C42000000
      00000000000000000000000000000000000000000000E7CECE00BD635A00DE8C
      7300C6634A00D66B4200D66B3900D66B3900CE6B3900D66B3100CE6B3900CE6B
      3900CE6B3900CE6B3900CE6B3900CE6B3900D66B3900C6633100BD5A3100BD5A
      3900BD634200C6735A00C6846B00BD847B00CE9C9400DEC6C600000000000000
      00000000000000000000000000000000000000000000D6CECE00AD8C9400BDA5
      A500D6CECE00DED6D600DED6D600DECECE00DECECE00D6BDBD00CEADAD00CEB5
      B500CEADAD00C6A5A500CEBDC600E7DEDE000000000000000000849C84002984
      390021B54A0039D66B0042DE730039D66B0029A5390084A58400000000000000
      0000000000000000000000000000000000000000000000000000AD8C9400BDA5
      A500D6CECE00DED6D600DED6D600DECECE00DECECE00D6BDBD00D6BDBD00E7CE
      CE00EFE7E700E7DEDE005242AD00635ACE005A52C6004A4A8400BDC6C6000000
      0000DEDEF7006B6BDE005A5AD6006B6BDE00DEDEF70000000000BDC6C6004A4A
      84005A5AC6006363D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063AD6B0029AD420042CE6B0039C6630039C65A0029BD520039D6630039D6
      6B0031CE630029CE5A0018B53900299C42000000000000000000000000000000
      000000000000E7CECE00C66B5200EFA58400C66B5A00CE7B5200DE845200D67B
      4A00D6734A00D6734200D66B3900CE6B3900CE6B3900CE6B3900CE6B3900CE6B
      3900CE6B3900CE6B3900CE6B3900CE633100CE633100C6633100C65A3900BD5A
      3900BD6B4A00CE9C8C00EFD6CE00000000000000000000000000000000000000
      000000000000BD9CA500DED6D600E7E7E700E7E7E700DEDEDE00DED6D600DED6
      D600D6CECE00BDA5A500B5949400BD9C9C00D6BDBD00EFDEDE00EFE7E700DED6
      D600DED6DE007B947B002184310021B5420031CE5A0039D66B0039D6730042DE
      730031BD5200319C4200429C5200429C5200429C520042944A0094BD94000000
      000000000000BD9CA500DED6D600E7E7E700E7E7E700DEDEDE00DED6D600DED6
      D600D6CECE00BDA5A500B59C9C00CEBDBD00EFE7E700F7EFEF00524AAD00635A
      D6006B63DE005A5AD60042427B00C6C6CE0000000000DEDEF7007373DE00DEDE
      F70000000000C6C6CE0042427B005A5AD6006B6BE7006363D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005AAD630039CE630063FF9C0052FF
      940052F7840042E77B0039DE730031D66B0031CE630029CE520021C6420008B5
      2900299C390000000000000000000000000000000000DEC6C600BD6B5A00EFAD
      8C00CE7B6B00CE7B5A00DE8C6300DE8C5A00D68C5A00D67B5200D67B5200D67B
      4A00D6734200D66B3900CE6B3100CE6B3900CE6B3900CE6B3900CE6B3900CE6B
      3900CE6B3900CE6B3900CE6B3900CE633100C65A3100C67B5A00DEBDAD000000
      000000000000000000000000000000000000CEB5B500DED6D600EFEFEF00EFEF
      EF00EFEFEF00E7E7E700E7DEDE00DEDEDE00CEBDBD00D6BDBD00C6BDC600B5A5
      AD00CEBDBD00EFE7E700F7E7E700D6C6CE00738C7300218C290018B5390029C6
      4A0031CE5A0039CE6B0039D66B0042DE73004ADE7B004AE77B004AEF7B0052F7
      84005AF78C0031C6520063AD630000000000CEB5B500DED6D600EFEFEF00EFEF
      EF00EFEFEF00E7E7E700E7DEDE00DEDEDE00CEBDBD00D6BDBD00CEC6C600C6BD
      BD00E7DEDE00EFE7E700524AAD006363D6006363DE006B73EF006363DE004242
      7B00C6C6CE00FFFFFF00EFEFFF0000000000C6C6CE0042427B006363DE007373
      EF006B6BDE006363DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063AD630039CE630063FF9C0052F78C0052EF840042E77B0039DE730031D6
      6B0031CE630029CE520021C6420018BD310000AD210018943100000000000000
      000000000000DEBDBD00BD6B5A00EFAD9400DE9C7B00CE735A00DE9C7300DE94
      6B00DE8C6300DE8C6300DE8C6300DE845A00D6845A00D6845200D6734200CE6B
      3900CE633100CE6B3900CE6B3900CE6B3900CE6B3900CE6B3900CE6B3900CE6B
      3900CE5A3100C6633900D6948C00000000000000000000000000000000000000
      0000CEB5B500EFEFEF00EFEFEF00F7F7F700F7F7F700EFEFEF00E7E7E700DEE7
      E700C6ADAD00DECECE00C6ADAD00C6B5B500E7D6D600EFE7E700CEC6CE005273
      52001884210018B5290021BD390029BD4A0031C6520039CE630039D66B0042DE
      73004AE77B0052EF84005AF78C0063FF9C006BFFA50042CE63006BB56B000000
      0000CEB5B500EFEFEF00EFEFEF00F7F7F700F7F7F700EFEFEF00E7E7E700DEE7
      E700C6ADAD00DEC6C600C6ADAD00CEBDBD00EFDEDE00EFE7E700524AAD006B63
      DE00636BDE006B6BE7007373E7006363DE0042427B00DEDEDE00FFFFFF00DEDE
      DE0042427B006363DE007373E7006B73E7006B6BE7006B6BDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063AD630039CE5A005AFF9C0052F7
      8C004AEF840042E77B0039DE730031D66B0031CE630029CE520021C6420018B5
      310010B5210000A51000109421000000000000000000D6B5B500C6735A00EFB5
      9400EFAD9400C6735A00E79C7B00DEA57B00DE9C7300DE947300DE946B00DE94
      6B00DE946300DE8C6300DE845A00D6845200D6734200CE633900CE6B3900CE6B
      3900CE6B3900CE6B3900CE6B3900CE6B3900CE5A3100CE6B4200C66B52000000
      000000000000000000000000000000000000DEC6C600E7EFEF00F7F7F700FFFF
      FF00FFFFFF00F7F7F700E7E7E700DEDEDE00C6A5A500DEBDBD00BD9C9C00D6B5
      B500EFDEDE00DEDEDE00528452000884180010AD180018B5290021B5390029BD
      4A0031C6520039CE630039D66B0042DE73004ADE7B0052E784005AEF8C0063F7
      940063FF9C0042CE63006BAD6B0000000000DEC6C600E7EFEF00F7F7F700FFFF
      FF00FFFFFF00F7F7F700E7E7E700DEDEDE00C6A5A500D6BDBD00BD949400D6B5
      B500EFDEDE00F7E7E700524AAD006B63DE006B6BDE006B6BDE006363DE007373
      E700D6D6F700FFFFFF00DEDEDE00FFFFFF00DED6F700737BE700636BE7007373
      E7006B73E7006B6BDE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063AD630039CE5A005AFF9C0052F78C004AEF840042E77B0039DE730031D6
      6B0031CE630029CE520021C6420018B5310010B5210000AD100000A508001884
      210000000000D6B5B500C67B6300F7BD9C00F7B59400D6847300DE947B00E7AD
      8C00E7AD8400E7A58400E79C8400E79C7B00DE9C7300DE946B00DE946B00DE94
      6B00DE8C6B00D67B5200CE6B3900C6633100C6633100CE6B3900CE6B3900CE6B
      3900CE5A3100CE6B4200D6845200CE9C94000000000000000000000000000000
      000000000000DECECE00F7F7F700EFD6D600EFD6DE00EFE7E700EFEFEF00DECE
      CE00CEADAD00D6ADAD00C6949400D6ADAD00EFDEDE00BDCEBD00298C310008A5
      100010AD180018B5290021BD390029BD4A0031CE5A0039CE630039D66B0042DE
      73004ADE7B0052E784005AEF8C0063F7940063FF9C0042CE63006BAD6B000000
      000000000000DECECE00F7F7F700EFD6D600EFD6DE00EFE7E700EFEFEF00DECE
      CE00CEADAD00CEA5A500C68C8C00D6B5B500EFDEDE00F7E7E700524AAD006B6B
      DE006B6BDE006363E7007373E700DEDEF700FFFFFF00C6C6CE0039427300C6C6
      C600FFFFFF00DEDEF7007373E7006B6BE7007373E7006B6BE700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063AD630039CE5A005AFF9C0052F7
      8C004AEF840042E77B0039DE730031D66B0031CE630029CE520021C6420018B5
      310010B5210008AD1000008408003973420000000000CEADA500CE7B6B00F7BD
      A500F7BD9C00DE9C8400CE847300EFBD9C00E7B59400E7AD9400E7AD8C00E7A5
      8C00E7A58400E79C8400DE9C7B00DE9C7300DE947300DE947300D68C6300D684
      5A00BD633900BD5A2900CE633900CE6B3900CE5A3100CE6B4200D6845A00C67B
      6300000000000000000000000000000000000000000000000000DECECE00CE9C
      9C00CE8C8400D6ADBD00D6BDBD00CEA5A500CE9C9C00CE8C8C00CE848400DEA5
      A500EFCECE00EFE7E700A5BDA5002994390008A5180018B5290021BD390029BD
      4A0031CE5A0039CE630039D66B0042DE73004ADE7B0052E784005AEF8C0063F7
      940063FF9C0042CE63006BAD6B000000000000000000F7E7E700DECECE00CE9C
      9C00CE8C8400D6ADBD00D6BDBD00CEA5A500CE9C9C00CE8C8C00CE848400DEAD
      AD00F7DEDE00F7E7E700524AB5007373E7007373E7007B84E700DEDEF700FFFF
      FF00C6C6C60042427B006363D60042427B00C6C6C600FFFFFF00D6D6F7007B84
      EF007373E7007373E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007394730039844200000000000000
      000063AD630039CE630063FF9C005AFF940052F7840042E77B0039DE730031D6
      6B0031CE630029CE520021C6420018BD310010B52900088C1800396B39000000
      000000000000C69C9C00D68C7B00F7C6AD00F7BDA500E7AD9400CE847300EFBD
      A500EFBDAD00EFBDA500EFB59C00E7B59400E7B59400E7AD9400E7AD8C00E7AD
      8C00E7A58400DE9C7B00DEA58400EFAD9400E7A57B00C67B5200C6633900CE63
      3100CE5A2900CE6B4200D68C5A00CE7B5200D6B5AD0000000000000000000000
      00000000000000000000E7CECE00C6949400FFBD5A00F7BD7B00DEAD9400CEA5
      A500C6848C00C66B6B00CE737300D68C8C00E7ADAD00F7E7E700F7EFEF00ADC6
      AD00399C4A0010AD290021BD390029C64A0031C6520039CE630039D66B0042DE
      73004ADE7B0052E784005AEF8C0063F7940063FF9C0042CE63006BB56B000000
      00000000000000000000E7CECE00C6949400FFBD5A00F7BD7B00DEAD9400CEA5
      A500C6848C00C66B6B00CE7B7B00DEA5A500F7D6D600F7EFEF00524AB500737B
      EF006B6BE700BDC6FF00FFFFFF00B5B5BD00424A7B00737BDE008C94F7007B84
      DE00424A7B00B5B5BD00FFFFFF00C6C6FF006B73E7007B7BEF00000000000000
      0000000000000000000000000000000000000000000000000000000000006B84
      6B00188C290008A529006BAD6B000000000052A55A0029C6520052FF8C004AEF
      7B0042E7730042E7730039DE730031D66B0031CE630029CE520021C6420010BD
      3100088C210052845A00000000000000000000000000BD949400D6948400F7CE
      B500EFC6AD00F7C6AD00CE8C7300E7BDA500F7CEBD00EFC6AD00EFC6AD00EFBD
      A500EFBDA500EFB59C00E7B59C00EFB59400E7AD9400E7B59400EFB59C00E7B5
      9C00EFB59400E7B59400D69C7300CE846300CE734A00CE734A00D68C5A00D67B
      5200CE8473000000000000000000000000000000000000000000E7CECE00CE8C
      7B00FF9C0800FFAD1800FFBD4200F7BD6300EFAD8C00D69C9C00D67B8400CE73
      7B00D68C8C00F7E7E700F7F7F700F7EFEF00C6CEBD0052A55A0010AD290029C6
      4A0031CE520031CE630039D66B0042DE73004AE77B0052EF84005AF78C0063FF
      9C006BFFA50042CE63006BAD7300000000000000000000000000E7CECE00CE8C
      7B00FF9C0800FFAD1800FFBD4200F7BD6300EFAD8C00D69C9C00D6848C00DE9C
      9C00EFD6D600F7EFEF005A4AB5007B84EF008484F7007B84C600636373005A63
      8C008C9CDE009CADF70094ADE7009CB5F7008C9CE7005A638C00636373007B84
      CE00848CF7007B84EF0000000000000000000000000000000000000000000000
      000000000000000000006B846300188C290029D6630029BD4A006BB56B000000
      00008CBD8C00318C4200399C4A0031944A0031944200219C310031C65A0039DE
      6B0031CE630029CE5A0021C64200109429005A845A0000000000000000000000
      000000000000B58C8C00DE9C8C00F7CEB500F7C6B500F7CEB500DE9C8C00CE94
      8400F7D6C600F7DEC600F7D6BD00EFCEBD00EFCEB500EFC6B500F7C6AD00EFBD
      A500EFBDA500E7BDAD00EFBDAD00EFC6AD00EFBDA500EFBDA500E7BD9C00DEA5
      8C00CE947300DEA58400E7A58400E79C7300CE7B5A00E7CECE00000000000000
      00000000000000000000DEC6C600D68C7300FFA52100FFAD2900FFAD2100FFB5
      2900FFBD3900FFB55200EFB57B00DEAD9400D6949400DEB5B500EFD6D600F7E7
      E700F7EFEF00D6DECE005AAD630018AD390029C6520039CE6B0039D66B0042DE
      730039CE630039BD5A0042C663004ACE6B004ACE6B0031AD4A0073B57B000000
      00000000000000000000DEC6C600D68C7300FFA52100FFAD2900FFAD2100FFB5
      2900FFBD3900FFB55200EFBD8C00E7C6B500EFDEDE00F7E7E700524AB500848C
      F7008C94F7007B84DE006373A50094A5E700A5BDF7009CB5EF009CB5EF009CB5
      EF00A5BDF70094A5DE005A73A5007B8CDE008C94FF008494F700000000000000
      0000000000000000000000000000000000000000000063846300188C290029CE
      5A0039E7730021BD42007BB57B00000000000000000000000000000000000000
      0000000000005294520021B5420039DE6B0031D6630021C65200108C29005A84
      5A000000000000000000000000000000000000000000B5848400E7AD9C00FFD6
      BD00F7CEB500F7CEB500F7CEAD00D6948400CE847300DE9C8C00DEB5A500EFCE
      BD00F7CEBD00F7CEBD00F7CEBD00F7CEBD00EFCEBD00EFC6B500EFC6AD00F7C6
      B500EFC6B500EFC6AD00EFBDAD00EFBDA500DEAD9400D6A58C00E7B59C00EFBD
      9C00E7B59400CE948C0000000000000000000000000000000000DEBDC600DE9C
      6300FFAD3100FFB53100FFBD3900FFBD3900FFBD3900FFBD3900FFBD4200FFBD
      4200F7BD6B00E7B59400DEADA500EFCECE00F7EFEF00F7EFEF00D6DED60063AD
      6B0021AD420031CE630042DE730039D66B0029A542007BAD7B00C6D6C600BDDE
      BD00BDDEBD00BDD6BD0000000000000000000000000000000000DEBDC600DE9C
      6300FFAD3100FFB53100FFBD3900FFBD3900FFBD3900FFBD3900FFC65200FFCE
      7B00FFE7C600F7E7DE008C7B9400635AC60094A5FF00ADCEFF00C6EFFF00B5E7
      FF00B5DEF700B5DEF700B5DEF700B5DEF700B5DEF700B5E7F700BDEFFF00B5CE
      FF0094ADFF006363CE0000000000000000000000000000000000000000000000
      00005A845A00108C290021C6520031D6630039DE6B0021B54200529452000000
      000000000000000000000000000000000000000000007BB57B0021BD420039E7
      730029CE5A00188C290063846300000000000000000000000000000000000000
      000000000000BD847B00E7B5A500FFD6C600F7D6BD00F7CEBD00F7CEB500F7CE
      B500EFBDA500E7A58C00D6947B00CE7B6B00CE846B00C6847300CE948400DEAD
      9C00F7DECE00EFD6C600F7D6C600EFCEBD00EFD6BD00EFCEB500EFCEB500F7CE
      B500F7CEB500E7BDA500DEB59C00E7B5A500EFBDAD00D6948400000000000000
      00000000000000000000CEADB500EFAD5A00FFBD3900FFBD4200FFBD4A00FFBD
      4A00FFC65200FFC65200FFBD4A00FFBD4A00FFBD4A00FFC64A00FFC66B00EFBD
      8C00EFC6C600F7EFEF00F7EFEF00DEDED60073B57B0021AD420039D66B0039D6
      6B0039AD4A00ADC6A500E7DEDE00000000000000000000000000000000000000
      00000000000000000000CEADB500EFAD5A00FFBD3900FFBD4200FFBD4A00FFBD
      4A00FFC65200FFC65200FFC65A00FFCE7300FFDEA500FFEFCE00F7EFDE008C73
      8C005A4AB500635AB500635AB500635AB5005A5AB5005A5AB500635AB5005A5A
      B5005A5AB5005A5AB5005A5AB500635ABD005A52BD0000000000000000000000
      00000000000000000000000000005A845A001094290021C6420029CE5A0031CE
      630039DE6B0031C65A00219C31003194420031944A00399C4A00318C42008CBD
      8C00000000006BB56B0029BD4A0029D66300188C29006B846300000000000000
      00000000000000000000000000000000000000000000B57B7300E7BDAD00FFDE
      CE00F7D6BD00F7D6BD00F7CEB500F7C6B500F7CEB500EFC6AD00F7C6AD00F7C6
      AD00EFB59400BD948C00C6BDBD00AD848400CE948C00F7E7D600F7DECE00F7DE
      CE00F7D6CE00F7D6C600F7D6C600F7D6BD00EFCEBD00F7CEBD00EFC6B500DEB5
      A500E7BDA500E7B59C00D6ADA500000000000000000000000000C69CA500F7B5
      5A00FFC64A00FFC65200FFC65A00FFC65A00FFCE5A00FFCE5A00FFC65A00FFC6
      5A00FFC65200FFC65200FFC65200F7B55A00DEADAD00EFE7E700F7EFEF00F7EF
      EF00DED6D60084B5840029AD4A0029CE5A0042B552009CBD9400E7DEDE000000
      00000000000000000000000000000000000000000000EFDEDE00C69CA500F7B5
      5A00FFC64A00FFC65200FFC65A00FFC65A00FFCE5A00FFCE5A00FFCE6300FFD6
      7300FFD68C00FFE7B500FFEFCE00FFEFCE00F7DEE700F7EFEF00F7EFEF00F7EF
      EF00EFDEDE00EFDEDE00EFE7E700F7E7E700EFE7E700EFDEDE00E7DEDE000000
      000000000000000000000000000000000000000000000000000052845A00088C
      210010BD310021C6420029CE520031CE630031D66B0039DE730042E7730042E7
      73004AEF7B0052FF8C0029C6520052A55A00000000006BAD6B0008A52900188C
      29006B846B000000000000000000000000000000000000000000000000000000
      000000000000B5736B00EFCEBD00FFE7CE00F7DEC600F7D6C600F7D6BD00F7CE
      BD00FFCEB500F7CEB500EFC6AD00EFBDA500C6A59400C6C6C600C6C6C600DEDE
      DE00A5848400CE9C9400EFD6CE00EFD6CE00FFE7D600FFE7D600FFEFDE00FFDE
      D600FFDECE00F7DECE00F7D6C600EFCEBD00E7BDAD00EFC6B500D69C94000000
      000000000000E7D6D600C69C9C00F7BD5A00FFCE5A00FFCE6300FFCE6B00FFCE
      6B00FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFCE6300FFC65A00FFC65200EFAD
      6300D6A5A500E7D6D600EFDEDE00F7EFEF00EFDEDE00DEDED6008CBD9400219C
      3900299C39009CBD9C00E7DEDE00000000000000000000000000000000000000
      000000000000E7D6D600C69C9C00F7BD5A00FFCE5A00FFCE6300FFCE6B00FFCE
      6B00FFCE6B00FFCE6B00FFD67300FFD67300FFD68400FFDE9400FFE7AD00FFDE
      C600F7E7E700F7EFEF00F7EFEF00F7EFEF00EFDEDE00EFDEDE00EFDEDE00EFDE
      DE00EFDEDE00EFDEDE00E7DEDE00000000000000000000000000000000000000
      000000000000396B3900088C180010B5290018BD310021C6420029CE520031CE
      630031D66B0039DE730042E77B0052F784005AFF940063FF9C0039CE630063AD
      630000000000A5CEA50039844200739473000000000000000000000000000000
      00000000000000000000000000000000000000000000AD6B6B00F7D6C600FFE7
      D600F7DECE00F7DEC600F7D6C600F7D6C600F7D6BD00FFD6BD00F7CEB500CEA5
      9400BDBDBD00E7E7E700DEDEDE00BDC6BD00DEDEDE00BD9C9C00BD949400D6B5
      A500C69C9400D6A59C00DEA59C00DEB5AD00EFC6B500F7D6C600FFDED600FFDE
      CE00F7D6CE00EFD6C600DEAD9C00CEADAD0000000000DECED600D6B59400F7C6
      6300FFCE6B00FFD66B00FFD67300FFD67B00FFD67B00FFD67B00FFD67B00FFD6
      7300FFD67300FFCE6B00FFCE6300E79C6B00D69CA500E7CECE00E7CECE00EFD6
      D600EFDEDE00EFDEDE00DEDED600B5CEB50094C69400CEDECE00E7DEDE000000
      00000000000000000000000000000000000000000000DECED600D6B59400F7C6
      6300FFCE6B00FFD66B00FFD67300FFD67B00FFD67B00FFD67B00FFD67B00FFD6
      7B00FFD67B00FFD68400FFD68400EFBD9C00E7BDBD00EFDEDE00EFD6D600E7CE
      CE00D6B5B500D6B5B500CEADAD00D6B5B500D6B5B500CEADAD00BDADB5000000
      000000000000000000000000000000000000397342000084080008AD100010B5
      210018B5310021C6420029CE520031CE630031D66B0039DE730042E77B004AEF
      840052F78C005AFF9C0039CE5A0063AD63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AD6B6300F7DECE00FFE7D600FFE7D600F7E7CE00F7DECE00F7DE
      C600F7D6C600FFD6BD00D6B5A500BDBDB500DEE7E700BDBDBD00CECECE00C6C6
      C600ADADAD00E7E7E700BDBDBD00C6BDBD00E7DEDE00B5A5A500E7D6D600F7D6
      D600DEC6BD00D6ADA500CE9C9400CEA59400D6A59C00DEB5A500DEADA500B58C
      840000000000D6C6C600DEB59400F7C66B00FFD67300FFD67B00FFDE8400FFDE
      8400FFDE8C00FFDE8C00FFDE8400FFDE8400FFD67B00FFD67300FFCE6B00DE9C
      7300D6A5A500DEC6C600DEC6C600DEBDBD00D6B5B500E7D6D600F7E7E700EFE7
      E700EFDEDE00E7CECE00C6B5B500000000000000000000000000000000000000
      000000000000D6C6C600DEB59400F7C66B00FFD67300FFD67B00FFDE8400FFDE
      8400FFDE8C00FFDE8C00FFDE8400FFDE8400FFDE8400FFD67B00FFD67300E7A5
      7B00D6ADAD00E7CECE00DEC6C600DEB5B500BD848400C69C9C00D6A5A500CE9C
      9C00C6949400BD8484009C848C00000000000000000000000000000000000000
      00001884210000A5080000AD100010B5210018B5310021C6420029CE520031CE
      630031D66B0039DE730042E77B004AEF840052F78C005AFF9C0039CE5A0063AD
      6300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B56B6300F7DECE00FFEF
      DE00FFE7D600FFDED600F7DECE00F7DECE00FFDECE00DEBDA500D6CEC600D6DE
      DE00BDBDBD00BDC6BD00B5B5B500C6C6C600DEDEDE00ADADAD00D6DED600BDBD
      BD00D6D6D600D6DEDE00BDBDBD00D6DEDE00000000000000000000000000FFFF
      FF00F7EFEF00E7D6D600AD949400E7D6D60000000000C6B5BD00E7BD8C00FFD6
      7300FFDE7B00FFDE8C00FFE78C00FFE79400FFE79C00FFE79C00FFE79400FFE7
      9400FFDE8C00FFDE8400FFD67300D6947300D6ADAD00DEBDBD00DEBDBD00D6A5
      A500CE949400CEA5A500D6B5B500DEC6C600D6BDBD00CEA5A500AD949C000000
      00000000000000000000000000000000000000000000C6B5BD00E7BD8C00FFD6
      7300FFDE7B00FFDE8C00FFE78C00FFE79400FFE79C00FFE79C00FFE79400FFE7
      9400FFDE8C00FFDE8400FFD67300D6947300D6ADAD00DEBDBD00DEBDBD00D69C
      9C00BD737300B5737300BD848400C6949400B5848400AD6B6B008C737B000000
      000000000000000000000000000000000000000000001094210000A5100010B5
      210018B5310021C6420029CE520031CE630031D66B0039DE730042E77B004AEF
      840052F78C005AFF9C0039CE5A0063AD63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AD737300EFCEBD00FFEFE700FFE7DE00FFE7D600FFE7D600FFE7
      D600E7CEB500CEC6BD00FFFFFF0000000000E7E7E700B5B5B500DEE7DE00CECE
      CE00BDBDBD00E7E7E700CECECE00EFF7EF00C6C6C600CECECE00DEDEDE00B5B5
      B500F7F7F700000000000000000000000000FFFFFF00C6CECE00E7EFEF000000
      000000000000C6B5BD00EFC68400FFDE7B00FFDE8C00FFE79400FFE79C00FFEF
      A500FFEFAD00FFEFAD00FFEFA500FFEF9C00FFE79400FFDE8C00FFD67B00CE8C
      7B00D6B5B500DEBDBD00D6B5B500CE949400CE737300CE848400C6848400C68C
      8C00C6949400BD8484009C848C00000000000000000000000000000000000000
      0000E7E7E700C6B5BD00EFC68400FFDE7B00FFDE8C00FFE79400FFE79C00FFEF
      A500FFEFAD00FFEFAD00FFEFA500FFEF9C00FFE79400FFDE8C00FFD67B00CE8C
      7B00D6B5B500DEBDBD00D6B5B500CE8C8C00C66B6B00C66B6B00BD6B6B00B573
      7300B5737300AD6363008C737B00000000000000000000000000000000000000
      000000000000000000001894310000AD210018BD310021C6420029CE520031CE
      630031D66B0039DE730042E77B0052EF840052F78C0063FF9C0039CE630063AD
      6300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEA5A500D69C9400FFEF
      E700FFEFDE00FFEFDE00FFEFDE00EFD6C600CEBDBD00F7FFFF00000000000000
      000000000000F7F7F700CED6CE00CECECE00D6D6D600CED6CE00F7F7F700CECE
      CE00DEDEDE00DEDEDE00CED6CE00E7E7E700EFEFEF000000000000000000FFFF
      FF00C6C6C600E7E7E700000000000000000000000000D6C6C600E7C67B00FFDE
      8400FFE79400FFEF9C00FFEFAD00FFF7AD00FFF7B500FFF7B500FFF7B500FFEF
      AD00FFEFA500FFE79400FFDE8400BD848400DEC6C600E7CECE00EFD6D600EFDE
      DE00E7BDBD00D6949400CE7B7B00CE737300CE737300BD6B6B00947384000000
      000000000000000000000000000000000000DED6DE00D6C6C600E7C67B00FFDE
      8400FFE79400FFEF9C00FFEFAD00FFF7AD00FFF7B500FFF7B500FFF7B500FFEF
      AD00FFEFA500FFE79400FFDE8400BD848400DEC6C600E7CECE00EFD6D600EFDE
      DE00E7BDBD00D68C8C00CE737300CE6B6B00C66B6B00B56363008C737B000000
      000000000000000000000000000000000000000000000000000000000000299C
      390008B5290021C6420029CE520031CE630031D66B0039DE730042E77B0052F7
      840052FF940063FF9C0039CE63005AAD63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BD7B7B00F7D6CE00FFF7E700FFEFE700F7DED600CEBD
      B500F7F7F700000000000000000000000000FFFFFF0000000000E7E7E700ADAD
      AD00CECECE00D6D6D600B5BDB500D6D6D600B5BDB500E7E7E700DEDEDE00BDBD
      BD00F7F7F70000000000FFFFFF00CECECE00DEDEDE0000000000000000000000
      000000000000D6CEC600CEAD7B00FFDE8C00FFE79C00FFEFA500FFF7B500FFFF
      BD00FFFFC600FFFFC600FFFFBD00FFF7B500FFEFAD00FFE79C00EFCE8400C694
      8C00F7E7E700F7E7E700F7EFEF00FFF7F700F7EFEF00F7E7E700EFD6D600E7B5
      B500D68C8C00B56B6B00AD949C00000000000000000000000000000000000000
      0000CECECE00D6CEC600CEAD7B00FFDE8C00FFE79C00FFEFA500FFF7B500FFFF
      BD00FFFFC600FFFFC600FFFFBD00FFF7B500FFEFAD00FFE79C00EFCE8400C694
      8C00F7E7E700F7E7E700F7EFEF00FFF7F700F7EFEF00F7E7E700EFD6D600E7B5
      B500D68C8C00B56B6B00AD949C00000000000000000000000000000000000000
      000000000000000000000000000000000000299C420018B5390029CE5A0031CE
      630039D66B0039D6630029BD520039C65A0039C6630042CE6B0029AD420063AD
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE9C9C00BD73
      6B00D6A59C00DEB5A500D6BDB500F7F7F7000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00EFEFEF00C6C6C600C6C6C600D6DED600B5B5
      B500E7E7E700F7F7F70000000000D6D6D600ADADAD00E7E7E700D6D6D600D6D6
      D6000000000000000000000000000000000000000000D6CECE00AD9C9C00AD9C
      9C00BDA59400C6B59C00D6C6A500EFDEB500F7F7C600FFF7C600FFFFC600FFFF
      BD00FFF7B500FFEFA500EFC68C00CE9C9C00EFD6D600EFCECE00E7CECE00E7C6
      C600E7CECE00E7CECE00E7CECE00DECECE00D6B5B500D6B5B500000000000000
      000000000000000000000000000000000000BDBDBD00D6CECE00AD9C9C00AD9C
      9C00BDA59400C6B59C00D6C6A500EFDEB500F7F7C600FFF7C600FFFFC600FFFF
      BD00FFF7B500FFEFA500EFC68C00CE9C9C00EFD6D600EFCECE00E7CECE00E7C6
      C600E7CECE00E7CECE00E7CECE00DECECE00D6B5B500D6B5B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000319C420018BD420031D6630039DE6B0021BD4A00529C52000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEB5B500D6A5A500C6949400BD949400E7DE
      DE00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00F7F7F700FFFF
      FF00FFFFFF00BDBDBD00C6C6C600DEDEDE00B5B5B500EFEFEF00FFFFFF00FFFF
      FF00E7E7E700BDBDBD00CECECE00000000000000000000000000000000000000
      000000000000CECECE00CECECE00CEC6C600C6B5BD00BDADAD00B5A5A500B59C
      A500BDA59C00C6AD9C00CEB59C00D6BDA500E7CEA500EFD69400D6AD8C00C68C
      8C00D6B5AD00DEBDBD00DEBDBD00DEBDBD00DEC6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CECECE00E7E7E700DEDEDE00CEC6C600C6B5BD00BDADAD00B5A5A500B59C
      A500BDA59C00C6AD9C00CEB59C00D6BDA500E7CEA500EFD69400D6AD8C00C68C
      8C00D6B5AD00DEBDBD00DEBDBD00DEBDBD00DEC6C600DEC6C600E7D6D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000039A54A0018BD
      4A0039DE730021BD4A0073B57B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E7DEDE00DEDEDE00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00F7F7F700F7F7F700FFFFFF00F7F7F700E7E7E700F7F7
      F700EFEFEF00B5BDB500E7E7E70000000000E7E7E700C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7D6D600DECECE00CEB5B500C6A5A500BDA5A500BD9C
      A500C69C9C00C69C9400BD8C8400AD7B7B00D6BDBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E7DEDE00E7DEDE00E7D6D600DECECE00CEB5B500C6A5A500BDA5A500BD9C
      A500C69C9C00C69C9400BD8C8400AD7B7B00D6BDBD00EFE7E700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000039A54A0018C6520021BD4A006BB573000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFEFEF00D6D6D6000000000000000000FFFFFF00FFFFFF00F7F7F700FFFF
      FF00F7F7F700EFEFEF00EFEFEF00F7F7F700F7F7F700E7E7E700F7F7F700EFEF
      EF00BDBDBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E7D6D600D6B5B500CEADAD00B58C8C00CEBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EFDEDE00E7D6D600D6B5B500CEADAD00B58C8C00CEBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000042A55A00089421006BAD7300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFEFEF00D6D6D600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F7F7F700DEDEDE00B5B5B500BDBDBD00EFEF
      EF00F7F7F700F7F7F700EFEFEF00BDBDBD000000000000000000000000000000
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
      00000000000000000000EFEFEF00D6D6D600F7F7F700FFFFFF00F7F7F700D6D6
      D600CECECE00CECECE008C8C8C00ADADAD00E7E7E700F7F7F700BDC6BD000000
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
      0000D6D6D600E7E7E700D6DED600D6D6D600000000000000000000000000BDBD
      BD00BDBDBD00C6C6C60000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      280000007C0000007C0000000100010000000000C00700000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
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
      C000000200000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C0000000000000000000000000000000
      C0000000000000000000000000000000C0000000000000000000000000000000
      C0000000000000000000000000000000C0000000000000000000000000000000
      C000000000000000000000000000000080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FE000000000000000000000000
      000000FE000000000000000000000000FFF00FFE000000000000000000000000
      FFF00FFE000000000000000000000000FFF9FFFFFFFFFFFFFFFFFFFFFFFFFFF0
      FC000001FFFF8FFFF8000FFFFFFFFFF0FC000001FFFF0FFFE00001FFFFFFFFF0
      FD0807F9F80E0FFFC00000FFC03F83F0FD000001E0040FFFC00000FF000E00F0
      FD660001C0000FFFC00000FC000C0040FD00000980000083C00000FC00080000
      8000000900000003E00001F8000800000006400900000003F00003F800000000
      0000000900000003F8000FF8C00000000000600180000003FE001FFC00000000
      00003001C0000003FE001FFE0000000000001801C0000003FC000FFE00000000
      00016401C0000003FC000FFE0000000000000001C0000003FC000FFE00000010
      00000001C0000007FC0007FE0000001000006641C000001FFC0007FE00000030
      000000018000001FF80007FE00000070000066618000001FF80007FC000000F0
      000000018000001FF80067FC000000F0000000018000001FFC0047FC000000F0
      000066618000001FFE0027FC000000F0000000010000001FFF0001FC000000F0
      000000090000001FFF8080FC000000F00000FF010000001FFFFF927C000000F0
      000000010000003FFFFF127C000001F000000043800001FFFFFF337C00003FF0
      0000FE47E0007FFFFFFF377FE003FFF08001FE0FFF80FFFFFFFF127FFF07FFF0
      FC01FE1FFFFFFFFFFFFF80FFFFFFFFF0FC00003FFFFFFFFFFFFF81FFFFFFFFF0
      FFFFFFFFFFFF0007FFFFFFFC00FFFFF0FFFFFC7FFFFE0003FFFF8FF8000FFFF0
      FFFFF83FFFFC0003FFFF87F80001FFF0F807F03FF80C0003FFFF83F800001FF0
      E001E03FE0002023FFFF81F8000003F08000C03FC0001043FFF000F8000001F0
      8000000180000883FFF00078000001F00000000100000103FFF00038000001F0
      0000000100000003FFF00018000001F00000000100000003FFF00008000000F0
      8000000180000003FFF00008000000F0C000000180000003FF30001800000070
      C0000001C0000003FE10003800000070C0000001C0000003FC10007800000030
      C0000001C0000003F81F80F800000030C0000003C0000003F01F81F800000030
      C000001FC0000007E00083F800000010C000001F8000001FC00087F800000010
      8000001F8000001F80008FF8000000008000001F8000001F0000FFF800000000
      8000001F8000001F0000FFF800000E008000001F8000001F8000FFF801000710
      8000001F0000001FC000FFF8038006308000001F0000001FE000FFFC07400470
      8000001F0000001FF000FFFC0F8020F08000003F0000003FF81FFFFE0E0001F0
      800007FF000001FFFC1FFFFFE20013F0FC007FFFF0003FFFFE1FFFFFF30007F0
      FFE0FFFFFFC0FFFFFF1FFFFFF8000FF0FFFFFFFFFFFFFFFFFFFFFFFFFC001FF0
      FFFFFFFFFFFFFFFFFFFFFFFFFF0E3FF000000000000000000000000000000000
      000000000000}
  end
  object ilSmall: TImageList
    AllocBy = 0
    ShareImages = True
    Left = 408
    Top = 32
    Bitmap = {
      494C010108000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000000000000000000000210800002108000021080000210800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000180000001800000018000000180000000000000000
      0000000000000000000000000000000000000000000000000000000000002121
      2100214A0000214A0000212121000000000021212100214A0000214A00002121
      2100000000000000000000000000000000000000000000000000000000002121
      21000000A5000000A5002121210000000000212121000000A5000000A5002121
      2100000000000000000000000000000000000000000000000000000000000000
      0000002108000021080073C64A006BBD39005ABD290052B52100002108000021
      0800000000000000000000000000000000000000000000000000000000000000
      000000180000001800003939D6002929CE002121CE001818C600001800000018
      000000000000000000000000000000000000000000000000000000000000214A
      000084CE6B007BCE5A000031080000000000003108004AAD080042AD0000214A
      0000000000000000000000000000000000000000000000000000000000000000
      A5006B6BE7005252DE0000008C000000000000008C001018C6000808BD000000
      A500000000000000000000000000000000000000000000000000000000000021
      080094D6730084CE63007BC6520000000000000000005ABD290052B518004AB5
      1000002108000000000000000000000000000000000000000000000000000018
      00006363E7005252DE004242DE0000000000000000002121CE001010C6000808
      C60000180000000000000000000000000000000000000000000000000000214A
      000094D673008CCE6B000031080000000000003108004AB5100042AD0800214A
      0000000000000000000000000000000000000000000000000000000000000000
      A5007373E7006363E70000008C000000000000008C002121CE001010C6000000
      A500000000000000000000000000000000000000000000000000000000000021
      080094D67B008CD6730084CE63007BC652006BC6420063BD31005AB5210052B5
      1800002108000000000000000000000000000000000000000000000000000018
      00006B6BE7006363E7005252DE004242DE003939D6002929CE002121CE001010
      C60000180000000000000000000000000000000000000000000000000000214A
      00009CD6840094D6730000310800000000000031080052B518004AB51000214A
      0000000000000000000000000000000000000000000000000000000000000000
      A5008484EF007373E70000008C000000000000008C003131CE002121C6000000
      A50000000000000000000000000000000000000000000000000000210800ADDE
      94009CDE8C0094D67B008CCE6B0000000000000000006BC6420063BD31005AB5
      210052B518000021080000000000000000000000000000000000001800008484
      F7007B7BEF006B6BE7005A5AE70000000000000000003131D6002929CE001818
      CE001010C600001800000000000000000000000000000000000000000000214A
      0000A5DE8C009CD684000031080000000000003108005ABD290052B51800214A
      0000000000000000000000000000000000000000000000000000000000000000
      A5009494F7008484EF0000008C000000000000008C003939D6002929CE000000
      A50000000000000000000000000000000000000000000000000000210800ADE7
      A500A5DE94009CDE8C0094D67B008CCE6B0000000000000000006BBD390063BD
      290052B521000021080000000000000000000000000000000000001800008C94
      F7008484F700737BEF006B6BE7005A5AE70000000000000000003131D6002929
      CE001818CE00001800000000000000000000000000000000000000000000214A
      0000ADDE9C00A5DE8C0000310800000000000031080063BD31005ABD2900214A
      0000000000000000000000000000000000000000000000000000000000000000
      A5009C9CF7008C8CF70000008C000000000000008C004A4ADE003939D6000000
      A50000000000000000000000000000000000000000000000000000210800B5E7
      AD00ADDE9C00A5DE94009CD6840094D6730084CE630000000000000000006BBD
      39005ABD29000021080000000000000000000000000000000000001800009C9C
      F7008C8CF7008484EF007373EF006B6BE7005A5AE70000000000000000003131
      D6002929CE00001800000000000000000000000000000000000000000000214A
      0000B5E7A500ADDE9C000031080000000000003108006BC6420063BD3900214A
      0000000000000000000000000000000000000000000000000000000000000000
      A500A5A5FF009C9CF70000008C000000000000008C005A5ADE004A4AD6000000
      A50000000000000000000000000000000000000000000000000000210800BDE7
      B500B5E7A50000000000000000009CD684008CD6730000000000000000006BC6
      420063BD3100002108000000000000000000000000000000000000180000A5A5
      FF00949CF70000000000000000007373EF006B6BE70000000000000000004242
      D6003131D600001800000000000000000000000000000000000000000000214A
      0000B5E7AD00B5E7A50000310800000000000031080073C652006BC64200214A
      0000000000000000000000000000000000000000000000000000000000000000
      A500ADADFF00A5A5FF0000008C000000000000008C006B6BE7005A5ADE000000
      A500000000000000000000000000000000000000000000000000000000000021
      0800B5E7AD000000000000000000A5DE8C0094D67B0000000000000000007BC6
      5200002108000000000000000000000000000000000000000000000000000018
      0000A5A5FF0000000000000000008484EF007373EF0000000000000000004A4A
      DE0000180000000000000000000000000000000000000000000000000000214A
      0000BDE7B500B5E7AD0000310800000000000031080084CE5A007BC65200214A
      0000000000000000000000000000000000000000000000000000000000000000
      A500ADADFF00ADADFF0000008C000000000000008C007B7BE7006B6BE7000000
      A500000000000000000000000000000000000000000000000000000000000021
      0800BDE7B500B5E7AD00000000000000000000000000000000008CCE6B007BCE
      5A00002108000000000000000000000000000000000000000000000000000018
      0000A5ADFF009CA5FF00000000000000000000000000000000006363E700525A
      DE0000180000000000000000000000000000000000000000000000000000214A
      0000BDE7B500BDE7B5000031080000000000003108008CCE6B007BCE5A00214A
      0000000000000000000000000000000000000000000000000000000000000000
      A500ADADFF00ADADFF0000008C000000000000008C008484EF007373E7000000
      A500000000000000000000000000000000000000000000000000000000000000
      00000021080000210800B5E7AD00ADE79C00A5DE94009CD68400002108000021
      0800000000000000000000000000000000000000000000000000000000000000
      000000180000001800009C9CFF009494F7008C8CF7007B7BEF00001800000018
      000000000000000000000000000000000000000000000000000000000000214A
      0000BDE7B500BDE7B50000310800000000000031080094D673008CCE6B00214A
      0000000000000000000000000000000000000000000000000000000000000000
      A500ADADFF00ADADFF0000008C000000000000008C009494F7008484EF000000
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000210800002108000021080000210800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000180000001800000018000000180000000000000000
      000000000000000000000000000000000000000000000000000000000000214A
      0000214A0000214A0000212121000000000021212100214A0000214A00002121
      2100000000000000000000000000000000000000000000000000000000002121
      21000000A5000000A5002121210000000000212121000000A5000000A5002121
      2100000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000031313100C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000031313100C6C6C60000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000084CE
      6B007BCE5A0073C652006BC6420063BD39005ABD290052B518004AB510004AAD
      080042AD00000000000000000000000000000000000000000000000000003939
      EF002929DE002121D6001818CE001010CE001010C6000808C6000000BD000000
      BD000000BD0000000000000000000000000000000000000000000000000084CE
      63006BC642000000000031313100CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003131
      CE002121CE000000000031313100CECECE000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000094D6
      73008CCE6B0084CE5A0073C652006BC6420063BD31005ABD290052B518004AB5
      100042AD08000000000000000000000000000000000000000000000000004242
      F7003939EF003131E7002121DE001818D6001010D6001010CE000808C6000000
      C6000000C60000000000000000000000000000000000000000000000000094D6
      73007BC6520063BD310052B518000000000031313100D6D6D600000000000000
      0000000000000000000000000000000000000000000000000000000000003939
      D6002929CE002121C6001010C6000000000031313100D6D6D600000000000000
      0000000000000000000000000000000000000000000000000000000000009CD6
      840094D673008CCE6B007BCE5A0073C652006BC6420063BD31005ABD290052B5
      18004AB510000000000000000000000000000000000000000000000000005252
      FF004242FF003939F7003131EF002929E7001818DE001818D6001010D6000808
      CE000000CE000000000000000000000000000000000000000000000000009CDE
      8C008CCE6B0073C64A005ABD29004AB5100042AD0000000000005A5A5A00DEDE
      DE00000000000000000000000000000000000000000000000000000000004242
      D6003939D6002929CE001818C6001010C6000808BD00000000005A5A5A00DEDE
      DE0000000000000000000000000000000000000000000000000000000000A5DE
      8C009CD6840094D673008CCE6B007BCE5A007BC652006BC6420063BD31005ABD
      290052B51800000000000000000000000000000000000000000000000000636B
      FF005A5AFF004A4AFF003939F7003131EF002929EF002121E7001818DE001010
      D6000808D600000000000000000000000000000000000000000000000000ADDE
      9C0094D67B0084CE5A006BBD390052B5210042AD080042AD000042AD00000000
      000063636300DEDEDE0000000000000000000000000000000000000000005252
      DE004242D6003131CE002121CE001818C6001010C6000808BD000000BD000000
      000063636300DEDEDE000000000000000000000000000000000000000000ADDE
      9C00A5DE8C009CD6840094D6730084CE6B007BCE5A007BC652006BC6420063BD
      31005ABD29000000000000000000000000000000000000000000000000007B7B
      FF006B6BFF005A5AFF004A4AFF003939FF003131F7002929EF002121E7001818
      DE001010D600000000000000000000000000000000000000000000000000B5E7
      A500A5DE8C008CD6730073C64A0063BD31004AB5100042AD000042AD000042AD
      000042AD00000808080000000000000000000000000000000000000000005A5A
      DE004A4ADE003942D6003131CE002121CE001818C6000808BD000000BD000000
      BD000000BD00080808000000000000000000000000000000000000000000B5E7
      A500ADDE9C00A5DE8C009CD6840094D6730084CE6B007BCE5A0073C652006BC6
      420063BD39000000000000000000000000000000000000000000000000008C8C
      FF007B7BFF007373FF006363FF005252FF004242FF003131FF002929F7002121
      EF001818E700000000000000000000000000000000000000000000000000BDE7
      B500ADDE9C009CD6840084CE63006BC642005AB521004AAD080042AD000042AD
      000042AD00002121210000000000000000000000000000000000000000006B6B
      E7005A5ADE004A4AD6003939D6002929CE002121C6001010C6000808BD000000
      BD000000BD00212121000000000000000000000000000000000000000000B5E7
      AD00B5E7A500ADDE9C00A5DE8C009CD6840094D673008CCE6B0084CE5A0073C6
      52006BC642000000000000000000000000000000000000000000000000009494
      FF008C8CFF008484FF007B7BFF006B6BFF005A5AFF004A4AFF003131FF002929
      F7001821EF00000000000000000000000000000000000000000000000000BDE7
      B500B5E7AD00A5DE940094D673007BC6520063BD310052B5180042AD00001818
      1800949494000000000000000000000000000000000000000000000000007373
      E7006363E7005252DE004A4AD6003939D6002929CE002121C6001010C6001818
      180094949400000000000000000000000000000000000000000000000000BDE7
      B500B5E7AD00B5E7A500ADDE9C00A5DE8C009CD6840094D673008CCE6B0084CE
      5A007BC652000000000000000000000000000000000000000000000000009C9C
      FF009C9CFF009494FF008C8CFF007B7BFF006B6BFF005A5AFF004A4AFF003131
      FF002929F700000000000000000000000000000000000000000000000000BDE7
      B500BDE7B500B5E7A5009CDE8C008CCE6B0073C64A001010100084848400F7F7
      F700000000000000000000000000000000000000000000000000000000007B7B
      EF006B73E7006363DE005252DE004242D6003131CE001010100084848400F7F7
      F70000000000000000000000000000000000000000000000000000000000BDE7
      B500BDE7B500B5E7AD00B5E7A500ADDE9C00A5DE8C009CD6840094D673008CCE
      6B007BCE5A00000000000000000000000000000000000000000000000000ADAD
      FF00A5A5FF00A59CFF009C9CFF008C8CFF008484FF007373FF005A5AFF004A4A
      FF003131FF00000000000000000000000000000000000000000000000000BDE7
      B500BDE7B500BDE7AD00ADDE9C00080808006B6B6B00EFEFEF00000000000000
      0000000000000000000000000000000000000000000000000000000000008C8C
      EF007B7BEF006B6BE7005A5ADE00080808006B6B6B00EFEFEF00000000000000
      000000000000000000000000000000000000000000000000000000000000BDE7
      B500BDE7B500BDE7B500B5E7AD00B5E7A500ADDE9C00A5DE8C009CD6840094D6
      73008CCE6B00000000000000000000000000000000000000000000000000ADAD
      FF00ADADFF00ADADFF00A5A5FF009C9CFF009494FF008484FF007373FF006363
      FF004A4AFF00000000000000000000000000000000000000000000000000BDE7
      B500BDE7B5000000000063636300DEDEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009494
      F7008484EF000000000063636300DEDEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A4A4A00D6D6D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A4A4A00D6D6D60000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FC3FFC3FE10FE10FF00FF00FE10FE10FE187E187E10FE10FE007E007E10FE10F
      C183C183E10FE10FC0C3C0C3E10FE10FC063C063E10FE10FC663C663E10FE10F
      E667E667E10FE10FE3C7E3C7E10FE10FF00FF00FE10FE10FFC3FFC3FE10FE10F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      E007E007E3FFE3FFC003C003C0FFC0FFC003C003C03FC03FC003C003C00FC00F
      C003C003C003C003C003C003C003C003C003C003C003C003C003C003C007C007
      C003C003C00FC00FC003C003C03FC03FC003C003C0FFC0FFE007E007E3FFE3FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object timerCompsList: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = timerCompsListTimer
    Left = 472
  end
  object PopupMenuComps: TPopupMenu
    Left = 440
  end
  object ilEvents: TImageList
    Left = 504
    Top = 32
    Bitmap = {
      494C010107000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00D6CECE00A58C9400845A6B0073525A0073525A007B5263009C848C00CEBD
      C600F7F7F7000000000000000000000000000000000000000000000000000000
      000000000000EFEFEF00A5A5A500A5A5A500D6D6D600B5B5B50094949400DEDE
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B7B8400AD6B42005A5A52007B7B8400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00CEBD
      C600B59C9C00C6B5B500CEB5B500C6ADAD00BD9C9C00AD84840084636B008C6B
      7B00C6BDBD00FFFFFF0000000000000000000000000000000000000000000000
      0000A5A5A50063636300525252005A5A5A00635A5A008C848400636363006363
      63007B7B7B00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00AD6B4200FF5A3100FF7B2100FF9C0000C67342006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000EFDEDE00D6CE
      CE00E7E7E700E7DEDE00DED6D600D6BDBD00BDA5A500A56B6B00BD8C8C008C63
      6B00AD949C00F7EFF70000000000000000000000000000000000D6D6D6006363
      6300A5A5A500F7F7F700B5B5B5009C8C8C00A5848400B5B5B500E7E7E700BDBD
      BD006B6B6B006363630073737300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF007373730073737300AD6B
      4200D66B2100B5524A00FF841000FF8C1000FFAD2900DE8C52005A5A52007373
      7300737373007373730073737300FFFFFF000000000000000000E7D6D600EFEF
      EF00F7F7F700EFEFEF00DEDEDE00D6C6C600BD8C8C009C5A5A00B5848400B584
      8C00B5A5AD00F7F7F700000000000000000000000000C6C6C6009C9C9C00EFEF
      EF00F7F7F700EFEFEF00ADADAD0094949400636363006B6B6B008C8C8C00BDBD
      BD00EFEFEF00B5B5B50084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00E7DEDE00F7F7E700F7EF
      E700F7EFDE00F7EFDE00F7E7D600F7941800FF9C0000FFB55200B57B5A00FFCE
      AD00FFD69C00FFCEAD0073737300FFFFFF000000000000000000EFDEDE00EFEF
      EF00EFE7E700F7F7F700E7E7E700D6B5B500A56363009C525200B5848400B58C
      9400E7DEDE0000000000000000000000000000000000D6D6D600FFFFFF00F7F7
      F700DEDEDE00949494007B7B7B0094949400B5B5B500A5A5A500949494008C8C
      8C008C8C8C006B6B6B008C8C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00EFE7E700FFF7EF00FFF7
      E700F7EFE700F7EFDE00F7EFDE00F7EFD600FF9C0800FFA52900FFC68400B58C
      7300B57B5A00FFCEAD0073737300FFFFFF00000000000000000000000000E7D6
      D600CE9C8C00DEB5B500D6A5A500CE9494009C4242009C4242009C6B6B00C6B5
      B500F7F7F70000000000000000000000000000000000BDBDBD00DEDEDE00A5A5
      A5009C9C9C00CECECE00ADADAD008C8C8C0084848400848484009C9C9C00BDBD
      BD007BAD8C00636363008C8C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00EFEFEF00FFF7F700FFF7
      EF00F7F7E700EFE7DE00EFE7DE00EFE7DE00E7DEDE00FF940000FFB54A00FFCE
      9C00C6A58400FFCEAD0073737300FFFFFF00000000000000000000000000E7D6
      D600E7A56300FFB53900F7C67B00DEADA500BD6B6B00A5424200845A6300A584
      9400D6C6CE00FFFFFF0000000000000000000000000073737300A5A5A500DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00E7E7E700CECECE00BDBDBD009C9C9C008C8C
      8C006B847300636363008C8C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F7F7F700FFFFFF00FFFF
      F700FFF7F700FFF7F700FFF7F700FFF7F700FF7B2100FF841000FFA52100FFC6
      7B00F7E7CE00FFCEAD0073737300FFFFFF00000000000000000000000000DEC6
      C600EFA55A00FFB53100FFB53900FFB53900F7BD7300E7AD8C00B57B7B008C5A
      630094738400EFEFEF000000000000000000000000009C9C9C00E7E7E700DEDE
      DE00D6D6D600CECECE00D6D6D600CECECE00C6C6C600C6C6C600CECECE00D6D6
      D600CECECE0073737300B5B5B500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F7F7F700FFFFFF00FFFF
      FF00FFFFFF00FFF7F700FFF7EF00F7EFE700F7EFDE00F7EFDE00F7EFDE00F7EF
      DE00F7EFDE00FFCEAD0073737300FFFFFF00000000000000000000000000D6BD
      BD00EFAD5200FFBD4A00FFC65200FFC65200FFC65200FFBD4A00FFB54A00DE8C
      6B008C6B7300EFEFEF00000000000000000000000000ADADAD00D6D6D600C6C6
      C600ADADAD00A5A5A500CECECE00F7F7F700EFEFEF00EFEFEF00DEDEDE00BDBD
      BD00BDBDBD009494940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F7F7F700EFCEAD00C673
      6B00D6AD9400DEC6C600EFEFEF00EFEFEF00EFEFE700EFEFE700F7EFE700EFEF
      E700EFEFE700FFCEAD0073737300FFFFFF000000000000000000FFFFFF00CEAD
      AD00FFC65200FFCE6300FFCE6B00FFCE6B00FFCE6B00FFCE6300FFC65200E794
      5A009C7B8400F7EFF700000000000000000000000000F7F7F700CECECE00CECE
      CE00EFEFEF00B5B5B500BDBDBD00ADADAD00B5B5B500BDBDBD00BDBDBD00B5B5
      B500B5B5B5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00EF842100FF73
      2100FF633100BD523900FFFFFF00FFFFFF00FFF7F700FFF7EF00FFF7EF00CECE
      CE007394D600FFCEAD0073737300FFFFFF000000000000000000E7DEDE00E7C6
      B500FFCE6B00FFD67B00FFDE8400FFDE8400FFDE8400FFD67B00FFCE6B00CE84
      6300A58C9400F7EFF7000000000000000000000000000000000000000000C6BD
      BD00FFD6C600FFD6C600FFD6CE00EFDED600E7E7DE00E7E7E7008C8C8C00D6D6
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFB54200FFA5
      1000FF940800E77B1800FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F7007394
      D6006BADFF00FFCEBD0073737300FFFFFF000000000000000000DED6D600EFCE
      A500FFD67B00FFDE8C00FFE79C00FFE79C00FFE79C00FFE78C00FFD67B00BD84
      7300B59CA500F7F7F7000000000000000000000000000000000000000000E7CE
      C600FFDEBD00FFDEBD00FFDEBD00FFD6B500FFD6AD00846B6B00D6D6D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFD69C00F7A5
      5A00FFBD6300FFAD3100D66B0800F7F7F700F7F7F700EFEFEF00EFEFEF00EFEF
      EF00E7E7E700FFCEBD0073737300FFFFFF000000000000000000D6CECE00EFCE
      9C00FFDE8C00FFEF9C00FFF7AD00FFF7B500FFF7AD00FFEFA500FFDE8C00A573
      7300BDADB500FFF7F7000000000000000000000000000000000000000000D6B5
      AD00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDEC6007B6B6B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F7A55A00FFD69C00FFC67B00BD632900B5524A00C6734200DE843900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000D6CECE00B5A5
      8C00D6BD9400E7D6A500FFF7BD00FFFFCE00FFFFC600FFF7AD00FFE794009C6B
      7300C6BDBD00FFFFFF0000000000000000000000000000000000FFF7F700DEC6
      B500FFEFDE00FFEFDE00FFEFDE00FFEFDE00DEC6B500A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7A55A00FFE7B500FFDEA500FFC68C00BD6329009C5A3900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000D6D6D600D6D6
      D600CEC6C600D6C6C600C6ADAD00C6A5A500CEB59C00DEC69C00DEBD9400A57B
      8400D6CED600FFFFFF0000000000000000000000000000000000D6C6C600FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00ADA59C00EFEFEF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C69C9400FFF7C600FFEFBD00A5634200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000FFFFFF00E7E7E700E7DEDE00E7DEDE00DECECE00D6BDBD00C69C9C00E7D6
      D600FFFFFF0000000000000000000000000000000000FFF7F700DEC6C600FFF7
      F700E7DED600E7DED600E7DED600EFE7E700F7EFEF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CECECE00CECECE00CECECE00CECECE00CECECE00FFF7F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500AD8C73000000
      00000000000000000000000000000000000000000000EFD6CE008C4229008439
      2900843929008439290084392900843929008439290084392900843929008439
      290084392900843929008C312100000000000000000000000000000000000000
      000000000000000000008484B5008484BD008484B500BDBDD600000000000000
      000000000000000000000000000000000000000000000000000000000000FFF7
      DE00E7C6A500F7CEA500FFCEA500FFCEA500FFCEA500F7CEA500CEB59C00ADAD
      A500FFF7FF00000000000000000000000000000000000000000000000000F7DE
      C600EFC69C00DEB58C00E7B58C00E7B58C00E7B58C00DEB58C00B59C8400AD8C
      7300AD8C7300000000000000000000000000D6E7E70008ADD60000ADD60000AD
      D60000ADD60000ADD60000ADDE0000BDE70000B5DE0000ADD60000ADD60000AD
      D60000ADD60000B5E70039637300B58C8C00000000000000000000000000BDBD
      DE004242A500000084000000840000008400000084000000840000006B008484
      AD00000000000000000000000000000000000000000000000000FFE7C600FFD6
      AD00FFD6AD00FFE7BD00FFEFC600FFF7C600FFEFC600FFE7BD00FFD6AD00F7D6
      AD009C8C8C00F7F7F70000000000000000000000000000000000EFCEAD00E7BD
      9400E7BD9400F7CEA500FFD6B500FFD6B500F7D6AD00F7CEA500E7BD9400DEBD
      9400AD8C7300AD8C730000000000000000008CDEEF0000BDE70000CEFF0000CE
      FF0000CEFF0000D6FF0008B5D6003931420063ADC60000D6FF0000CEFF0000CE
      FF0000D6FF0000CEF700219CB500C68494000000000000000000BDBDE7000000
      8C0000008C000000940000009400000094000000940000008C00000084000000
      840042428C0000000000000000000000000000000000FFE7C600FFD6AD00FFDE
      B500FFEFC600FFDEBD00E7947300FFB58400FFB58C00FFE7BD00FFEFC600FFDE
      B500FFD6AD009C8C8C00000000000000000000000000EFCEAD00E7BD9400EFC6
      9C00FFD6AD00AD7B5A0084391800AD522100AD522900BD845A00FFD6AD00EFC6
      9C00E7BD9400AD8C73000000000000000000BDEFFF0000BDE70008D6FF0000D6
      FF0000D6FF0000D6FF00007B8C00210008004231420000E7FF0000D6FF0000D6
      FF0010EFFF0000D6FF004A5A6300E7C6CE0000000000BDBDEF00000094000000
      94002929AD000000A5000000A5000000A5000000A50000009C002121A5000000
      8C000000840042428400000000000000000000000000FFDEB500FFE7BD00FFEF
      CE00FFF7CE00FFFFDE00E7BDAD00FF845A00FFBD9400FFFFDE00FFF7CE00FFEF
      CE00FFE7BD00EFCEAD00CECECE000000000000000000E7C69C00EFCEA500FFD6
      B500FFDEB500FFE7CE00845A4A009C290000A55A3100FFE7CE00FFD6B500FFD6
      B500EFCEA500D6B59400AD8C7300000000000000000042D6EF0000CEF70008E7
      FF0000D6FF0000DEFF0000DEF700007B7B0008B5CE0000DEFF0000DEFF0000DE
      FF0010EFFF0008C6E700A563520000000000000000000808A5000000A5004A4A
      AD00000000006363CE000000AD000000B5000000AD005A5ABD00000000005252
      BD000000940000008C0084849C0000000000FFEFD600FFE7C600FFF7D600FFF7
      D600FFF7D600FFFFDE00EFC6B500FF8C5A00FFC69C00FFFFDE00FFF7D600FFF7
      D600FFF7CE00FFE7C600AD9C940000000000EFCEA500EFCEAD00FFDEBD00FFDE
      BD00FFDEBD00FFE7C6008C6352009C310000AD633900FFE7CE00FFDEBD00FFDE
      BD00FFDEB500EFCEAD00BD845A000000000000000000BDF7FF0000C6E70008E7
      FF0000DEFF0000DEFF0000E7FF00109CB50000E7FF0000DEFF0000DEFF0018F7
      FF0000DEFF00426B7300EFD6CE00000000008C8CD6000000A5000000B5006B6B
      9400F7F7EF00000000006363D6000000B5006363C600FFFFF700FFFFF7007B7B
      B5000000A5000000940000005A0000000000FFE7BD00FFEFD600FFFFDE00FFFF
      DE00FFFFDE00FFFFE700EFC6B500FF8C5A00FFC69C00FFFFE700FFFFD600FFFF
      DE00FFFFDE00FFEFD600DEC6AD00DEDED600EFCEA500F7D6BD00FFE7C600FFE7
      C600FFE7C600FFE7CE008C6352009C310000B5633900FFE7CE00FFE7BD00FFE7
      C600FFE7C600EFCEA500D6B59400AD8C7300000000000000000042D6EF0000D6
      F70008EFFF0000E7FF0000EFFF00314A520000D6EF0000E7FF0000E7FF0010EF
      FF0008CEE700A563520000000000000000005A5ACE000000B5000000C6000000
      CE005A5A9400F7F7EF0000000000A5A5EF0000000000FFFFF7007373AD000000
      BD000000B5000000A50000008C00C6C6CE00FFE7C600FFF7DE00FFFFE700FFFF
      E700FFFFE700FFFFEF00EFC6BD00FF8C5A00FFC69C00FFFFEF00FFFFDE00FFFF
      DE00FFFFEF00FFFFDE00EFD6B500DEDED600EFCEAD00F7DEC600FFEFCE00FFE7
      CE00FFE7CE00FFE7CE008C635A009C310000B5633900FFE7CE00FFE7C600FFE7
      C600FFEFD600FFEFD600D6B59400AD8C73000000000000000000BDF7FF0000CE
      E70008EFFF0000E7FF0000F7FF005229310010B5C60000E7FF0010F7FF0000E7
      FF00426B7300EFD6CE0000000000000000001818BD000000C6000000CE000000
      D6000000CE007373AD000000000000000000000000008484C6000000C6000000
      C6000000BD000000AD000000A5008C8C9400FFE7CE00FFFFE700FFFFEF00FFFF
      E700FFFFEF00FFFFF700EFAD9C00FF8C5A00FFC6A500FFFFF700FFFFE700FFFF
      E700FFFFEF00FFFFEF00EFD6BD00DEDED600EFCEB500FFE7CE00FFEFD600FFE7
      CE00FFEFD600FFE7CE008C4A39009C310000AD634200FFE7CE00FFE7CE00FFE7
      CE00FFEFD600FFEFD600EFCEA500AD8C730000000000000000000000000042DE
      EF0000DEF70008F7FF0000D6E70052182100298C9C0000F7FF0010F7FF0008D6
      E700A56352000000000000000000000000001010C6000808D6000808DE000000
      DE000000D6005A5ACE000000000000000000000000005A5ADE000000CE000000
      CE000000CE000000BD000000B5008C8C9400FFEFCE00FFFFEF00FFFFF700FFFF
      EF00FFFFF700EFD6C600E7A59400DE948400FFCEB500FFFFF700FFFFEF00FFFF
      EF0000000000FFFFF700EFD6BD00DEDED600EFD6B500FFEFD600FFEFDE00FFEF
      D600FFEFDE008C736300844231007B392100A56B5200FFE7CE00FFEFD600FFEF
      D600FFEFDE00FFF7DE00BDA59400AD8C7300000000000000000000000000BDF7
      FF0000D6EF0008F7FF0000949C003100080031394A0010FFFF0000F7FF004273
      7300EFCEC6000000000000000000000000003131DE001010E7001010EF000000
      EF005A5AD600FFFFEF00FFFFF700C6C6D600F7F7F700000000006363E7000000
      D6000808D6000808C6000000B5009C9CA500FFEFCE00FFFFF70000000000FFFF
      F700FFFFF70000000000000000000000000000000000FFFFF700FFFFF700FFFF
      F7000000000000000000DEC6B50000000000EFD6B500FFEFDE00FFF7DE00FFEF
      DE00FFEFDE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFEFDE00FFEFDE00FFEF
      DE00FFF7DE00FFF7E700BDA59400AD8C73000000000000000000000000000000
      000042E7EF0000EFF700087B7B00210008003121290010FFFF0000E7EF009C5A
      5A00000000000000000000000000000000008C8CEF001818EF002121FF006363
      DE00FFFFEF00F7F7EF007373B5000000DE006B6BA500EFEFEF00000000006B6B
      E7000808E7000808CE001010A50000000000FFF7F70000000000000000000000
      00000000000000000000F7BDAD00FF8C6300FFEFD60000000000000000000000
      00000000000000000000FFEFE70000000000F7DEC600FFEFE700FFF7DE00FFF7
      DE00FFEFDE00FFF7DE00945A4A009C310800D6AD9400FFEFDE00FFEFDE00FFF7
      DE00FFF7DE00FFF7E700AD8C7300000000000000000000000000000000000000
      0000BDF7FF0000E7EF0008E7EF00006B730010BDBD0000FFFF00397B8400E7CE
      C60000000000000000000000000000000000CECEFF002929F7003131FF007B7B
      BD00EFEFDE006B6BB5000000EF000000E7000000E7005A5A9400DEDECE006B6B
      C6001010EF001010D6005A5AB5000000000000000000FFF7EF00000000000000
      00000000000000000000BD847300E7735A00FFD6C60000000000000000000000
      000000000000FFE7DE00000000000000000000000000FFE7CE00FFF7DE00FFF7
      DE00FFF7DE00FFEFDE005A29180084180000AD736300FFEFDE00FFF7DE00FFF7
      DE00FFF7DE00BDA59400DEBD9400000000000000000000000000000000000000
      00000000000042E7EF0000F7F70008FFFF0010FFFF0000EFEF009C635A000000
      000000000000000000000000000000000000000000006363FF004242FF005252
      FF006363BD003131FF001818FF000808FF001010FF002121FF004A4ABD002929
      FF002121F7002121CE00DEDEE700000000000000000000000000000000000000
      0000000000000000000000000000E7DED6000000000000000000000000000000
      00000000000000000000000000000000000000000000F7DEC600FFE7CE00FFF7
      DE00FFF7DE00FFF7DE00D6D6D600A59C9400F7F7EF00FFF7DE00FFF7DE00FFF7
      DE00F7E7E700DEBD940000000000000000000000000000000000000000000000
      000000000000BDF7FF0000E7EF0031FFFF0008FFFF0039848400E7CEC6000000
      00000000000000000000000000000000000000000000000000006363FF005A5A
      FF008484FF008484FF007373FF006363FF005A5AFF005A5AFF005252FF003939
      FF002121EF00CECEEF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      EF00000000000000000000000000000000000000000000000000F7DEC600F7E7
      E700FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00F7E7
      D600DEBD94000000000000000000000000000000000000000000000000000000
      0000000000000000000039F7F70008FFFF0000EFEF00A5736300000000000000
      0000000000000000000000000000000000000000000000000000000000006B6B
      FF006363FF008C8CFF00A5A5FF009C9CFF008484FF006B6BFF004A4AFF004242
      EF00D6D6F7000000000000000000000000000000000000000000000000000000
      000000000000FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFF7F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7E7D600F7E7D600F7E7D600F7E7CE00F7E7CE00F7E7CE00F7E7CE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084FFFF00BDCEBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CECEFF00ADADFF006B6BFF006B6BFF006363FF008484FF00A5A5FF000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E007F80F00000000C003F0030000
      0000C003C00100000000C003800100000000C007800100000000E00780010000
      0000E003800100000000E003800100000000E003800300000000C00380070000
      0000C003E00F00000000C003E01F00000000C003E03F00000000C003C03F0000
      0000C003C03F00000000F007807F0000F81FF81F8001FC3FE007E0070000E00F
      C003C0030000C007800380030000800380018001800188210001000180010401
      00000000C003028000000000C003038000000000E007038000080000E0070040
      278D0000F00F00217C7D0001F00F0001BC7B8001F81F8001FEFF8003F81FC003
      FFEFC007FC3FE007F81FF01FFE7FF01F00000000000000000000000000000000
      000000000000}
  end
  object PopupMenuTray: TPopupMenu
    Left = 440
    Top = 32
    object cmnRestore: TMenuItem
      Caption = 'Restore'
      OnClick = cmnRestoreClick
    end
  end
  object tmrIntDate: TTimer
    OnTimer = tmrIntDateTimer
    Left = 576
  end
  object tmrShowFormKillTasks: TTimer
    Enabled = False
    Interval = 20
    OnTimer = tmrShowFormKillTasksTimer
    Left = 472
    Top = 32
  end
  object dsComps: TDataSource
    DataSet = cdsComps
    Left = 504
  end
  object cdsComps: TADODataSet
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'Ping'
        DataType = ftInteger
      end
      item
        Name = 'Computer'
        DataType = ftInteger
      end
      item
        Name = 'State'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Tarif'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Balance'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Start'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'End'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Time'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TimeLeft'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Printed'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Traffic'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Client'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Selection'
        DataType = ftInteger
      end>
    Parameters = <>
    StoreDefs = True
    Left = 536
  end
  object ilReports: TImageList
    Left = 536
    Top = 34
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000636363000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006363630039ADF7006363630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006363630039ADF7006363630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006363630039ADF7006363630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000636363006363630039ADF7006363630063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006363630063BDF70052B5F70039ADF70063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063636300A5DEFF0039ADF70063BDF70052B5F70039ADF700636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      63006BC6F70039ADF700A5DEFF0039ADF70063BDF70052B5F70039ADF7006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      6300A5DEFF006BC6F70039ADF700A5DEFF0039ADF70063BDF70052B5F7006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006363630039AD
      F7006BC6F700A5DEFF006BC6F70039ADF700A5DEFF0039ADF70039ADF70039AD
      F700636363000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063636300A5DE
      FF0039ADF700636363006363630063636300636363006363630039ADF70039AD
      F700636363000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000636363006363
      63006363630063636300ADB5BD00ADB5BD00ADB5BD0063636300636363006363
      6300636363000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000636363006363
      6300CED6DE00CED6DE00ADB5BD00CED6DE00ADB5BD00ADB5BD00ADB5BD006363
      6300636363000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000636363006363630063636300636363006363630063636300636363000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FEFF000000000000
      FC7F000000000000FC7F000000000000FC7F000000000000F83F000000000000
      F83F000000000000F01F000000000000E00F000000000000E00F000000000000
      C007000000000000C007000000000000C007000000000000C007000000000000
      F01F000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
  object ColorDialog: TColorDialog
    Left = 576
    Top = 32
  end
  object tmrFileSynchronization: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = tmrFileSynchronizationTimer
    Left = 608
  end
  object tmrCyclicCompAction: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrCyclicCompActionTimer
    Left = 608
    Top = 32
  end
  object timerGSessionsLoad: TTimer
    Interval = 17000
    OnTimer = timerGSessionsLoadTimer
    Left = 344
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 374
    Top = 32
  end
  object bsPolyglotTranslator1: TbsPolyglotTranslator
    Manager = dmMain.bsPolyglotManager
    Left = 288
  end
  object PopupMenuShutdown: TPopupMenu
    Left = 344
    Top = 32
    object cmnShutdownAll: TMenuItem
      Caption = #1042#1099#1082#1083#1102#1095#1080#1090#1100' '#1074#1089#1077
      OnClick = cmnShutdownAllClick
    end
    object cmnShutdownFree: TMenuItem
      Caption = #1042#1099#1082#1083#1102#1095#1080#1090#1100' '#1089#1074#1086#1073#1086#1076#1085#1099#1077
      OnClick = cmnShutdownFreeClick
    end
  end
end
