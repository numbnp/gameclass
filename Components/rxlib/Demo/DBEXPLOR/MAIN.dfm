object DBExplorerMainForm: TDBExplorerMainForm
  Left = 217
  Top = 151
  Width = 475
  Height = 190
  Caption = 'Database Explorer'
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000F00000000888
    888888888888880000F00F0000000000000000000000000FB07B000008000888
    8888888888888000FB0F0FBF000008FFFFF8FFFFFF8FF0B00F000FBFFB000888
    888888880000000F000FBFF9FFF008AAAAA8AAA00999890000000989BFF00888
    8888880098BFEF80FBF00FFFFFB008FFFFF8FF088E7FFE8000FFFBFBFFF00888
    88888809F0E0078080000FFFF00008FFFFF8FF087000F7808088800000000888
    88888809E7007008808F8088888008FFFFF8FFF00BF7008F8088808000800888
    8888888800000888808F8088808008FFFFF8FFFFFF8FFFFF8088808F80800888
    8888888888888888808F8088808008FFFFF8FFFFFF8FFFFF8088808F80800888
    8888888888888888808F80888080000000000000000000000088808F80800E7E
    7E7E7E7E7E7E7E7EE08F80888080000000000000000000000088808F80800000
    08FFFFF8FFFFFF8FFFFF80888080000008888888888888888888808F80800000
    000000000000000000000088808000000E7E7E7E7E7E7E7E7E7EE08F80800000
    00000000000000000000008880800000000008FFFFF8FFFFFF8FFFFF80800000
    0000088888888888888888888080000000000000000000000000000000800000
    00000E7E7E7E7E7E7E7E7E7EE08000000000000000000000000000000000FFFF
    FC4FFFFFF80F8000000F00000003000000010000000000000000000000000000
    0000000000000000000000000007000000010000000100000001000000010000
    00010000000100000001000000010000000100000001F0000001F0000001F000
    0001F0000001F0000001FF000001FF000001FF000001FF000001FF0000030100}
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poDefault
  WindowMenu = WindowMenu
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object SQLFontContainer: TLabel
    Left = 4
    Top = 68
    Width = 56
    Height = 13
    Caption = 'SQLFont'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 112
    Width = 467
    Height = 24
    Align = alBottom
    BorderWidth = 1
    TabOrder = 0
    object StatusLine: TPanel
      Left = 2
      Top = 2
      Width = 95
      Height = 20
      Align = alClient
      Alignment = taLeftJustify
      BevelInner = bvLowered
      BevelOuter = bvNone
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 322
      Top = 2
      Width = 143
      Height = 20
      Align = alRight
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      BorderWidth = 3
      TabOrder = 1
      object DBGauge: TGauge
        Left = 4
        Top = 4
        Width = 135
        Height = 12
        Align = alClient
        BackColor = clBtnFace
        BorderStyle = bsNone
        ForeColor = clActiveCaption
        Progress = 0
        ShowText = False
      end
    end
    object Panel4: TPanel
      Left = 193
      Top = 2
      Width = 129
      Height = 20
      Align = alRight
      BevelInner = bvLowered
      BevelOuter = bvNone
      TabOrder = 2
      object DBStatusLabel: TDBStatusLabel
        Left = 1
        Top = 1
        Width = 127
        Height = 18
        Captions.Strings = (
          'Inactive'
          'Browse'
          'Edit'
          'Insert'
          'Search'
          'Calculate')
        ShowOptions = doBoth
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        OnGetDataName = DBStatusLabelGetDataName
      end
    end
    object RecNoPanel: TPanel
      Left = 97
      Top = 2
      Width = 96
      Height = 20
      Align = alRight
      BevelInner = bvLowered
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object DBRecordNo: TDBStatusLabel
        Left = 1
        Top = 1
        Width = 94
        Height = 18
        Style = lsRecordNo
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        OnGetDataName = DBStatusLabelGetDataName
        OnDblClick = DBRecordNoDblClick
      end
    end
  end
  object SpeedBar: TSpeedBar
    Left = 0
    Top = 0
    Width = 467
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    BoundLines = [blTop, blBottom]
    BtnOffsetHorz = 6
    BtnOffsetVert = 4
    BtnWidth = 24
    BtnHeight = 23
    IniStorage = FormPlacement
    Version = 6
    BevelOuter = bvNone
    TabOrder = 1
    OnApplyAlign = SpeedBarApplyAlign
    InternalVer = 1
    object Panel3: TPanel
      Left = 256
      Top = 2
      Width = 211
      Height = 27
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object DBNavigator: TDBNavigator
        Left = 10
        Top = 3
        Width = 200
        Height = 21
        TabOrder = 0
      end
    end
    object ToolSplitter: TRxSplitter
      Left = 254
      Top = 2
      Width = 2
      Height = 27
      ControlFirst = Panel3
      Align = alRight
      TopLeftLimit = 100
      BottomRightLimit = 10
    end
    object TSpeedbarSection
      Caption = 'Database'
    end
    object TSpeedbarSection
      Caption = 'Utilities'
    end
    object TSpeedbarSection
      Caption = 'Tools'
    end
    object TSpeedbarSection
      Caption = 'Help'
    end
    object SpeedItem1: TSpeedItem
      Caption = 'Open Database'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333000030000000003333333333000030F77777080333333333000030F7
        7777080333333333000030F77777080333333333000030F77777080333333333
        000030F77777080333333333000030F77777080333333333000030F888870803
        33333333000030FFFFF7080333333333000030F88887080333333333000030FF
        FFF7080333333333000030F77997080330000333000030F77997080330EA0333
        000030FFFFFF080000AE00030000300000000030EAEAEA030000333333333330
        00AE0003000033333333333330EA033300003333333333333000033300003333
        33333333333333330000}
      Hint = 'Open Database|Open an existing database'
      Spacing = 1
      Left = 6
      Top = 4
      Visible = True
      OnClick = FileOpenItemClick
      SectionName = 'Database'
    end
    object CloseButton: TSpeedItem
      Caption = 'Close Database'
      Enabled = False
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333000030000000003333333333000030F77777080333333333000030F7
        7777080333333333000030F77777080333333333000030F77777080333333333
        000030F77777080333333333000030F77777080333333333000030F888870803
        33333333000030FFFFF7080333333333000030F88887080333333333000030FF
        FFF7080333333333000030F77997080333333333000030F77997080333333333
        000030FFFFFF0803333333330000300000000033000000030000333333333333
        09D9D90300003333333333330000000300003333333333333333333300003333
        33333333333333330000}
      Hint = 'Close Database|Close current database'
      Spacing = 1
      Left = 30
      Top = 4
      Visible = True
      OnClick = FileCloseItemClick
      SectionName = 'Database'
    end
    object SpeedItem3: TSpeedItem
      Caption = 'Exit'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333000088888888888888833338000088888888888888F3F38800008888
        888888888F3F38880000444444088888FFF44443000033333450888F3FF43333
        00003333345508FFFFF4333300003333345550FFFFF4333300003330045550FF
        FFF4333300003330A05550FFFFF4333300000000EA0550FFFEF4333300000EAE
        AEA050FFFFF4333300000AEAEAEA00FEFEF4333300000EAEAEA050FFFFF43333
        00000000EA0550FEFEF4333300003330A05550EFEFE4333300003330045550FE
        FEF4333300003333345550EFEFE4333300003333344444444444333300003333
        33333333333333330000}
      Hint = 'Exit|Exit the application'
      Spacing = 1
      Left = 222
      Top = 4
      Visible = True
      OnClick = FileExitItemClick
      SectionName = 'Database'
    end
    object PackBtn: TSpeedItem
      Caption = 'Pack Table'
      Enabled = False
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDDDD000000000DDDDDDDDDDD00DDDDDDDDDDD0000000D0DDDDDD078787
        870DD00000000000080DD03B3B3B3B0D070DD0B3B3B3B30D080DD03B3B3B3B0D
        070DD0B3B3B3B30D080DD03B3000000D070DD0B3B0DDDDDD080DDD000D000000
        070DDDDDDD08787870DDDDDDDDD000000DDDDDDDDDDDDDDDDDDD}
      Hint = 'Pack Table|Pack Paradox or DBase table'
      Spacing = 1
      Left = 3
      Top = 4
      OnClick = PackTableClick
      SectionName = 'Utilities'
    end
    object DeleteBtn: TSpeedItem
      Caption = 'Delete Table'
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      Hint = 'Delete Table|Delete selected table'
      NumGlyphs = 2
      Spacing = 1
      Left = 3
      Top = 4
      OnClick = DeleteTableClick
      SectionName = 'Utilities'
    end
    object EmptyBtn: TSpeedItem
      Caption = 'Empty Table'
      Enabled = False
      Glyph.Data = {
        42010000424D4201000000000000760000002800000011000000110000000100
        040000000000CC00000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333300000003333333333133333300000003333333331133333100000003333
        3333311133313000000033333333331133113000000030000000000011533000
        0000303333333335113330000000303003003031511330000000303333333311
        331150000000304444445144443510000000334FFFFF15FFF43330000000334F
        00F00F00F43330000000334FFFFFFFFFF4333000000033444444444444333000
        0000334344344344343330000000334444444444443330000000333333333333
        333330000000}
      Hint = 'Empty Table|Empty selected table'
      Spacing = 1
      Left = 3
      Top = 4
      OnClick = EmptyTableClick
      SectionName = 'Utilities'
    end
    object RenameBtn: TSpeedItem
      Caption = 'Rename Table'
      Enabled = False
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        83333333330AAAAA00833333330AAAAAA2033333330AAAAA2A20333333000000
        A220333333333333002033333333333333003333033333333300333003333333
        0020330A00000000A22030AAAAAAAAAA2A200AAAAAAAAAAAA20330AAAAAAAAAA
        0033330A00000000833333300333333333333333033333333333}
      Hint = 'Rename Table|Rename selected table'
      Spacing = 1
      Left = 3
      Top = 4
      OnClick = RenameTableClick
      SectionName = 'Utilities'
    end
    object ExportBtn: TSpeedItem
      Caption = 'Export Data'
      Enabled = False
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D800000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333303333333
        3333330000003333003000000000000000003800000078888888800000008000
        0000F77777778000000000830030F99777778000000000330330FFFFFFFF7000
        0000003333300000000000000000003333333333333333000000333333333333
        3333330000000000000000033333330000000FFF0FFFFF033333330000000F9F
        0FB99F033333330000000FFF0FFFFF033333330000000F9F0FB99F0333333300
        00000FFF0FFFFF033333330000000000000000033333330000000EEEEEEEEE03
        333333000000000000000003333333000000}
      Hint = 'Export Data|Export data to dBase, ASCII or Paradox format'
      Spacing = 1
      Left = 62
      Top = 4
      Visible = True
      OnClick = ExportClick
      SectionName = 'Utilities'
    end
    object ImportBtn: TSpeedItem
      Caption = 'Import Data'
      Enabled = False
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D800000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333330000000000000000033333330000000788888888033333330000000F77
        777778033333330000000F99777778033333330000000FFFFFFFF70333333300
        0000000000000003333333000000333333333333333333000000333333333333
        33333300000000333330000000000000000000333330FFF0FFFFF00000000033
        0330F9F0F9B9F000000000830030FFF0FFFFF000000080000000F9F0F9B9F000
        000038000000FFF0FFFFF000000033330030000000000000000033330330EEEE
        EEEEE0000000333333300000000000000000}
      Hint = 'Import Data|Import data from dBase or Paradox format'
      Spacing = 1
      Left = 86
      Top = 4
      Visible = True
      OnClick = ImportClick
      SectionName = 'Utilities'
    end
    object RepairBtn: TSpeedItem
      Caption = 'Check Paradox Tables'
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333FF33333333FF3330033333333
        00333388FF33333388FF300003333330000338888FFFFFF8888F000000000000
        000088888888888888880F77FFFF7FFF77F08F333F33333333380FFF9FFF7FFF
        FF808F338FF333FFFFF80FF999FF700000038F388833388888830FFF9FFF0777
        70338F3383338F3338330FFFFFFF077703338FFFFFFF8FFF8333800000000000
        3333888888888888F33333333339399939333333333338883333333333333393
        3333333333333383333333333333933393333333333333333333333333333393
        3333333333333333333333333333333333333333333333333333}
      Hint = 'Check Paradox Tables|Check and repair Paradox tables'
      NumGlyphs = 2
      Spacing = 1
      Left = 3
      Top = 4
      OnClick = CheckPXAllClick
      SectionName = 'Utilities'
    end
    object SpeedItem4: TSpeedItem
      AllowAllUp = True
      Caption = 'Sync Pages'
      GroupIndex = 1
      Down = True
      Glyph.Data = {
        42010000424D4201000000000000760000002800000011000000110000000100
        040000000000CC00000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333300000000000000033333333300000000FFFFFF033333333300000000F88
        88F033333333300000000FFFFFF033333333300000000F8888F0333333333000
        00000FFFFFF044444444300000000F8888F088888884300000000FFFFFF03333
        3334300000000000000030030034300000003333433333333334300000003333
        4300300300343000000034334333333333343000000044434444444444443000
        000034334F44F44F44F430000000333344444444444430000000333333333333
        333330000000}
      Hint = 'Sync Pages|Automatic open table on navigate'
      Spacing = 1
      Left = 110
      Top = 4
      Visible = True
      OnClick = AutoActivateItemClick
      SectionName = 'Tools'
    end
    object SpeedItem2: TSpeedItem
      AllowAllUp = True
      Caption = 'Show System Tables'
      GroupIndex = 2
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333300003333333333333333333300003333330000000333333300003331
        11110888803333330000339999991777880333330000339F99F9177778803333
        0000339F9FF91777788033330000339FF9F91777788033330000339F99F91777
        7880333300003399999977A2788033330000333338FFFFFFF880333300003333
        388888888880333300003333387FFF8F78803333000033333878000878803333
        0000333338777777788033330000333338FFFFFFF78033330000333333877777
        7770333300003333333888888883333300003333333333333333333300003333
        33333333333333330000}
      Hint = 'Show System Tables|Show System Tables'
      Spacing = 1
      Left = 134
      Top = 4
      Visible = True
      OnClick = SystemTablesItemClick
      SectionName = 'Tools'
    end
    object KeepConnectionsSpd: TSpeedItem
      AllowAllUp = True
      Caption = 'Keep Connections'
      GroupIndex = 3
      Down = True
      Glyph.Data = {
        42010000424D4201000000000000760000002800000011000000110000000100
        040000000000CC00000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333338888888
        8888800000003333383333333333800000003333383333333333800000003333
        3838838838838000000033333833333333338000000033333838838838838000
        0000344448333333333380000000348888888888888880000000343338388388
        3883800000003430088888888888800000003433333333334333300000003430
        0300300343333000000034333333333343333000000034444444444443333000
        000034F44F44F44F433330000000344444444444433330000000333333333333
        333330000000}
      Hint = 'Keep Connections|Keep database connections'
      Spacing = 1
      Left = 142
      Top = 4
      OnClick = KeepConnectionsItemClick
      SectionName = 'Tools'
    end
    object OptionsBtn: TSpeedItem
      Caption = 'Options'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333300000000000033330FFFFFFFFFF033330F00F00000F033330FFFFFFFFFF0
        33330F00F00000F033330FFFFFFFFFF033330FFFFFFF0FF033330F00FFF070F0
        33340F070F07070003440FF07070707770440000070707777744333330707777
        7744333333077777704433333330000003443333333333333333}
      Hint = 'Options|Set options'
      Spacing = 1
      Left = 166
      Top = 4
      Visible = True
      OnClick = OptionsClick
      SectionName = 'Tools'
    end
    object SpeedItem5: TSpeedItem
      Caption = 'Customize Speedbar'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777700007777777777777777777700007F88888888888888888800007F78
        888788887888877800007F7FAA87F9987FCC877800007F7FAA87F9987FCC8778
        00007F7FFF87FFF87FFF877800007F77777777777777777800007FFFFFFFFFFF
        FFFFFFF800007777777777777777777700007777777777777777777700007777
        7777777777777777000077777777777778000877000077777777777780EEE077
        00007778000000000EE0087700007770E4EEEEEEEEE077770000777800000000
        0EE00877000077777777777780EEE07700007777777777777800087700007777
        77777777777777770000}
      Hint = 'Customize Speedbar|Customize Speedbar'
      Spacing = 1
      Left = 190
      Top = 4
      Visible = True
      OnClick = CustomizeToolbarItemClick
      SectionName = 'Tools'
    end
    object SpeedItem6: TSpeedItem
      Caption = 'About'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333300003333333333333333333300003333333800008333333300003333
        3800444400833333000033338044444444083333000033380444BBBB44408333
        0000333044444BB4444403330000338044444BB4444408330000330444444BB4
        444440330000330444444BB4444440330000330444444BB44444403300003304
        4444BBB4444440330000338044444444444408330000333044444BB444440333
        0000333804444BB4444083330000333380444444440833330000333338004444
        0083333300003333333800008333333300003333333333333333333300003333
        33333333333333330000}
      Hint = 'About|About Database Explorer'
      Spacing = 1
      Left = 190
      Top = 4
      OnClick = HelpAboutItemClick
      SectionName = 'Help'
    end
  end
  object FormPlacement: TFormStorage
    OnSavePlacement = FormPlacementSavePlacement
    OnRestorePlacement = FormPlacementRestorePlacement
    StoredProps.Strings = (
      'SQLFontContainer.Font'
      'SpeedBar.Options'
      'Panel3.Width')
    StoredValues = <>
    Left = 32
    Top = 36
  end
  object MainMenu1: TMainMenu
    Left = 4
    Top = 36
    object File1: TMenuItem
      Caption = '&Database'
      Hint = 'Databases related commands'
      object FileOpenItem: TMenuItem
        Caption = '&Open...'
        Hint = 'Open an existing database'
        ShortCut = 113
        OnClick = FileOpenItemClick
      end
      object ReopenMenu: TMenuItem
        Caption = 'Reopen'
        Enabled = False
        Hint = 'Reopen the specified database'
      end
      object FileCloseItem: TMenuItem
        Caption = '&Close'
        Hint = 'Close current database'
        OnClick = FileCloseItemClick
      end
      object StartTransItem: TMenuItem
        Caption = 'Start Transaction'
        Enabled = False
        Hint = 'Start Transaction on current database'
        OnClick = StartTransItemClick
      end
      object CommitItem: TMenuItem
        Caption = 'Commit'
        Enabled = False
        Hint = 'Commit changes to database'
        OnClick = CommitItemClick
      end
      object RollbackItem: TMenuItem
        Caption = 'Rollback'
        Enabled = False
        Hint = 'Rolback changes'
        OnClick = RollbackItemClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object BdePropsItem: TMenuItem
        Caption = 'P&roperties'
        Hint = 'Database Engine Properties'
        OnClick = BdePropsItemClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object FileExitItem: TMenuItem
        Caption = 'E&xit'
        Hint = 'Exit the application'
        ShortCut = 32856
        OnClick = FileExitItemClick
      end
    end
    object UtilitiesMenu: TMenuItem
      Caption = '&Utilities'
      object PackTableItem: TMenuItem
        Caption = '&Pack Table'
        Enabled = False
        Hint = 'Pack Paradox or DBase table'
        OnClick = PackTableClick
      end
      object DeleteTableItem: TMenuItem
        Caption = '&Delete Table'
        Enabled = False
        Hint = 'Delete selected table'
        OnClick = DeleteTableClick
      end
      object EmptyTableItem: TMenuItem
        Caption = '&Empty Table'
        Enabled = False
        Hint = 'Empty selected table'
        OnClick = EmptyTableClick
      end
      object ReindexItem: TMenuItem
        Caption = 'Re&index Table'
        Enabled = False
        Hint = 'Reindex Paradox or DBase table'
        OnClick = ReindexItemClick
      end
      object RenameTableItem: TMenuItem
        Caption = '&Rename Table'
        Enabled = False
        Hint = 'Rename selected table'
        OnClick = RenameTableClick
      end
      object ExportTableItem: TMenuItem
        Caption = 'E&xport Data'
        Enabled = False
        Hint = 'Export data to dBase, ASCII or Paradox format'
        OnClick = ExportClick
      end
      object ImportDataItem: TMenuItem
        Caption = 'I&mport Data'
        Enabled = False
        Hint = 'Import data from dBase or Paradox format'
        OnClick = ImportClick
      end
      object CheckPXSubMenu: TMenuItem
        Caption = '&Check Paradox Tables'
        Hint = 'Check and repair Paradox tables'
        object CheckPXItem: TMenuItem
          Caption = '&Single Table'
          Enabled = False
          Hint = 'Check and repair single Paradox table'
          OnClick = CheckPXItemClick
        end
        object CheckPXAllItem: TMenuItem
          Caption = '&All Tables'
          Enabled = False
          Hint = 'Check all Paradox Tables in database'
          OnClick = CheckPXAllClick
        end
      end
    end
    object Options1: TMenuItem
      Caption = '&Tools'
      Hint = 'Configuration settings'
      object AutoActivateItem: TMenuItem
        Caption = '&Sync Pages'
        Checked = True
        Hint = 'Automatic open table on navigate'
        OnClick = AutoActivateItemClick
      end
      object SystemTablesItem: TMenuItem
        Caption = 'System &Tables'
        Hint = 'Show system tables'
        OnClick = SystemTablesItemClick
      end
      object KeepConnectionsItem: TMenuItem
        Caption = '&Keep Connections'
        Checked = True
        Hint = 'Keep database connections'
        OnClick = KeepConnectionsItemClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object OptionsItem: TMenuItem
        Caption = '&Options...'
        Hint = 'Preferences'
        OnClick = OptionsClick
      end
      object CustomizeSpeedbar: TMenuItem
        Caption = '&Customize Speedbar...'
        Hint = 'Customize Speedbar'
        OnClick = CustomizeToolbarItemClick
      end
      object UserHelpItem: TMenuItem
        Caption = 'User &Help Files...'
        Hint = 'Configure items that can be added on the Help menu'
        OnClick = UserHelpItemClick
      end
      object Flatspeedbarbuttons1: TMenuItem
        Caption = '&Flat Speedbar Buttons'
        Hint = 'Add or remove the 3D-border when the button is unselected'
        OnClick = Flatspeedbarbuttons1Click
      end
    end
    object WindowMenu: TMenuItem
      Caption = '&Window'
      Hint = 'Window related commands such as Tile and Cascade'
      object WindowCascadeItem: TMenuItem
        Caption = '&Cascade'
        Hint = 'Arrange windows so they overlap'
        OnClick = WindowCascadeItemClick
      end
      object WindowTileItem: TMenuItem
        Caption = 'Tile &Horizontal'
        Hint = 'Arrange windows side by side'
        OnClick = WindowTileItemClick
      end
      object WindowTileVerticalItem: TMenuItem
        Caption = 'Tile &Vertical'
        Hint = 'Arrange windows stacked vertically'
        OnClick = WindowTileItemClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object WindowArrangeItem: TMenuItem
        Caption = '&Arrange Icons'
        Hint = 'Arrange window icons at bottom of main window'
        OnClick = WindowArrangeItemClick
      end
      object WindowMinimizeItem: TMenuItem
        Caption = '&Minimize All'
        Hint = 'Minimize all windows'
        OnClick = WindowMinimizeItemClick
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      Hint = 'Help topics'
      object HelpAboutItem: TMenuItem
        Caption = '&About'
        Hint = 'About Database Explorer'
        OnClick = HelpAboutItemClick
      end
    end
  end
  object DBProgress1: TDBProgress
    MessageControl = StatusLine
    Gauge = DBGauge
    Left = 60
    Top = 36
  end
  object AppEvents: TAppEvents
    UpdateFormatSettings = False
    OnActivate = AppActivate
    OnHint = ShowHint
    Left = 88
    Top = 36
  end
  object ClosedDatabases: TMRUManager
    Capacity = 15
    IniStorage = FormPlacement
    RecentMenu = ReopenMenu
    OnClick = ClosedDatabasesClick
    Left = 116
    Top = 36
  end
  object HelpList: TMRUManager
    AutoEnable = False
    Capacity = 40
    IniStorage = FormPlacement
    RecentMenu = Help1
    ShowAccelChar = False
    OnClick = HelpListClick
    Left = 144
    Top = 36
  end
end
