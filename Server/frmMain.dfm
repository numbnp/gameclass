object formMain: TformMain
  Left = 246
  Top = 136
  AlphaBlendValue = 0
  BiDiMode = bdLeftToRight
  BorderWidth = 5
  Caption = 's'
  ClientHeight = 686
  ClientWidth = 829
  Color = clBtnFace
  Constraints.MinHeight = 332
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
    Width = 829
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object tbActions: TToolBar
      Left = 0
      Top = 0
      Width = 707
      Height = 57
      Align = alClient
      ButtonHeight = 59
      ButtonWidth = 61
      Caption = 'tbActions'
      Color = clBtnFace
      EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
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
        Left = 61
        Top = 0
        Caption = 'Add'
        ImageIndex = 5
        OnClick = tbCompAddClick
      end
      object tbCompStop: TToolButton
        Left = 122
        Top = 0
        Caption = 'Stop'
        ImageIndex = 1
        OnClick = tbCompStopClick
      end
      object tbCompMove: TToolButton
        Left = 183
        Top = 0
        Caption = 'Move'
        ImageIndex = 2
        OnClick = tbCompMoveClick
      end
      object ToolButton2: TToolButton
        Left = 244
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object tbCompLogoff: TToolButton
        Left = 252
        Top = 0
        Caption = 'Logoff'
        DropdownMenu = PopupMenuLogoff
        ImageIndex = 10
        Style = tbsDropDown
        OnClick = tbCompLogoffClick
      end
      object tbCompReset: TToolButton
        Left = 328
        Top = 0
        Caption = 'Reset'
        DropdownMenu = PopupMenuReset
        ImageIndex = 7
        Style = tbsDropDown
        OnClick = tbCompResetClick
      end
      object tbCompShutdown: TToolButton
        Left = 404
        Top = 0
        Caption = 'Shutdown'
        DropdownMenu = PopupMenuShutdown
        ImageIndex = 8
        Style = tbsDropDown
        OnClick = tbCompShutdownClick
      end
      object tbCompWakeUp: TToolButton
        Left = 480
        Top = 0
        Caption = 'Wakeup'
        DropdownMenu = PopupMenuWakeup
        ImageIndex = 9
        Style = tbsDropDown
        OnClick = tbCompWakeUpClick
      end
      object ToolButton9: TToolButton
        Left = 556
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object tbSideline: TToolButton
        Left = 564
        Top = 0
        Caption = #1059#1089#1083#1091#1075#1080
        ImageIndex = 6
        OnClick = tbSidelineClick
      end
      object ToolButton1: TToolButton
        Left = 625
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 5
        Style = tbsSeparator
      end
    end
    object pnlTimer: TPanel
      Left = 707
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
    Width = 829
    Height = 629
    ActivePage = tabComputers
    Align = alClient
    TabOrder = 1
    OnChange = PageControlChange
    object tabComputers: TTabSheet
      Caption = 'Computers'
      object splitComps: TSplitter
        Left = 0
        Top = 469
        Width = 821
        Height = 6
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 677
        ExplicitWidth = 971
      end
      object gridComps: TDBGridEh
        Left = 0
        Top = 0
        Width = 762
        Height = 469
        Align = alClient
        AutoFitColWidths = True
        DataSource = dsComps
        DynProps = <>
        EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
        Flat = True
        FooterParams.Color = clWindow
        GridLineParams.VertEmptySpaceStyle = dessNonEh
        IndicatorOptions = []
        MinAutoFitWidth = 50
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove]
        PopupMenu = PopupMenuComps
        ReadOnly = True
        TabOrder = 0
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
            DynProps = <>
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
            DynProps = <>
            EditButtons = <>
            FieldName = 'Computer'
            Footers = <>
            Title.TitleButton = True
            Title.SortIndex = 1
            Title.SortMarker = smDownEh
            Width = 75
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'State'
            Footers = <>
            Title.TitleButton = True
            Width = 80
            WordWrap = True
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'Tarif'
            Footers = <>
            Title.TitleButton = True
            Width = 100
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'Balance'
            Footers = <>
            Title.TitleButton = True
            Width = 110
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'Start'
            Footers = <>
            Title.TitleButton = True
            Width = 55
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'End'
            Footers = <>
            Title.TitleButton = True
            Width = 55
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'Time'
            Footers = <>
            Title.TitleButton = True
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'TimeLeft'
            Footers = <>
            Title.TitleButton = True
            Width = 65
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'Printed'
            Footers = <>
            Title.TitleButton = True
            Width = 75
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'Traffic'
            Footers = <>
            Title.TitleButton = True
            Width = 75
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'Client'
            Footers = <>
            Title.TitleButton = True
            Width = 100
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'Description'
            Footers = <>
            Title.TitleButton = True
          end
          item
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'Group'
            Footers = <>
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object pnlBottom: TPanel
        Left = 0
        Top = 475
        Width = 821
        Height = 126
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object lvConsole: TListView
          Left = 0
          Top = 0
          Width = 821
          Height = 126
          Align = alClient
          BiDiMode = bdLeftToRight
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
          Left = 821
          Top = 0
          Width = 0
          Height = 126
          Align = alRight
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
      object tbRunPad: TToolBar
        Left = 762
        Top = 0
        Width = 59
        Height = 469
        Align = alRight
        AutoSize = True
        ButtonHeight = 54
        ButtonWidth = 55
        EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
        Images = ilRunPad
        TabOrder = 2
        Visible = False
        object tlbMonOn: TToolButton
          Left = 0
          Top = 0
          Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1084#1086#1085#1080#1090#1086#1088' '#1089#1088#1077#1076#1089#1090#1074#1072#1084#1080' RunPad'
          ImageIndex = 0
          ParentShowHint = False
          Wrap = True
          ShowHint = True
          OnClick = tlbMonOnClick
        end
        object tlbMonOff: TToolButton
          Left = 0
          Top = 54
          Hint = #1042#1099#1082#1083#1102#1095#1080#1090#1100' '#1084#1086#1085#1080#1090#1086#1088' '#1089#1088#1077#1076#1089#1090#1074#1072#1084#1080' RunPad'
          ImageIndex = 1
          ParentShowHint = False
          Wrap = True
          ShowHint = True
          OnClick = tlbMonOffClick
        end
        object tlbStationUnlock: TToolButton
          Left = 0
          Top = 108
          Hint = #1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1082#1086#1084#1087#1100#1102#1090#1077#1088' '#1089#1088#1077#1076#1089#1090#1074#1072#1084#1080'RunPad'
          ImageIndex = 2
          ParentShowHint = False
          Wrap = True
          ShowHint = True
          OnClick = tlbStationUnlockClick
        end
        object tlbStationLock: TToolButton
          Left = 0
          Top = 162
          Hint = #1047#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1082#1086#1084#1087#1100#1102#1090#1077#1088' '#1089#1088#1077#1076#1089#1090#1074#1072#1084#1080' RunPad'
          ImageIndex = 3
          ParentShowHint = False
          ShowHint = True
          OnClick = tlbStationLockClick
        end
      end
      object pnlRep: TPanel
        Left = 0
        Top = 460
        Width = 17
        Height = 17
        TabOrder = 3
        Visible = False
      end
    end
    object tabReports: TTabSheet
      Caption = 'Reports'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlReports: TPanel
        Left = 0
        Top = 0
        Width = 861
        Height = 693
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
        Width = 821
        Height = 601
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 821
        ExplicitHeight = 601
        inherited Panel1: TPanel
          Top = 560
          Width = 821
          ExplicitTop = 570
          ExplicitWidth = 831
          DesignSize = (
            821
            41)
          inherited edtMessage: TEdit
            Width = 1929
            ExplicitWidth = 1969
          end
          inherited btnSend: TButton
            Left = 1951
            OnClick = frameMessagesbtnSendClick
            ExplicitLeft = 1991
          end
        end
        inherited Panel2: TPanel
          Width = 821
          Height = 560
          ExplicitWidth = 831
          ExplicitHeight = 570
          inherited memMessages: TMemo
            Width = 669
            Height = 568
            Lines.Strings = ()
            ExplicitWidth = 659
            ExplicitHeight = 558
          end
          inherited Panel3: TPanel
            Height = 558
            ExplicitHeight = 650
            inherited lvUsers: TListView
              Height = 648
              Columns = <
                item
                  AutoSize = True
                  Caption = #1048#1084#1103
                end
                item
                  AutoSize = True
                  Caption = #8470
                end
                item
                  Caption = 'IP'
                  MaxWidth = 20
                end>
              ExplicitHeight = 648
            end
          end
        end
      end
    end
  end
  object menuMain: TMainMenu
    Tag = 1
    AutoLineReduction = maManual
    Left = 168
    Top = 112
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
    object subView: TMenuItem
      Tag = 1
      Caption = #1042#1080#1076
      object mnuPanelRunPad: TMenuItem
        AutoCheck = True
        AutoLineReduction = maManual
        Caption = #1055#1072#1085#1077#1083#1100' RunPad'
        OnClick = mnuPanelRunPadClick
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
      object mnuCompBackPartMoney: TMenuItem
        Caption = #1042#1077#1088#1085#1091#1090#1100' '#1095#1072#1089#1090#1100' '#1089#1076#1072#1095#1080
        ShortCut = 8238
        OnClick = mnuCompBackPartMoneyClick
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
      494C01010B000E0040001F001F0000000000FF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000007C0000005D000000010020000000000030B4
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEFEFF00FCFCFF00F9F9FE00F1F1FC00395AE100395AE100385B
      E1003E61E2004668E400476CE6004269E8003763E8002859E8001A4FE7001249
      E7000B43E700063DE600E7E7FB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFF00FCFCFF00F9F9FE00F1F1FC002C2C34003131390033333B003333
      3C0034343D0035353D0034343D0035353E0035353D0034343D0033333C003030
      380029293200E7E7FB0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FF00FCFCFF00F9F9FE00F1F1FC0064B2640050A8500064B2640050A8500064B2
      640050A8500064B2640050A8500064B2640050A8500064B2640050A85000EAEA
      FB00E7E7FB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFF00F9F9FF00F3F3
      FD001237C900193DCA002144CC002446CD002445CC002245CD002146CD001D44
      CF001942D2001440D3000F3DD2000A39D3000335D300002FCF000028BD000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFF00F9F9FF00F3F3FD003236
      4D003131380034343C0035353E0035353E0036363F0035353E0035353E003636
      3F0036363F0036363F0035353E0032323B002B2B330034364300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FDFDFF00F9F9FF00D7EDDF00418545000862
      0F000E65150013671A0013681A001067170007620E0004630B0007680F000767
      0F000767100003650C0002620C0032823A00B8DAD00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFF00FBFBFF00F6F6FD002F52E1001B42DB00274BDE003052DF003357
      E0003154DF002A50DF00244EDF001D4BE1001949E200174AE400164AE5001046
      E600073EE4000238E100002ECE00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FF00FBFBFF00F6F6FD00292931002F2F3800303038002B2B320033333B003535
      3E0034343D0033333B0033333C0035353D0034343D003030380028282F001E1E
      230027272D0025252A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFF00FBFB
      FF00F6F6FD003D8C4200117A110020882000288C2800298C290022882200298C
      29007FB67F006DB76D00068E0600018D0100078F070003900300008D0000067E
      06002F8634000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CEC1C600B29E
      A700A28993009C838D009C838E00AF99A100D0C3CA00F9F9FF00EFEFFC00385A
      E200264BE0003255E2003B5DE4003A5CE4004768E600849BEE00C2CDF700D3DC
      FB00BCCAF8007292F1002459EA000E48EA000C45E900063DE5000231D3000000
      00000000000000000000000000000000000000000000CEC1C600B29EA700A289
      93009C838D009C838E00AF99A100D0C3CA00F9F9FF00EFEFFC002E2F37003434
      3D0035353D00363847003637450039514D003E5B3F00527A53004F7C4D004D7A
      4E003F66400038563E003536420035364200303037002D2D3500000000000000
      000000000000000000000000000000000000CEC1C600B29EA700A28993009C83
      8D009C838E00AF99A100D0C3CA00F9F9FF00EFEFFC000C7C1200218E2100399C
      3900329A3200299529002F982F003AA33A00C0E2C000BEE5BE0028AC28000AA5
      0A0000A5000001AD01000CAF0C00028E020001630A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B49DA3009C767B009F7E8200A9888A00AB858800A8818500A67D8100A37D
      8200B9A2A700D8CFD800D0CADC004161E4002F53E1003C5EE4004061E4005E7A
      E800D4DCF900F8F9FE00D5DEFA00C3D0F800D5DEFA00F8FAFF00C2D1F9002E61
      EC000A45EA000A41E6000636D30000000000000000000000000000000000B49D
      A3009C767B009F7E8200A9888A00AB858800A8818500A67D8100A37D8200B9A2
      A700D8CFD800D0CADC0031313A0035353E0036363F00363744003B534000D4DC
      F900F8F9FE00D5DEFA00C3D0F800D5DEFA00F8FAFF00C2D1F900395937003636
      410034343D0032323B0000000000000000000000000000000000B49DA3009C76
      7B009F7E8200A9888A00AB858800A8818500A67D8100A37D8200B9A2A700D8CF
      D800D8CEDF00118318002D982D00389C380071B871008EC88E003E9F3E0030A5
      3000CFEFCF00CEEACE001CA71C001CAC1C0077CD770045C4450003AE03000B8F
      0B00096312000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A98B9000BEA6A700D5CACA00D8D1D100DAD0
      D000D9CCCC00DAC9C900D0BABB00D4B8B800DFCCCE00E5DCE500CBC2DC004967
      E400385BE3004362E4005571E600D7DEF900E6EAFC008097EE004268E7002251
      E4003462E8007091F000E6ECFD00C1D0FA001C52EA000E44E6000C3BD3000000
      00000000000000000000A98B9000BEA6A700D5CACA00D8D1D100DAD0D000D9CC
      CC00DAC9C900D0BABB00D4B8B800DFCCCE00E5DCE500CBC2DC0033333B003636
      3F0036363F0038464400D7DEF900E6EAFC00548A6B0041894A003E8B3F004088
      400048805100E6ECFD00C1D0FA003C4749003D3D490034343C00000000000000
      000000000000A98B9000BEA6A700D5CACA00D8D1D100DAD0D000D9CCCC00DAC9
      C900D0BABB00D4B8B800DFCCCE00E5DCE500D8CBDC001B8B22003AA03A00379B
      370094C99400F6FBF600AAD3AA004DAD4D00B6E1B600B0E4B00039B839009ADB
      9A00F1FAF1006DD26D0000A700000D8E0D000A65130000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BC9FA100DCD7
      D700E3E6E500E0E0E000DEDCDC00DCD7D700DAD1D100D5C9C900BEA1A100B79D
      9D00CCB6B800E0D7E400CDC6E6005571E6004060E4004665E50096A7F100FBFB
      FE007F95ED003559E3006481EB00D2DBF900547AEB001248E5006B8DF100FCFC
      FF006B8DF1001044E4001440D3000000000000000000BC9FA100DCD7D700E3E6
      E500E0E0E000DEDCDC00DCD7D700DAD1D100D5C9C900BEA1A100B79D9D00CCB6
      B800E0D7E400CDC6E60034343C0036363F0036363F003B4F4100FBFBFE004359
      4F0041982A0042B12000E1E6FB0042B1200042AE21003F6D3900FCFCFF003F53
      47003E3E4B0034343C000000000000000000BC9FA100DCD7D700E3E6E500E0E0
      E000DEDCDC00DCD7D700DAD1D100D5C9C900BEA1A100B79D9D00CCB6B800E0D7
      E400DAC9DA00208C27003A9D3A0042A142004DA64D00AFD7AF0000000000A0D2
      A0004DAF4D0045B2450097D697000000000099DA990019AF190000AA0000048B
      04000E6517000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CAB3B200DAD6D500E9EBEB00EAEAEA00EAEAEA00E5E6E600E0DF
      DF00DDD9D900CDB9B900D2BCBC00CAC2C300C2B6BB00D6CCDD00C6C0E300637C
      E8004968E5004967E500D0D7F800D3DAF900506DE6003D60E400738DEC000000
      00006586ED001C4EE5002757E800D0DBF900B7C7F7001143E2001A44D3000000
      0000CAB3B200DAD6D500E9EBEB00EAEAEA00EAEAEA00E5E6E600E0DFDF00DDD9
      D900CDB9B900D2BCBC00CAC2C300C2B6BB00D6CCDD00C6C0E30034343D003636
      3F0036363F00546F5900D3DAF9003E5F440041A6240042B12000E1E6FB0042B1
      200042AF21003F703700D0DBF900506D56003E3E4B0034343D0000000000CAB3
      B200DAD6D500E9EBEB00EAEAEA00EAEAEA00E5E6E600E0DFDF00DDD9D900CDB9
      B900D2BCBC00CAC2C300C2B6BB00D6CCDD00DCCAD90029932E0046A2460058AC
      580049A449005AAD5A00A3D1A3007FBF7F002E9A2E00269D260072C272008ED3
      8E002EB22E0011A8110015A715000B8D0B0012661B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CCB5B500E9ECEC00EDED
      ED00F3F3F300F3F3F300EBEBEB00E3E3E300DFE0E000C4A8A800DAC6C600C3AA
      AA00C8B5B900D8CEDF00C4BEE4006A82E900506DE6004E6AE700E0E5FA00C0CA
      F6004664E5004061E4007088EC00000000006281EA00204DE4001445E400BAC9
      F700D0DAFA001443E1002047D10000000000CCB5B500E9ECEC00EDEDED00F3F3
      F300F3F3F300EBEBEB00E3E3E300DFE0E000C4A8A800DAC6C600C3AAAA00C8B5
      B900D8CEDF00C4BEE40034343C0036363F0036363F005B785C00C0CAF6003E63
      420042AA230042B12000E1E6FB0042B1200042AD22003E693A00BAC9F700577C
      5A003E3E4A0035353E0000000000CCB5B500E9ECEC00EDEDED00F3F3F300F3F3
      F300EBEBEB00E3E3E300DFE0E000C4A8A800DAC6C600C3AAAA00C8B5B900D8CE
      DF00D8CEDF0025952B0096CC9600CCE5CC00D2E9D200C2E1C2005BAD5B003599
      35003F9F3F003AA53A001EA11E003BAF3B00B1E3B100C3EAC300B7E1B70078B8
      780007610F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D8C1C100E7E8E800F3F5F500FBFBFC00FBFCFD00F0F1F100E6E7
      E700DFDDDD00C6A2A200D7BABA00BD949400CDB1B700D8CBDC00C4BBE5006F86
      E9005973E8005571E700D3DAF900D1D8F800506CE5003D5DE300718AEB000000
      00006481EA001C48E2002550E300CED7F900BCC9F7001B46E0002549D0000000
      0000D8C1C100E7E8E800F3F5F500FBFBFC00FBFCFD00F0F1F100E6E7E700DFDD
      DD00C6A2A200D7BABA00BD949400CDB1B700D8CBDC00C4BBE50034343D003636
      3F0036363F0049624B00D1D8F8003F60480041A6240042B12000E1E6FB0042B1
      200041A226003C594300CED7F90060846C003C3C480035353E0000000000D8C1
      C100E7E8E800F3F5F500FBFBFC00FBFCFD00F0F1F100E6E7E700DFDDDD00C6A2
      A200D7BABA00BD949400CDB1B700D8CBDC00D8CBDC0027952C0098CC9800CEE6
      CE00D4EAD400C2E0C2005AAD5A00359A35003FA13F0038A138001B991B003AA9
      3A00B2DCB200C2E5C200BBDEBB0078B9780007610F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DAC9C900F2F3
      F300EBD7D700E9D7DA00EAE3E300E8ECEC00D9CDCD00CEA9A900CEA4A400BF8C
      8D00D0ACB200DAC9DA00C5BBE3006F86E900617AE800607AE800A4B3F200F9FA
      FE007C91EC003656E100637DE800D1D9F9005472E700133EDE006883EB00FBFC
      FE007991ED00234BDF00284AD0000000000000000000DAC9C900F2F3F300EBD7
      D700E9D7DA00EAE3E300E8ECEC00D9CDCD00CEA9A900CEA4A400BF8C8D00D0AC
      B200DAC9DA00C5BBE30032323B0036363E0036363F003D524300F9FAFE00475E
      5A0040982C0042B12000E1E6FB0042B020003E833600414E5800FBFCFE003E59
      46003A3A450034343D000000000000000000DAC9C900F2F3F300EBD7D700E9D7
      DA00EAE3E300E8ECEC00D9CDCD00CEA9A900CEA4A400BF8C8D00D0ACB200DAC9
      DA00DAC9DA00389A3D0056AB560064B2640050A850005CAE5C00A3D1A3007EBE
      7E002C972C00249224006EB76E008DCB8D0031A1310012961200239A2300148D
      140014661C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F0E4E400DFCACB00CB999900CC8C8700D3AEBA00D5B8
      BD00C9A4A500CC9D9D00C98A8A00C8838400D6A8AD00DCCAD900C9BFE2006C84
      E9006982EA006C86EB007088EB00DFE5FA00E1E6FB007B8FEC00415FE300274B
      E0003457E3006A83EA00E1E6FB00CDD6F8003458E3002B51E0002A4BD0000000
      000000000000F0E4E400DFCACB00CB999900CC8C8700D3AEBA00D5B8BD00C9A4
      A500CC9D9D00C98A8A00C8838400D6A8AD00DCCAD900C9BFE20032323A003535
      3E0035353E0039454400DFE5FA00E1E6FB0050716A00407451003E7948003E79
      4E004A776300E1E6FB00CDD6F800374B4D0035353E0035353E00000000000000
      0000F0E4E400DFCACB00CB999900CC8C8700D3AEBA00D5B8BD00C9A4A500CC9D
      9D00C98A8A00C8838400D6A8AD00DCCAD900DCCAD9003F9B44005BAE5B005CAF
      5C0059AC5900B2D9B200000000009DCE9D004DA74D0046A2460097C997000000
      00009CCF9C0022952200189118001C891C0013671B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E4CC
      CD00C6939500F9BA5F00F0B97B00DEAB9400CEA0A500C7848C00C3696A00CE79
      7A00DAA2A600E0CAD700D3CAE6006C85E900738BEB00778FEC006881EA00798F
      EC00E1E6FB00F5F6FE00C9D2F700B8C4F500CBD3F800F4F6FE00D1D9F8004867
      E500294EE2003053E0002B4BCE00000000000000000000000000E4CCCD00C693
      9500F9BA5F00F0B97B00DEAB9400CEA0A500C7848C00C3696A00CE797A00DAA2
      A600E0CAD700D3CAE6003030390035353E0035353E0036363F00384A3A00E1E6
      FB00F5F6FE00C9D2F700B8C4F500CBD3F800F4F6FE00D1D9F800395937003636
      400035353D0035353D00000000000000000000000000E4CCCD00C6939500F9BA
      5F00F0B97B00DEAB9400CEA0A500C7848C00C3696A00CE797A00DAA2A600E0CA
      D700D8CBDC00429E470064B2640059AD5900A7D4A700FAFDFA00ADD5AD0050A8
      5000B8DCB800B3D9B3003F9E3F00A1CFA100F6FBF60082C28200178D1700258B
      2500116719000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E2CACB00CC8F7C00FC9F0E00FFAA1B00FFBC
      4700F7BA6200E9AF8B00D6999800D5878C00D79BA000E3CBD400DAD6EA007189
      EA008399EE008A9EEE007B92EC006881EA007088EB00A2B1F200D3DAF900DEE4
      FA00D0D7F80092A4F0004F6CE600385AE300395BE3003355E0002949CE000000
      00000000000000000000E2CACB00CC8F7C00FC9F0E00FFAA1B00FFBC4700F7BA
      6200E9AF8B00D6999800D5878C00D79BA000E3CBD400DAD6EA003D3D49003535
      3E0034343D0036363F0036363F003B4948003D524100435D440058745C004055
      44003F4E49003847400036374300363742003131390032323A00000000000000
      000000000000E2CACB00CC8F7C00FC9F0E00FFAA1B00FFBC4700F7BA6200E9AF
      8B00D6999800D5878C00D79BA000E3CBD400DAC9DA0049A34E0071BB71006CB7
      6C0093CA9300A4D3A40053A9530044A24400D4E9D400D2E9D20032993200369B
      36008CC78C0064B4640025932500298D29000E65160000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEC3
      C500D08E7100FCA72500FFAE2900FFAD2600FFB12C00FFB83F00FAB75100ECBC
      8A00E5C1B700E8D4DC00E0D1E1007D93EB0094A6F1009BACF100889CEE00788F
      EC006E87EA00657FE9005C77E7005874E7005672E7005672E7005471E8004D6C
      E6004463E5003658E1002446CE00000000000000000000000000DEC3C500D08E
      7100FCA72500FFAE2900FFAD2600FFB12C00FFB83F00FAB75100ECBC8A00E5C1
      B700E8D4DC00E0D1E1003C3C490036363F0036363F0036363F0036363F003636
      3F003C3C47003D3D4A003E3E4B003E3E4B0035353E0036363F0035353E003333
      3C0034343D002A2A3100000000000000000000000000DEC3C500D08E7100FCA7
      2500FFAE2900FFAD2600FFB12C00FFB83F00FAB75100ECBC8A00E5C1B700E8D4
      DC00DCCAD90050A5540082C8820086C886006DB76D0059AC59005BAD5B0065B3
      6500CFE7CF00CBE5CB0056AB56003FA03F00359B3500379C370042A14200298D
      29000C6413000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D8BCC000DA9B6500FDAF3300FFB43600FFB8
      3D00FFB83F00FFB83E00FFB93D00FFC15300FCCD7D00F6E2C300EDDDDC008B9E
      ED00879CEF0090A3F0007D93ED006E87EA006982EA00657DE900607BE8005E79
      E8005A75E8005572E700516EE7004969E5003E60E4003053E0001F42CC000000
      00000000000000000000D8BCC000DA9B6500FDAF3300FFB43600FFB83D00FFB8
      3F00FFB83E00FFB93D00FFC15300FCCD7D00F6E2C300EDDDDC00C2BCBA003C3C
      490036363F0036363F0036363F0036363F0036363F0036363F0035353E003535
      3E0035353E0036363F0035353E0034343D002F2F37002F396700000000000000
      000000000000D8BCC000DA9B6500FDAF3300FFB43600FFB83D00FFB83F00FFB8
      3E00FFB93D00FFC15300FCCD7D00F6E2C300EDDDDC0074B8770076C076007CC5
      7C0071BA710065B365005CAE5C005DAE5D009ACD9A0098CB980053A953004BA5
      4B004CA64C0045A24500379A37001E7E1E004187460000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CBAA
      B000EAAA5D00FFB83F00FFBC4700FFBD4A00FFBF4E00FFC15000FFC15100FFC4
      5C00FFCE7700FDDCA200FAE8CC00E6DFD9008B9EED007C93EB00718AEA006C85
      EA006E86EA007188EA007289EA006F87EA006880E9005B76E700506EE6004866
      E4004162E300395AE100DFDFF900000000000000000000000000CBAAB000EAAA
      5D00FFB83F00FFBC4700FFBD4A00FFBF4E00FFC15000FFC15100FFC45C00FFCE
      7700FDDCA200FAE8CC00E6DFD900DECCBE003B3B470036363F0036363F003636
      3E0035353E0035353E0034343D0035353D0035353E0036363F0035353E003434
      3C003B3B4800DFDFF900000000000000000000000000CBAAB000EAAA5D00FFB8
      3F00FFBC4700FFBD4A00FFBF4E00FFC15000FFC15100FFC45C00FFCE7700FDDC
      A200FAE8CC00D6ECDC0070B6730048A34D00409D45003F9C44003E9B44003B9A
      41003496390031973600329C3800319737002E91340025912C0016831D003689
      3C00D0E9D9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E8DBDB00C09CA400F1B45B00FFC14D00FFC25400FFC5
      5A00FFC75D00FFC85F00FFC85F00FFCA6600FFD07600FFD68D00FCE1B000F9E8
      CE00F3DFCE00E1D1E100DCD7EC00D2D0EA00C9C2E600BBB4DD00BBB2DD00BAB2
      E000BDB3E500BEB5E100BDB3DC00C1BCDD00DEDEF600E7E7F900EFEFFC000000
      000000000000E8DBDB00C09CA400F1B45B00FFC14D00FFC25400FFC55A00FFC7
      5D00FFC85F00FFC85F00FFCA6600FFD07600FFD68D00FCE1B000F9E8CE00F3DF
      CE00E1D1E100DCD7EC00D2D0EA00C9C2E600BBB4DD00BBB2DD00BAB2E000BDB3
      E500BEB5E100BDB3DC00C1BCDD00DEDEF600E7E7F900EFEFFC00000000000000
      0000E8DBDB00C09CA400F1B45B00FFC14D00FFC25400FFC55A00FFC75D00FFC8
      5F00FFC85F00FFCA6600FFD07600FFD68D00FCE1B000F9E8CE00F3DFCE00F1F1
      FD00F5F5FE00F8F8FE00F5F5FE00F8F8FE00F1F1FD00F5F5FE00F8F8FE00F1F1
      FD00F5F5FE00F8F8FE00F1F1FD00F5F5FE00F8F8FE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E2D4D500C39E
      9900F4BC5D00FFC85A00FFC96300FFCC6800FFCE6A00FFCF6C00FFCF6C00FFD0
      7000FFD27700FFD58300FED99200FCDFA800F3DBC100EBDAE200EBE4EF00E6E0
      EC00DFDAE800D6CADC00D4C9DD00D2C8DD00D2C6DC00D2C7DC00D5C8DB00D4CD
      DD00F1F1FD00F5F5FE00F8F8FE000000000000000000E2D4D500C39E9900F4BC
      5D00FFC85A00FFC96300FFCC6800FFCE6A00FFCF6C00FFCF6C00FFD07000FFD2
      7700FFD58300FED99200FCDFA800F3DBC100EBDAE200EBE4EF00E6E0EC00DFDA
      E800D6CADC00D4C9DD00D2C8DD00D2C6DC00D2C7DC00D5C8DB00D4CDDD00F1F1
      FD00F5F5FE00F8F8FE000000000000000000E2D4D500C39E9900F4BC5D00FFC8
      5A00FFC96300FFCC6800FFCE6A00FFCF6C00FFCF6C00FFD07000FFD27700FFD5
      8300FED99200FCDFA800F3DBC100EBDAE200EBE4EF00E6E0EC00DFDAE800D6CA
      DC00D4C9DD00D2C8DD00D2C6DC00D2C7DC00D5C8DB00D4CDDD00F1F1FD00F5F5
      FE00F8F8FE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DCCCD100D6B29500F6C16000FFCE6800FFD06F00FFD3
      7600FFD67B00FFD67B00FFD67B00FFD67B00FFD67D00FFD67D00FFD58200FED5
      8600EAB99900DFBBBF00E6D6D900E3D0D500DFC7CC00CCADB300CEB2B900C5AB
      B100C8ADB500CAADB500C9A9AD00B7A9B300F9F9FE00FAFAFF00FEFEFF000000
      000000000000DCCCD100D6B29500F6C16000FFCE6800FFD06F00FFD37600FFD6
      7B00FFD67B00FFD67B00FFD67B00FFD67D00FFD67D00FFD58200FED58600EAB9
      9900DFBBBF00E6D6D900E3D0D500DFC7CC00CCADB300CEB2B900C5ABB100C8AD
      B500CAADB500C9A9AD00B7A9B300F9F9FE00FAFAFF00FEFEFF00000000000000
      0000DCCCD100D6B29500F6C16000FFCE6800FFD06F00FFD37600FFD67B00FFD6
      7B00FFD67B00FFD67B00FFD67D00FFD67D00FFD58200FED58600EAB99900DFBB
      BF00E6D6D900E3D0D500DFC7CC00CCADB300CEB2B900C5ABB100C8ADB500CAAD
      B500C9A9AD00B7A9B300F9F9FE00FAFAFF00FEFEFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D4C1C600D9B5
      9400F7C66900FFD37500FFD77C00FFDA8300FFDC8600FFDE8900FFDE8A00FFDD
      8700FFDB8500FFD88200FFD67E00FED07700E1A57F00D7ADAF00E0C8C800DEC2
      C200D7AFB000B8878900C2999B00CFA3A300CB9D9D00C0959500B98284009D83
      8E00FEFEFF00FEFEFF00FEFEFF000000000000000000D4C1C600D9B59400F7C6
      6900FFD37500FFD77C00FFDA8300FFDC8600FFDE8900FFDE8A00FFDD8700FFDB
      8500FFD88200FFD67E00FED07700E1A57F00D7ADAF00E0C8C800DEC2C200D7AF
      B000B8878900C2999B00CFA3A300CB9D9D00C0959500B98284009D838E00FEFE
      FF00FEFEFF00FEFEFF000000000000000000D4C1C600D9B59400F7C66900FFD3
      7500FFD77C00FFDA8300FFDC8600FFDE8900FFDE8A00FFDD8700FFDB8500FFD8
      8200FFD67E00FED07700E1A57F00D7ADAF00E0C8C800DEC2C200D7AFB000B887
      8900C2999B00CFA3A300CB9D9D00C0959500B98284009D838E00FEFEFF00FEFE
      FF00FEFEFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C2B2BA00E7BF8D00FFD07000FFDA7F00FFDD8800FFE0
      8E00FFE39500FFE59900FFE59900FFE49600FFE19000FFDD8900FFD98000FED2
      7600D4967600D5ADAF00DBBEBE00D9B9B900D09A9A00BB737300B1777700B983
      8300C1919100B4848400AE6B6D008E707C000000000000000000000000000000
      000000000000C2B2BA00E7BF8D00FFD07000FFDA7F00FFDD8800FFE08E00FFE3
      9500FFE59900FFE59900FFE49600FFE19000FFDD8900FFD98000FED27600D496
      7600D5ADAF00DBBEBE00D9B9B900D09A9A00BB737300B1777700B9838300C191
      9100B4848400AE6B6D008E707C00000000000000000000000000000000000000
      0000C2B2BA00E7BF8D00FFD07000FFDA7F00FFDD8800FFE08E00FFE39500FFE5
      9900FFE59900FFE49600FFE19000FFDD8900FFD98000FED27600D4967600D5AD
      AF00DBBEBE00D9B9B900D09A9A00BB737300B1777700B9838300C1919100B484
      8400AE6B6D008E707C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7E0E000C5B4BA00E8C7
      8600FFDB7A00FFDE8A00FFE39400FFE79C00FFEAA200FFEDA900FFEEAA00FFEA
      A300FFE89D00FFE49600FFDF8C00FDD67F00CB8B7A00D7B5B600D9BBBB00D6B5
      B500CC8F8F00C46B6B00C56D6D00B96B6B00B6707000B0747400AD6667008E70
      7C0000000000000000000000000000000000E7E0E000C5B4BA00E8C78600FFDB
      7A00FFDE8A00FFE39400FFE79C00FFEAA200FFEDA900FFEEAA00FFEAA300FFE8
      9D00FFE49600FFDF8C00FDD67F00CB8B7A00D7B5B600D9BBBB00D6B5B500CC8F
      8F00C46B6B00C56D6D00B96B6B00B6707000B0747400AD6667008E707C000000
      0000000000000000000000000000E7E0E000C5B4BA00E8C78600FFDB7A00FFDE
      8A00FFE39400FFE79C00FFEAA200FFEDA900FFEEAA00FFEAA300FFE89D00FFE4
      9600FFDF8C00FDD67F00CB8B7A00D7B5B600D9BBBB00D6B5B500CC8F8F00C46B
      6B00C56D6D00B96B6B00B6707000B0747400AD6667008E707C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DDD7D800D3C6C500E3C07C00FFDF8400FFE29200FFE89E00FFED
      A800FFF1AF00FFF3B500FFF3B500FFF2B000FFEEAA00FFEAA100FFE49500FCD9
      8600BF828100DFC3C300E2CACA00E9D6D600EEDADB00E3BABA00D18E8E00CC73
      7300C9696900C56D6D00B46465008F707B000000000000000000000000000000
      0000DDD7D800D3C6C500E3C07C00FFDF8400FFE29200FFE89E00FFEDA800FFF1
      AF00FFF3B500FFF3B500FFF2B000FFEEAA00FFEAA100FFE49500FCD98600BF82
      8100DFC3C300E2CACA00E9D6D600EEDADB00E3BABA00D18E8E00CC737300C969
      6900C56D6D00B46465008F707B0000000000000000000000000000000000DDD7
      D800D3C6C500E3C07C00FFDF8400FFE29200FFE89E00FFEDA800FFF1AF00FFF3
      B500FFF3B500FFF2B000FFEEAA00FFEAA100FFE49500FCD98600BF828100DFC3
      C300E2CACA00E9D6D600EEDADB00E3BABA00D18E8E00CC737300C9696900C56D
      6D00B46465008F707B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CFCCCE00D5C9C400CFAF
      7F00FBDA8900FDE49800FEEAA500FFF2B200FFFABE00FFFDC500FFFDC400FFFA
      BF00FFF4B500FFEDA900FFE79B00EDC88700C6908E00F3E7E700F2E5E500F4EA
      E900F8F0F000F6EDED00F1E2E200EDD5D500E1B3B300D4898900B7686A00AC96
      9F0000000000000000000000000000000000CFCCCE00D5C9C400CFAF7F00FBDA
      8900FDE49800FEEAA500FFF2B200FFFABE00FFFDC500FFFDC400FFFABF00FFF4
      B500FFEDA900FFE79B00EDC88700C6908E00F3E7E700F2E5E500F4EAE900F8F0
      F000F6EDED00F1E2E200EDD5D500E1B3B300D4898900B7686A00AC969F000000
      0000000000000000000000000000CFCCCE00D5C9C400CFAF7F00FBDA8900FDE4
      9800FEEAA500FFF2B200FFFABE00FFFDC500FFFDC400FFFABF00FFF4B500FFED
      A900FFE79B00EDC88700C6908E00F3E7E700F2E5E500F4EAE900F8F0F000F6ED
      ED00F1E2E200EDD5D500E1B3B300D4898900B7686A00AC969F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF00D3CCCE00AA999C00AC9B9D00BDA79600C6B29A00D4C0
      A200E8DEB600F4F1C100F8F5C500FDF9C700FFFBBF00FFF7B100FFEFA200E8C6
      8A00CA999800EAD3D400E8CFCF00E5CBCB00E1C6C500E2C9C800E2CACA00E3CE
      CE00DEC8C800D3B4B400D2B5B600000000000000000000000000000000000000
      0000BFBFBF00D3CCCE00AA999C00AC9B9D00BDA79600C6B29A00D4C0A200E8DE
      B600F4F1C100F8F5C500FDF9C700FFFBBF00FFF7B100FFEFA200E8C68A00CA99
      9800EAD3D400E8CFCF00E5CBCB00E1C6C500E2C9C800E2CACA00E3CECE00DEC8
      C800D3B4B400D2B5B6000000000000000000000000000000000000000000BFBF
      BF00D3CCCE00AA999C00AC9B9D00BDA79600C6B29A00D4C0A200E8DEB600F4F1
      C100F8F5C500FDF9C700FFFBBF00FFF7B100FFEFA200E8C68A00CA999800EAD3
      D400E8CFCF00E5CBCB00E1C6C500E2C9C800E2CACA00E3CECE00DEC8C800D3B4
      B400D2B5B6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CAC9C900E4E1E100DDD8
      D900CBC2C500C4B6B800BDAAAE00B6A0A200B79FA200B9A09800C2A99D00C9B1
      9D00D5BEA000E5CFA000EFD49700D7AE8900C18F8E00D4B0AF00D8B8B800D8B9
      B900D9BDBE00DEC7C700DBC5C500E3D3D3000000000000000000000000000000
      000000000000000000000000000000000000CAC9C900E4E1E100DDD8D900CBC2
      C500C4B6B800BDAAAE00B6A0A200B79FA200B9A09800C2A99D00C9B19D00D5BE
      A000E5CFA000EFD49700D7AE8900C18F8E00D4B0AF00D8B8B800D8B9B900D9BD
      BE00DEC7C700DBC5C500E3D3D300000000000000000000000000000000000000
      0000000000000000000000000000CAC9C900E4E1E100DDD8D900CBC2C500C4B6
      B800BDAAAE00B6A0A200B79FA200B9A09800C2A99D00C9B19D00D5BEA000E5CF
      A000EFD49700D7AE8900C18F8E00D4B0AF00D8B8B800D8B9B900D9BDBE00DEC7
      C700DBC5C500E3D3D30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E2DFDF00E4DBDB00E0D6
      D600D8CACB00CAB5B600C0A2A300BFA1A300BF9CA000C0989B00C69C9500BB8C
      8400A97D7F00D2BDBF00ECE3E300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E2DFDF00E4DBDB00E0D6D600D8CA
      CB00CAB5B600C0A2A300BFA1A300BF9CA000C0989B00C69C9500BB8C8400A97D
      7F00D2BDBF00ECE3E30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E2DFDF00E4DBDB00E0D6D600D8CACB00CAB5
      B600C0A2A300BFA1A300BF9CA000C0989B00C69C9500BB8C8400A97D7F00D2BD
      BF00ECE3E3000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E8DD
      DD00E1D0D000D0B6B700CAA9AB00B5898C00CCBCBF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E8DDDD00E1D0
      D000D0B6B700CAA9AB00B5898C00CCBCBF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E8DDDD00E1D0D000D0B6
      B700CAA9AB00B5898C00CCBCBF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6CECE00BDA59C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A4A4A00313131003131310031313100313131002929
      290063636300DEB5B500C6736B00733931001018180031313100393939003131
      3100313131003131310031313100313131003131310031313100313131003131
      3100313131002931290052525200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C9C8C00428442008CBD
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B594A500947B840094737B008C636B008C636B0094637300945A
      6B008C5A6B008C5A63008C5A630094636B00946B73008C636B009C738400AD8C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C8C8C00DEDE
      DE00D6D6D600D6D6D600D6D6D600D6D6D600D6D6CE00EFD6D600DEAD9400BD6B
      6B00634A4200636B73009CA5A500CECECE00D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600BDBDBD00313931000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084948400298C390010A531005AAD5A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000094526300A56B7300AD737B00B57B8400BD8C
      8C00CE9C9C00C68C9400C6949C00D6ADAD00CE9C9C00C6949400BD8C8C00B584
      8400AD7B7B009C636B00945A6300945A5A008C525A008C4A5A00844A5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A50000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000EFE7E700EFDEDE00E7C6C600B56B6B009C6331007B736B00ADB5
      B500FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000CED6CE0031313100000000000000000000000000000000000000
      000000000000CEC6C600B59CA500A58C94009C848C009C849400AD949C00C6B5
      BD0000000000000000000000000084948400298C390031CE630031CE5A0063AD
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000945A6300AD84
      7B00B58C8C00BD8C8C00C69C9C00D6ADA500CEA5AD00BD946B00BD945200C694
      9400D6ADAD00CE9C9C00BD949400B58C8C00B5848400A57373009C6B6B009C63
      63009C6B63009C6B6B009C6363007B4252000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CEC6C600B59C
      A500A58C94009C848C009C848C00A58C9400B59CA500CEBDBD00000000000000
      00000000000000000000000000000000000000000000428C4200428C4200428C
      4200428C4200428C420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000BDC6BD00D6D6D600D6D6D600CECECE00BDBDBD00D6D6D600D6D6D600E7CE
      BD00BD7B6300CE5A0000C66B1800635A4A008C8C9400C6C6C600CECECE00C6C6
      C600CEC6CE00C6C6C600CEC6CE00C6C6C600DEDEDE00D6D6D600313131000000
      0000000000000000000000000000B59CA5009C737B009C7B8400AD8C8C00AD84
      8C00AD848400AD848C00A5848400AD949C00CEB5BD00000000007B947B00298C
      390029C65A0042E77B0031C6520063AD63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A56B7300B5848400B5848C00C6949400CE9CA500DEB5
      B500C69CA500C69C4A00DEC63900CEAD4A00C6948C00D6ADAD00CE9C9C00BD94
      9400B5848400AD7B7B00A56B6B009C6363009C6363009C6B63009C6363007B42
      5200000000000000000000000000000000000000000000000000000000000000
      0000B59CA5009C737B009C7B8400AD8C8C00AD848C00AD848400A57B8400946B
      73008C636B008C6B7300A5848C00CEBDC600000000000000000000000000428C
      4200428C420084FFB50084FFB5007BFFA5007BF79C0073EF9400428C4200428C
      4200000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A50000000000CECECE000000000000000000FFFF
      FF00CECECE000000000000000000E7CEB500C65A0800D6843100DE6B0800BD5A
      08004A3931005A5A6300949494009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C00E7E7E700D6D6D60031313100000000000000000000000000AD8C9400BDA5
      A500D6CECE00DED6D600DED6D600DECECE00DECECE00DEC6C600DECECE00EFDE
      DE00DED6D6007B8C7B002184310029BD520039D66B0042DE730031C65A004294
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5737300B584
      8400BD8C8C00C69C9C00CEA5A500DEB5B500C69CA500D6BD6300E7CE5A00EFD6
      6300CEAD8C00BD949C00D6ADAD00BD949400B5848400B5848400A57373009C63
      6B009C6363009C6B6B00945A5A008C6373000000000000000000000000000000
      00000000000000000000D6CECE00AD8C9400BDA5A500D6CECE00DED6D600DED6
      D600DECECE00DECECE00D6BDBD00CEADAD00CEB5B500CEADAD00C6A5A500CEBD
      C6000000000000000000428C42008CFFBD00ADFFD600C6FFE700C6FFDE00A5FF
      D6008CFFBD007BFFA50073F79C0073EF8C00428C420000000000428C4200428C
      4200000000000000000000000000000000000000000000000000A5A5A5000000
      0000C6C6C600E7E7E700DEDEDE00DEDEDE00C6C6C600E7E7E700DEDEDE00DEE7
      E700C69C6300D66B0800D6843100D6630000C65A08006B5A52005A5A6300CECE
      CE00CECECE00DEDEDE009C9C9C00CECECE0000000000CED6CE00313131000000
      000000000000BD9CA500DED6D600E7E7E700E7E7E700DEDEDE00DEDEDE00DED6
      D600DED6D600D6C6BD00E7D6D600DECED6007B8C7B00218C310021BD420031CE
      5A0039CE6B0042DE730042D66B0029A54200399C4A00429C5200429C52003994
      4A0000000000398C420031944200399C4A00318C39006BAD7300000000000000
      00000000000000000000C69CA500A5737300BD949400CE9C9C00D6ADAD00D6AD
      AD00CEADB500EFE7CE00E7D66B00F7E78C00FFF7E700C69CA500C6949400C694
      9400B58C8C00B5848400A57373009C636B009C6363009C6B6B0084425200B5A5
      A500000000000000000000000000000000000000000000000000BD9CA500DED6
      D600E7E7E700E7E7E700DEDEDE00DED6D600DED6D600D6CECE00BDA5A500B594
      9400BD9C9C00D6BDBD00EFDEDE00EFE7E70000000000428C42008CFFBD006BE7
      8C005ABD5A005ABD5A005ABD5A006BD66B00CEFFE7008CFFBD007BFFA5007BF7
      9C0073EF9400428C42005ADE7B00428C420000000000BDA5A500BDA59C00BDB5
      B500CECECE00DEDEDE0084848400EFEFEF00BDC6BD00EFEFEF00EFEFEF00EFEF
      EF00CECECE00EFEFEF00EFEFEF00E7E7E700CECECE00E79C5200CE6B0800D684
      3100D6630000C66308004A392900848C8C00BDBDBD00DEE7DE009C9C9C00CECE
      CE0000000000CED6CE003131310000000000CEB5B500DED6D600EFEFEF00EFEF
      EF00EFEFEF00E7E7E700E7E7E700E7DEDE00DECECE00EFE7E700DED6DE00738C
      7B00188C290018B5390029C64A0031CE5A0039CE6B0039D6730042DE7B004AE7
      7B004AE77B0052EF84005AFF940039D6630052A55A0029B54A0042EF7B0052FF
      8C0031D65A00429C4A000000000000000000000000000000000000000000AD73
      7B00B5848400CE9C9C00D6ADAD00CEA5A500D6ADAD00FFFFFF00F7E78C00EFC6
      3900FFF7D600FFF7F700C6948C00BD8C8C00BD8C8C00B5848400A56B73009C6B
      6B009C6B63008C4A5200A5737B00000000000000000000000000000000000000
      000000000000CEB5B500DED6D600EFEFEF00EFEFEF00EFEFEF00E7E7E700E7DE
      DE00DEDEDE00CEBDBD00D6BDBD00C6BDC600B5A5AD00CEBDBD00EFDEDE00EFE7
      E70000000000428C42005ABD5A005ABD5A00EFF7F700EFF7F700EFF7F700EFF7
      F7005ABD5A00CEFFE7008CFFBD007BFFA5007BF79C0073EF940073E78C00428C
      4200BDADA500B5846B00CE8C7B00B57363009C736300947B73006B5A52008C84
      84008C8C8C00C6CECE00DEDEDE00EFEFEF00CECECE000000000000000000FFFF
      FF00CECECE0000000000D6843900D66B1000DE843100D6630000BD6308006B5A
      4A00737B7B00CECECE0094949400CECECE0000000000CED6CE00313131000000
      0000CEB5B500EFEFEF00EFEFEF00F7F7F700F7F7F700EFEFEF00E7E7E700E7E7
      E700E7D6D600DECED6005A735A001884210018B5290021BD390029C64A0031CE
      5A0039CE6B0042D6730042DE7B004AE784005AEF8C005AF794006BFFA5004ADE
      730063AD630039BD520052F78C0063FF9C0042DE73004AA55200000000000000
      000000000000000000000000000000000000B58C8C00B5848400CEA5A500D6AD
      AD00D6A5A500FFF7F700CEDECE00ADAD7300ADBDB500BDE7FF00BDCED600B584
      7B00BD847B00AD7B7B00A5737300945A5A008C4A5200B5848C00000000000000
      00000000000000000000000000000000000000000000CEB5B500EFEFEF00EFEF
      EF00F7F7F700F7F7F700EFEFEF00E7E7E700DEE7E700C6ADAD00DECECE00C6AD
      AD00C6B5B500E7D6D600EFDEDE00EFE7E700428C420052BD5200EFF7F700EFF7
      F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F70042B54200CEFFE7008CFF
      BD0084FFAD007BFFA50073F79C00428C4200C6948400FFC6AD00FFD6B500FFC6
      A500EFA58C00EFA58400DE9C8400C6847300A56B630084635A00736363006B6B
      6B0073737300A5A5A500CECEC600CECECE00BDBDBD00D6D6D600EFF7EF00CE8C
      3900D6731000DE843100D6630000C6731800635242006B6B630052525200ADAD
      AD0000000000D6D6D6003131310000000000DEC6C600E7EFEF00F7F7F700FFFF
      FF00FFFFFF00F7F7F700EFEFEF00EFE7E700E7E7E7006B8C6B000884180010AD
      180018B5290021B5390029C64A0031CE5A0039CE6B0039D6730042DE7B004AE7
      7B0052EF84005AF78C0063FF9C0042D66B005AAD630039BD520052F78C005AFF
      9C0042DE6B004AA5520000000000000000000000000000000000000000000000
      000000000000CEADB500B5848C00CE8C8400BD9CA50084BDEF005AB5FF0052B5
      FF004AB5FF004AADFF005ABDFF006BA5DE009C848C00B5736300945A5A00A573
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000DEC6C600E7EFEF00F7F7F7000000000000000000F7F7F700E7E7
      E700DEDEDE00C6A5A500DEBDBD00BD9C9C00D6B5B500EFDEDE00EFDEDE00F7EF
      EF0039AD3900EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7
      F700EFF7F700EFF7F7005ABD5A008CFFBD0084FFB50084FFAD007BFFA500428C
      4200C69C8C00FFC6AD00FFD6B500E7A58C00D68C7B00DE947B00FFC6A500E7A5
      8C00E79C7B00F7AD8C00DE9C8400C6846B00A5736300847B7300D6D6D600FFFF
      FF00CECECE000000000000000000FFFFFF00D6843900D67B2100DE7B2900CE5A
      0000BD633100C6846300736B52004A525200ADADAD00C6C6C600313931000000
      000000000000DECECE00F7F7F700EFD6D600EFD6DE00EFE7E700EFEFEF00E7DE
      DE00D6D6CE00398C420008A5100010AD180018B5290021B5390029C64A0031CE
      5A0039CE6B0039D6730042DE7B004AE77B0052EF84005AF7940063FF9C0042D6
      6B005AAD630039BD520052F78C005AFF9C0042DE6B004AA55200000000000000
      000000000000000000000000000000000000000000000000000000000000AD94
      A50063ADE70063C6FF0073C6FF006BC6FF006BBDFF0063BDFF005AB5FF0052BD
      FF005AB5F7007B738400A5737300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DECECE00F7F7
      F700EFD6D600EFD6DE00EFE7E700EFEFEF00DECECE00CEADAD00D6ADAD00C694
      9400D6ADAD00EFDEDE00EFDEDE00F7EFEF004A52E70042429400424294004242
      9400424294004242940042429400EFF7F700EFF7F7005ABD5A00CEFFE700C6FF
      E700C6FFE700C6FFE700C6FFE700428C4200C69C8C00FFC6AD00FFCEB500E7AD
      9400FFDEC600FFCEA500D69C8400DE9C8400DE9C7B00EFAD9400E7A58400D694
      7300FFBD9400C69C8400ADADAD00EFEFEF00CECECE00F7F7F700000000000000
      0000FFFFF700D67B3100D67B2100DE8C5A00C67B8400CE733100CE735200AD6B
      6B005A5A5A007B7B7B0039393900000000000000000000000000DECECE00CE9C
      9C00CE8C8400D6ADBD00DEBDC600D6BDBD00E7CECE00B5BDAD002994390008A5
      180018B5290021BD390029C64A0031CE5A0039D66B0042D6730042DE7B004AE7
      7B0052EF84005AF7940063FF9C0042D66B005AAD630039BD520052F78C005AFF
      9C0042DE6B004AA5520000000000000000000000000000000000000000000000
      000000000000000000000000000084CEFF0073CEFF008CCEFF0084CEFF0084CE
      FF007BC6FF0073C6FF006BBDFF005AB5FF0052BDFF004AA5E700738C94000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DECECE00CE9C9C00CE8C8400D6ADBD00D6BD
      BD00CEA5A500CE9C9C00CE8C8C00CE848400DEA5A500EFCECE00EFDEDE00F7EF
      EF004A52E700C6CEFF006B6BFF005A63FF005252FF004A4AFF0042429400EFF7
      F700EFF7F7005ABD5A005ABD5A005ABD5A005ABD5A005ABD5A005ABD5A005ABD
      5A00C6948C00FFC6AD00FFD6B500F7BD9C00EFCEB500EFD6B500E7AD8C00EFCE
      B500FFE7C600DEA58C00DEA58C00F7B59400EFAD8C00D6A594008C949400D6D6
      D600C6C6C600D6D6D600FFFFFF000000000000000000DEC6BD00CE8C7300EFD6
      D600E7AD8400CE5A0000C65A1000A57373007B6B6B0039424200292929000000
      00000000000000000000E7CECE00C6949400FFBD5A00F7BD7B00E7B59C00D6B5
      B500DEADAD00EFBDBD00B5BDA5003194420010A5210021BD390029C64A0031CE
      5A0039D66B0042D6730042DE7B004AE77B0052EF84005AF7940063FF9C0042D6
      73005AAD630039BD520052F78C0063FF9C0042DE6B004AA55200000000000000
      0000000000000000000000000000000000000000000000000000BDE7FF007BC6
      FF0094D6FF0094D6FF0094D6FF008CCEFF008CCEFF0084CEFF0073C6FF0063BD
      FF005AB5FF0052BDFF004A8CBD00B5B5AD000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7CE
      CE00C6949400FFBD5A00F7BD7B00DEAD9400CEA5A500C6848C00C66B6B00CE73
      7300D68C8C00E7ADAD00EFDEDE00F7EFEF004A52E700BDC6FF007B84FF006B73
      FF006363FF0042429400EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7
      F700EFF7F700EFF7F700EFF7F70042429400D6A59400FFC6B500FFD6B500FFC6
      A500CE947B00DEA58C00FFCEAD00EFBD9C00E7C6AD00EFB59C00EFBDA500FFEF
      CE00EFBD9C00D6A59400B5BDB50000000000CECECE000000000000000000FFFF
      FF00D6D6D60000000000FFE7DE00D67B2900E78C2900E79C4A00D66300008452
      180084636300846B730010101800000000000000000000000000E7CECE00CE8C
      7B00FF9C0800FFAD1800FFBD4A00F7BD6B00EFBD9C00E7BDBD00F7C6CE00C6C6
      B50042A5520010AD310029C64A0031CE5A0039CE6B0039D66B0042DE7B004AE7
      84005AEF8C005AF794006BFFA50042DE73005AAD630031BD4A0052F78C0063FF
      9C0042DE6B004AA5520000000000000000000000000000000000000000000000
      00000000000000000000ADD6FF0094D6FF00A5DEFF00ADDEFF00A5DEFF009CD6
      FF0094D6FF008CD6FF0084CEFF0073C6FF0063BDFF005ABDFF004AA5E70094A5
      AD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E7CECE00CE8C7B00FF9C0800FFAD1800FFBD
      4200F7BD6300EFB58C00D69C9C00D67B8400CE737B00D68C8C00EFDEDE00F7EF
      EF004A52E700BDC6FF008C8CFF007B8CFF00737BFF006B6BFF0042429400EFF7
      F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700424294004242
      9400D6A59400FFCEB500FFD6BD00DEA58C00E7A58400DE9C7B00F7BD9C00CE94
      7B00C6846B00FFC6A500F7BD9C00D6A58C00FFC6A500CEA58C008C949400D6D6
      D600C6C6C600DEDEDE00DEDEDE00D6D6D600C6C6C600DEDEDE00DEDEE700CECE
      B500C6732900E78C3100E7944200D66300007B5229007B6363005A4A4A000000
      00000000000000000000DEC6C600D68C7300FFA52100FFAD2900FFAD2900FFB5
      3100FFBD4A00FFC66B00F7CEA500FFDED600CED6C6004AA55A0018AD390031CE
      5A0039CE6B0042D6730042D66B0039C65A0039C65A0042C663004ACE6B0031B5
      4A005AAD6B00B5DEB50039CE630042CE630029B542004AA55A00000000000000
      0000000000000000000000000000000000000000000000000000ADDEFF00ADDE
      FF00B5DEFF00B5DEFF00B5DEFF00B5DEFF00A5DEFF0094D6FF008CCEFF007BC6
      FF006BBDFF005ABDFF0052B5F7008C9CB5000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEC6
      C600D68C7300FFA52100FFAD2900FFAD2100FFB52900FFBD3900FFB55200EFB5
      7B00DEAD9400DEADA500EFDEDE00F7EFEF004A52E700B5BDFF008C94FF00C6CE
      FF00848CFF007B84FF006B73FF0042429400EFF7F700EFF7F700EFF7F700EFF7
      F70042429400424294004242940000000000D6A59400FFCEBD00FFD6B500E7B5
      9C00FFE7CE00FFD6BD00D69C8400E7B59C00F7BD9C00E7AD8C00D69C8400D68C
      7300EFB59400D6AD94009C9C9C00EFEFEF00CECECE00F7F7F700EFEFEF00EFEF
      EF00CECECE00F7F7F700EFEFEF00EFEFF700CECED600E7945200E78C3100E78C
      3900CE63080094523900AD737300000000000000000000000000DEBDC600DE9C
      6300FFAD3100FFB53100FFBD3900FFBD4200FFBD4200FFBD4A00FFC66300FFCE
      8400FFE7BD00D6D6C6004AA55A0021B5420039D66B0042DE730031C65A00429C
      4A00B5CEAD00BDD6BD00BDD6B500B5CEB500CEDEC600CEB5AD00ADC6AD00BDD6
      BD00B5D6B5000000000000000000000000000000000000000000000000000000
      00000000000000000000B5E7FF00BDEFFF00D6F7FF00DEFFFF00D6FFFF00CEF7
      FF00B5EFFF00A5DEFF008CD6FF0084CEFF0073BDFF0063C6FF0052A5DE00525A
      6300E7DED6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEBDC600DE9C6300FFAD3100FFB53100FFBD
      3900FFBD3900FFBD3900FFBD3900FFBD4200FFBD4200FFCE7B00FFE7CE00F7EF
      E7004A52E700B5BDFF004A52E7008C94FF00C6CEFF008C8CFF007B8CFF00737B
      FF00424294004242940042429400424294004A52FF00424AFF004A52E7000000
      0000D6A59400FFD6BD00FFDEB500FFC6A500E7C6AD00E7CEAD00EFBD9C00EFCE
      B500FFEFCE00DEAD9400E7B59C00FFDEC600EFB59C00D6AD9400ADADA500FFFF
      FF00CED6CE000000000000000000FFFFFF00CECECE000000000000000000FFFF
      FF00CECECE0000000000DE944200DE842900DE842900CE630800C6A59C000000
      00000000000000000000CEADB500EFAD5A00FFBD3900FFBD4200FFBD4A00FFBD
      4A00FFC65200FFC65200FFC65A00FFCE6B00FFD68400FFE7AD00DEDEBD0052A5
      630021B54A0042DE730031C6520063AD6300EFDEDE00F7E7E700F7DEDE00E7C6
      C600CEADAD00BD9494009C7B8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5DEFF008CA5
      B500737373005A63630063636300737B7B00949CA5008CBDDE0094D6FF008CD6
      FF0073CEFF006BCEFF00314A630010080000CECECE0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CEAD
      B500EFAD5A00FFBD3900FFBD4200FFBD4A00FFBD4A00FFC65200FFC65200FFBD
      4A00FFBD4A00FFCE7300FFDEA500FFF7D6007B7BE7005252E700F7EFEF004A52
      E700848CFF00C6CEFF00C6CEFF00848CFF007B84FF006B73FF006363FF005A5A
      FF008C94FF004A52E7000000000000000000DEAD9400FFD6C600FFDEBD00F7C6
      A500C6846B00DE9C8400FFD6B500EFBD9C00D6AD9400F7CEAD00F7C6AD00F7DE
      BD00F7C6A500D6AD940084848400CECECE00BDBDBD00CECECE00CECECE00CECE
      CE00BDBDBD00CECECE00CECECE00CECECE00BDBDBD00CED6D600BDC6C600C69C
      5A00DE8C2100E77B1800A56342000000000000000000EFDEDE00CEADA500F7B5
      5A00FFC64A00FFC65200FFC65A00FFC65A00FFCE5A00FFCE6300FFCE6300FFCE
      6300FFCE7300FFD68C00FFE7AD00DEDEBD0052A5630029BD520029C6520063AD
      6300DED6CE00D6BDBD00D6ADAD00DEB5B500CE9C9C00B5848400947B84000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0052525A00000000000808080010101000212121003939
      390042393900423939005A5A6300637B94005A94C60029526B00000000000808
      0800CECECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C69CA500F7B55A00FFC64A00FFC65200FFC6
      5A00FFC65A00FFCE5A00FFCE5A00FFC65A00FFC65A00FFD66300FFDE9400FFE7
      CE00F7E7DE00EFE7E700F7E7E700F7EFEF004A52E7004A52E7008C94FF00C6CE
      FF00BDC6FF00A5ADFF008C94FF004A52E7004A52E70000000000000000000000
      0000DEA59400FFD6C600FFDEBD00D6A58C00EFB59C00EFA58C00EFBD9C00D69C
      7B00D68C7300F7BDA500CEB5AD0084849C00EFCEB500D6B59C00ADADAD00FFFF
      FF00CED6CE000000000000000000FFFFFF00CECECE000000000000000000FFFF
      FF00CECECE000000000000000000FFFFFF00C6AD7300CE9452006B524A000000
      000000000000E7D6D600CEAD9C00F7BD5A00FFCE5A00FFCE6300FFCE6B00FFCE
      6B00FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFD67300FFD68C00FFDE
      B500D6CECE0063AD7300109C290052A56300D6BDBD00CEADAD00BD949400B584
      8400AD848400AD737B0094737B00000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00181818004A4A
      4A0073737300848484008C8C8C00737373006B6B6B005A5A5A00423939001008
      0800312929008C848400A5A5A5004A4A4A008C8C8C0000000000000000000000
      0000000000000000000000000000000000000000000000000000E7D6D600C69C
      9C00F7BD5A00FFCE5A00FFCE6300FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFCE
      6B00FFCE6B00FFD66300FFDE9400F7DECE00EFDEDE00EFE7E700EFE7E700EFE7
      E700EFE7E700F7EFEF004A52E7004A52E7004A52E7004A52E7004A52E700DEDE
      E70000000000000000000000000000000000DEA59400FFDECE00FFDEBD00E7BD
      9C00FFEFD600FFDEC600D6A58C00EFC6AD00FFDEBD00E7B59400638CCE004A7B
      FF0094A5C600DEB594009C9C9C00E7E7E700CECECE00EFF7EF00EFEFEF00E7EF
      E700C6CEC600EFF7EF00EFEFEF00E7EFE700C6CEC600EFF7EF00EFEFEF00E7E7
      E700D6D6D600CECECE00313131000000000000000000E7CECE00DEB59400F7C6
      6300FFCE6B00FFD66B00FFD67300FFD67B00FFD67B00FFD67B00FFD67B00FFD6
      7B00FFD67300FFD67300FFD67B00EFBD9C00EFCECE00E7E7DE0094C69C00ADCE
      AD00CEADAD00C69C9C00AD7B7B00AD7B7B00AD7B7B00AD6B73008C737B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00525252006B6B6B00848484008C8C8C00949494009C9C
      9C008C8C8C00737373005252520031313100B5B5B5000000000000000000DEDE
      DE009C9C9C000000000000000000000000000000000000000000000000000000
      00000000000000000000DECED600DEB59400F7C66300FFCE6B00FFD66B00FFD6
      7300FFD67B00FFD67B00FFD67B00FFD67B00FFD67300FFD67300FFD67B00FFDE
      A500F7D6B500E7BDC600EFDEDE00EFDEDE00EFDEDE00F7E7E700F7E7E700F7EF
      EF00F7EFEF00F7EFEF00F7EFEF00EFE7E7000000000000000000000000000000
      0000DEA59400FFDED600FFDEBD00FFCEAD00E7C6AD00E7C6AD00F7C6A500E7C6
      B500F7E7C600E7BD9C0084ADCE008CBDFF008CADD600D6B59400948C8C00D6DE
      D600C6C6C600DEDEDE00DEDEDE00D6DED600C6C6C600DEDEDE00DEDEDE00D6DE
      D600C6C6C600DEDEDE00DEDEDE00D6D6D600D6D6D600D6D6D600313131000000
      000000000000DEC6C600DEBD9400F7C66B00FFD67300FFD67B00FFDE8400FFDE
      8400FFDE8C00FFDE8C00FFDE8400FFDE8400FFD67B00FFD67B00FFD67300E7AD
      8400DEBDBD00EFD6D600EFD6D600E7C6C600C6949400C69C9C00CE9C9C00C68C
      8C00B5848400AD6B73008C737B00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B005A5A
      5A008484840094949400ADADAD00ADADB5009C9C9C008C8C8C006B6B6B005A5A
      5A00DEDEDE0000000000FFFFFF00FFFFFF00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000D6C6C600DEB5
      9400F7C66B00FFD67300FFD67B00FFDE8400FFDE8400FFDE8C00FFDE8C00FFDE
      8400FFDE8400FFD67B00FFD67300FFD67300E7A57B00DEADAD00E7CECE00E7CE
      CE00DEBDBD00EFDEDE00EFDEDE00F7E7E700EFE7E700EFDEDE00E7CECE00EFDE
      DE0000000000000000000000000000000000DEA59400FFDED600FFDEBD00FFDE
      BD00FFCEAD00FFCEB500FFDEBD00F7D6B500EFC6A500FFDEB500D6CEBD008CB5
      CE00CEC6C600DEB5A500ADADAD00FFFFFF00CECECE000000000000000000FFFF
      FF00CECECE000000000000000000FFFFFF00CECECE000000000000000000FFFF
      FF00D6D6D600D6D6D600313131000000000000000000D6C6BD00E7BD8C00FFD6
      7300FFDE7B00FFDE8C00FFE78C00FFE79400FFE79C00FFE79C00FFE79400FFE7
      9400FFDE8C00FFDE8400FFD67B00DE9C7B00DEB5BD00E7CECE00E7C6C600D6AD
      AD00C6848400B57B7B00BD848400C6949400B5848400AD6B6B008C737B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000737373007B7B7B009C949C00ADA5AD00ADAD
      AD009C9C9C008C8C8C00737373005A5A5A009C9C9C00EFEFEF0000000000EFEF
      EF00DEDEDE000000000000000000000000000000000000000000000000000000
      00000000000000000000C6B5BD00EFB58C00FFD67300FFDE7B00FFDE8C00FFE7
      8C00FFE79400FFE79C00FFE79C00FFE79400FFE79400FFDE8C00FFDE8400FFD6
      7300D6947300D6ADAD00DEBDBD00DEBDBD00D6A5A500CE949400CEA5A500D6B5
      B500DEC6C600D6BDBD00CEA5A500AD949C000000000000000000000000000000
      0000DEAD9400FFE7DE00FFDEC600F7C6A500E7B58C00EFB59400E7B59400E7BD
      9C00EFC6A500EFC6AD00EFC6A500F7CEAD00FFEFC600DEBDA50084848400CECE
      CE00BDBDBD00D6D6D600D6D6D600D6D6D600BDBDBD00D6D6D600D6D6D600D6D6
      D600BDBDBD00D6D6D600D6D6D600CECECE00D6D6D600D6D6D600313131000000
      0000EFE7E700CEBDBD00E7C68C00FFDE7B00FFDE8C00FFE79400FFE79C00FFEF
      A500FFEFAD00FFEFAD00FFEFA500FFEF9C00FFE79400FFDE8C00FFD67B00CE8C
      7B00DEB5BD00DEBDBD00DEBDBD00CE949400C6737300C6737300BD6B6B00B573
      7300B5737300AD6363008C737B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000949494007B847B0094949400949494008C8C8C007B7B7B00636363004A4A
      4A0039393900A5A5A500DEDEDE00ADADAD00A5A5A500ADADAD00BDBDBD000000
      0000000000000000000000000000000000000000000000000000C6B5BD00EFC6
      8400FFDE7B00FFDE8C00FFE79400FFE79C00FFEFA500FFEFAD00FFEFAD00FFEF
      A500FFEF9C00FFE79400FFDE8C00FFD67B00CE8C7B00D6B5B500DEBDBD00D6B5
      B500CE949400CE737300CE848400C6848400C68C8C00C6949400BD8484009C84
      8C0000000000000000000000000000000000DEA59400FFEFE700FFDEC600EFA5
      7B00FFB58400FFB58C00FFBD8C00FFBD9400FFB58C00F7B59400F7B59400EFB5
      9400EFC6AD00DEBDA5009C9C9C00F7F7F700FFFFFF00F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000D6D6D6003131310000000000E7DEDE00D6C6BD00E7C68C00FFDE
      8400FFE79400FFEF9C00FFEFAD00FFF7AD00FFF7B500FFF7B500FFF7B500FFEF
      AD00FFEFA500FFE79400FFDE8400C6848400E7C6C600E7CECE00EFD6D600EFDE
      DE00E7BDBD00D68C8C00CE737300CE6B6B00C66B6B00B56363008C737B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600A5A5A5009C9C
      9C009494940084848400848484008484840000000000D6D6D600D6CECE00E7E7
      E700EFEFEF00E7E7E700A5A5A5008C8C8C000000000000000000000000000000
      00000000000000000000D6C6C600E7C67B00FFDE8400FFE79400FFEF9C00FFEF
      AD00FFF7AD00FFF7B500FFF7B500FFF7B500FFEFAD00FFEFA500FFE79400FFDE
      8400BD848400DEC6C600E7CECE00EFD6D600EFDEDE00E7BDBD00D6949400CE7B
      7B00CE737300CE737300BD6B6B00947384000000000000000000000000000000
      0000DEA59400FFEFE700FFDEC600E79C7300FF945200FF9C6300FFA56300FFA5
      6B00FFA56B00FFAD7300FFAD7B00FFB57B00EFAD7B00D6AD9C00ADADA500FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000F7F7F700DEDEDE00DEDEDE00DEDEDE00E7E7E700CECECE004A4A4A000000
      0000D6D6D600D6C6BD00D6B58C00FFDE8C00FFE79C00FFEFA500FFF7B500FFFF
      BD00FFFFC600FFFFC600FFFFBD00FFF7B500FFEFAD00FFE79C00EFCE8400C68C
      8C00F7E7EF00F7E7E700F7EFEF00F7F7F700F7EFEF00F7E7E700EFD6D600E7B5
      B500D68C8C00B56B6B00AD949C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EFE7E700FFFFFF0000000000E77B7300FFFFFF0000000000BDB5
      BD008C8C8C000000000000000000000000000000000000000000D6CEC600CEAD
      7B00FFDE8C00FFE79C00FFEFA500FFF7B500FFFFBD00FFFFC600FFFFC600FFFF
      BD00FFF7B500FFEFAD00FFE79C00EFCE8400C6948C00F7E7E700F7E7E700F7EF
      EF00FFF7F700F7EFEF00F7E7E700EFD6D600E7B5B500D68C8C00B56B6B00AD94
      9C0000000000000000000000000000000000DEA59400FFEFEF00FFE7CE00EFBD
      9C00EF845200F7844A00F7844200F7844200F7844A00FF8C4A00FF944A00FF8C
      4A00F7946300D6B59C00A5ADA500FFFFFF00F7F7F700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700EFEFEF00FFFFFF008C848C009C9C9C009C9C9C009494
      94008C8C8C00525252007B7B7B0000000000CECECE00CEC6C600BDADA500AD9C
      9C00BDA59400C6B59C00D6C6A500EFDEB500F7F7C600FFF7C600FFFFC600FFFF
      BD00FFF7B500FFEFA500EFC68C00CE9C9C00EFD6D600EFCECE00E7CECE00E7C6
      C600E7CECE00E7CECE00E7CECE00DECECE00D6B5B500D6B5B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700F7F7F700FFFFFF000000
      0000F7DED600FFFFFF0000000000FFFFFF009C9C9C0000000000000000000000
      00000000000000000000D6CECE00AD9C9C00AD9C9C00BDA59400CEB59C00D6C6
      A500EFDEB500F7F7C600FFF7C600FFFFC600FFFFBD00FFF7B500FFEFA500EFC6
      8C00CE9C9C00EFD6D600EFCECE00E7CECE00E7C6C600E7CECE00E7CECE00E7CE
      CE00DECECE00D6B5B500D6B5B500000000000000000000000000000000000000
      0000E7AD9C00FFF7F700FFE7CE00FFE7BD00F7D6B500EFBD9C00EFB59400EFAD
      9400E7AD8C00E7A57300E7946300E7845A00EFBD9400DEC6AD00A5A5A500FFFF
      FF00F7F7F700DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00E7E7E700FFFF
      FF00A5A5A50000000000FFFFFF00DEDEDE007373730073737300000000000000
      000000000000E7DEDE00D6CED600CEC6C600C6BDBD00C6B5B500C6ADAD00C6AD
      AD00BDA59C00C6AD9C00CEB59C00D6BDA500E7CEA500EFD69400D6AD8C00C68C
      8C00D6B5AD00DEBDBD00DEBDBD00DEBDBD00DEC6C600DEC6C600E7D6D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF000000000000000000E77B7300FFFFFF00000000000000
      0000C6C6C6000000000000000000000000000000000000000000CECECE00CECE
      CE00CEC6C600C6B5BD00BDADAD00B5A5A500B59CA500BDA59C00C6AD9C00CEB5
      9C00D6BDA500E7CEA500EFD69400D6AD8C00C68C8C00D6B5AD00DEBDBD00DEBD
      BD00DEBDBD00DEC6C60000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFD6BD00FFFFF700FFFFE700FFFF
      D600FFFFDE00FFFFDE00FFF7DE00FFF7D600FFF7D600FFEFCE00FFEFCE00FFE7
      C600FFEFD600E7CEB500ADA5A500FFFFFF000000000000000000000000000000
      0000000000000000000000000000F7F7F700A5A5A50000000000D6D6D6006B6B
      6B0073737300000000000000000000000000000000000000000000000000E7DE
      DE00E7DEDE00E7DEDE00DED6D600DECECE00CEBDBD00C6ADAD00C6ADAD00BD9C
      A500C69C9C00C69C9400BD8C8400AD7B7B00D6BDBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00000000000000
      0000E77B7300000000000000000000000000CECECE0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7D6
      D600DECECE00CEB5B500C6A5A500BDA5A500BD9CA500C69C9C00C69C9400BD8C
      8400AD7B7B00D6BDBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EFE7D600F7E7D600F7DEC600F7E7C600FFE7C600FFE7C600F7E7
      BD00F7E7BD00FFEFC600FFF7CE00FFF7CE00FFFFCE00DECEAD00C6C6C6000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F7009C9C9C00DEDEDE006B6B6B00737373000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EFE7E700E7DEDE00E7D6D600D6B5B500CEADAD00B58C8C00CEBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00F7F7F700FFFFFF0000000000E7847300FFFFFF0000000000F7F7
      F700DEDEDE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E7D6D600D6B5B500CEADAD00B58C8C00CEBDBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000948C8C00F7F7EF00F7EFEF00F7E7D600EFDECE00EFDE
      C600F7DECE00EFDEDE00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00949494006B736B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00E7948C00FFF7F700FFFFFF00EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A59CA5009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00A5A5
      A500525252007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00F7F7F700FFFFFF00F7F7F700EFEFEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005242AD00524AAD00524AAD00524A
      AD00524AAD00524AAD00524AAD00524AAD00524AAD00524AAD00524AAD00524A
      AD005242AD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5524A00AD392900AD5A4200B5634A00B5634A00B573
      6300C68C7B00CE9C8C00D6B5A500DEC6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5BDB5005284
      520063A563000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A42
      AD005A4AB5005A4AB5005A4AB5005A4AB5005A4AB5005A4AB5005A4AB5005A4A
      B5005A4AB5005A4AB5005A4AB5005A4AB5005A4AB5004A42AD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006BAD73000894210042A55A000000000000000000000000000000
      00000000000000000000000000000000000000000000E7DEDE00AD635200BD52
      3900D66B3900D66B3100BD5A3900B55A3900B55A4200BD634200BD735A00BD84
      7300C68C7B00CE9C8C00D6B5A500DEC6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADADAD0042844A0018A5390031A54200A5CEA500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005242AD005A4AB500635AC6005A52CE005252C6005A5A
      CE00635ACE00635ACE00635ACE00635ACE00635ACE005A5ACE005252C6005A52
      CE00635AC6005A4AB50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006BB5730021BD4A0018C6
      520039A54A000000000000000000000000000000000000000000000000000000
      000000000000E7D6DE00AD6B5A00C6635200CE633100D66B3900D66B3900D66B
      3900D66B3900C65A3100BD5A3900B55A3900B55A4200BD634200BD735A00BD84
      7300C6948C00D6ADA500DEC6BD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEC6C600B59CA500A58C
      94009C848C009C848C00A58C9400B59CA500CEBDBD0000000000000000000000
      0000000000000000000000000000000000009CA59C003984420029B54A0039D6
      6B0042B55200A5CEA50000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEC6C600B59CA500A58C
      94009C848C009C848C00AD9CA500D6C6CE0000000000000000005A4AB500635A
      CE005A52CE007B7BDE00A5A5E700736BD6005A52CE006363D6006363D6006363
      D6005A52CE00736BD600A5A5E7007B7BDE005A52CE00635ACE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000073B57B0021BD4A0039DE730018BD4A0039A54A00000000000000
      00000000000000000000000000000000000000000000DECED600B5635200CE7B
      6300C65A3900D66B3900D66B3900D66B3900CE6B3900CE6B3900CE6B3900CE63
      3100CE633100C6633100BD5A3900BD5A3900BD634200C6735200C6846B00BD84
      7B00C6948C00D6ADA500DEC6BD00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B59C
      A5009C737B009C7B8400AD8C8C00AD848C00AD848400A57B8400946B73008C63
      6B008C6B7300A5848C00CEBDC6000000000000000000000000000000000094A5
      94003184390029B54A0039DE730039D66B0039AD4A00BDD6BD00000000000000
      000000000000000000000000000000000000000000000000000000000000B59C
      A5009C737B009C7B8400AD8C8C00AD848C00AD848400A57B8400A57B8400BDA5
      A500DED6D600E7DEDE00524AAD006363D6004242AD009C9CBD0000000000D6D6
      F7006B63D6005A5AD6006363D6005A5AD6006B63D600D6D6F700000000009C9C
      BD004242AD006363D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000529C520021BD4A0039DE
      6B0031D6630018BD4200319C4200000000000000000000000000000000000000
      000000000000E7CECE00BD635A00DE8C7300C6634A00D66B4200D66B3900D66B
      3900CE6B3900D66B3100CE6B3900CE6B3900CE6B3900CE6B3900CE6B3900CE6B
      3900D66B3900C6633100BD5A3100BD5A3900BD634200C6735A00C6846B00BD84
      7B00CE9C9400DEC6C60000000000000000000000000000000000000000000000
      000000000000D6CECE00AD8C9400BDA5A500D6CECE00DED6D600DED6D600DECE
      CE00DECECE00D6BDBD00CEADAD00CEB5B500CEADAD00C6A5A500CEBDC600E7DE
      DE000000000000000000849C84002984390021B54A0039D66B0042DE730039D6
      6B0029A5390084A5840000000000000000000000000000000000000000000000
      00000000000000000000AD8C9400BDA5A500D6CECE00DED6D600DED6D600DECE
      CE00DECECE00D6BDBD00D6BDBD00E7CECE00EFE7E700E7DEDE005242AD00635A
      CE005A52C6004A4A8400BDC6C60000000000DEDEF7006B6BDE005A5AD6006B6B
      DE00DEDEF70000000000BDC6C6004A4A84005A5AC6006363D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063AD6B0029AD420042CE6B0039C6
      630039C65A0029BD520039D6630039D66B0031CE630029CE5A0018B53900299C
      42000000000000000000000000000000000000000000E7CECE00C66B5200EFA5
      8400C66B5A00CE7B5200DE845200D67B4A00D6734A00D6734200D66B3900CE6B
      3900CE6B3900CE6B3900CE6B3900CE6B3900CE6B3900CE6B3900CE6B3900CE63
      3100CE633100C6633100C65A3900BD5A3900BD6B4A00CE9C8C00EFD6CE000000
      00000000000000000000000000000000000000000000BD9CA500DED6D600E7E7
      E700E7E7E700DEDEDE00DED6D600DED6D600D6CECE00BDA5A500B5949400BD9C
      9C00D6BDBD00EFDEDE00EFE7E700DED6D600DED6DE007B947B002184310021B5
      420031CE5A0039D66B0039D6730042DE730031BD5200319C4200429C5200429C
      5200429C520042944A0094BD94000000000000000000BD9CA500DED6D600E7E7
      E700E7E7E700DEDEDE00DED6D600DED6D600D6CECE00BDA5A500B59C9C00CEBD
      BD00EFE7E700F7EFEF00524AAD00635AD6006B63DE005A5AD60042427B00C6C6
      CE0000000000DEDEF7007373DE00DEDEF70000000000C6C6CE0042427B005A5A
      D6006B6BE7006363D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005AAD630039CE630063FF9C0052FF940052F7840042E77B0039DE730031D6
      6B0031CE630029CE520021C6420008B52900299C390000000000000000000000
      000000000000DEC6C600BD6B5A00EFAD8C00CE7B6B00CE7B5A00DE8C6300DE8C
      5A00D68C5A00D67B5200D67B5200D67B4A00D6734200D66B3900CE6B3100CE6B
      3900CE6B3900CE6B3900CE6B3900CE6B3900CE6B3900CE6B3900CE6B3900CE63
      3100C65A3100C67B5A00DEBDAD00000000000000000000000000000000000000
      0000CEB5B500DED6D600EFEFEF00EFEFEF00EFEFEF00E7E7E700E7DEDE00DEDE
      DE00CEBDBD00D6BDBD00C6BDC600B5A5AD00CEBDBD00EFE7E700F7E7E700D6C6
      CE00738C7300218C290018B5390029C64A0031CE5A0039CE6B0039D66B0042DE
      73004ADE7B004AE77B004AEF7B0052F784005AF78C0031C6520063AD63000000
      0000CEB5B500DED6D600EFEFEF00EFEFEF00EFEFEF00E7E7E700E7DEDE00DEDE
      DE00CEBDBD00D6BDBD00CEC6C600C6BDBD00E7DEDE00EFE7E700524AAD006363
      D6006363DE006B73EF006363DE0042427B00C6C6CE00FFFFFF00EFEFFF000000
      0000C6C6CE0042427B006363DE007373EF006B6BDE006363DE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063AD630039CE630063FF9C0052F7
      8C0052EF840042E77B0039DE730031D66B0031CE630029CE520021C6420018BD
      310000AD210018943100000000000000000000000000DEBDBD00BD6B5A00EFAD
      9400DE9C7B00CE735A00DE9C7300DE946B00DE8C6300DE8C6300DE8C6300DE84
      5A00D6845A00D6845200D6734200CE6B3900CE633100CE6B3900CE6B3900CE6B
      3900CE6B3900CE6B3900CE6B3900CE6B3900CE5A3100C6633900D6948C000000
      000000000000000000000000000000000000CEB5B500EFEFEF00EFEFEF00F7F7
      F700F7F7F700EFEFEF00E7E7E700DEE7E700C6ADAD00DECECE00C6ADAD00C6B5
      B500E7D6D600EFE7E700CEC6CE00527352001884210018B5290021BD390029BD
      4A0031C6520039CE630039D66B0042DE73004AE77B0052EF84005AF78C0063FF
      9C006BFFA50042CE63006BB56B0000000000CEB5B500EFEFEF00EFEFEF00F7F7
      F700F7F7F700EFEFEF00E7E7E700DEE7E700C6ADAD00DEC6C600C6ADAD00CEBD
      BD00EFDEDE00EFE7E700524AAD006B63DE00636BDE006B6BE7007373E7006363
      DE0042427B00DEDEDE00FFFFFF00DEDEDE0042427B006363DE007373E7006B73
      E7006B6BE7006B6BDE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063AD630039CE5A005AFF9C0052F78C004AEF840042E77B0039DE730031D6
      6B0031CE630029CE520021C6420018B5310010B5210000A51000109421000000
      000000000000D6B5B500C6735A00EFB59400EFAD9400C6735A00E79C7B00DEA5
      7B00DE9C7300DE947300DE946B00DE946B00DE946300DE8C6300DE845A00D684
      5200D6734200CE633900CE6B3900CE6B3900CE6B3900CE6B3900CE6B3900CE6B
      3900CE5A3100CE6B4200C66B5200000000000000000000000000000000000000
      0000DEC6C600E7EFEF00F7F7F700FFFFFF00FFFFFF00F7F7F700E7E7E700DEDE
      DE00C6A5A500DEBDBD00BD9C9C00D6B5B500EFDEDE00DEDEDE00528452000884
      180010AD180018B5290021B5390029BD4A0031C6520039CE630039D66B0042DE
      73004ADE7B0052E784005AEF8C0063F7940063FF9C0042CE63006BAD6B000000
      0000DEC6C600E7EFEF00F7F7F700FFFFFF00FFFFFF00F7F7F700E7E7E700DEDE
      DE00C6A5A500D6BDBD00BD949400D6B5B500EFDEDE00F7E7E700524AAD006B63
      DE006B6BDE006B6BDE006363DE007373E700D6D6F700FFFFFF00DEDEDE00FFFF
      FF00DED6F700737BE700636BE7007373E7006B73E7006B6BDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063AD630039CE5A005AFF9C0052F7
      8C004AEF840042E77B0039DE730031D66B0031CE630029CE520021C6420018B5
      310010B5210000AD100000A508001884210000000000D6B5B500C67B6300F7BD
      9C00F7B59400D6847300DE947B00E7AD8C00E7AD8400E7A58400E79C8400E79C
      7B00DE9C7300DE946B00DE946B00DE946B00DE8C6B00D67B5200CE6B3900C663
      3100C6633100CE6B3900CE6B3900CE6B3900CE5A3100CE6B4200D6845200CE9C
      94000000000000000000000000000000000000000000DECECE00F7F7F700EFD6
      D600EFD6DE00EFE7E700EFEFEF00DECECE00CEADAD00D6ADAD00C6949400D6AD
      AD00EFDEDE00BDCEBD00298C310008A5100010AD180018B5290021BD390029BD
      4A0031CE5A0039CE630039D66B0042DE73004ADE7B0052E784005AEF8C0063F7
      940063FF9C0042CE63006BAD6B000000000000000000DECECE00F7F7F700EFD6
      D600EFD6DE00EFE7E700EFEFEF00DECECE00CEADAD00CEA5A500C68C8C00D6B5
      B500EFDEDE00F7E7E700524AAD006B6BDE006B6BDE006363E7007373E700DEDE
      F700FFFFFF00C6C6CE0039427300C6C6C600FFFFFF00DEDEF7007373E7006B6B
      E7007373E7006B6BE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063AD630039CE5A005AFF9C0052F78C004AEF840042E77B0039DE730031D6
      6B0031CE630029CE520021C6420018B5310010B5210008AD1000008408003973
      420000000000CEADA500CE7B6B00F7BDA500F7BD9C00DE9C8400CE847300EFBD
      9C00E7B59400E7AD9400E7AD8C00E7A58C00E7A58400E79C8400DE9C7B00DE9C
      7300DE947300DE947300D68C6300D6845A00BD633900BD5A2900CE633900CE6B
      3900CE5A3100CE6B4200D6845A00C67B63000000000000000000000000000000
      00000000000000000000DECECE00CE9C9C00CE8C8400D6ADBD00D6BDBD00CEA5
      A500CE9C9C00CE8C8C00CE848400DEA5A500EFCECE00EFE7E700A5BDA5002994
      390008A5180018B5290021BD390029BD4A0031CE5A0039CE630039D66B0042DE
      73004ADE7B0052E784005AEF8C0063F7940063FF9C0042CE63006BAD6B000000
      000000000000F7E7E700DECECE00CE9C9C00CE8C8400D6ADBD00D6BDBD00CEA5
      A500CE9C9C00CE8C8C00CE848400DEADAD00F7DEDE00F7E7E700524AB5007373
      E7007373E7007B84E700DEDEF700FFFFFF00C6C6C60042427B006363D6004242
      7B00C6C6C600FFFFFF00D6D6F7007B84EF007373E7007373E700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007394730039844200000000000000000063AD630039CE630063FF9C005AFF
      940052F7840042E77B0039DE730031D66B0031CE630029CE520021C6420018BD
      310010B52900088C1800396B39000000000000000000C69C9C00D68C7B00F7C6
      AD00F7BDA500E7AD9400CE847300EFBDA500EFBDAD00EFBDA500EFB59C00E7B5
      9400E7B59400E7AD9400E7AD8C00E7AD8C00E7A58400DE9C7B00DEA58400EFAD
      9400E7A57B00C67B5200C6633900CE633100CE5A2900CE6B4200D68C5A00CE7B
      5200D6B5AD000000000000000000000000000000000000000000E7CECE00C694
      9400FFBD5A00F7BD7B00DEAD9400CEA5A500C6848C00C66B6B00CE737300D68C
      8C00E7ADAD00F7E7E700F7EFEF00ADC6AD00399C4A0010AD290021BD390029C6
      4A0031C6520039CE630039D66B0042DE73004ADE7B0052E784005AEF8C0063F7
      940063FF9C0042CE63006BB56B00000000000000000000000000E7CECE00C694
      9400FFBD5A00F7BD7B00DEAD9400CEA5A500C6848C00C66B6B00CE7B7B00DEA5
      A500F7D6D600F7EFEF00524AB500737BEF006B6BE700BDC6FF00FFFFFF00B5B5
      BD00424A7B00737BDE008C94F7007B84DE00424A7B00B5B5BD00FFFFFF00C6C6
      FF006B73E7007B7BEF0000000000000000000000000000000000000000000000
      00000000000000000000000000006B846B00188C290008A529006BAD6B000000
      000052A55A0029C6520052FF8C004AEF7B0042E7730042E7730039DE730031D6
      6B0031CE630029CE520021C6420010BD3100088C210052845A00000000000000
      000000000000BD949400D6948400F7CEB500EFC6AD00F7C6AD00CE8C7300E7BD
      A500F7CEBD00EFC6AD00EFC6AD00EFBDA500EFBDA500EFB59C00E7B59C00EFB5
      9400E7AD9400E7B59400EFB59C00E7B59C00EFB59400E7B59400D69C7300CE84
      6300CE734A00CE734A00D68C5A00D67B5200CE84730000000000000000000000
      00000000000000000000E7CECE00CE8C7B00FF9C0800FFAD1800FFBD4200F7BD
      6300EFAD8C00D69C9C00D67B8400CE737B00D68C8C00F7E7E700F7F7F700F7EF
      EF00C6CEBD0052A55A0010AD290029C64A0031CE520031CE630039D66B0042DE
      73004AE77B0052EF84005AF78C0063FF9C006BFFA50042CE63006BAD73000000
      00000000000000000000E7CECE00CE8C7B00FF9C0800FFAD1800FFBD4200F7BD
      6300EFAD8C00D69C9C00D6848C00DE9C9C00EFD6D600F7EFEF005A4AB5007B84
      EF008484F7007B84C600636373005A638C008C9CDE009CADF70094ADE7009CB5
      F7008C9CE7005A638C00636373007B84CE00848CF7007B84EF00000000000000
      00000000000000000000000000000000000000000000000000006B846300188C
      290029D6630029BD4A006BB56B00000000008CBD8C00318C4200399C4A003194
      4A0031944200219C310031C65A0039DE6B0031CE630029CE5A0021C642001094
      29005A845A0000000000000000000000000000000000B58C8C00DE9C8C00F7CE
      B500F7C6B500F7CEB500DE9C8C00CE948400F7D6C600F7DEC600F7D6BD00EFCE
      BD00EFCEB500EFC6B500F7C6AD00EFBDA500EFBDA500E7BDAD00EFBDAD00EFC6
      AD00EFBDA500EFBDA500E7BD9C00DEA58C00CE947300DEA58400E7A58400E79C
      7300CE7B5A00E7CECE0000000000000000000000000000000000DEC6C600D68C
      7300FFA52100FFAD2900FFAD2100FFB52900FFBD3900FFB55200EFB57B00DEAD
      9400D6949400DEB5B500EFD6D600F7E7E700F7EFEF00D6DECE005AAD630018AD
      390029C6520039CE6B0039D66B0042DE730039CE630039BD5A0042C663004ACE
      6B004ACE6B0031AD4A0073B57B00000000000000000000000000DEC6C600D68C
      7300FFA52100FFAD2900FFAD2100FFB52900FFBD3900FFB55200EFBD8C00E7C6
      B500EFDEDE00F7E7E700524AB500848CF7008C94F7007B84DE006373A50094A5
      E700A5BDF7009CB5EF009CB5EF009CB5EF00A5BDF70094A5DE005A73A5007B8C
      DE008C94FF008494F70000000000000000000000000000000000000000000000
      00000000000063846300188C290029CE5A0039E7730021BD42007BB57B000000
      000000000000000000000000000000000000000000005294520021B5420039DE
      6B0031D6630021C65200108C29005A845A000000000000000000000000000000
      000000000000B5848400E7AD9C00FFD6BD00F7CEB500F7CEB500F7CEAD00D694
      8400CE847300DE9C8C00DEB5A500EFCEBD00F7CEBD00F7CEBD00F7CEBD00F7CE
      BD00EFCEBD00EFC6B500EFC6AD00F7C6B500EFC6B500EFC6AD00EFBDAD00EFBD
      A500DEAD9400D6A58C00E7B59C00EFBD9C00E7B59400CE948C00000000000000
      00000000000000000000DEBDC600DE9C6300FFAD3100FFB53100FFBD3900FFBD
      3900FFBD3900FFBD3900FFBD4200FFBD4200F7BD6B00E7B59400DEADA500EFCE
      CE00F7EFEF00F7EFEF00D6DED60063AD6B0021AD420031CE630042DE730039D6
      6B0029A542007BAD7B00C6D6C600BDDEBD00BDDEBD00BDD6BD00000000000000
      00000000000000000000DEBDC600DE9C6300FFAD3100FFB53100FFBD3900FFBD
      3900FFBD3900FFBD3900FFC65200FFCE7B00FFE7C600F7E7DE008C7B9400635A
      C60094A5FF00ADCEFF00C6EFFF00B5E7FF00B5DEF700B5DEF700B5DEF700B5DE
      F700B5DEF700B5E7F700BDEFFF00B5CEFF0094ADFF006363CE00000000000000
      0000000000000000000000000000000000005A845A00108C290021C6520031D6
      630039DE6B0021B5420052945200000000000000000000000000000000000000
      0000000000007BB57B0021BD420039E7730029CE5A00188C2900638463000000
      00000000000000000000000000000000000000000000BD847B00E7B5A500FFD6
      C600F7D6BD00F7CEBD00F7CEB500F7CEB500EFBDA500E7A58C00D6947B00CE7B
      6B00CE846B00C6847300CE948400DEAD9C00F7DECE00EFD6C600F7D6C600EFCE
      BD00EFD6BD00EFCEB500EFCEB500F7CEB500F7CEB500E7BDA500DEB59C00E7B5
      A500EFBDAD00D694840000000000000000000000000000000000CEADB500EFAD
      5A00FFBD3900FFBD4200FFBD4A00FFBD4A00FFC65200FFC65200FFBD4A00FFBD
      4A00FFBD4A00FFC64A00FFC66B00EFBD8C00EFC6C600F7EFEF00F7EFEF00DEDE
      D60073B57B0021AD420039D66B0039D66B0039AD4A00ADC6A500E7DEDE000000
      0000000000000000000000000000000000000000000000000000CEADB500EFAD
      5A00FFBD3900FFBD4200FFBD4A00FFBD4A00FFC65200FFC65200FFC65A00FFCE
      7300FFDEA500FFEFCE00F7EFDE008C738C005A4AB500635AB500635AB500635A
      B5005A5AB5005A5AB500635AB5005A5AB5005A5AB5005A5AB5005A5AB500635A
      BD005A52BD000000000000000000000000000000000000000000000000005A84
      5A001094290021C6420029CE5A0031CE630039DE6B0031C65A00219C31003194
      420031944A00399C4A00318C42008CBD8C00000000006BB56B0029BD4A0029D6
      6300188C29006B84630000000000000000000000000000000000000000000000
      000000000000B57B7300E7BDAD00FFDECE00F7D6BD00F7D6BD00F7CEB500F7C6
      B500F7CEB500EFC6AD00F7C6AD00F7C6AD00EFB59400BD948C00C6BDBD00AD84
      8400CE948C00F7E7D600F7DECE00F7DECE00F7D6CE00F7D6C600F7D6C600F7D6
      BD00EFCEBD00F7CEBD00EFC6B500DEB5A500E7BDA500E7B59C00D6ADA5000000
      00000000000000000000C69CA500F7B55A00FFC64A00FFC65200FFC65A00FFC6
      5A00FFCE5A00FFCE5A00FFC65A00FFC65A00FFC65200FFC65200FFC65200F7B5
      5A00DEADAD00EFE7E700F7EFEF00F7EFEF00DED6D60084B5840029AD4A0029CE
      5A0042B552009CBD9400E7DEDE00000000000000000000000000000000000000
      000000000000EFDEDE00C69CA500F7B55A00FFC64A00FFC65200FFC65A00FFC6
      5A00FFCE5A00FFCE5A00FFCE6300FFD67300FFD68C00FFE7B500FFEFCE00FFEF
      CE00F7DEE700F7EFEF00F7EFEF00F7EFEF00EFDEDE00EFDEDE00EFE7E700F7E7
      E700EFE7E700EFDEDE00E7DEDE00000000000000000000000000000000000000
      0000000000000000000052845A00088C210010BD310021C6420029CE520031CE
      630031D66B0039DE730042E7730042E773004AEF7B0052FF8C0029C6520052A5
      5A00000000006BAD6B0008A52900188C29006B846B0000000000000000000000
      00000000000000000000000000000000000000000000B5736B00EFCEBD00FFE7
      CE00F7DEC600F7D6C600F7D6BD00F7CEBD00FFCEB500F7CEB500EFC6AD00EFBD
      A500C6A59400C6C6C600C6C6C600DEDEDE00A5848400CE9C9400EFD6CE00EFD6
      CE00FFE7D600FFE7D600FFEFDE00FFDED600FFDECE00F7DECE00F7D6C600EFCE
      BD00E7BDAD00EFC6B500D69C94000000000000000000E7D6D600C69C9C00F7BD
      5A00FFCE5A00FFCE6300FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFCE
      6B00FFCE6300FFC65A00FFC65200EFAD6300D6A5A500E7D6D600EFDEDE00F7EF
      EF00EFDEDE00DEDED6008CBD9400219C3900299C39009CBD9C00E7DEDE000000
      00000000000000000000000000000000000000000000E7D6D600C69C9C00F7BD
      5A00FFCE5A00FFCE6300FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFD67300FFD6
      7300FFD68400FFDE9400FFE7AD00FFDEC600F7E7E700F7EFEF00F7EFEF00F7EF
      EF00EFDEDE00EFDEDE00EFDEDE00EFDEDE00EFDEDE00EFDEDE00E7DEDE000000
      00000000000000000000000000000000000000000000396B3900088C180010B5
      290018BD310021C6420029CE520031CE630031D66B0039DE730042E77B0052F7
      84005AFF940063FF9C0039CE630063AD630000000000A5CEA500398442007394
      7300000000000000000000000000000000000000000000000000000000000000
      000000000000AD6B6B00F7D6C600FFE7D600F7DECE00F7DEC600F7D6C600F7D6
      C600F7D6BD00FFD6BD00F7CEB500CEA59400BDBDBD00E7E7E700DEDEDE00BDC6
      BD00DEDEDE00BD9C9C00BD949400D6B5A500C69C9400D6A59C00DEA59C00DEB5
      AD00EFC6B500F7D6C600FFDED600FFDECE00F7D6CE00EFD6C600DEAD9C00CEAD
      AD0000000000DECED600D6B59400F7C66300FFCE6B00FFD66B00FFD67300FFD6
      7B00FFD67B00FFD67B00FFD67B00FFD67300FFD67300FFCE6B00FFCE6300E79C
      6B00D69CA500E7CECE00E7CECE00EFD6D600EFDEDE00EFDEDE00DEDED600B5CE
      B50094C69400CEDECE00E7DEDE00000000000000000000000000000000000000
      000000000000DECED600D6B59400F7C66300FFCE6B00FFD66B00FFD67300FFD6
      7B00FFD67B00FFD67B00FFD67B00FFD67B00FFD67B00FFD68400FFD68400EFBD
      9C00E7BDBD00EFDEDE00EFD6D600E7CECE00D6B5B500D6B5B500CEADAD00D6B5
      B500D6B5B500CEADAD00BDADB500000000000000000000000000000000000000
      0000397342000084080008AD100010B5210018B5310021C6420029CE520031CE
      630031D66B0039DE730042E77B004AEF840052F78C005AFF9C0039CE5A0063AD
      6300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD6B6300F7DECE00FFE7
      D600FFE7D600F7E7CE00F7DECE00F7DEC600F7D6C600FFD6BD00D6B5A500BDBD
      B500DEE7E700BDBDBD00CECECE00C6C6C600ADADAD00E7E7E700BDBDBD00C6BD
      BD00E7DEDE00B5A5A500E7D6D600F7D6D600DEC6BD00D6ADA500CE9C9400CEA5
      9400D6A59C00DEB5A500DEADA500B58C840000000000D6C6C600DEB59400F7C6
      6B00FFD67300FFD67B00FFDE8400FFDE8400FFDE8C00FFDE8C00FFDE8400FFDE
      8400FFD67B00FFD67300FFCE6B00DE9C7300D6A5A500DEC6C600DEC6C600DEBD
      BD00D6B5B500E7D6D600F7E7E700EFE7E700EFDEDE00E7CECE00C6B5B5000000
      00000000000000000000000000000000000000000000D6C6C600DEB59400F7C6
      6B00FFD67300FFD67B00FFDE8400FFDE8400FFDE8C00FFDE8C00FFDE8400FFDE
      8400FFDE8400FFD67B00FFD67300E7A57B00D6ADAD00E7CECE00DEC6C600DEB5
      B500BD848400C69C9C00D6A5A500CE9C9C00C6949400BD8484009C848C000000
      0000000000000000000000000000000000001884210000A5080000AD100010B5
      210018B5310021C6420029CE520031CE630031D66B0039DE730042E77B004AEF
      840052F78C005AFF9C0039CE5A0063AD63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B56B6300F7DECE00FFEFDE00FFE7D600FFDED600F7DECE00F7DE
      CE00FFDECE00DEBDA500D6CEC600D6DEDE00BDBDBD00BDC6BD00B5B5B500C6C6
      C600DEDEDE00ADADAD00D6DED600BDBDBD00D6D6D600D6DEDE00BDBDBD00D6DE
      DE00000000000000000000000000FFFFFF00F7EFEF00E7D6D600AD949400E7D6
      D60000000000C6B5BD00E7BD8C00FFD67300FFDE7B00FFDE8C00FFE78C00FFE7
      9400FFE79C00FFE79C00FFE79400FFE79400FFDE8C00FFDE8400FFD67300D694
      7300D6ADAD00DEBDBD00DEBDBD00D6A5A500CE949400CEA5A500D6B5B500DEC6
      C600D6BDBD00CEA5A500AD949C00000000000000000000000000000000000000
      000000000000C6B5BD00E7BD8C00FFD67300FFDE7B00FFDE8C00FFE78C00FFE7
      9400FFE79C00FFE79C00FFE79400FFE79400FFDE8C00FFDE8400FFD67300D694
      7300D6ADAD00DEBDBD00DEBDBD00D69C9C00BD737300B5737300BD848400C694
      9400B5848400AD6B6B008C737B00000000000000000000000000000000000000
      0000000000001094210000A5100010B5210018B5310021C6420029CE520031CE
      630031D66B0039DE730042E77B004AEF840052F78C005AFF9C0039CE5A0063AD
      6300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD737300EFCEBD00FFEF
      E700FFE7DE00FFE7D600FFE7D600FFE7D600E7CEB500CEC6BD00FFFFFF000000
      0000E7E7E700B5B5B500DEE7DE00CECECE00BDBDBD00E7E7E700CECECE00EFF7
      EF00C6C6C600CECECE00DEDEDE00B5B5B500F7F7F70000000000000000000000
      0000FFFFFF00C6CECE00E7EFEF000000000000000000C6B5BD00EFC68400FFDE
      7B00FFDE8C00FFE79400FFE79C00FFEFA500FFEFAD00FFEFAD00FFEFA500FFEF
      9C00FFE79400FFDE8C00FFD67B00CE8C7B00D6B5B500DEBDBD00D6B5B500CE94
      9400CE737300CE848400C6848400C68C8C00C6949400BD8484009C848C000000
      000000000000000000000000000000000000E7E7E700C6B5BD00EFC68400FFDE
      7B00FFDE8C00FFE79400FFE79C00FFEFA500FFEFAD00FFEFAD00FFEFA500FFEF
      9C00FFE79400FFDE8C00FFD67B00CE8C7B00D6B5B500DEBDBD00D6B5B500CE8C
      8C00C66B6B00C66B6B00BD6B6B00B5737300B5737300AD6363008C737B000000
      00000000000000000000000000000000000000000000000000001894310000AD
      210018BD310021C6420029CE520031CE630031D66B0039DE730042E77B0052EF
      840052F78C0063FF9C0039CE630063AD63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEA5A500D69C9400FFEFE700FFEFDE00FFEFDE00FFEFDE00EFD6
      C600CEBDBD00F7FFFF00000000000000000000000000F7F7F700CED6CE00CECE
      CE00D6D6D600CED6CE00F7F7F700CECECE00DEDEDE00DEDEDE00CED6CE00E7E7
      E700EFEFEF000000000000000000FFFFFF00C6C6C600E7E7E700000000000000
      000000000000D6C6C600E7C67B00FFDE8400FFE79400FFEF9C00FFEFAD00FFF7
      AD00FFF7B500FFF7B500FFF7B500FFEFAD00FFEFA500FFE79400FFDE8400BD84
      8400DEC6C600E7CECE00EFD6D600EFDEDE00E7BDBD00D6949400CE7B7B00CE73
      7300CE737300BD6B6B0094738400000000000000000000000000000000000000
      0000DED6DE00D6C6C600E7C67B00FFDE8400FFE79400FFEF9C00FFEFAD00FFF7
      AD00FFF7B500FFF7B500FFF7B500FFEFAD00FFEFA500FFE79400FFDE8400BD84
      8400DEC6C600E7CECE00EFD6D600EFDEDE00E7BDBD00D68C8C00CE737300CE6B
      6B00C66B6B00B56363008C737B00000000000000000000000000000000000000
      0000000000000000000000000000299C390008B5290021C6420029CE520031CE
      630031D66B0039DE730042E77B0052F7840052FF940063FF9C0039CE63005AAD
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00F7D6
      CE00FFF7E700FFEFE700F7DED600CEBDB500F7F7F70000000000000000000000
      0000FFFFFF0000000000E7E7E700ADADAD00CECECE00D6D6D600B5BDB500D6D6
      D600B5BDB500E7E7E700DEDEDE00BDBDBD00F7F7F70000000000FFFFFF00CECE
      CE00DEDEDE0000000000000000000000000000000000D6CEC600CEAD7B00FFDE
      8C00FFE79C00FFEFA500FFF7B500FFFFBD00FFFFC600FFFFC600FFFFBD00FFF7
      B500FFEFAD00FFE79C00EFCE8400C6948C00F7E7E700F7E7E700F7EFEF00FFF7
      F700F7EFEF00F7E7E700EFD6D600E7B5B500D68C8C00B56B6B00AD949C000000
      000000000000000000000000000000000000CECECE00D6CEC600CEAD7B00FFDE
      8C00FFE79C00FFEFA500FFF7B500FFFFBD00FFFFC600FFFFC600FFFFBD00FFF7
      B500FFEFAD00FFE79C00EFCE8400C6948C00F7E7E700F7E7E700F7EFEF00FFF7
      F700F7EFEF00F7E7E700EFD6D600E7B5B500D68C8C00B56B6B00AD949C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000299C420018B5390029CE5A0031CE630039D66B0039D6630029BD520039C6
      5A0039C6630042CE6B0029AD420063AD6B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CE9C9C00BD736B00D6A59C00DEB5A500D6BDB500F7F7
      F7000000000000000000000000000000000000000000FFFFFF00FFFFFF00EFEF
      EF00C6C6C600C6C6C600D6DED600B5B5B500E7E7E700F7F7F70000000000D6D6
      D600ADADAD00E7E7E700D6D6D600D6D6D6000000000000000000000000000000
      000000000000D6CECE00AD9C9C00AD9C9C00BDA59400C6B59C00D6C6A500EFDE
      B500F7F7C600FFF7C600FFFFC600FFFFBD00FFF7B500FFEFA500EFC68C00CE9C
      9C00EFD6D600EFCECE00E7CECE00E7C6C600E7CECE00E7CECE00E7CECE00DECE
      CE00D6B5B500D6B5B50000000000000000000000000000000000000000000000
      0000BDBDBD00D6CECE00AD9C9C00AD9C9C00BDA59400C6B59C00D6C6A500EFDE
      B500F7F7C600FFF7C600FFFFC600FFFFBD00FFF7B500FFEFA500EFC68C00CE9C
      9C00EFD6D600EFCECE00E7CECE00E7C6C600E7CECE00E7CECE00E7CECE00DECE
      CE00D6B5B500D6B5B50000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319C420018BD420031D6
      630039DE6B0021BD4A00529C5200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEB5
      B500D6A5A500C6949400BD949400E7DEDE00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00F7F7F700FFFFFF00FFFFFF00BDBDBD00C6C6C600DEDE
      DE00B5B5B500EFEFEF00FFFFFF00FFFFFF00E7E7E700BDBDBD00CECECE000000
      00000000000000000000000000000000000000000000CECECE00CECECE00CEC6
      C600C6B5BD00BDADAD00B5A5A500B59CA500BDA59C00C6AD9C00CEB59C00D6BD
      A500E7CEA500EFD69400D6AD8C00C68C8C00D6B5AD00DEBDBD00DEBDBD00DEBD
      BD00DEC6C6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CECECE00E7E7E700DEDEDE00CEC6
      C600C6B5BD00BDADAD00B5A5A500B59CA500BDA59C00C6AD9C00CEB59C00D6BD
      A500E7CEA500EFD69400D6AD8C00C68C8C00D6B5AD00DEBDBD00DEBDBD00DEBD
      BD00DEC6C600DEC6C600E7D6D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000039A54A0018BD4A0039DE730021BD4A0073B57B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7DE
      DE00DEDEDE00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7
      F700FFFFFF00F7F7F700E7E7E700F7F7F700EFEFEF00B5BDB500E7E7E7000000
      0000E7E7E700C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7D6D600DECE
      CE00CEB5B500C6A5A500BDA5A500BD9CA500C69C9C00C69C9400BD8C8400AD7B
      7B00D6BDBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7DEDE00E7DEDE00E7D6D600DECE
      CE00CEB5B500C6A5A500BDA5A500BD9CA500C69C9C00C69C9400BD8C8400AD7B
      7B00D6BDBD00EFE7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000039A5
      4A0018C6520021BD4A006BB57300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFEFEF00D6D6D600000000000000
      0000FFFFFF00FFFFFF00F7F7F700FFFFFF00F7F7F700EFEFEF00EFEFEF00F7F7
      F700F7F7F700E7E7E700F7F7F700EFEFEF00BDBDBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7D6
      D600D6B5B500CEADAD00B58C8C00CEBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFDEDE00E7D6
      D600D6B5B500CEADAD00B58C8C00CEBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000042A55A00089421006BAD73000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EFEFEF00D6D6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7
      F700DEDEDE00B5B5B500BDBDBD00EFEFEF00F7F7F700F7F7F700EFEFEF00BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFEFEF00D6D6
      D600F7F7F700FFFFFF00F7F7F700D6D6D600CECECE00CECECE008C8C8C00ADAD
      AD00E7E7E700F7F7F700BDC6BD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6D6D600E7E7E700D6DED600D6D6
      D600000000000000000000000000BDBDBD00BDBDBD00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E000000280000007C0000005D00000001000100
      00000000D00500000000000000000000000000000000000000000000FFFFFF00
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
      494C01010C000E00400010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000002D5600002D5600002D5600002D5600000000000000
      0000000000000000000000000000000000000000000000000000000000002121
      2100214A0000214A0000212121000000000021212100214A0000214A00002121
      2100000000000000000000000000000000000000000000000000000000002121
      21000000A5000000A5002121210000000000212121000000A5000000A5002121
      2100000000000000000000000000000000000000000000000000000000008F8F
      8F0000D0710000D071008F8F8F00000000008F8F8F0000D0710000D071008F8F
      8F00000000000000000000000000000000000000000000000000000000000000
      0000002D5600002D560052D8CD003ED6C20020E4D40013E3D200002D5600002D
      560000000000000000000000000000000000000000000000000000000000214A
      000084CE6B007BCE5A000031080000000000003108004AAD080042AD0000214A
      0000000000000000000000000000000000000000000000000000000000000000
      A5006B6BE7005252DE0000008C000000000000008C001018C6000808BD000000
      A5000000000000000000000000000000000000000000000000000000000000D0
      710084F2D40075F5D00000A3C0000000000000A3C0001BFFA10017FFA50000D0
      710000000000000000000000000000000000000000000000000000000000002D
      560078E4DB006BDDD7005AD6C900000000000000000020E4D40009E5C90000E8
      CF00002D5600000000000000000000000000000000000000000000000000214A
      000094D673008CCE6B000031080000000000003108004AB5100042AD0800214A
      0000000000000000000000000000000000000000000000000000000000000000
      A5007373E7006363E70000008C000000000000008C002121CE001010C6000000
      A5000000000000000000000000000000000000000000000000000000000000D0
      710089F7D20084F2CC0000A3C0000000000000A3C00027FFB0001BFFAC0000D0
      710000000000000000000000000000000000000000000000000000000000002D
      560081E3DF0078E4E3006BDDD7005AD6C9004AD8D0002DDDCA0013E3C80009E5
      C900002D5600000000000000000000000000000000000000000000000000214A
      00009CD6840094D6730000310800000000000031080052B518004AB51000214A
      0000000000000000000000000000000000000000000000000000000000000000
      A5008484EF007373E70000008C000000000000008C003131CE002121C6000000
      A5000000000000000000000000000000000000000000000000000000000000D0
      710098F4D90089F7D20000A3C0000000000000A3C0002DFFAD0027FFB00000D0
      7100000000000000000000000000000000000000000000000000002D560098E8
      E20091E4E90081E3DF0071DDD40000000000000000004AD8D0002DDDCA0013E3
      C80009E5C900002D56000000000000000000000000000000000000000000214A
      0000A5DE8C009CD684000031080000000000003108005ABD290052B51800214A
      0000000000000000000000000000000000000000000000000000000000000000
      A5009494F7008484EF0000008C000000000000008C003939D6002929CE000000
      A5000000000000000000000000000000000000000000000000000000000000D0
      71009DF9DC0098F4D90000A3C0000000000000A3C0003DFFBD002DFFAD0000D0
      7100000000000000000000000000000000000000000000000000002D5600A9E6
      EF0098E7E80091E4E90081E3DF0071DDD40000000000000000003ED6C20020E4
      C60013E3D200002D56000000000000000000000000000000000000000000214A
      0000ADDE9C00A5DE8C0000310800000000000031080063BD31005ABD2900214A
      0000000000000000000000000000000000000000000000000000000000000000
      A5009C9CF7008C8CF70000008C000000000000008C004A4ADE003939D6000000
      A5000000000000000000000000000000000000000000000000000000000000D0
      7100ACF6E2009DF9DC0000A3C0000000000000A3C00048FAB9003DFFBD0000D0
      7100000000000000000000000000000000000000000000000000002D5600B0E7
      EE00A0E8E70098E7E8008AE2DF0078E4DB006BDDD70000000000000000003ED6
      C20020E4D400002D56000000000000000000000000000000000000000000214A
      0000B5E7A500ADDE9C000031080000000000003108006BC6420063BD3900214A
      0000000000000000000000000000000000000000000000000000000000000000
      A500A5A5FF009C9CF70000008C000000000000008C005A5ADE004A4AD6000000
      A5000000000000000000000000000000000000000000000000000000000000D0
      7100B3FBE900ACF6E20000A3C0000000000000A3C00062F2C40057F1C00000D0
      7100000000000000000000000000000000000000000000000000002D5600B9E9
      ED00A9EEEF0000000000000000008AE2DF0078E4E30000000000000000004AD8
      D0002DDDCA00002D56000000000000000000000000000000000000000000214A
      0000B5E7AD00B5E7A50000310800000000000031080073C652006BC64200214A
      0000000000000000000000000000000000000000000000000000000000000000
      A500ADADFF00A5A5FF0000008C000000000000008C006B6BE7005A5ADE000000
      A5000000000000000000000000000000000000000000000000000000000000D0
      7100BBF9F000B3FBE90000A3C0000000000000A3C0006FEFC90062F2C40000D0
      710000000000000000000000000000000000000000000000000000000000002D
      5600B0E7EE00000000000000000091E9E40081E3DF0000000000000000005AD6
      C900002D5600000000000000000000000000000000000000000000000000214A
      0000BDE7B500B5E7AD0000310800000000000031080084CE5A007BC65200214A
      0000000000000000000000000000000000000000000000000000000000000000
      A500ADADFF00ADADFF0000008C000000000000008C007B7BE7006B6BE7000000
      A5000000000000000000000000000000000000000000000000000000000000D0
      7100C2F8EE00BBF9F00000A3C0000000000000A3C00075F5C6006FEFC00000D0
      710000000000000000000000000000000000000000000000000000000000002D
      5600B9E9ED00B0E7EE000000000000000000000000000000000071DDD40060DE
      DA00002D5600000000000000000000000000000000000000000000000000214A
      0000BDE7B500BDE7B5000031080000000000003108008CCE6B007BCE5A00214A
      0000000000000000000000000000000000000000000000000000000000000000
      A500ADADFF00ADADFF0000008C000000000000008C008484EF007373E7000000
      A5000000000000000000000000000000000000000000000000000000000000D0
      7100C2F8EE00C2F8EE0000A3C0000000000000A3C00084F2CC0075F5D00000D0
      7100000000000000000000000000000000000000000000000000000000000000
      0000002D5600002D5600B0E7EE009FEEEF0098E7E8008AE2DF00002D5600002D
      560000000000000000000000000000000000000000000000000000000000214A
      0000BDE7B500BDE7B50000310800000000000031080094D673008CCE6B00214A
      0000000000000000000000000000000000000000000000000000000000000000
      A500ADADFF00ADADFF0000008C000000000000008C009494F7008484EF000000
      A5000000000000000000000000000000000000000000000000000000000000D0
      7100C2F8EE00C2F8EE0000A3C0000000000000A3C00089F7D20084F2CC0000D0
      7100000000000000000000000000000000000000000000000000000000000000
      00000000000000000000002D5600002D5600002D5600002D5600000000000000
      000000000000000000000000000000000000000000000000000000000000214A
      0000214A0000214A0000212121000000000021212100214A0000214A00002121
      2100000000000000000000000000000000000000000000000000000000002121
      21000000A5000000A5002121210000000000212121000000A5000000A5002121
      21000000000000000000000000000000000000000000000000000000000000D0
      710000D0710000D071008F8F8F00000000008F8F8F0000D0710000D071008F8F
      8F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      000031313100C5C5C50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000210800002108000021080000210800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000001E0500001E0500001E0500001E0500000000000000
      0000000000000000000000000000000000000000000000000000000000003131
      CE002121CE000000000031313100CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005BEA
      FB0035E8FD000000000031313100CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000002108000021080073C64A006BBD39005ABD290052B52100002108000021
      0800000000000000000000000000000000000000000000000000000000000000
      0000001E0500001E05003C3CD4002E2FCF002323CB001818C600001E0500001E
      0500000000000000000000000000000000000000000000000000000000003939
      D6002929CE002121C6001010C6000000000031313100D6D6D600000000000000
      00000000000000000000000000000000000000000000000000000000000069F3
      FF0049EDF7001FF2FF0003F6FF000000000031313100D6D6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000021
      080094D6730084CE63007BC6520000000000000000005ABD290052B518004AB5
      100000210800000000000000000000000000000000000000000000000000001E
      05006262E2005455DD004747D80000000000000000002222CA001617C6000E0D
      C200001E05000000000000000000000000000000000000000000000000004242
      D6003939D6002929CE001818C6001010C6000808BD00000000005A5A5A00DEDE
      DE000000000000000000000000000000000000000000000000000000000085E4
      FF0063EDF90040EBFA0017ECFF0000EDFC0000E0E800000000005A5A5A00DEDE
      DE00000000000000000000000000000000000000000000000000000000000021
      080094D67B008CD6730084CE63007BC652006BC6420063BD31005AB5210052B5
      180000210800000000000000000000000000000000000000000000000000001E
      05006D6EE7006061E2005254DC004546D8003939D2002C2CCE002120C9001516
      C500001E05000000000000000000000000000000000000000000000000005252
      DE004242D6003131CE002121CE001818C6001010C6000808BD000000BD000000
      000063636300DEDEDE00000000000000000000000000000000000000000095EB
      FB0074EBFC004DF5FF002AF5FC000BEBFF0000E0EE0000E0E80000E0E8000000
      000063636300DEDEDE000000000000000000000000000000000000210800ADDE
      94009CDE8C0094D67B008CCE6B0000000000000000006BC6420063BD31005AB5
      210052B518000021080000000000000000000000000000000000001E05008586
      F0007979EB006C6CE6005F5FE10000000000000000003737D2002A2BCD001F1F
      C9001514C500001E050000000000000000000000000000000000000000005A5A
      DE004A4ADE003942D6003131CE002121CE001818C6000808BD000000BD000000
      BD000000BD00080808000000000000000000000000000000000000000000A1EE
      FF0085F2FF0069E8FF0040EBFA001FF2FF0000EDFC0000E0E80000E0E80000E0
      E80000E0E800080808000000000000000000000000000000000000210800ADE7
      A500A5DE94009CDE8C0094D67B008CCE6B0000000000000000006BBD390063BD
      290052B521000021080000000000000000000000000000000000001E05008F90
      F4008485F0007778EB006B6BE5005D5EE10000000000000000003536D1002A2A
      CD001E1EC800001E050000000000000000000000000000000000000000006B6B
      E7005A5ADE004A4AD6003939D6002929CE002121C6001010C6000808BD000000
      BD000000BD00212121000000000000000000000000000000000000000000B1E9
      FB0095EBFB007CE9FA005BEAFB0035E8FD000BF6FF0000EBEE0000E0E80000E0
      E80000E0E800212121000000000000000000000000000000000000210800B5E7
      AD00ADDE9C00A5DE94009CD6840094D6730084CE630000000000000000006BBD
      39005ABD29000021080000000000000000000000000000000000001E05009899
      F7008E8FF3008383EF007677EA00696AE5005C5DE00000000000000000003534
      D1002829CC00001E050000000000000000000000000000000000000000007373
      E7006363E7005252DE004A4AD6003939D6002929CE002121C6001010C6001818
      180094949400000000000000000000000000000000000000000000000000B1E9
      FB00A8E7FE008DE9FD0069F3FF0049EDF7001FF2FF0003F6FF0000E0E8001919
      190094949400000000000000000000000000000000000000000000210800BDE7
      B500B5E7A50000000000000000009CD684008CD6730000000000000000006BC6
      420063BD31000021080000000000000000000000000000000000001E0500A0A2
      FB009798F70000000000000000007475EA006868E50000000000000000004040
      D6003333D000001E050000000000000000000000000000000000000000007B7B
      EF006B73E7006363DE005252DE004242D6003131CE001010100084848400F7F7
      F70000000000000000000000000000000000000000000000000000000000B1E9
      FB00B1E9FB00A1EEFF0085E4FF0063EDF90040EBFA001010100084848400F7F7
      F700000000000000000000000000000000000000000000000000000000000021
      0800B5E7AD000000000000000000A5DE8C0094D67B0000000000000000007BC6
      520000210800000000000000000000000000000000000000000000000000001E
      0500A0A0FA0000000000000000008080ED007374E90000000000000000004C4C
      DA00001E05000000000000000000000000000000000000000000000000008C8C
      EF007B7BEF006B6BE7005A5ADE00080808006B6B6B00EFEFEF00000000000000
      000000000000000000000000000000000000000000000000000000000000B1E9
      FB00B1E9FB00A8F3FE0095EBFB00080808006B6B6B00EFEFEF00000000000000
      0000000000000000000000000000000000000000000000000000000000000021
      0800BDE7B500B5E7AD00000000000000000000000000000000008CCE6B007BCE
      5A0000210800000000000000000000000000000000000000000000000000001E
      0500A6A8FD009FA0FA00000000000000000000000000000000006465E3005758
      DE00001E05000000000000000000000000000000000000000000000000009494
      F7008484EF000000000063636300DEDEDE000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B1E9
      FB00B1E9FB000000000063636300DEDEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000021080000210800B5E7AD00ADE79C00A5DE94009CD68400002108000021
      0800000000000000000000000000000000000000000000000000000000000000
      0000001E0500001E05009E9EF9009395F500898AF1007D7DED00001E0500001E
      0500000000000000000000000000000000000000000000000000000000000000
      00004A4A4A00D6D6D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A4A4A00D6D6D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000210800002108000021080000210800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000001E0500001E0500001E0500001E0500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000000000000084CE
      6B007BCE5A0073C652006BC6420063BD39005ABD290052B518004AB510004AAD
      080042AD00000000000000000000000000000000000000000000000000003939
      EF002929DE002121D6001818CE001010CE001010C6000808C6000000BD000000
      BD000000BD000000000000000000000000000000000000000000000000009BFF
      F90093FFF6008CFEF50083FFF2007BFFF10071FFED0065FFE40061FFE70059FF
      DE0055FFE10000000000000000000000000000000000000000000000000084CE
      63006BC642000000000031313100CECECE000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000094D6
      73008CCE6B0084CE5A0073C652006BC6420063BD31005ABD290052B518004AB5
      100042AD08000000000000000000000000000000000000000000000000004242
      F7003939EF003131E7002121DE001818D6001010D6001010CE000808C6000000
      C6000000C600000000000000000000000000000000000000000000000000A3FF
      F3009BFFF20093FFEE008CFEF50083FFF20075FFEA0071FFED0065FFE40061FF
      E70059FFE60000000000000000000000000000000000000000000000000094D6
      73007BC6520063BD310052B518000000000031313100D6D6D600000000000000
      0000000000000000000000000000000000000000000000000000000000009CD6
      840094D673008CCE6B007BCE5A0073C652006BC6420063BD31005ABD290052B5
      18004AB510000000000000000000000000000000000000000000000000005252
      FF004242FF003939F7003131EF002929E7001818DE001818D6001010D6000808
      CE000000CE00000000000000000000000000000000000000000000000000ABFF
      F800A3FFF3009BFFF20093FFF6008CFEF50083FFF20075FFEA0071FFED0065FF
      E40061FFE7000000000000000000000000000000000000000000000000009CDE
      8C008CCE6B0073C64A005ABD29004AB5100042AD0000000000005A5A5A00DEDE
      DE0000000000000000000000000000000000000000000000000000000000A5DE
      8C009CD6840094D673008CCE6B007BCE5A007BC652006BC6420063BD31005ABD
      290052B51800000000000000000000000000000000000000000000000000636B
      FF005A5AFF004A4AFF003939F7003131EF002929EF002121E7001818DE001010
      D6000808D600000000000000000000000000000000000000000000000000B3FF
      F700ABFFF800A3FFF3009BFFF20093FFF6008CFEED0083FFF20075FFEA0071FF
      ED0065FFE400000000000000000000000000000000000000000000000000ADDE
      9C0094D67B0084CE5A006BBD390052B5210042AD080042AD000042AD00000000
      000063636300DEDEDE000000000000000000000000000000000000000000ADDE
      9C00A5DE8C009CD6840094D6730084CE6B007BCE5A007BC652006BC6420063BD
      31005ABD29000000000000000000000000000000000000000000000000007B7B
      FF006B6BFF005A5AFF004A4AFF003939FF003131F7002929EF002121E7001818
      DE001010D600000000000000000000000000000000000000000000000000BBFF
      FB00B3FFF700ABFFF800A3FFF3009BFFF90093FFF6008CFEED0083FFF20075FF
      EA0071FFED00000000000000000000000000000000000000000000000000B5E7
      A500A5DE8C008CD6730073C64A0063BD31004AB5100042AD000042AD000042AD
      000042AD0000080808000000000000000000000000000000000000000000B5E7
      A500ADDE9C00A5DE8C009CD6840094D6730084CE6B007BCE5A0073C652006BC6
      420063BD39000000000000000000000000000000000000000000000000008C8C
      FF007B7BFF007373FF006363FF005252FF004242FF003131FF002929F7002121
      EF001818E700000000000000000000000000000000000000000000000000C5FF
      FD00BBFFFB00B3FFF700ABFFF800A3FFF3009BFFF90093FFF6008CFEF50083FF
      F2007BFFF100000000000000000000000000000000000000000000000000BDE7
      B500ADDE9C009CD6840084CE63006BC642005AB521004AAD080042AD000042AD
      000042AD0000212121000000000000000000000000000000000000000000B5E7
      AD00B5E7A500ADDE9C00A5DE8C009CD6840094D673008CCE6B0084CE5A0073C6
      52006BC642000000000000000000000000000000000000000000000000009494
      FF008C8CFF008484FF007B7BFF006B6BFF005A5AFF004A4AFF003131FF002929
      F7001821EF00000000000000000000000000000000000000000000000000C9FC
      FF00C5FFFD00BBFFFB00B3FFF700ABFFF800A3FFF3009BFFF20093FFEE008CFE
      F50083FFF200000000000000000000000000000000000000000000000000BDE7
      B500B5E7AD00A5DE940094D673007BC6520063BD310052B5180042AD00001818
      180094949400000000000000000000000000000000000000000000000000BDE7
      B500B5E7AD00B5E7A500ADDE9C00A5DE8C009CD6840094D673008CCE6B0084CE
      5A007BC652000000000000000000000000000000000000000000000000009C9C
      FF009C9CFF009494FF008C8CFF007B7BFF006B6BFF005A5AFF004A4AFF003131
      FF002929F700000000000000000000000000000000000000000000000000CDFD
      FF00C9FCFF00C5FFFD00BBFFFB00B3FFF700ABFFF800A3FFF3009BFFF20093FF
      EE008CFEED00000000000000000000000000000000000000000000000000BDE7
      B500BDE7B500B5E7A5009CDE8C008CCE6B0073C64A001010100084848400F7F7
      F70000000000000000000000000000000000000000000000000000000000BDE7
      B500BDE7B500B5E7AD00B5E7A500ADDE9C00A5DE8C009CD6840094D673008CCE
      6B007BCE5A00000000000000000000000000000000000000000000000000ADAD
      FF00A5A5FF00A59CFF009C9CFF008C8CFF008484FF007373FF005A5AFF004A4A
      FF003131FF00000000000000000000000000000000000000000000000000CDFD
      FF00CDFDFF00C9FCFF00C5FFFD00BBFFFB00B3FFF700ABFFF800A3FFF3009BFF
      F20093FFF600000000000000000000000000000000000000000000000000BDE7
      B500BDE7B500BDE7AD00ADDE9C00080808006B6B6B00EFEFEF00000000000000
      000000000000000000000000000000000000000000000000000000000000BDE7
      B500BDE7B500BDE7B500B5E7AD00B5E7A500ADDE9C00A5DE8C009CD6840094D6
      73008CCE6B00000000000000000000000000000000000000000000000000ADAD
      FF00ADADFF00ADADFF00A5A5FF009C9CFF009494FF008484FF007373FF006363
      FF004A4AFF00000000000000000000000000000000000000000000000000CDFD
      FF00CDFDFF00CDFDFF00C9FCFF00C5FFFD00BBFFFB00B3FFF700ABFFF800A3FF
      F3009BFFF200000000000000000000000000000000000000000000000000BDE7
      B500BDE7B5000000000063636300DEDEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FC3FE10FE10FE10FF00FE10FE10FE10FE187E10FE10FE10FE007E10FE10FE10F
      C183E10FE10FE10FC0C3E10FE10FE10FC063E10FE10FE10FC663E10FE10FE10F
      E667E10FE10FE10FE3C7E10FE10FE10FF00FE10FE10FE10FFC3FE10FE10FE10F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      E3FFE3FFFC3FFC3FC0FFC0FFF00FF00FC03FC03FE187E187C00FC00FE007E007
      C003C003C183C183C003C003C0C3C0C3C003C003C063C063C007C007C663C663
      C00FC00FE667E667C03FC03FE3C7E3C7C0FFC0FFF00FF00FE3FFE3FFFC3FFC3F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      E007E007E007E3FFC003C003C003C0FFC003C003C003C03FC003C003C003C00F
      C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003C007
      C003C003C003C00FC003C003C003C03FC003C003C003C0FFE007E007E007E3FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object timerCompsList: TTimer
    Enabled = False
    Interval = 500
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
      494C010107000900400010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF000000E007F80F00000000C003F0030000
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
    Left = 576
    Top = 344
  end
  object ilReports: TImageList
    Left = 600
    Top = 202
    Bitmap = {
      494C010101000400400010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object PopupMenuShutdown: TPopupMenu
    Left = 400
    Top = 256
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
    Left = 276
    Top = 142
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
    Left = 276
    Top = 262
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
  object ilRunPad: TImageList
    BlendColor = clBlack
    BkColor = clBlack
    DrawingStyle = dsFocus
    Height = 31
    Width = 31
    Left = 356
    Top = 289
    Bitmap = {
      494C01010400090040001F001F0000000000FF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000007C0000003E00000001002000000000002078
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9294007349
      5A009C696B0073495A0073495A0073495A0073495A009C7573009C9294000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BDA6A5FF9C696BFF9C696BFFAD8A8CFFBD9E9CFFBD92
      94FFBD9294FFB59294FFA57173FF9C696BFF8C5552FF73495AFF73495AFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDA6A5FF9C696BFF9C696BFFAD8A8CFFBD9E9CFFBD9294FFBD92
      94FFB59294FFA57173FF9C696BFF8C5552FF73495AFF73495AFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDA6A5009C696B009C696B00AD8A8C00BD9E9C00BD929400BD929400B592
      9400A57173009C696B008C55520073495A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073495A0073495A008C555200A5828400AD7D7B00AD7D7B009C6D6B008C55
      52008445420073495A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDA6A5FFDED7D6FFDECF
      CEFFDED7D6FFDED3D6FFDECFCEFFDECBCEFFD6C3C6FFD6C3C6FFD6BABDFFD6B6
      B5FFCEA6A5FFB58684FF9C696BFF73495AFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDA6A5FFDED7D6FFDECFCEFFDED7
      D6FFDED3D6FFDECFCEFFDECBCEFFD6C3C6FFD6C3C6FFD6BABDFFD6B6B5FFCEA6
      A5FFB58684FF9C696BFF73495AFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BDA6A500DED7D600DECFCE00DED7D600DED3
      D600DECFCE00DECBCE00D6C3C600D6C3C600D6BABD00D6B6B500CEA6A5009C69
      6B0073495A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000073495A00AD7D7B00CEBABD00DEC7C600DECF
      CE00DEC7C600D6C3C600D6BEBD00CEB2B500C69A9C009C696B0073495A007349
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDA6A5FFDEDFDEFFDEDFDEFFDEDFDEFFDEDBDEFFDED7D6FFDED3D6FFDECF
      CEFFDECBCEFFBD9E9CFFAD8684FFAD8684FFC69A9CFFD6AEADFFCEA6A5FFAD7D
      7BFF73495AFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDA6
      A5FFDEDFDEFFDEDFDEFFDEDFDEFFDEDBDEFFDED7D6FFDED3D6FFDECFCEFFDECB
      CEFFBD9E9CFFAD8684FFAD8684FFC69A9CFFD6AEADFFCEA6A5FFAD7D7BFF7349
      5AFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDA6A500DEDF
      DE00DEDFDE00DEDFDE00DEDBDE00DED7D600DED3D600DECFCE00DECBCE00BD9E
      9C00AD868400AD868400C69A9C00CEA6A500AD7D7B0073495A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B5929400D6CBCE00DEDB
      DE00DEDBDE00DEDBDE00DED7D600DED3D600DECFCE00DEC7C600D6BEBD00D6C3
      C600BD9E9C00BD8A8C00D6AAAD00BD9294008445420073495A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6AEADFFE7E3E7FFE7E7E7FFE7E7E7FFE7E7
      E7FFE7E3E7FFDEDFDEFFDED7D6FFDED3D6FFCEBABDFFCEB2B5FFC6BABDFF9C92
      94FFA57D7BFFAD7D7BFFCEA6A5FFCEA2A5FFAD7D7BFF73495AFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6AEADFFE7E3E7FFE7E7E7FFE7E7E7FFE7E7E7FFE7E3
      E7FFDEDFDEFFDED7D6FFDED3D6FFCEBABDFFCEB2B5FFC6BABDFF9C9294FFA57D
      7BFFAD7D7BFFCEA6A5FFCEA2A5FFAD7D7BFF73495AFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6AEAD00E7E3E700E7E7E700E7E7E700E7E7E700E7E3E700DEDF
      DE00DED7D600DED3D600CEBABD00CEB2B500C6BABD009C929400A57D7B00CEA6
      A500CEA2A500AD7D7B0073495A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5929400BD9E9C00DEDFDE00E7E3E700E7E3E700DEDFDE00DEDBDE00DED7
      D600DED3D600DECFCE00CEA6A500E7DBDE00CEC7C600C6AEAD00BD8A8C00CEA6
      A500AD7573008445420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6A2A5FFDEDB
      DEFFE7E7E7FFEFEBEFFFEFEFEFFFEFEFEFFFEFEBEFFFE7E7E7FFDEDFDEFFDED7
      D6FFC6A2A5FFDEC3C6FFC6B2B5FFA58E8CFFA58E8CFFA58E8CFFC69E9CFFCEA6
      A5FFBD9294FF9C696BFF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6A2A5FFDEDBDEFFE7E7
      E7FFEFEBEFFFEFEFEFFFEFEFEFFFEFEBEFFFE7E7E7FFDEDFDEFFDED7D6FFC6A2
      A5FFDEC3C6FFC6B2B5FFA58E8CFFA58E8CFFA58E8CFFC69E9CFFCEA6A5FFBD92
      94FF9C696BFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6A2A500DEDBDE00E7E7E700EFEB
      EF00EFEFEF00EFEFEF00EFEBEF00E7E7E700DEDFDE00DED7D600C6A2A500DEC3
      C600C6B2B500A58E8C00A58E8C00C69E9C00CEA6A500BD9294009C696B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C3C600E7E3E700EFEBEF00EFEB
      EF00EFEBEF00E7E7E700E7E7E700DEDBDE00DED7D600DECFCE00CEAAAD00D6BE
      BD00CEB2B500CEB2B500CEB2B500A5757300CEA2A500B586840073495A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CEB2B5FFE7E7E7FFEFEBEFFFF7F3F7FFF7F3F7FFF7F3
      F7FFEFEFEFFFE7E7E7FFE7E3E7FFDED7D6FFBD9294FFE7D7D6FFBD9E9CFFAD86
      84FFAD8684FFAD8684FFCEA2A5FFCEA6A5FFCE9694FF9C696BFF000000000000
      0000000000009C7573FF8C5552FF73495AFF0000000000000000000000000000
      000000000000CEB2B5FFE7E7E7FFEFEBEFFFF7F3F7FFF7F3F7FFF7F3F7FFEFEF
      EFFFE7E7E7FFE7E3E7FFDED7D6FFBD9294FFE7D7D6FFBD9E9CFFAD8684FFAD86
      84FFAD8684FFCEA2A5FFCEA6A5FFCE9694FF9C696BFF00000000000000000000
      00009C7573FF8C5552FF73495AFF000000000000000000000000000000000000
      0000CEB2B500E7E7E700EFEBEF00F7F3F700F7F3F700F7F3F700EFEFEF00E7E7
      E700E7E3E700DED7D600BD929400E7D7D600BD9E9C00AD868400AD868400CEA2
      A500CEA6A500CE9694009C696B000000000000000000000000009C7573008C55
      520073495A000000000000000000000000000000000000000000000000000000
      0000E7E3E700E7E7E700F7F3F700F7F3F700F7F3F700EFEFEF00EFEBEF00DEDF
      DE00DEDBDE00CEA6A500DEC3C600CE9E9C00CE9E9C00CE9E9C00CE9E9C00A575
      7300CEA2A500C68E8C0073495A0000000000000000000000000073495A007349
      5A00000000000000000000000000000000000000000000000000DEBEBDFFE7DB
      DEFFEFEFEFFFF7F3F7FFFFFBFFFFFFFBFFFFF7F3F7FFEFEBEFFFE7E3E7FFDED7
      D6FFC69294FFDEC7C6FFB58284FFB58284FFB58284FFB57D7BFFCEA6A5FFCEA6
      A5FFCE9694FF9C7573FF000000009C696BFFA58284FFCEA2A5FFADA2A5FFA582
      84FF73495AFF73495AFF000000000000000000000000DEBEBDFFE7DBDEFFEFEF
      EFFFF7F3F7FFFFFBFFFFFFFBFFFFF7F3F7FFEFEBEFFFE7E3E7FFDED7D6FFC692
      94FFDEC7C6FFB58284FFB58284FFB58284FFB57D7BFFCEA6A5FFCEA6A5FFCE96
      94FF9C7573FF000000009C696BFFA58284FFCEA2A5FFADA2A5FFA58284FF7349
      5AFF73495AFF000000000000000000000000DEBEBD00E7DBDE00EFEFEF00F7F3
      F700FFFBFF00FFFBFF00F7F3F700EFEBEF00E7E3E700DED7D600C6929400DEC7
      C600B5828400B5828400B5828400CEA6A500CEA6A500CE9694009C7573000000
      00009C696B00A5828400CEA2A500ADA2A500A582840073495A0073495A000000
      000000000000000000000000000000000000DEDBDE00EFEBEF00F7F3F700FFFB
      FF00FFFBFF00EFEFEF00EFEBEF00DEDFDE00DEDBDE00C69A9C00DEC3C600CE96
      9400CE969400CE969400CE969400B5828400CEA2A500C68E8C00000000000000
      000073495A0073495A00BDA6A500A592940073495A0000000000000000000000
      0000000000000000000000000000CEB2B5FFEFEFEFFFF7F3F7FFEFDBDEFFF7EF
      EFFFF7F3F7FFEFEBEFFFE7E3E7FFD6BEBDFFCEA6A5FFD6AAADFFBD797BFFBD79
      7BFFBD797BFFBD7173FFD6AAADFFCEA6A5FFB58284FF9C696BFFBD9294FFD6B2
      B5FFDEB6B5FFD6B2B5FFADA2A5FFADA2A5FFB59E9CFF9C7573FF73495AFF7349
      5AFF0000000000000000CEB2B5FFEFEFEFFFF7F3F7FFEFDBDEFFF7EFEFFFF7F3
      F7FFEFEBEFFFE7E3E7FFD6BEBDFFCEA6A5FFD6AAADFFBD797BFFBD797BFFBD79
      7BFFBD7173FFD6AAADFFCEA6A5FFB58284FF9C696BFFBD9294FFD6B2B5FFDEB6
      B5FFD6B2B5FFADA2A5FFADA2A5FFB59E9CFF9C7573FF73495AFF73495AFF0000
      000000000000CEB2B500EFEFEF00F7F3F700EFDBDE00F7EFEF00F7F3F700EFEB
      EF00E7E3E700D6BEBD00CEA6A500D6AAAD00BD797B00BD797B00BD797B00D6AA
      AD00CEA6A500B58284009C696B00BD929400D6B2B500DEB6B500D6B2B500ADA2
      A500ADA2A500B59E9C009C75730073495A0073495A0000000000000000000000
      0000CEA29C00DEC7C600F7F3F700F7EFEF00F7E7E700EFEFEF00EFEBEF00DEDF
      DE00DEDBDE00D6AEAD00D6B2B500CE828400CE828400CE828400C6797B00B58A
      8C00C68E8C0073495A00B5828400CEA6A500DEB6B500D6B6B500C6AEAD00ADA2
      A500ADA2A500A57D7B00A57D7B0073495A000000000000000000000000000000
      0000DEC3C6FFE7D7D6FFCE9694FFBD7173FFD6A2A5FFDECBCEFFDEDFDEFFCEA6
      A5FFD6A2A5FFCE9694FFBD7173FFC67173FFC67173FFC67173FFCEA6A5FFC692
      94FFCEA2A5FFDEBEBDFFDEBEBDFFDEBABDFFDEB6B5FFD6B2B5FFADA2A5FFADA2
      A5FFADA2A5FFADA2A5FFA59294FF9C696BFF73495AFF0000000000000000DEC3
      C6FFE7D7D6FFCE9694FFBD7173FFD6A2A5FFDECBCEFFDEDFDEFFCEA6A5FFD6A2
      A5FFCE9694FFBD7173FFC67173FFC67173FFC67173FFCEA6A5FFC69294FFCEA2
      A5FFDEBEBDFFDEBEBDFFDEBABDFFDEB6B5FFD6B2B5FFADA2A5FFADA2A5FFADA2
      A5FFADA2A5FFA59294FF9C696BFF73495AFF0000000000000000DEC3C600E7D7
      D600CE969400BD717300D6A2A500DECBCE00DEDFDE00CEA6A500D6A2A500CE96
      9400BD717300C6717300C6717300CEA6A500C6929400CEA2A500DEBEBD00DEBE
      BD00DEBABD00DEB6B500D6B2B500ADA2A500ADA2A500ADA2A500ADA2A500A592
      94009C696B0073495A00000000000000000000000000CEA29C00EFEFEF00D6B2
      B500BD717300DEC7C600E7E7E700DEDFDE00DED3D600D6AAAD00D6A2A500CE79
      7B00CE797B00CE797B00C6757300B5868400B57D7B00BD929400DEBEBD00DEBE
      BD00DEB6B500D6B6B500C6AEAD00ADA2A500ADA2A500ADA2A500B59E9C009C6D
      6B0073495A0000000000000000000000000000000000DEB6B5FFCE9694FFF7CB
      9CFFE7C3C6FFD69A9CFFC6797BFFC68E8CFFCE9694FFC67573FFC66D6BFFC66D
      6BFFCE696BFFCE696BFFD6B2B5FFDECBCEFFDEC7C6FFDEC3C6FFDEBEBDFFDEBA
      BDFFDEB6B5FFD6A2A5FFA58284FFB59E9CFFB59E9CFFB59E9CFFB59E9CFFADA2
      A5FFA58E8CFF000000000000000000000000DEB6B5FFCE9694FFF7CB9CFFE7C3
      C6FFD69A9CFFC6797BFFC68E8CFFCE9694FFC67573FFC66D6BFFC66D6BFFCE69
      6BFFCE696BFFD6B2B5FFDECBCEFFDEC7C6FFDEC3C6FFDEBEBDFFDEBABDFFDEB6
      B5FFD6A2A5FFA58284FFB59E9CFFB59E9CFFB59E9CFFB59E9CFFADA2A5FFA58E
      8CFF000000000000000000000000DEB6B500CE969400F7CB9C00E7C3C600D69A
      9C00C6797B00C68E8C00CE969400C6757300C66D6B00C66D6B00CE696B00D6B2
      B500DECBCE00DEC7C600DEC3C600DEBEBD00DEBABD00DEB6B500D6A2A500A582
      8400B59E9C00B59E9C00B59E9C00B59E9C00ADA2A500A58E8C0073495A000000
      00000000000000000000CEA29C00C69294000000000000000000DEAAAD00C671
      7300CE8A8C00CE757300CE656300CE656300CE656300CE656300B5696B00D6B2
      B500DEC7C600DEC3C600DEBEBD00DEBEBD00DEB6B500D6B2B500A5757300A582
      8400B59E9C00B59E9C00B59E9C009CB69C00B59E9C0073495A00000000000000
      000000000000DEB6B5FFC68E8CFFFFA210FFFFAA21FFFFC773FFE7DFB5FFDEAA
      ADFFCE797BFFC66D6BFFCE6563FFCE6563FFC65D5AFFC66D6BFFE7CFCEFFDECB
      CEFFDEC7C6FFDEC3C6FFD6B2B5FFCEA2A5FFCE9A9CFFCE9E9CFF9C696BFF9C69
      6BFFA58284FFB59294FFB59E9CFF63FF9CFFAD8A8CFF00000000000000000000
      0000DEB6B5FFC68E8CFFD98E32FF836686FFBD988CFFDFD7B5FFDEAAADFFCE79
      7BFFC66D6BFFCE6563FFCE6563FFC65D5AFFC66D6BFFE7CFCEFFDECBCEFFDEC7
      C6FFDEC3C6FFD6B2B5FFCEA2A5FFCE9A9CFFCE9E9CFF9C696BFF9C696BFFA582
      84FFB59294FFB59E9CFF63FF9CFFAD8A8CFF000000000000000000000000DEB6
      B500C68E8C00FFA21000FFAA2100FFC77300E7DFB500DEAAAD00CE797B00C66D
      6B00CE656300CE656300C65D5A00E7CFCE00DECBCE00DEC7C600DEC3C600D6B2
      B500CEA2A500CE9A9C00CE9E9C009C696B009C696B00A5828400B5929400B59E
      9C0063FF9C00AD8A8C0073495A0000000000000000000000000000000000CE9E
      9C0000000000000000000000000000000000CE8A8C00C66D6B00C6616300C65D
      5A00C65D5A00C65D5A00AD656300D6BEBD00DEC7C600DEC3C600DEBEBD00DEBA
      BD00CE9E9C00CE9A9C00A57173009C656300A5828400B59E9C00B59E9C0063FF
      9C009CB69C0073495A00000000000000000000000000D6AEADFFDE965AFFFFA2
      10FFFFAA21FFFFAA21FFFFAA21FFFFB64AFFEFC78CFFDEAAADFFCE8A8CFFC66D
      6BFFC65D5AFFB5696BFFE7CFCEFFDEC3C6FFD6AEADFFCE9E9CFFCE9A9CFFD6A2
      A5FFD6AEADFFD6B2B5FFB59294FFAD8684FF9C6D6BFF9C696BFFA58284FFB592
      94FFAD8A8CFF000000000000000000000000D6AEADFFDE965AFF7B5E88FF4443
      BBFF4B47B5FFBD8656FFFFB64AFFEFC78CFFDEAAADFFCE8A8CFFC66D6BFFC65D
      5AFFB5696BFFE7CFCEFFDEC3C6FFD6AEADFFCE9E9CFFCE9A9CFFD6A2A5FFD6AE
      ADFFD6B2B5FFB59294FFAD8684FF9C6D6BFF9C696BFFA58284FFB59294FFAD8A
      8CFF000000000000000000000000D6AEAD00DE965A00FFA21000FFAA2100FFAA
      2100FFAA2100FFB64A00EFC78C00DEAAAD00CE8A8C00C66D6B00C65D5A00E7CF
      CE00DEC3C600D6AEAD00CE9E9C00CE9A9C00D6A2A500D6AEAD00D6B2B500B592
      9400AD8684009C6D6B009C696B00A5828400B5929400AD8A8C0073495A000000
      00000000000000000000D6B6B500CE9A9C000000000000000000000000000000
      0000000000000000000000000000CE828400C66D6B00B54D4A00AD7D7B00DECB
      CE00D6B2B500CE9E9C00CE9A9C00D6A2A500D6B6B500D6B6B500BD9E9C00B592
      9400A58284009C6563009C696B00B5929400B592940073495A00000000000000
      000000000000CEA2A5FFCE9273FFFFAA21FFFFB229FFFFB229FFFFB631FFC3AD
      25FF579D10FF7A9E1BFFD1B15DFFD6B284FFD69A9CFFCE7573FFCE8A8CFFCE96
      94FFD6A2A5FFD6B2B5FFDEBEBDFFDEBABDFFDEB6B5FFCEAAADFFB58A8CFFA575
      73FFB58A8CFFAD8684FF9C6D6BFF9C696BFFA57573FF00000000000000000000
      0000CEA2A5FFCE9273FF7D628CFF4242BCFF4242BCFF766296FFFFB631FFFFB6
      31FFFFAE39FFEFB66BFFD6B284FFD69A9CFFCE7573FFCE8A8CFFCE9694FFD6A2
      A5FFD6B2B5FFDEBEBDFFDEBABDFFDEB6B5FFCEAAADFFB58A8CFFA57573FFB58A
      8CFFAD8684FF9C6D6BFF9C696BFFA57573FF000000000000000000000000CEA2
      A500CE927300FFAA2100FFB22900FFB22900FFB63100FFB63100FFB63100FFAE
      3900EFB66B00D6B28400D69A9C00CE8A8C00CE969400D6A2A500D6B2B500DEBE
      BD00DEBABD00DEB6B500CEAAAD00B58A8C00A5757300B58A8C00AD8684009C6D
      6B009C696B00A575730073495A00000000000000000000000000D6B6B500C68E
      8C00000000000000000000000000000000000000000000000000000000000000
      000000000000CE757300BD797B00D6A2A500CE9A9C00CE9E9C00DEBABD00DEBE
      BD00DEB6B500D6B6B500BD9E9C00AD868400B5929400AD8684009C6D6B009C69
      6B00A582840073495A00000000000000000000000000D6B2B5FFDE965AFFFFB6
      31FFFFB631FFFFB639FFDFB131FF289708FF029100FF049100FF409B0EFFDFB1
      31FFFFB64AFFEFB66BFFD6A294FFCE797BFFCE8A8CFFDEAAADFFDEBEBDFFDEBA
      BDFFDEB6B5FFCEAAADFFB58684FFBD8E8CFFBD8684FFAD7D7BFFB58684FFB586
      84FFA57173FF000000000000000000000000D6B2B5FFDE965AFFD29A51FF4A47
      B6FF4242BDFF5D52A9FFFFBA39FFFFBA39FFFFBA39FFFFBA39FFFFB639FFFFB6
      4AFFEFB66BFFD6A294FFCE797BFFCE8A8CFFDEAAADFFDEBEBDFFDEBABDFFDEB6
      B5FFCEAAADFFB58684FFBD8E8CFFBD8684FFAD7D7BFFB58684FFB58684FFA571
      73FF000000000000000000000000D6B2B500DE965A00FFB63100FFB63100FFB6
      3900FFB63900FFBA3900FFBA3900FFBA3900FFBA3900FFB63900FFB64A00D6A2
      9400CE797B00CE8A8C00DEAAAD00DEBEBD00DEBABD00DEB6B500CEAAAD00B586
      8400BD8E8C00BD868400AD7D7B00B5868400B5868400A571730073495A000000
      00000000000000000000DEBABD00B57D7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE6D6B00CE7D7B00DEBEBD00DEBEBD00DEB6B500D6B6B500C69A9C00A575
      7300CE9A9C00A5717300A5757300B5929400B586840073495A00000000000000
      0000D6B6B5FFD6AEADFFEFA24AFFF2B436FF99A927FF2D980BFF179506FF0692
      01FF019100FF019100FF069201FF80A725FFFFBA42FFFFBA42FFFFB639FFEFAE
      52FFDEA673FFCE696BFFDEBEBDFFDEBABDFFDEB6B5FFCEAAADFFAD7D7BFFBD8E
      8CFFCE9A9CFFCE9A9CFFBD8E8CFFAD7573FFAD8684FF0000000000000000D6B6
      B5FFD6AEADFFEFA24AFFFFB639FF5D53ABFF4242BDFF4A47B7FFD2A065FFFFBE
      4AFFFFBE4AFFFFBE4AFFFFBE4AFFF5B348FFC89765FF7F6792FF6256A8FFAE87
      89FFCE696BFFDEBEBDFFDEBABDFFDEB6B5FFCEAAADFFAD7D7BFFBD8E8CFFCE9A
      9CFFCE9A9CFFBD8E8CFFAD7573FFAD8684FF0000000000000000D6B6B500D6AE
      AD00EFA24A00FFB63900FFBA4200FFBA4200FFBE4A00FFBE4A00FFBE4A00FFBE
      4A00FFBE4A00FFBE4A00FFBA4200FFB63900EFAE5200DEA67300CE696B00DEBE
      BD00DEBABD00DEB6B500CEAAAD00AD7D7B00BD8E8C00CE9A9C00CE9A9C00BD8E
      8C00AD757300AD86840073495A00000000000000000000000000D6AEAD003223
      2000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE7D7B00D6AEAD00DEBE
      BD00DEB6B500D6B6B500BD929400A5717300CE9A9C00CE9A9C00BD8E8C00A571
      7300BD8A8C0073495A000000000000000000D6B6B5FFCEA6A5FFDFB140FF68A3
      1EFF089202FF009100FF009100FF069201FF20970BFF0A9303FF029100FF399C
      12FFF3C04EFFFFBE4AFFFFBE4AFFFFBA42FFFFB639FFCE696BFFDEBEBDFFDEBA
      BDFFDEB6B5FFD6A2A5FFAD7D7BFFBD8E8CFFCE9A9CFFCE9A9CFFCE9A9CFFB582
      84FFB58284FF0000000000000000D6B6B5FFCEA6A5FFFFB64AFFFFBE4AFF7664
      9CFF4242BCFF4242BCFF7D6B9BFFFFC75AFFFFC75AFFF5C057FFC89D71FF816D
      99FF4F4AB4FF4242BCFF4242BCFF6B5BA0FFCE696BFFDEBEBDFFDEBABDFFDEB6
      B5FFD6A2A5FFAD7D7BFFBD8E8CFFCE9A9CFFCE9A9CFFCE9A9CFFB58284FFB582
      84FF0000000000000000D6B6B500C69E9C00FFC34A00FFC35200FFC75A00FFCB
      5A00FFCB6300FFCB6300FFCB6300FFCB6300FFCB6300FFCB6300FFCB5A00FFC3
      5200FFBE4A00FFB64A00CE7D7B00DEBEBD00DEBABD00DEB6B500D6A2A500AD75
      7300A5717300A5717300BD868400CE9A9C00B5828400B57D7B0073495A000000
      00000000000000000000C69A9C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEAAAD00DEBEBD00DEB6B500D6B6B500BD8A8C00A56D
      6B00CE9A9C00CE9A9C00CE9A9C00B5828400B582840073495A00000000000000
      0000D6B6B5FFC69E9CFF80AA25FF0B9303FF039101FF019100FF129506FF78AC
      2EFFD5C152FF339C13FF029100FF0B9304FFA7B63AFFFFC75AFFFFC352FFFFBE
      4AFFFFB64AFFCE7D7BFFDEBEBDFFDEBABDFFDEB6B5FFD6A2A5FFAD7573FFA571
      73FFA57173FFBD8684FFCE9A9CFFB58284FFB57D7BFF0000000000000000D6B6
      B5FFC69E9CFFFFC34AFFFFC352FFBD997CFF4B48B7FF4343BCFF5650B3FFD9AF
      75FFD2AA78FF7264A6FF4B48B8FF4242BCFF4242BCFF4343BCFF4846B8FFAD83
      7BFFCE7D7BFFDEBEBDFFDEBABDFFDEB6B5FFD6A2A5FFAD7573FFA57173FFA571
      73FFBD8684FFCE9A9CFFB58284FFB57D7BFF0000000000000000D6B6B500C6A2
      8400FFC75A00FFCB5A00FFCB6300FFCF6B00FFCF6B00FFD36B00FFD36B00FFD3
      6B00FFD36B00FFCF6B00FFCF6B00FFCB5A00FFC35200EFAE5200CE828400DEBE
      BD00DEBABD00DEB6B500D6A2A500AD757300BD8A8C00BD868400AD7D7B009C69
      6B00AD757300B57D7B0073495A000000000000000000D6B6B500AD8684000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEBEBD00DEBE
      BD00DEB6B500D6B6B500C6828400A56D6B00AD7D7B009C696B00AD7D7B00B582
      8400B57D7B0073495A000000000000000000D6B6B5FFC6A284FF80AC2DFF1A96
      09FF2B9A10FF6DAB2DFFD5C459FFFFD36BFFFFD36BFF50A521FF019100FF0191
      00FF47A21DFFFFCB63FFFFCB5AFFFFC352FFEFAE52FFCE8284FFDEBEBDFFDEBA
      BDFFDEB6B5FFD6A2A5FFAD7573FFBD8A8CFFBD8684FFAD7D7BFF9C696BFFAD75
      73FFB57D7BFF0000000000000000D6B6B5FFC6A284FFFFC75AFFFFCB5AFFF6C4
      67FFAB908FFF4E4BB7FF4645BBFF534FB5FF4F4CB6FF4242BCFF4242BCFF4242
      BCFF4C49B8FF7B6B9FFFC29A73FFE6A857FFCE8284FFDEBEBDFFDEBABDFFDEB6
      B5FFD6A2A5FFAD7573FFBD8A8CFFBD8684FFAD7D7BFF9C696BFFAD7573FFB57D
      7BFF00000000D6B6B500E7CFCE00DEA67300FFCB6300FFCF6B00FFD36B00FFD3
      7300FFD77300FFD77B00FFD77B00FFD77B00FFD77B00FFD77300FFD37300FFCF
      6B00FFCB6300DEA67300CE828400DEBEBD00DEBABD00DEB6B500D6A2A500AD75
      7300BD868400A5717300A5717300BD8A8C00AD7D7B00BD797B0073495A000000
      000000000000D6B6B50020181700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEBEBD00DEBEBD00DEB6B500D6B6B500C6828400A56D
      6B00BD8E8C00BD868400A5717300A5717300B57D7B0073495A0000000000D6B6
      B5FFE7CFCEFFDEA673FFDFC356FFA0B743FFDFCA5DFFFFD373FFFFD773FFFFD7
      7BFFFFD77BFFC3C65EFF0B9405FF009100FF109507FFD5C859FFFFCF6BFFFFCB
      63FFDEA673FFCE8284FFDEBEBDFFDEBABDFFDEB6B5FFD6A2A5FFAD7573FFBD86
      84FFA57173FFA57173FFBD8A8CFFAD7D7BFFBD797BFF00000000D6B6B5FFE7CF
      CEFFDEA673FFFFCB63FFFFCF6BFFFFD36BFFF6CC76FF9D8A98FF4645BBFF4242
      BCFF4242BCFF4242BCFF4E4BB8FF675FAEFFC5A783FFFFCF6BFFFFCB63FFDEA6
      73FFCE8284FFDEBEBDFFDEBABDFFDEB6B5FFD6A2A5FFAD7573FFBD8684FFA571
      73FFA57173FFBD8A8CFFAD7D7BFFBD797BFF00000000D6B6B500DECBCE00DEA6
      7300FFCF6B00FFD37300FFD77B00FFDB7B00FFDB8400FFDF8400FFDF8C00FFDF
      8C00FFDF8400FFDB8400FFDB7B00FFD37300FFCB6300DEA67300CE969400DEBE
      BD00DEBABD00DEB6B500D6A2A500AD757300BD8E8C00CE9A9C00C68E8C00BD86
      8400B5828400B575730073495A0000000000D6B6B500DECBCE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000003020100DEBEBD00DEBE
      BD00DEB6B500D6B6B500C6797B00A56D6B00CE9A9C00AD7D7B009C656300B582
      8400B575730073495A0000000000D6B6B5FFDECBCEFFDEA673FFFFCF6BFFFFD3
      73FFFFD77BFFFFDB7BFFFFDB84FFFFDF84FFFFDF8CFFFFDF8CFF2E9F17FF0091
      00FF029100FF6EAF35FFFFD373FFFFCB63FFDEA673FFCE9694FFDEBEBDFFDEBA
      BDFFDEB6B5FFD6A2A5FFAD7573FFBD8E8CFFCE9A9CFFC68E8CFFBD8684FFB582
      84FFB57573FF00000000D6B6B5FFDECBCEFFDEA673FFFFCF6BFFFFD373FFD2B3
      8AFF796FA9FF5350B7FF4443BCFF4242BCFF4242BCFF514EB8FFD2B791FFFFDB
      7BFFFFD77BFFFFD373FFFFCB63FFDEA673FFCE9694FFDEBEBDFFDEBABDFFDEB6
      B5FFD6A2A5FFAD7573FFBD8E8CFFCE9A9CFFC68E8CFFBD8684FFB58284FFB575
      73FF00000000D6B6B500D6C3C600EFB66B00FFD37300FFD77B00FFDB8400FFDF
      8C00FFE38C00FFE39400FFE39400FFE39400FFE39400FFE38C00FFDF8C00FFD7
      7B00FFD37300CE927300D6A2A500DEBEBD00DEBABD00DEB6B500CE969400B569
      6B00A5717300BD868400CE969400CE9A9C00B5828400BD71730073495A000000
      0000D6B6B500EFDBDE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000006030300DEBEBD00DEBEBD00DEB6B500D6B6B500C6797B00A56D
      6B00CE9A9C00CE9A9C00CE969400B5828400B575730073495A0000000000D6B6
      B5FFD6C3C6FFEFB66BFFFFD373FFFFD77BFFFFDB84FFFFDF8CFFFFE38CFFFFE3
      94FFFFE394FFFFE394FF98C158FF079303FF019100FF37A01CFFF3D375FFFFD3
      73FFCE9273FFD6A2A5FFDEBEBDFFDEBABDFFDEB6B5FFCE9694FFB5696BFFA571
      73FFBD8684FFCE9694FFCE9A9CFFB58284FFBD7173FF00000000D6B6B5FFD6C3
      C6FFEFB66BFFFFD373FFD9B988FF534FB7FF4242BCFF4242BDFF4544BCFF4B49
      BAFF4847BBFF5552B8FFCFBA98FFFFDF8CFFFFDB84FFFFD77BFFFFD373FFCE92
      73FFD6A2A5FFDEBEBDFFDEBABDFFDEB6B5FFCE9694FFB5696BFFA57173FFBD86
      84FFCE9694FFCE9A9CFFB58284FFBD7173FF00000000D6B6B500C6B2B500FFD3
      7300FFD77B00FFDF8400FFE38C00FFE39400FFE79C00FFEB9C00FFEBA500FFEB
      A500FFEB9C00FFE79C00FFE39400FFDB8400FFD77B00CE927300D6AEAD00DEBE
      BD00DEBABD00DEB6B500CE969400C6717300C6757300B5696B00AD6D6B00AD7D
      7B00AD757300BD71730073495A0000000000CEBABD00D6C3C600000000000000
      0000000000000000000000000000221E13000000000000000000000000000000
      000000000000000000000000000000000000000000006C3D3E00DEBEBD00DEBE
      BD00DEB6B500D6B6B500C6757300C6757300A5696B00AD7D7B00BD8E8C00B582
      8400BD71730073495A0000000000D6B6B5FFC6B2B5FFFFD373FFFFD77BFFFFDF
      84FFFFE38CFFFFE394FFFFE79CFFFFEB9CFFFFEBA5FFFFEBA5FFF3E694FF33A2
      1FFF029101FF0B9406FFA7C156FFFFD77BFFCE9273FFD6AEADFFDEBEBDFFDEBA
      BDFFDEB6B5FFCE9694FFC67173FFC67573FFB5696BFFAD6D6BFFAD7D7BFFAD75
      73FFBD7173FF00000000D6B6B5FFC6B2B5FFF3C977FFAB9597FF504DB8FF4443
      BCFF4242BCFF4A49BBFF9A91ADFFD2C2AAFF5B59B9FF4242BDFF5653B9FFDFC7
      9AFFFFE38CFFFFDB84FFFFD77BFFCE9273FFD6AEADFFDEBEBDFFDEBABDFFDEB6
      B5FFCE9694FFC67173FFC67573FFB5696BFFAD6D6BFFAD7D7BFFAD7573FFBD71
      73FFD6B6B500DED3D600C6AEAD00FFD77B00FFDB8400FFE38C00FFE79400FFEB
      9C00FFEBA500FFEFAD00FFEFAD00FFEFAD00FFEFAD00FFEBA500FFEB9C00FFE3
      8C00FFDB8400BD717300D6B2B500DEBEBD00DEBABD00DEB6B500CE969400C671
      7300C6717300C6717300C6717300C6717300B5696B00B5696B0073495A000000
      0000DED3D600C6B2B500000000000000000000000000221E1300221E13000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A9656700DEBEBD00DEBEBD00DEB6B500D6B6B500C6717300C671
      7300C6717300B5696B00A5696B00A5717300C671730073495A00D6B6B5FFDED3
      D6FFC6AEADFFFFD77BFFFFDB84FFFFE38CFFFFE794FFFFEB9CFFFFEBA5FFFFEF
      ADFFFFEFADFFFFEFADFFFFEFADFF43A82BFF019100FF019100FF42A624FFFFDB
      84FFBD7173FFD6B2B5FFDEBEBDFFDEBABDFFDEB6B5FFCE9694FFC67173FFC671
      73FFC67173FFC67173FFC67173FFB5696BFFB5696BFFD6B6B5FFDED3D6FFC6AE
      ADFFCFB18BFF504EB8FF4242BDFF4B4ABAFF726DB4FFCBBDABFFFFEFADFFFFEF
      ADFF9A93B5FF4545BCFF4343BCFF6864B6FFE7D299FFFFE38CFFFFDB84FFBD71
      73FFD6B2B5FFDEBEBDFFDEBABDFFDEB6B5FFCE9694FFC67173FFC67173FFC671
      73FFC67173FFC67173FFB5696BFFB5696BFFD6B6B500F7EFEF00BD9E9400FFDB
      7B00FFDF8C00FFE39400FFEB9C00FFEFAD00FFF3AD00FFF3B500FFF7BD00FFF7
      BD00FFF3B500FFF3AD00FFEBA500FFE39400FFDF8C00BD797B00E7C3C600E7CF
      CE00EFDBDE00F7E7E700FFFBFF00F7E7E700DEAAAD00CE8A8C00CE696B00CE6D
      6B00CE6D6B00C66D6B0073495A0000000000F7EFEF00A5929400000000000000
      0000221E13000000000000000000000000000000000000000000000000000000
      0000000000000000000012100A000000000089614C00BD717300DEBEBD00DEBE
      BD00DEB6B500DEC3C600D69E9C00CE6D6B00CE6D6B00CE6D6B00CE6D6B00CE6D
      6B00CE6D6B0073495A00D6B6B5FFF7EFEFFFBD9E94FFFFDB7BFFFFDF8CFFFFE3
      94FFFFEB9CFFFFEFADFFFFF3ADFFFFF3B5FFFFF7BDFFFFF7BDFFFFF3B5FF60B6
      41FF009100FF009100FF18980DFFF3DB85FFBD797BFFE7C3C6FFE7CFCEFFEFDB
      DEFFF7E7E7FFFFFBFFFFF7E7E7FFDEAAADFFCE8A8CFFCE696BFFCE6D6BFFCE6D
      6BFFC66D6BFFD6B6B5FFF7EFEFFFBD9E94FFCFB48BFF6E66B1FF504EB9FFABA0
      AAFFFFEFADFFFFF3ADFFFFF3B5FFFFF7BDFFE7E0BDFF5654BCFF4242BCFF4343
      BCFF958CAEFFFFE394FFFFDF8CFFBD797BFFE7C3C6FFE7CFCEFFEFDBDEFFF7E7
      E7FFFFFBFFFFF7E7E7FFDEAAADFFCE8A8CFFCE696BFFCE6D6BFFCE6D6BFFC66D
      6BFFC6BABD00EFEBEF00BD9E9400EFC78C00FFE38C00FFE79C00FFEBA500FFF3
      AD00FFF7BD00FFFBC600FFFBC600FFFBC600FFFBC600FFF7BD00FFEFAD00FFE7
      9C00EFC78C00BD797B00F7E7E700F7E7E700F7E7E700F7E7E700F7E7E700F7E7
      E700F7E7E700F7E7E700EFDBDE00DEAAAD00CE8A8C00B5696B009C7573000000
      0000E7E3E7009C9294000000000000000000221E130000000000000000000000
      0000222019002220190022201900000000000000000000000000221E13000000
      000089614C00C6828400E7CFCE00EFDBDE00FFFBFF00FFFBFF00FFFBFF00F7EF
      EF00DE9E9C00CE6D6B00CE6D6B00CE6D6B00CE6D6B0073495A00C6BABDFFEFEB
      EFFFBD9E94FFEFC78CFFFFE38CFFFFE79CFFFFEBA5FFFFF3ADFFFFF7BDFFFFFB
      C6FFFFFBC6FFFFFBC6FFFFFBC6FF96CC6EFF029101FF009100FF089304FFC2BD
      72FFBD797BFFF7E7E7FFF7E7E7FFF7E7E7FFF7E7E7FFF7E7E7FFF7E7E7FFF7E7
      E7FFF7E7E7FFEFDBDEFFDEAAADFFCE8A8CFFB5696BFFC6BABDFFEFEBEFFFBD9E
      94FFE4BE8FFFCFBA98FFCFBDA4FFF3E0A6FFFFF3ADFFFFF7BDFFFFFBC6FFFFFB
      C6FFFFFBC6FFB3B1C2FF4545BDFF4242BCFF5654BAFFE7D2A0FFEFC78CFFBD79
      7BFFF7E7E7FFF7E7E7FFF7E7E7FFF7E7E7FFF7E7E7FFF7E7E7FFF7E7E7FFF7E7
      E7FFEFDBDEFFDEAAADFFCE8A8CFFB5696BFFD6B6B500EFEBEF009C9294009C92
      9400A58E8C00BD9E9400CEB29400D6C3AD00E7DFB500FFFFCE00FFFFCE00FFFF
      CE00FFFFCE00FFFBC600FFF3B500FFEB9C00EFC78C00BD797B00EFCFCE00EFDB
      DE00EFCFCE00E7D7D600EFCFCE00E7D7D600EFCFCE00E7D7D600D6AEAD00D6AE
      AD00D6AEAD00D6AEAD0000000000D6B6B500C6BABD009C9294009C929400A592
      9400000000000000000000000000000000000000000000000000000000000000
      0000222019000000000000000000221E1300BD797B00CE9E9C00EFDBDE00EFDB
      DE00EFDBDE00EFDBDE00EFDBDE00EFDBDE00EFDBDE00EFDBDE00EFDBDE00E7C3
      C600DE9E9C0000000000D6B6B5FFEFEBEFFF9C9294FF9C9294FFA58E8CFFBD9E
      94FFCEB294FFD6C3ADFFE7DFB5FFFFFFCEFFFFFFCEFFFFFFCEFFFFFFCEFFA3D5
      7EFF0A9507FF009100FF12970AFFC2BD72FFBD797BFFEFCFCEFFEFDBDEFFEFCF
      CEFFE7D7D6FFEFCFCEFFE7D7D6FFEFCFCEFFE7D7D6FFD6AEADFFD6AEADFFD6AE
      ADFFD6AEADFFD6B6B5FFEFEBEFFF9C9294FF9C9294FFA58E8CFFBD9E94FFCEB2
      94FFD6C3ADFFE7DFB5FFFFFFCEFFFFFFCEFFFFFFCEFFF6F6CDFF7F7EBFFF4545
      BCFF4646BCFF716CB4FFD9B692FFBD797BFFEFCFCEFFEFDBDEFFEFCFCEFFE7D7
      D6FFEFCFCEFFE7D7D6FFEFCFCEFFE7D7D6FFD6AEADFFD6AEADFFD6AEADFFD6AE
      ADFFD6B6B500DEDFDE00F7EFEF00E7DBDE00D6CBCE00CEBABD00BDA6A500A58E
      8C00A58E8C00A58E8C00BD9E9400CEB29400D6C3AD00E7DFB500FFF7BD00FFEB
      9C00D6B28400BD797B00DEBEBD00DEBEBD00D6AEAD00D6AEAD00D6AEAD00D6AE
      AD00D6AEAD00D6AEAD000000000000000000000000000000000000000000D6B6
      B500FFFBFF00E7E3E700C6BABD00ADA2A500A5929400A5929400A58E8C00A58E
      8C00AD8A8C003029270000000000000000000000000000000000000000000000
      0000B57D7B00CEA6A500DEBEBD00DEBEBD00DEBEBD00DEBEBD00D6AEAD00C69A
      9C00C69A9C000000000000000000000000000000000000000000D6B6B5FFDEDF
      DEFFF7EFEFFFE7DBDEFFD6CBCEFFCEBABDFFBDA6A5FFA58E8CFFA58E8CFFA58E
      8CFFBD9E94FFCEB294FFD6C3ADFFCFD7A2FF79C15AFF35A423FF95C55AFFCBB0
      7DFFBD797BFFDEBEBDFFDEBEBDFFD6AEADFFD6AEADFFD6AEADFFD6AEADFFD6AE
      ADFFD6AEADFF00000000000000000000000000000000D6B6B5FFDEDFDEFFF7EF
      EFFFE7DBDEFFD6CBCEFFCEBABDFFBDA6A5FFA58E8CFFA58E8CFFA58E8CFFBD9E
      94FFCEB294FFD6C3ADFFD2CBB6FF6765BDFF4444BCFF4D4CBAFF9E8899FFBD79
      7BFFDEBEBDFFDEBEBDFFD6AEADFFD6AEADFFD6AEADFFD6AEADFFD6AEADFFD6AE
      ADFF00000000000000000000000000000000D6B6B500D6B6B500D6B6B500D6B6
      B500D6B6B500C6BABD00D6CBCE00DED3D600EFDBDE00DECBCE00CEB2B500BDA6
      A500B5929400AD868400AD868400D6A29400C6A28400BD797B00BD929400BD9E
      9C00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6B6B500D6B6B500DEDBDE00EFEB
      EF00E7D7D600C6B2B500B59E9C00A58E8C00A58E8C00AD8A8C00AD8A8C00AD86
      8400AD86840000000000201C140000000000B57D7B00D6A2A500CEA6A500C69E
      9C00BD929400BD92940000000000000000000000000000000000000000000000
      00000000000000000000D6B6B5FFD6B6B5FFD6B6B5FFD6B6B5FFD6B6B5FFC6BA
      BDFFD6CBCEFFDED3D6FFEFDBDEFFDECBCEFFCEB2B5FFBDA6A5FFB59294FFAD86
      84FFAD8684FFB59A8CFFD6A294FFC6A284FFBD797BFFBD9294FFBD9E9CFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D6B6B5FFD6B6B5FFD6B6B5FFD6B6B5FFD6B6B5FFC6BABDFFD6CB
      CEFFDED3D6FFEFDBDEFFDECBCEFFCEB2B5FFBDA6A5FFB59294FFAD8684FF9376
      91FF665DADFF836CAAFFB5958BFFBD797BFFBD9294FFBD9E9CFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6B6B500D6B6B500D6B6
      B500D6B6B500D6B6B500D6B6B500CEB2B500D6BEBD00E7C3C600DEBEBD00CEA2
      A500B5868400BD797B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEC7C600D6B6B500D6B6
      B500D6B6B500DEC7C600E7CFCE00CEAAAD00BD9E9C00AD868400B5868400B582
      8400B58284000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D6B6B5FFD6B6B5FFD6B6B5FFD6B6B5FFD6B6
      B5FFD6B6B5FFCEB2B5FFD6BEBDFFE7C3C6FFDEBEBDFFD6AEADFFCEA2A5FFB586
      84FFBD797BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D6B6B5FFD6B6B5FFD6B6B5FFD6B6B5FFD6B6B5FFD6B6
      B5FFCEB2B5FFD6BEBDFFE7C3C6FFDEBEBDFFD6AEADFFCEA2A5FFB58684FFBD79
      7BFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6B6
      B500D6B6B500D6B6B500D6B6B500D6B6B500D6B6B50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6B6B500CEA6A500CEA6
      A500CEA6A500DEBABD00CEA6A500C69A9C00AD7D7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6B6B5FFD6B6B5FFD6B6
      B5FFD6B6B5FFD6B6B5FFD6B6B5FFD6B6B5FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6B6B5FFD6B6B5FFD6B6B5FFD6B6
      B5FFD6B6B5FFD6B6B5FFD6B6B5FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      280000007C0000003E0000000100010000000000E00300000000000000000000
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
      FC01FFFFFFFFFFFFC001FFFF8003FFF0F000FFFFF003FFFF8000FFFF0001FFF0
      E0007FFFE000FFFF00007FFE0000FFF0C0003FFF80003FFE00003FFC00007FF0
      80001FFF00003FFC00003FF800007FF000001FFF00001FFC000038F8000071F0
      00001C7F00001CFC00002038000040700000101F0000307E0000000C00000010
      800000070000000F0000000600000000C0000003800000078000000700000000
      E0000001C00000038000000700000000E0000001E00000038000000700000000
      E0000001C00000038000000700000000E0000001C00000038000000700000000
      E0000001C00000030000000600000000C0000001C00000030000000600000000
      C0000001C00000030000000600000000C0000001800000030000000600000000
      8000000180000002000000040000000080000001000000020000000400000000
      8000000100000002000000040000000080000001000000020000000400000000
      0000000100000000000000000000000000000001000000000000000000000000
      0000000100000000000000000000000000000002000000040000000000000000
      0000003E0000007C00000078000000F000000FFF000003FC00001FF800003FF0
      F8003FFFF8007FFFE0007FFFC000FFF0FFE07FFFFF807FFFFF80FFFFFF01FFF0
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    Left = 772
    Top = 277
  end
  object cdsComps: TMemTableEh
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
        Size = 20
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
        Size = 20
      end
      item
        Name = 'Selection'
        DataType = ftInteger
      end
      item
        Name = 'SysState'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Group'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 516
    Top = 345
  end
end
