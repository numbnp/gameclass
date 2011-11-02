object formMain: TformMain
  Left = 357
  Top = 473
  AlphaBlendValue = 0
  AutoScroll = False
  BiDiMode = bdRightToLeftNoAlign
  BorderWidth = 5
  Caption = 's'
  ClientHeight = 583
  ClientWidth = 951
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
    Width = 951
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object tbActions: TToolBar
      Left = 0
      Top = 0
      Width = 829
      Height = 57
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
      object ToolButton2: TToolButton
        Left = 220
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object tbCompLogoff: TToolButton
        Left = 228
        Top = 0
        Caption = 'Logoff'
        DropdownMenu = PopupMenuLogoff
        ImageIndex = 10
        Style = tbsDropDown
        OnClick = tbCompLogoffClick
      end
      object tbCompReset: TToolButton
        Left = 296
        Top = 0
        Caption = 'Reset'
        DropdownMenu = PopupMenuReset
        ImageIndex = 7
        Style = tbsDropDown
        OnClick = tbCompResetClick
      end
      object tbCompShutdown: TToolButton
        Left = 364
        Top = 0
        Caption = 'Shutdown'
        DropdownMenu = PopupMenuShutdown
        ImageIndex = 8
        Style = tbsDropDown
        OnClick = tbCompShutdownClick
      end
      object tbCompWakeUp: TToolButton
        Left = 432
        Top = 0
        Caption = 'Wakeup'
        DropdownMenu = PopupMenuWakeup
        ImageIndex = 9
        Style = tbsDropDown
        OnClick = tbCompWakeUpClick
      end
      object ToolButton9: TToolButton
        Left = 500
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object tbSideline: TToolButton
        Left = 508
        Top = 0
        Caption = #1059#1089#1083#1091#1075#1080
        ImageIndex = 6
        OnClick = tbSidelineClick
      end
      object ToolButton1: TToolButton
        Left = 563
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 5
        Style = tbsSeparator
      end
    end
    object pnlTimer: TPanel
      Left = 829
      Top = 0
      Width = 122
      Height = 57
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
    Top = 57
    Width = 951
    Height = 526
    ActivePage = tabComputers
    Align = alClient
    TabOrder = 1
    OnChange = PageControlChange
    object tabComputers: TTabSheet
      Caption = 'Computers'
      object splitComps: TSplitter
        Left = 0
        Top = 366
        Width = 943
        Height = 6
        Cursor = crVSplit
        Align = alBottom
      end
      object gridComps: TDBGridEh
        Left = 0
        Top = 0
        Width = 943
        Height = 366
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
        OnGetCellParams = gridCompsGetCellParams
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
        Top = 372
        Width = 943
        Height = 126
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object lvConsole: TListView
          Left = 0
          Top = 0
          Width = 943
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
          Left = 943
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
        Width = 943
        Height = 498
        Align = alClient
        TabOrder = 0
        inherited Panel1: TPanel
          Top = 457
          Width = 943
          DesignSize = (
            943
            41)
          inherited edtMessage: TEdit
            Width = 832
          end
          inherited btnSend: TButton
            Left = 854
            OnClick = frameMessagesbtnSendClick
          end
        end
        inherited Panel2: TPanel
          Width = 943
          Height = 457
          inherited memMessages: TMemo
            Width = 781
            Height = 455
            Lines.Strings = ()
          end
          inherited Panel3: TPanel
            Height = 455
            inherited lvUsers: TListView
              Height = 453
            end
          end
        end
      end
    end
  end
  object menuMain: TMainMenu
    Left = 440
    Top = 168
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
        object mnuLogoff: TMenuItem
          Caption = #1042#1099#1081#1090#1080' '#1080#1079' '#1089#1080#1089#1090#1077#1084#1099
          OnClick = mnuLogoffClick
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
        Visible = False
        OnClick = mnuFontClick
      end
      object mnuTableOpt: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1074#1085#1077#1096#1085#1077#1075#1086' '#1074#1080#1076#1072
        Enabled = False
        OnClick = mnuTableOptClick
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
        Visible = False
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
    Left = 472
    Top = 168
    Bitmap = {
      494C01010B000E0004001F001F0000000000FF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFF00FCFCFF00F9F9
      FE00F1F1FC00395AE100395AE100385BE1003E61E2004668E400476CE6004269
      E8003763E8002859E8001A4FE7001249E7000B43E700063DE600E7E7FB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFF00FCFCFF00F9F9FE00F1F1
      FC002C2C34003131390033333B0033333C0034343D0035353D0034343D003535
      3E0035353D0034343D0033333C003030380029293200E7E7FB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FEFEFF00FCFCFF00F9F9FE00F1F1FC0064B2
      640050A8500064B2640050A8500064B2640050A8500064B2640050A8500064B2
      640050A8500064B2640050A85000EAEAFB00E7E7FB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFF00F9F9FF00F3F3FD001237C900193DCA002144CC002446
      CD002445CC002245CD002146CD001D44CF001942D2001440D3000F3DD2000A39
      D3000335D300002FCF000028BD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFF00F9F9FF00F3F3FD0032364D003131380034343C0035353E003535
      3E0036363F0035353E0035353E0036363F0036363F0036363F0035353E003232
      3B002B2B33003436430000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FDFD
      FF00F9F9FF00D7EDDF004185450008620F000E65150013671A0013681A001067
      170007620E0004630B0007680F0007670F000767100003650C0002620C003282
      3A00B8DAD0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFF00FBFBFF00F6F6FD002F52
      E1001B42DB00274BDE003052DF003357E0003154DF002A50DF00244EDF001D4B
      E1001949E200174AE400164AE5001046E600073EE4000238E100002ECE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FEFEFF00FBFBFF00F6F6FD00292931002F2F
      3800303038002B2B320033333B0035353E0034343D0033333B0033333C003535
      3D0034343D003030380028282F001E1E230027272D0025252A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFF00FBFBFF00F6F6FD003D8C4200117A11002088
      2000288C2800298C290022882200298C29007FB67F006DB76D00068E0600018D
      0100078F070003900300008D0000067E06002F86340000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CEC1C600B29EA700A28993009C838D009C838E00AF99
      A100D0C3CA00F9F9FF00EFEFFC00385AE200264BE0003255E2003B5DE4003A5C
      E4004768E600849BEE00C2CDF700D3DCFB00BCCAF8007292F1002459EA000E48
      EA000C45E900063DE5000231D300000000000000000000000000000000000000
      000000000000CEC1C600B29EA700A28993009C838D009C838E00AF99A100D0C3
      CA00F9F9FF00EFEFFC002E2F370034343D0035353D0036384700363745003951
      4D003E5B3F00527A53004F7C4D004D7A4E003F66400038563E00353642003536
      4200303037002D2D350000000000000000000000000000000000000000000000
      0000CEC1C600B29EA700A28993009C838D009C838E00AF99A100D0C3CA00F9F9
      FF00EFEFFC000C7C1200218E2100399C3900329A3200299529002F982F003AA3
      3A00C0E2C000BEE5BE0028AC28000AA50A0000A5000001AD01000CAF0C00028E
      020001630A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B49DA3009C767B009F7E8200A988
      8A00AB858800A8818500A67D8100A37D8200B9A2A700D8CFD800D0CADC004161
      E4002F53E1003C5EE4004061E4005E7AE800D4DCF900F8F9FE00D5DEFA00C3D0
      F800D5DEFA00F8FAFF00C2D1F9002E61EC000A45EA000A41E6000636D3000000
      0000000000000000000000000000B49DA3009C767B009F7E8200A9888A00AB85
      8800A8818500A67D8100A37D8200B9A2A700D8CFD800D0CADC0031313A003535
      3E0036363F00363744003B534000D4DCF900F8F9FE00D5DEFA00C3D0F800D5DE
      FA00F8FAFF00C2D1F900395937003636410034343D0032323B00000000000000
      00000000000000000000B49DA3009C767B009F7E8200A9888A00AB858800A881
      8500A67D8100A37D8200B9A2A700D8CFD800D8CEDF00118318002D982D00389C
      380071B871008EC88E003E9F3E0030A53000CFEFCF00CEEACE001CA71C001CAC
      1C0077CD770045C4450003AE03000B8F0B000963120000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A98B
      9000BEA6A700D5CACA00D8D1D100DAD0D000D9CCCC00DAC9C900D0BABB00D4B8
      B800DFCCCE00E5DCE500CBC2DC004967E400385BE3004362E4005571E600D7DE
      F900E6EAFC008097EE004268E7002251E4003462E8007091F000E6ECFD00C1D0
      FA001C52EA000E44E6000C3BD300000000000000000000000000A98B9000BEA6
      A700D5CACA00D8D1D100DAD0D000D9CCCC00DAC9C900D0BABB00D4B8B800DFCC
      CE00E5DCE500CBC2DC0033333B0036363F0036363F0038464400D7DEF900E6EA
      FC00548A6B0041894A003E8B3F004088400048805100E6ECFD00C1D0FA003C47
      49003D3D490034343C00000000000000000000000000A98B9000BEA6A700D5CA
      CA00D8D1D100DAD0D000D9CCCC00DAC9C900D0BABB00D4B8B800DFCCCE00E5DC
      E500D8CBDC001B8B22003AA03A00379B370094C99400F6FBF600AAD3AA004DAD
      4D00B6E1B600B0E4B00039B839009ADB9A00F1FAF1006DD26D0000A700000D8E
      0D000A6513000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BC9FA100DCD7D700E3E6E500E0E0E000DEDCDC00DCD7
      D700DAD1D100D5C9C900BEA1A100B79D9D00CCB6B800E0D7E400CDC6E6005571
      E6004060E4004665E50096A7F100FBFBFE007F95ED003559E3006481EB00D2DB
      F900547AEB001248E5006B8DF100FCFCFF006B8DF1001044E4001440D3000000
      000000000000BC9FA100DCD7D700E3E6E500E0E0E000DEDCDC00DCD7D700DAD1
      D100D5C9C900BEA1A100B79D9D00CCB6B800E0D7E400CDC6E60034343C003636
      3F0036363F003B4F4100FBFBFE0043594F0041982A0042B12000E1E6FB0042B1
      200042AE21003F6D3900FCFCFF003F5347003E3E4B0034343C00000000000000
      0000BC9FA100DCD7D700E3E6E500E0E0E000DEDCDC00DCD7D700DAD1D100D5C9
      C900BEA1A100B79D9D00CCB6B800E0D7E400DAC9DA00208C27003A9D3A0042A1
      42004DA64D00AFD7AF0000000000A0D2A0004DAF4D0045B2450097D697000000
      000099DA990019AF190000AA0000048B04000E65170000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CAB3B200DAD6D500E9EB
      EB00EAEAEA00EAEAEA00E5E6E600E0DFDF00DDD9D900CDB9B900D2BCBC00CAC2
      C300C2B6BB00D6CCDD00C6C0E300637CE8004968E5004967E500D0D7F800D3DA
      F900506DE6003D60E400738DEC00000000006586ED001C4EE5002757E800D0DB
      F900B7C7F7001143E2001A44D30000000000CAB3B200DAD6D500E9EBEB00EAEA
      EA00EAEAEA00E5E6E600E0DFDF00DDD9D900CDB9B900D2BCBC00CAC2C300C2B6
      BB00D6CCDD00C6C0E30034343D0036363F0036363F00546F5900D3DAF9003E5F
      440041A6240042B12000E1E6FB0042B1200042AF21003F703700D0DBF900506D
      56003E3E4B0034343D0000000000CAB3B200DAD6D500E9EBEB00EAEAEA00EAEA
      EA00E5E6E600E0DFDF00DDD9D900CDB9B900D2BCBC00CAC2C300C2B6BB00D6CC
      DD00DCCAD90029932E0046A2460058AC580049A449005AAD5A00A3D1A3007FBF
      7F002E9A2E00269D260072C272008ED38E002EB22E0011A8110015A715000B8D
      0B0012661B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CCB5B500E9ECEC00EDEDED00F3F3F300F3F3F300EBEBEB00E3E3
      E300DFE0E000C4A8A800DAC6C600C3AAAA00C8B5B900D8CEDF00C4BEE4006A82
      E900506DE6004E6AE700E0E5FA00C0CAF6004664E5004061E4007088EC000000
      00006281EA00204DE4001445E400BAC9F700D0DAFA001443E1002047D1000000
      0000CCB5B500E9ECEC00EDEDED00F3F3F300F3F3F300EBEBEB00E3E3E300DFE0
      E000C4A8A800DAC6C600C3AAAA00C8B5B900D8CEDF00C4BEE40034343C003636
      3F0036363F005B785C00C0CAF6003E63420042AA230042B12000E1E6FB0042B1
      200042AD22003E693A00BAC9F700577C5A003E3E4A0035353E0000000000CCB5
      B500E9ECEC00EDEDED00F3F3F300F3F3F300EBEBEB00E3E3E300DFE0E000C4A8
      A800DAC6C600C3AAAA00C8B5B900D8CEDF00D8CEDF0025952B0096CC9600CCE5
      CC00D2E9D200C2E1C2005BAD5B00359935003F9F3F003AA53A001EA11E003BAF
      3B00B1E3B100C3EAC300B7E1B70078B8780007610F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D8C1C100E7E8E800F3F5
      F500FBFBFC00FBFCFD00F0F1F100E6E7E700DFDDDD00C6A2A200D7BABA00BD94
      9400CDB1B700D8CBDC00C4BBE5006F86E9005973E8005571E700D3DAF900D1D8
      F800506CE5003D5DE300718AEB00000000006481EA001C48E2002550E300CED7
      F900BCC9F7001B46E0002549D00000000000D8C1C100E7E8E800F3F5F500FBFB
      FC00FBFCFD00F0F1F100E6E7E700DFDDDD00C6A2A200D7BABA00BD949400CDB1
      B700D8CBDC00C4BBE50034343D0036363F0036363F0049624B00D1D8F8003F60
      480041A6240042B12000E1E6FB0042B1200041A226003C594300CED7F9006084
      6C003C3C480035353E0000000000D8C1C100E7E8E800F3F5F500FBFBFC00FBFC
      FD00F0F1F100E6E7E700DFDDDD00C6A2A200D7BABA00BD949400CDB1B700D8CB
      DC00D8CBDC0027952C0098CC9800CEE6CE00D4EAD400C2E0C2005AAD5A00359A
      35003FA13F0038A138001B991B003AA93A00B2DCB200C2E5C200BBDEBB0078B9
      780007610F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DAC9C900F2F3F300EBD7D700E9D7DA00EAE3E300E8EC
      EC00D9CDCD00CEA9A900CEA4A400BF8C8D00D0ACB200DAC9DA00C5BBE3006F86
      E900617AE800607AE800A4B3F200F9FAFE007C91EC003656E100637DE800D1D9
      F9005472E700133EDE006883EB00FBFCFE007991ED00234BDF00284AD0000000
      000000000000DAC9C900F2F3F300EBD7D700E9D7DA00EAE3E300E8ECEC00D9CD
      CD00CEA9A900CEA4A400BF8C8D00D0ACB200DAC9DA00C5BBE30032323B003636
      3E0036363F003D524300F9FAFE00475E5A0040982C0042B12000E1E6FB0042B0
      20003E833600414E5800FBFCFE003E5946003A3A450034343D00000000000000
      0000DAC9C900F2F3F300EBD7D700E9D7DA00EAE3E300E8ECEC00D9CDCD00CEA9
      A900CEA4A400BF8C8D00D0ACB200DAC9DA00DAC9DA00389A3D0056AB560064B2
      640050A850005CAE5C00A3D1A3007EBE7E002C972C00249224006EB76E008DCB
      8D0031A1310012961200239A2300148D140014661C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0E4E400DFCA
      CB00CB999900CC8C8700D3AEBA00D5B8BD00C9A4A500CC9D9D00C98A8A00C883
      8400D6A8AD00DCCAD900C9BFE2006C84E9006982EA006C86EB007088EB00DFE5
      FA00E1E6FB007B8FEC00415FE300274BE0003457E3006A83EA00E1E6FB00CDD6
      F8003458E3002B51E0002A4BD0000000000000000000F0E4E400DFCACB00CB99
      9900CC8C8700D3AEBA00D5B8BD00C9A4A500CC9D9D00C98A8A00C8838400D6A8
      AD00DCCAD900C9BFE20032323A0035353E0035353E0039454400DFE5FA00E1E6
      FB0050716A00407451003E7948003E794E004A776300E1E6FB00CDD6F800374B
      4D0035353E0035353E000000000000000000F0E4E400DFCACB00CB999900CC8C
      8700D3AEBA00D5B8BD00C9A4A500CC9D9D00C98A8A00C8838400D6A8AD00DCCA
      D900DCCAD9003F9B44005BAE5B005CAF5C0059AC5900B2D9B200000000009DCE
      9D004DA74D0046A2460097C99700000000009CCF9C0022952200189118001C89
      1C0013671B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E4CCCD00C6939500F9BA5F00F0B97B00DEAB
      9400CEA0A500C7848C00C3696A00CE797A00DAA2A600E0CAD700D3CAE6006C85
      E900738BEB00778FEC006881EA00798FEC00E1E6FB00F5F6FE00C9D2F700B8C4
      F500CBD3F800F4F6FE00D1D9F8004867E500294EE2003053E0002B4BCE000000
      00000000000000000000E4CCCD00C6939500F9BA5F00F0B97B00DEAB9400CEA0
      A500C7848C00C3696A00CE797A00DAA2A600E0CAD700D3CAE600303039003535
      3E0035353E0036363F00384A3A00E1E6FB00F5F6FE00C9D2F700B8C4F500CBD3
      F800F4F6FE00D1D9F800395937003636400035353D0035353D00000000000000
      000000000000E4CCCD00C6939500F9BA5F00F0B97B00DEAB9400CEA0A500C784
      8C00C3696A00CE797A00DAA2A600E0CAD700D8CBDC00429E470064B2640059AD
      5900A7D4A700FAFDFA00ADD5AD0050A85000B8DCB800B3D9B3003F9E3F00A1CF
      A100F6FBF60082C28200178D1700258B25001167190000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E2CA
      CB00CC8F7C00FC9F0E00FFAA1B00FFBC4700F7BA6200E9AF8B00D6999800D587
      8C00D79BA000E3CBD400DAD6EA007189EA008399EE008A9EEE007B92EC006881
      EA007088EB00A2B1F200D3DAF900DEE4FA00D0D7F80092A4F0004F6CE600385A
      E300395BE3003355E0002949CE00000000000000000000000000E2CACB00CC8F
      7C00FC9F0E00FFAA1B00FFBC4700F7BA6200E9AF8B00D6999800D5878C00D79B
      A000E3CBD400DAD6EA003D3D490035353E0034343D0036363F0036363F003B49
      48003D524100435D440058745C00405544003F4E490038474000363743003637
      42003131390032323A00000000000000000000000000E2CACB00CC8F7C00FC9F
      0E00FFAA1B00FFBC4700F7BA6200E9AF8B00D6999800D5878C00D79BA000E3CB
      D400DAC9DA0049A34E0071BB71006CB76C0093CA9300A4D3A40053A9530044A2
      4400D4E9D400D2E9D20032993200369B36008CC78C0064B4640025932500298D
      29000E6516000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEC3C500D08E7100FCA72500FFAE2900FFAD
      2600FFB12C00FFB83F00FAB75100ECBC8A00E5C1B700E8D4DC00E0D1E1007D93
      EB0094A6F1009BACF100889CEE00788FEC006E87EA00657FE9005C77E7005874
      E7005672E7005672E7005471E8004D6CE6004463E5003658E1002446CE000000
      00000000000000000000DEC3C500D08E7100FCA72500FFAE2900FFAD2600FFB1
      2C00FFB83F00FAB75100ECBC8A00E5C1B700E8D4DC00E0D1E1003C3C49003636
      3F0036363F0036363F0036363F0036363F003C3C47003D3D4A003E3E4B003E3E
      4B0035353E0036363F0035353E0033333C0034343D002A2A3100000000000000
      000000000000DEC3C500D08E7100FCA72500FFAE2900FFAD2600FFB12C00FFB8
      3F00FAB75100ECBC8A00E5C1B700E8D4DC00DCCAD90050A5540082C8820086C8
      86006DB76D0059AC59005BAD5B0065B36500CFE7CF00CBE5CB0056AB56003FA0
      3F00359B3500379C370042A14200298D29000C64130000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D8BC
      C000DA9B6500FDAF3300FFB43600FFB83D00FFB83F00FFB83E00FFB93D00FFC1
      5300FCCD7D00F6E2C300EDDDDC008B9EED00879CEF0090A3F0007D93ED006E87
      EA006982EA00657DE900607BE8005E79E8005A75E8005572E700516EE7004969
      E5003E60E4003053E0001F42CC00000000000000000000000000D8BCC000DA9B
      6500FDAF3300FFB43600FFB83D00FFB83F00FFB83E00FFB93D00FFC15300FCCD
      7D00F6E2C300EDDDDC00C2BCBA003C3C490036363F0036363F0036363F003636
      3F0036363F0036363F0035353E0035353E0035353E0036363F0035353E003434
      3D002F2F37002F396700000000000000000000000000D8BCC000DA9B6500FDAF
      3300FFB43600FFB83D00FFB83F00FFB83E00FFB93D00FFC15300FCCD7D00F6E2
      C300EDDDDC0074B8770076C076007CC57C0071BA710065B365005CAE5C005DAE
      5D009ACD9A0098CB980053A953004BA54B004CA64C0045A24500379A37001E7E
      1E00418746000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CBAAB000EAAA5D00FFB83F00FFBC4700FFBD
      4A00FFBF4E00FFC15000FFC15100FFC45C00FFCE7700FDDCA200FAE8CC00E6DF
      D9008B9EED007C93EB00718AEA006C85EA006E86EA007188EA007289EA006F87
      EA006880E9005B76E700506EE6004866E4004162E300395AE100DFDFF9000000
      00000000000000000000CBAAB000EAAA5D00FFB83F00FFBC4700FFBD4A00FFBF
      4E00FFC15000FFC15100FFC45C00FFCE7700FDDCA200FAE8CC00E6DFD900DECC
      BE003B3B470036363F0036363F0036363E0035353E0035353E0034343D003535
      3D0035353E0036363F0035353E0034343C003B3B4800DFDFF900000000000000
      000000000000CBAAB000EAAA5D00FFB83F00FFBC4700FFBD4A00FFBF4E00FFC1
      5000FFC15100FFC45C00FFCE7700FDDCA200FAE8CC00D6ECDC0070B6730048A3
      4D00409D45003F9C44003E9B44003B9A41003496390031973600329C38003197
      37002E91340025912C0016831D0036893C00D0E9D90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E8DBDB00C09C
      A400F1B45B00FFC14D00FFC25400FFC55A00FFC75D00FFC85F00FFC85F00FFCA
      6600FFD07600FFD68D00FCE1B000F9E8CE00F3DFCE00E1D1E100DCD7EC00D2D0
      EA00C9C2E600BBB4DD00BBB2DD00BAB2E000BDB3E500BEB5E100BDB3DC00C1BC
      DD00DEDEF600E7E7F900EFEFFC000000000000000000E8DBDB00C09CA400F1B4
      5B00FFC14D00FFC25400FFC55A00FFC75D00FFC85F00FFC85F00FFCA6600FFD0
      7600FFD68D00FCE1B000F9E8CE00F3DFCE00E1D1E100DCD7EC00D2D0EA00C9C2
      E600BBB4DD00BBB2DD00BAB2E000BDB3E500BEB5E100BDB3DC00C1BCDD00DEDE
      F600E7E7F900EFEFFC000000000000000000E8DBDB00C09CA400F1B45B00FFC1
      4D00FFC25400FFC55A00FFC75D00FFC85F00FFC85F00FFCA6600FFD07600FFD6
      8D00FCE1B000F9E8CE00F3DFCE00F1F1FD00F5F5FE00F8F8FE00F5F5FE00F8F8
      FE00F1F1FD00F5F5FE00F8F8FE00F1F1FD00F5F5FE00F8F8FE00F1F1FD00F5F5
      FE00F8F8FE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E2D4D500C39E9900F4BC5D00FFC85A00FFC96300FFCC
      6800FFCE6A00FFCF6C00FFCF6C00FFD07000FFD27700FFD58300FED99200FCDF
      A800F3DBC100EBDAE200EBE4EF00E6E0EC00DFDAE800D6CADC00D4C9DD00D2C8
      DD00D2C6DC00D2C7DC00D5C8DB00D4CDDD00F1F1FD00F5F5FE00F8F8FE000000
      000000000000E2D4D500C39E9900F4BC5D00FFC85A00FFC96300FFCC6800FFCE
      6A00FFCF6C00FFCF6C00FFD07000FFD27700FFD58300FED99200FCDFA800F3DB
      C100EBDAE200EBE4EF00E6E0EC00DFDAE800D6CADC00D4C9DD00D2C8DD00D2C6
      DC00D2C7DC00D5C8DB00D4CDDD00F1F1FD00F5F5FE00F8F8FE00000000000000
      0000E2D4D500C39E9900F4BC5D00FFC85A00FFC96300FFCC6800FFCE6A00FFCF
      6C00FFCF6C00FFD07000FFD27700FFD58300FED99200FCDFA800F3DBC100EBDA
      E200EBE4EF00E6E0EC00DFDAE800D6CADC00D4C9DD00D2C8DD00D2C6DC00D2C7
      DC00D5C8DB00D4CDDD00F1F1FD00F5F5FE00F8F8FE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DCCCD100D6B2
      9500F6C16000FFCE6800FFD06F00FFD37600FFD67B00FFD67B00FFD67B00FFD6
      7B00FFD67D00FFD67D00FFD58200FED58600EAB99900DFBBBF00E6D6D900E3D0
      D500DFC7CC00CCADB300CEB2B900C5ABB100C8ADB500CAADB500C9A9AD00B7A9
      B300F9F9FE00FAFAFF00FEFEFF000000000000000000DCCCD100D6B29500F6C1
      6000FFCE6800FFD06F00FFD37600FFD67B00FFD67B00FFD67B00FFD67B00FFD6
      7D00FFD67D00FFD58200FED58600EAB99900DFBBBF00E6D6D900E3D0D500DFC7
      CC00CCADB300CEB2B900C5ABB100C8ADB500CAADB500C9A9AD00B7A9B300F9F9
      FE00FAFAFF00FEFEFF000000000000000000DCCCD100D6B29500F6C16000FFCE
      6800FFD06F00FFD37600FFD67B00FFD67B00FFD67B00FFD67B00FFD67D00FFD6
      7D00FFD58200FED58600EAB99900DFBBBF00E6D6D900E3D0D500DFC7CC00CCAD
      B300CEB2B900C5ABB100C8ADB500CAADB500C9A9AD00B7A9B300F9F9FE00FAFA
      FF00FEFEFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D4C1C600D9B59400F7C66900FFD37500FFD77C00FFDA
      8300FFDC8600FFDE8900FFDE8A00FFDD8700FFDB8500FFD88200FFD67E00FED0
      7700E1A57F00D7ADAF00E0C8C800DEC2C200D7AFB000B8878900C2999B00CFA3
      A300CB9D9D00C0959500B98284009D838E00FEFEFF00FEFEFF00FEFEFF000000
      000000000000D4C1C600D9B59400F7C66900FFD37500FFD77C00FFDA8300FFDC
      8600FFDE8900FFDE8A00FFDD8700FFDB8500FFD88200FFD67E00FED07700E1A5
      7F00D7ADAF00E0C8C800DEC2C200D7AFB000B8878900C2999B00CFA3A300CB9D
      9D00C0959500B98284009D838E00FEFEFF00FEFEFF00FEFEFF00000000000000
      0000D4C1C600D9B59400F7C66900FFD37500FFD77C00FFDA8300FFDC8600FFDE
      8900FFDE8A00FFDD8700FFDB8500FFD88200FFD67E00FED07700E1A57F00D7AD
      AF00E0C8C800DEC2C200D7AFB000B8878900C2999B00CFA3A300CB9D9D00C095
      9500B98284009D838E00FEFEFF00FEFEFF00FEFEFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C2B2BA00E7BF
      8D00FFD07000FFDA7F00FFDD8800FFE08E00FFE39500FFE59900FFE59900FFE4
      9600FFE19000FFDD8900FFD98000FED27600D4967600D5ADAF00DBBEBE00D9B9
      B900D09A9A00BB737300B1777700B9838300C1919100B4848400AE6B6D008E70
      7C000000000000000000000000000000000000000000C2B2BA00E7BF8D00FFD0
      7000FFDA7F00FFDD8800FFE08E00FFE39500FFE59900FFE59900FFE49600FFE1
      9000FFDD8900FFD98000FED27600D4967600D5ADAF00DBBEBE00D9B9B900D09A
      9A00BB737300B1777700B9838300C1919100B4848400AE6B6D008E707C000000
      000000000000000000000000000000000000C2B2BA00E7BF8D00FFD07000FFDA
      7F00FFDD8800FFE08E00FFE39500FFE59900FFE59900FFE49600FFE19000FFDD
      8900FFD98000FED27600D4967600D5ADAF00DBBEBE00D9B9B900D09A9A00BB73
      7300B1777700B9838300C1919100B4848400AE6B6D008E707C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7E0E000C5B4BA00E8C78600FFDB7A00FFDE8A00FFE39400FFE7
      9C00FFEAA200FFEDA900FFEEAA00FFEAA300FFE89D00FFE49600FFDF8C00FDD6
      7F00CB8B7A00D7B5B600D9BBBB00D6B5B500CC8F8F00C46B6B00C56D6D00B96B
      6B00B6707000B0747400AD6667008E707C000000000000000000000000000000
      0000E7E0E000C5B4BA00E8C78600FFDB7A00FFDE8A00FFE39400FFE79C00FFEA
      A200FFEDA900FFEEAA00FFEAA300FFE89D00FFE49600FFDF8C00FDD67F00CB8B
      7A00D7B5B600D9BBBB00D6B5B500CC8F8F00C46B6B00C56D6D00B96B6B00B670
      7000B0747400AD6667008E707C0000000000000000000000000000000000E7E0
      E000C5B4BA00E8C78600FFDB7A00FFDE8A00FFE39400FFE79C00FFEAA200FFED
      A900FFEEAA00FFEAA300FFE89D00FFE49600FFDF8C00FDD67F00CB8B7A00D7B5
      B600D9BBBB00D6B5B500CC8F8F00C46B6B00C56D6D00B96B6B00B6707000B074
      7400AD6667008E707C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DDD7D800D3C6C500E3C0
      7C00FFDF8400FFE29200FFE89E00FFEDA800FFF1AF00FFF3B500FFF3B500FFF2
      B000FFEEAA00FFEAA100FFE49500FCD98600BF828100DFC3C300E2CACA00E9D6
      D600EEDADB00E3BABA00D18E8E00CC737300C9696900C56D6D00B46465008F70
      7B0000000000000000000000000000000000DDD7D800D3C6C500E3C07C00FFDF
      8400FFE29200FFE89E00FFEDA800FFF1AF00FFF3B500FFF3B500FFF2B000FFEE
      AA00FFEAA100FFE49500FCD98600BF828100DFC3C300E2CACA00E9D6D600EEDA
      DB00E3BABA00D18E8E00CC737300C9696900C56D6D00B46465008F707B000000
      0000000000000000000000000000DDD7D800D3C6C500E3C07C00FFDF8400FFE2
      9200FFE89E00FFEDA800FFF1AF00FFF3B500FFF3B500FFF2B000FFEEAA00FFEA
      A100FFE49500FCD98600BF828100DFC3C300E2CACA00E9D6D600EEDADB00E3BA
      BA00D18E8E00CC737300C9696900C56D6D00B46465008F707B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CFCCCE00D5C9C400CFAF7F00FBDA8900FDE49800FEEAA500FFF2
      B200FFFABE00FFFDC500FFFDC400FFFABF00FFF4B500FFEDA900FFE79B00EDC8
      8700C6908E00F3E7E700F2E5E500F4EAE900F8F0F000F6EDED00F1E2E200EDD5
      D500E1B3B300D4898900B7686A00AC969F000000000000000000000000000000
      0000CFCCCE00D5C9C400CFAF7F00FBDA8900FDE49800FEEAA500FFF2B200FFFA
      BE00FFFDC500FFFDC400FFFABF00FFF4B500FFEDA900FFE79B00EDC88700C690
      8E00F3E7E700F2E5E500F4EAE900F8F0F000F6EDED00F1E2E200EDD5D500E1B3
      B300D4898900B7686A00AC969F0000000000000000000000000000000000CFCC
      CE00D5C9C400CFAF7F00FBDA8900FDE49800FEEAA500FFF2B200FFFABE00FFFD
      C500FFFDC400FFFABF00FFF4B500FFEDA900FFE79B00EDC88700C6908E00F3E7
      E700F2E5E500F4EAE900F8F0F000F6EDED00F1E2E200EDD5D500E1B3B300D489
      8900B7686A00AC969F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF00D3CCCE00AA99
      9C00AC9B9D00BDA79600C6B29A00D4C0A200E8DEB600F4F1C100F8F5C500FDF9
      C700FFFBBF00FFF7B100FFEFA200E8C68A00CA999800EAD3D400E8CFCF00E5CB
      CB00E1C6C500E2C9C800E2CACA00E3CECE00DEC8C800D3B4B400D2B5B6000000
      000000000000000000000000000000000000BFBFBF00D3CCCE00AA999C00AC9B
      9D00BDA79600C6B29A00D4C0A200E8DEB600F4F1C100F8F5C500FDF9C700FFFB
      BF00FFF7B100FFEFA200E8C68A00CA999800EAD3D400E8CFCF00E5CBCB00E1C6
      C500E2C9C800E2CACA00E3CECE00DEC8C800D3B4B400D2B5B600000000000000
      0000000000000000000000000000BFBFBF00D3CCCE00AA999C00AC9B9D00BDA7
      9600C6B29A00D4C0A200E8DEB600F4F1C100F8F5C500FDF9C700FFFBBF00FFF7
      B100FFEFA200E8C68A00CA999800EAD3D400E8CFCF00E5CBCB00E1C6C500E2C9
      C800E2CACA00E3CECE00DEC8C800D3B4B400D2B5B60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CAC9C900E4E1E100DDD8D900CBC2C500C4B6B800BDAAAE00B6A0
      A200B79FA200B9A09800C2A99D00C9B19D00D5BEA000E5CFA000EFD49700D7AE
      8900C18F8E00D4B0AF00D8B8B800D8B9B900D9BDBE00DEC7C700DBC5C500E3D3
      D300000000000000000000000000000000000000000000000000000000000000
      0000CAC9C900E4E1E100DDD8D900CBC2C500C4B6B800BDAAAE00B6A0A200B79F
      A200B9A09800C2A99D00C9B19D00D5BEA000E5CFA000EFD49700D7AE8900C18F
      8E00D4B0AF00D8B8B800D8B9B900D9BDBE00DEC7C700DBC5C500E3D3D3000000
      000000000000000000000000000000000000000000000000000000000000CAC9
      C900E4E1E100DDD8D900CBC2C500C4B6B800BDAAAE00B6A0A200B79FA200B9A0
      9800C2A99D00C9B19D00D5BEA000E5CFA000EFD49700D7AE8900C18F8E00D4B0
      AF00D8B8B800D8B9B900D9BDBE00DEC7C700DBC5C500E3D3D300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E2DFDF00E4DBDB00E0D6D600D8CACB00CAB5B600C0A2A300BFA1
      A300BF9CA000C0989B00C69C9500BB8C8400A97D7F00D2BDBF00ECE3E3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2DFDF00E4DBDB00E0D6D600D8CACB00CAB5B600C0A2A300BFA1A300BF9C
      A000C0989B00C69C9500BB8C8400A97D7F00D2BDBF00ECE3E300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E2DF
      DF00E4DBDB00E0D6D600D8CACB00CAB5B600C0A2A300BFA1A300BF9CA000C098
      9B00C69C9500BB8C8400A97D7F00D2BDBF00ECE3E30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E8DDDD00E1D0D000D0B6B700CAA9AB00B589
      8C00CCBCBF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E8DDDD00E1D0D000D0B6B700CAA9AB00B5898C00CCBC
      BF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E8DDDD00E1D0D000D0B6B700CAA9AB00B5898C00CCBCBF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      FFF80001FFF00003FFE0000000000000FFF80001FFF00003FFE0000000000000
      FFF00001FFE00003FFC0000000000000FC000001F8000003F000000000000000
      F0000001E0000003C000000000000000E0000001C00000038000000000000000
      C000000180000003000021000000000080000101000000020000000000000000
      8000010100000002000000000000000080000101000000020000000000000000
      C0000001800000030000000000000000C0000001800000030000210000000000
      E0000001C00000038000000000000000E0000001C00000038000000000000000
      E0000001C00000038000000000000000E0000001C00000038000000000000000
      E0000001C00000038000000000000000C0000001800000030000000000000000
      C0000001800000030000000000000000C0000001800000030000000000000000
      C0000001800000030000000000000000C000000F8000001F0000003800000000
      8000000F0000001E00000038000000008000000F0000001E0000003800000000
      8000000F0000001E00000038000000008000001F0000003E0000007800000000
      800000FF000001FE000003F800000000F8001FFFF0003FFFE0007FF800000000
      FFE07FFFFFC0FFFFFF81FFF800000000FFFFFFFFFFFFFFFFFFFFFFF800000000
      FFFFFFFFFFFFFFFFFFFFFFF800000000FFF9FFFFFFFFFFFFFFFFFFFFFFFFFFF0
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
    Left = 472
    Top = 200
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
    Left = 536
    Top = 168
  end
  object PopupMenuComps: TPopupMenu
    Left = 504
    Top = 168
  end
  object ilEvents: TImageList
    Left = 568
    Top = 200
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
    Left = 504
    Top = 200
    object cmnRestore: TMenuItem
      Caption = 'Restore'
      OnClick = cmnRestoreClick
    end
  end
  object tmrIntDate: TTimer
    OnTimer = tmrIntDateTimer
    Left = 640
    Top = 168
  end
  object tmrShowFormKillTasks: TTimer
    Enabled = False
    Interval = 20
    OnTimer = tmrShowFormKillTasksTimer
    Left = 536
    Top = 200
  end
  object dsComps: TDataSource
    DataSet = cdsComps
    Left = 568
    Top = 168
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
      end
      item
        Name = 'SysState'
        DataType = ftString
        Size = 20
      end>
    Parameters = <>
    StoreDefs = True
    Left = 600
    Top = 168
  end
  object ilReports: TImageList
    Left = 600
    Top = 202
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
    Left = 640
    Top = 200
  end
  object tmrFileSynchronization: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = tmrFileSynchronizationTimer
    Left = 672
    Top = 168
  end
  object tmrCyclicCompAction: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrCyclicCompActionTimer
    Left = 672
    Top = 200
  end
  object timerGSessionsLoad: TTimer
    Interval = 17000
    OnTimer = timerGSessionsLoadTimer
    Left = 408
    Top = 168
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 438
    Top = 200
  end
  object bsPolyglotTranslator1: TbsPolyglotTranslator
    Manager = dmMain.bsPolyglotManager
    Left = 352
    Top = 168
  end
  object PopupMenuShutdown: TPopupMenu
    Left = 408
    Top = 200
    object cmnShutdownAll: TMenuItem
      Caption = #1042#1099#1082#1083#1102#1095#1080#1090#1100' '#1074#1089#1077
      OnClick = cmnShutdownAllClick
    end
    object cmnShutdownFree: TMenuItem
      Caption = #1042#1099#1082#1083#1102#1095#1080#1090#1100' '#1089#1074#1086#1073#1086#1076#1085#1099#1077
      OnClick = cmnShutdownFreeClick
    end
  end
  object PopupMenuReset: TPopupMenu
    Left = 324
    Top = 198
    object cmnResetAll: TMenuItem
      Caption = #1055#1077#1088#1077#1079#1072#1075#1088#1091#1079#1080#1090#1100' '#1074#1089#1077
      OnClick = cmnResetAllClick
    end
    object cmnResetFree: TMenuItem
      Caption = #1055#1077#1088#1077#1079#1072#1075#1088#1091#1079#1080#1090#1100' '#1089#1074#1086#1073#1086#1076#1085#1099#1077
      OnClick = cmnResetFreeClick
    end
  end
  object PopupMenuWakeup: TPopupMenu
    Left = 356
    Top = 198
    object cmnWakeupAll: TMenuItem
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1074#1089#1077
      OnClick = cmnWakeupAllClick
    end
    object cmnWakeFree: TMenuItem
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1089#1074#1086#1073#1086#1076#1085#1099#1077
      OnClick = cmnWakeFreeClick
    end
    object cmnWakeupNoFree: TMenuItem
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1079#1072#1085#1103#1090#1099#1077
      OnClick = cmnWakeupNoFreeClick
    end
  end
  object PopupMenuLogoff: TPopupMenu
    Left = 284
    Top = 198
    object cmnLogoffAll: TMenuItem
      Caption = #1051#1086#1075#1086#1092#1092' '#1076#1083#1103' '#1074#1089#1077#1093
      OnClick = cmnLogoffAllClick
    end
    object cmnLogoffFree: TMenuItem
      Caption = #1051#1086#1075#1086#1092#1092' '#1076#1083#1103' '#1089#1074#1086#1073#1086#1076#1085#1099#1093
      OnClick = cmnLogoffFreeClick
    end
  end
end
