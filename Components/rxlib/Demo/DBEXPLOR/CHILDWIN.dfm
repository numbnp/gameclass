object MDIChild: TMDIChild
  Left = 339
  Top = 138
  Width = 378
  Height = 230
  ActiveControl = TablesGrid
  Caption = 'Database'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000008888888888888888888000000000000000000000000000000080000
    000000080FFFF0FFFFFFFFFFFF080000000000000F44F0F444444444FF080000
    000000070FFFF0FFFFFFFFFFFF080000000000070F44F0F44444444FFF080000
    000000070FFFF0FFFFFFFFFFFF080000000000070F44F0F444444444FF080000
    088800070FFFF0FFFFFFFFFFFF080000800880070F44F0F44444444FFF080000
    0E6088070FFFF0FFFFFFFFFFFF08000000E608070F44F0F444444444FF080880
    000E08070FFFF0FFFFFFFFFFFF088088000E0807000000000000000000080E08
    80E608870EEEEEEEEEEEEEEEEE080FE00E60E0880000000000000000000000FE
    E60E6E0886666666666666660800000000EEE6E0880000000000000000000000
    000FEE6E0880000000000000000000000000FEE6E08800000000000000000000
    00000FEE6E0880000000000000000000000000FEE6E088000000000000000000
    0000000FEE6E0888880000000000000000000000FEE6E0000880000000000000
    000000000FEE06EE60880000000000000000000000E06E00E608000000000000
    000000000006E0000E0800000000000000000000000E08000080000000000000
    00000000000E0880000000000000000000000000000FE0880000000000000000
    000000000000FE0800000000000000000000000000000080000000000000FFF8
    0000FFF00000FFE00000FFC00000FFC00000FFC00000FFC00000FFC00000F8C0
    0000F0400000F0000000F80000009C0000000C00000000000000000000018000
    0003C0000007FC01FFFFFE00FFFFFF007FFFFF803FFFFFC003FFFFE001FFFFF0
    00FFFFF800FFFFFC30FFFFFC39FFFFFC1FFFFFFC0FFFFFFE0FFFFFFF1FFF8B85}
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object TablesGrid: TRxDBGrid
    Left = 0
    Top = 0
    Width = 92
    Height = 196
    Align = alLeft
    DataSource = DataSource1
    Options = [dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = PopupTablesMenu
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawDataCell = TablesGridDrawDataCell
    OnDblClick = TablesGridDblClick
    OnKeyPress = TablesGridKeyPress
    RowColor2 = 16776176
  end
  object rxSplitter1: TRxSplitter
    Left = 92
    Top = 0
    Width = 3
    Height = 196
    ControlFirst = TablesGrid
    ControlSecond = Panel1
    Align = alLeft
    TopLeftLimit = 35
    BottomRightLimit = 35
  end
  object Panel1: TPanel
    Left = 95
    Top = 0
    Width = 275
    Height = 196
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Notebook1: TNotebook
      Left = 0
      Top = 0
      Width = 275
      Height = 175
      Align = alClient
      TabOrder = 0
      object TPage
        Left = 0
        Top = 0
        Caption = 'Grid'
        object rxDBGrid2: TRxDBGrid
          Left = 0
          Top = 29
          Width = 275
          Height = 146
          Align = alClient
          DataSource = DataSource2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = GridDblClick
          RowColor2 = 16776176
          TitleButtons = True
          OnCheckButton = rxDBGrid2CheckButton
          OnGetBtnParams = rxDBGrid2GetBtnParams
          OnTitleBtnClick = rxDBGrid2TitleBtnClick
        end
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 275
          Height = 29
          Align = alTop
          BevelInner = bvRaised
          BevelOuter = bvNone
          TabOrder = 1
          object Label2: TLabel
            Left = 8
            Top = 8
            Width = 54
            Height = 13
            Caption = '&Sorted by:  '
            FocusControl = DBIndexCombo1
          end
          object DBIndexCombo1: TDBIndexCombo
            Left = 64
            Top = 4
            Width = 201
            Height = 21
            DataSource = DataSource2
            NoIndexItem = '<Default>'
            EnableNoIndex = True
            ItemHeight = 13
            TabOrder = 0
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'SQL'
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 275
          Height = 120
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object SQLMemo: TMemo
            Left = 9
            Top = 16
            Width = 231
            Height = 96
            Align = alClient
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpFixed
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            PopupMenu = PopupSQLMenu
            ScrollBars = ssBoth
            TabOrder = 0
            OnChange = SQLMemoChange
          end
          object Panel3: TPanel
            Left = 240
            Top = 16
            Width = 35
            Height = 96
            Align = alRight
            BevelOuter = bvNone
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            object RunSQL: TSpeedButton
              Left = 7
              Top = 2
              Width = 24
              Height = 24
              Hint = 'Exec SQL Query|'
              Enabled = False
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333300003333333333333333333300003333333033333333333300003333
                33380333333333330000333333330033333333330000333333330B0333333333
                00003333330000B03333333300003333330BBFBB03333333000033333330FB00
                00333333000033333330BFB0333333330000333300000BFB0333333300003333
                0FBFBFBFB03333330000333330FBFB00003333330000333330BFBFB033333333
                00003333330BFBFB0333333300003333330FFFBFF0333333000033333330FBFF
                BF03333300003333333000000000333300003333333333333333333300003333
                33333333333333330000}
              OnClick = RunSQLClick
            end
            object PriorSQL: TSpeedButton
              Left = 7
              Top = 32
              Width = 24
              Height = 24
              Hint = 'Prior SQL|'
              Enabled = False
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333333333333333333333330000033
                3333333330444033333330000044400000333304444444440333333044444440
                3333333304444403333333333044403333333333330403333333333333303333
                3333333333333333333333333333333333333333333333333333}
              OnClick = NavigateSQLClick
            end
            object NextSQL: TSpeedButton
              Left = 7
              Top = 55
              Width = 24
              Height = 24
              Hint = 'Next SQL|'
              Enabled = False
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333333333033333333333333040333
                3333333330444033333333330444440333333330444444403333330444444444
                0333300000444000003333333044403333333333300000333333333333333333
                3333333333333333333333333333333333333333333333333333}
              OnClick = NavigateSQLClick
            end
          end
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 275
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            object Label1: TLabel
              Left = 11
              Top = 1
              Width = 57
              Height = 13
              Caption = 'SQL &Text:   '
            end
            object TrayIconImage: TImage
              Left = 108
              Top = 0
              Width = 32
              Height = 32
              AutoSize = True
              Picture.Data = {
                055449636F6E0000010001001010100000000000280100001600000028000000
                10000000200000000100040000000000C0000000000000000000000000000000
                0000000000000000000080000080000000808000800000008000800080800000
                C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
                FFFFFF0000000000000000000000888888880000000087777778800000008777
                7777880000008777777788000000877777778800000087777AA7880000008777
                7997880000008FFFFFFF88000000888888888800000087FFF8F7880000008780
                00878800000087777777880000008FFFFFFF7800000008777777770000000088
                88888800F80F2C04F00700F8F00300F8F00100F8F00100F8F00100F8F0010078
                F001F7BDF001F7BDF001F7BDF001F7BDF001EF7BF001EF7BF0010000F8010000
                FC030000}
              Visible = False
            end
            object TrayAbortImage: TImage
              Left = 136
              Top = 0
              Width = 32
              Height = 32
              AutoSize = True
              Picture.Data = {
                055449636F6E0000010001001010100000000000280100001600000028000000
                10000000200000000100040000000000C0000000000000000000000000000000
                0000000000000000000080000080000000808000800000008000800080800000
                C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
                FFFFFF0000000000000000000011111088880000099999917778800009999991
                7777880009FFFF917777880009FFFF9177778800099999917AA7880009999997
                7997880000008FFFFFFF88000000888888888800000087FFF8F7880000008780
                00878800000087777777880000008FFFFFFF7800000008777777770000000088
                88888800F80F6404C00700008003000080010000800100008001000080010000
                8001EF7BF001EF7BF001EF7BF001EF7BF001EF7BF001EF7BF0010000F8010000
                FC036404}
              Visible = False
            end
          end
          object Panel5: TPanel
            Left = 0
            Top = 16
            Width = 9
            Height = 96
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 3
          end
          object Panel6: TPanel
            Left = 0
            Top = 112
            Width = 275
            Height = 8
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 4
          end
        end
        object rxDBGrid3: TRxDBGrid
          Left = 0
          Top = 123
          Width = 275
          Height = 59
          Align = alClient
          DataSource = DataSource2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = GridDblClick
          RowColor2 = 16776176
        end
        object rxSplitter2: TRxSplitter
          Left = 0
          Top = 120
          Width = 275
          Height = 3
          ControlFirst = Panel2
          ControlSecond = rxDBGrid3
          Align = alTop
          TopLeftLimit = 10
          BottomRightLimit = 10
        end
      end
    end
    object TabSet1: TTabSet
      Left = 0
      Top = 175
      Width = 275
      Height = 21
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Tabs.Strings = (
        'Table'
        'Fields'
        'Indices'
        'Ref Int'
        'SQL')
      TabIndex = 0
      OnChange = TabSet1Change
    end
  end
  object TableList: TDatabaseItems
    OnCalcFields = TableListCalcFields
    Left = 4
    Top = 3
    object TableListPict: TBooleanField
      Alignment = taCenter
      DisplayWidth = 3
      FieldKind = fkCalculated
      FieldName = 'Pict'
      ReadOnly = True
      DisplayValues = ' ,1'
      Calculated = True
    end
    object TableListTABNAME: TStringField
      DisplayWidth = 132
      FieldKind = fkCalculated
      FieldName = 'TABNAME'
      Size = 132
      Calculated = True
    end
    object TableListNAME: TStringField
      FieldName = 'NAME'
      Visible = False
      Size = 127
    end
    object TableListEXTENSION: TStringField
      FieldName = 'EXTENSION'
      Visible = False
      Size = 3
    end
    object TableListTYPE: TStringField
      FieldName = 'TYPE'
      Visible = False
      Size = 31
    end
    object TableListVIEW: TBooleanField
      FieldName = 'VIEW'
      Visible = False
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = TableList
    OnDataChange = DataSource1DataChange
    Left = 32
    Top = 3
  end
  object FieldList1: TTableItems
    OnCalcFields = FieldList1CalcFields
    Left = 4
    Top = 59
    object FieldList1NAME: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 25
      FieldName = 'NAME'
      Size = 31
    end
    object FieldList1TypeName: TStringField
      FieldKind = fkCalculated
      FieldName = 'TypeName'
      Size = 8
      Calculated = True
    end
    object FieldList1TYPE: TWordField
      DisplayLabel = 'Type'
      FieldName = 'TYPE'
      Visible = False
    end
    object FieldList1SubTypeName: TStringField
      FieldKind = fkCalculated
      FieldName = 'SubTypeName'
      Size = 14
      Calculated = True
    end
    object FieldList1Required: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'Required'
      DisplayValues = 'Yes;No'
      Calculated = True
    end
    object FieldList1SUBTYPE: TWordField
      DisplayLabel = 'SubType'
      FieldName = 'SUBTYPE'
      Visible = False
    end
    object FieldList1UNITS1: TWordField
      DisplayLabel = 'Units1'
      FieldName = 'UNITS1'
    end
    object FieldList1UNITS2: TWordField
      DisplayLabel = 'Units2'
      FieldName = 'UNITS2'
    end
    object FieldList1LENGTH: TWordField
      DisplayLabel = 'Length'
      FieldName = 'LENGTH'
    end
  end
  object IndexList1: TTableItems
    ItemType = dtIndices
    Left = 32
    Top = 59
    object IndexList1NAME: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 50
      FieldName = 'NAME'
      Size = 127
    end
    object IndexList1TAGNAME: TStringField
      DisplayLabel = 'Tag'
      DisplayWidth = 20
      FieldName = 'TAGNAME'
      Size = 31
    end
    object IndexList1UNIQUE: TBooleanField
      DisplayLabel = 'Unique'
      FieldName = 'UNIQUE'
      DisplayValues = 'Yes;No'
    end
    object IndexList1PRIMARY: TBooleanField
      DisplayLabel = 'Primary'
      FieldName = 'PRIMARY'
      DisplayValues = 'Yes;No'
    end
  end
  object DataSource2: TDataSource
    DataSet = Table1
    OnStateChange = DataSource2StateChange
    Left = 60
    Top = 87
  end
  object Table1: TTable
    AfterOpen = AfterOpen
    AfterPost = AfterPost
    Left = 4
    Top = 87
  end
  object Query1: TRxQuery
    AfterOpen = AfterOpen
    AfterPost = AfterPost
    RequestLive = True
    Macros = <>
    Left = 32
    Top = 87
  end
  object FormStorage: TFormStorage
    MinMaxInfo.MinTrackHeight = 170
    MinMaxInfo.MinTrackWidth = 300
    Options = [fpState]
    OnSavePlacement = FormStorageSavePlacement
    OnRestorePlacement = FormStorageRestorePlacement
    StoredProps.Strings = (
      'TablesGrid.Width'
      'Panel2.Height'
      'OpenDialog1.InitialDir'
      'SaveDialog1.InitialDir')
    StoredValues = <>
    Left = 60
    Top = 3
  end
  object PopupTablesMenu: TPopupMenu
    Left = 4
    Top = 31
    object FilterItem: TMenuItem
      Caption = 'Tables Filter...'
      Hint = 'Set tablenames filter'
      ShortCut = 117
      OnClick = FilterItemClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CloseTableItem: TMenuItem
      Caption = 'Close Table'
      Hint = 'Close current table'
      OnClick = CloseTableItemClick
    end
    object CloseItem: TMenuItem
      Caption = 'Close Database'
      Hint = 'Close current database'
      OnClick = CloseItemClick
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'sql'
    FileName = '*.sql'
    Filter = 'SQL files (*.sql)|*.sql|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist]
    Title = 'Load query'
    Left = 4
    Top = 115
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'sql'
    FileName = '*.sql'
    Filter = 'SQL files (*.sql)|*.sql|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist]
    Title = 'Save query'
    Left = 32
    Top = 115
  end
  object TrayMenu: TPopupMenu
    Left = 60
    Top = 31
    object CancelItem: TMenuItem
      Caption = 'Abort query'
      Enabled = False
      Hint = 'Abort currently running query'
    end
  end
  object PopupSQLMenu: TPopupMenu
    OnPopup = PopupSQLMenuPopup
    Left = 32
    Top = 31
    object Undo1: TMenuItem
      Tag = 1
      Caption = '&Undo'
      OnClick = PopupSQLMenuClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Cut1: TMenuItem
      Tag = 2
      Caption = 'Cu&t'
      OnClick = PopupSQLMenuClick
    end
    object Copy1: TMenuItem
      Tag = 3
      Caption = '&Copy'
      OnClick = PopupSQLMenuClick
    end
    object Paste1: TMenuItem
      Tag = 4
      Caption = '&Paste'
      OnClick = PopupSQLMenuClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object SelectAll1: TMenuItem
      Tag = 5
      Caption = 'Select &All'
      OnClick = PopupSQLMenuClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Saveas1: TMenuItem
      Tag = 6
      Caption = '&Save as...'
      ShortCut = 113
      OnClick = PopupSQLMenuClick
    end
    object Load1: TMenuItem
      Tag = 7
      Caption = '&Load...'
      ShortCut = 114
      OnClick = PopupSQLMenuClick
    end
    object PriorSQLItem: TMenuItem
      Tag = 9
      Caption = 'Prior SQL'
      OnClick = PopupSQLMenuClick
    end
    object NextSQLItem: TMenuItem
      Tag = 10
      Caption = 'Next SQL'
      OnClick = PopupSQLMenuClick
    end
    object Runquery1: TMenuItem
      Tag = 8
      Caption = 'Exec SQL'
      ShortCut = 120
      OnClick = PopupSQLMenuClick
    end
  end
  object RefIntList: TTableItems
    OnCalcFields = RefIntListCalcFields
    ItemType = dtRefInt
    Left = 60
    Top = 59
    object RefIntListNAME: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Size = 31
    end
    object RefIntListINTTYPE: TStringField
      DisplayLabel = 'Type'
      FieldKind = fkCalculated
      FieldName = 'INTTYPE'
      Size = 10
      Calculated = True
    end
    object RefIntListOTHERTABLE: TStringField
      DisplayLabel = 'Referential Table'
      FieldName = 'OTHERTABLE'
      Size = 81
    end
  end
  object DbImages: TPicClip
    Cols = 5
    Picture.Data = {
      07544269746D6170A6020000424DA60200000000000076000000280000005000
      00000E0000000100040000000000300200000000000000000000100000000000
      000000000000000080000080000000808000800000008000800080800000C0C0
      C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDD111DDDDD0000000000000DD000000000DDDDDDDD0000000000
      000DD000000000DDDDDDDDD11DDDDD191DDDDD0FF0FFFF0FFF0DD0FF0FFFF0DD
      DDDDDD0FF0FFFF0FFF0DD0FF0FFFF0DDDDDDDDD191DDD1991DDDDD04F0F44F0F
      4F0DD04F0F44F0DDD00DDD04F0F44F0F4F0DD04F0F44F0DDD00DDDD1991DD199
      1DDDDD0FF0FFFF0FFF0DD0FF0FFFF0DD000DDD0FF0FFFF0FFF0DD0FF0FFFF0DD
      000DDDDD191D1991DDDDDD04F0F44F0F4F0DD04F0F40000800DDDD04F0F44F0F
      4F0DD04F0F40000800DDDDDD1991991DDDDDDD0FF0FFFF0FFF0DD0FF0F0FFF00
      8DDDDD0FF0FFFF0FFF0DD0FF0F0FFF008DDDDDDDD199991DDDDDDD04F0F44F0F
      4F0DD000000888870DDDDD04F0F44F0F4F0DD000000888870DDDDDDDDD1991DD
      DDDDDD0FF0FFFF0FFF0DD0EEE0EEEE870DDDDD0FF0FFFF0FFF0DD09990999987
      0DDDDDDDD199991DDDDDDD0000000000000DD00000EEEE870DDDDD0000000000
      000DD000009999870DDDDDDD19919991DDDDDD0EEEEEEEEEEE0DDDDDD0088887
      0DDDDD0999999999990DDDDDD00888870DDDDDD1991D19991DDDDD0000000000
      000DDDDDDD077770DDDDDD0000000000000DDDDDDD077770DDDDDDD111DDD199
      1DDDDDDDDDDDDDDDDDDDDDDDDDD0000DDDDDDDDDDDDDDDDDDDDDDDDDDDD0000D
      DDDDDDDDDDDDDD111DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
    Left = 60
    Top = 115
  end
end
