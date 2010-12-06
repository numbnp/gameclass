object framReport: TframReport
  Left = 0
  Top = 0
  Width = 443
  Height = 277
  Align = alClient
  TabOrder = 0
  object tbarReports: TToolBar
    Left = 0
    Top = 0
    Width = 87
    Height = 277
    Align = alLeft
    AutoSize = True
    BorderWidth = 1
    ButtonHeight = 19
    ButtonWidth = 81
    EdgeBorders = [ebRight]
    Flat = True
    List = True
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    object tbCurrentReport: TToolButton
      Left = 0
      Top = 0
      AllowAllUp = True
      Caption = 'Current Report'
      Enabled = False
      ImageIndex = 0
      Wrap = True
      OnClick = tbCurrentReportClick
    end
    object tbLastSessions: TToolButton
      Left = 0
      Top = 19
      AllowAllUp = True
      Caption = 'Last Sessions'
      Enabled = False
      ImageIndex = 1
      OnClick = tbLastSessionsClick
      OnMouseDown = tbLastSessionsMouseDown
    end
  end
  object Panel: TPanel
    Left = 87
    Top = 0
    Width = 356
    Height = 277
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlFilter: TPanel
      Left = 0
      Top = 0
      Width = 356
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object lblBeginTime: TLabel
        Left = 1
        Top = 5
        Width = 49
        Height = 22
        AutoSize = False
        Caption = '  Begin:'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object lblEndTime: TLabel
        Left = 200
        Top = 5
        Width = 40
        Height = 22
        AutoSize = False
        Caption = '  End:'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object dtpBeginDate: TDateTimePicker
        Left = 50
        Top = 5
        Width = 80
        Height = 22
        Hint = 'Begin date for filter'
        Date = 37690.423999340300000000
        Time = 37690.423999340300000000
        Enabled = False
        TabOrder = 0
      end
      object dtpEndDate: TDateTimePicker
        Left = 241
        Top = 5
        Width = 81
        Height = 22
        Hint = 'End date for filter'
        Date = 37690.425297500000000000
        Time = 37690.425297500000000000
        Enabled = False
        TabOrder = 1
      end
      object dtpEndTime: TDateTimePicker
        Left = 322
        Top = 5
        Width = 66
        Height = 22
        Hint = 'End time for filter'
        Date = 37690.432075300900000000
        Time = 37690.432075300900000000
        Enabled = False
        Kind = dtkTime
        TabOrder = 2
      end
      object cbAllRecords: TCheckBox
        Left = 395
        Top = 5
        Width = 46
        Height = 22
        Hint = 'Enable/disable time filter'
        Alignment = taLeftJustify
        Caption = '  All:'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 3
      end
      object dtpBeginTime: TDateTimePicker
        Left = 130
        Top = 5
        Width = 66
        Height = 22
        Hint = 'Begin time for filter'
        Date = 37690.431826446800000000
        Time = 37690.431826446800000000
        Enabled = False
        Kind = dtkTime
        TabOrder = 4
      end
      object cbFilter: TCheckBox
        Left = 451
        Top = 5
        Width = 52
        Height = 22
        Hint = 'Enable/disable recordset filter'
        Alignment = taLeftJustify
        Caption = 'Filter:'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 5
        OnClick = cbFilterClick
      end
    end
    object pcReport: TPageControl
      Left = 0
      Top = 32
      Width = 356
      Height = 245
      Align = alClient
      MultiLine = True
      ParentShowHint = False
      ShowHint = False
      Style = tsButtons
      TabHeight = 1
      TabOrder = 1
      TabWidth = 1
      object tabRichEdit: TTabSheet
        Caption = '1'
        TabVisible = False
        object reditReport: TRichEdit
          Left = 0
          Top = 0
          Width = 348
          Height = 235
          Align = alClient
          TabOrder = 0
        end
      end
      object tabGrid: TTabSheet
        Caption = '2'
        ImageIndex = 1
        TabVisible = False
        object gridReport: TDBGridEh
          Left = 0
          Top = 0
          Width = 348
          Height = 228
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataSource = datasrcReport
          FooterColor = clWindow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'MS Sans Serif'
          FooterFont.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghDialogFind]
          PopupMenu = pmnuReports
          SortLocal = True
          STFilter.Local = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          FilterStringColor = clWindow
          OnApplyFilter = gridReportApplyFilter
        end
      end
      object tabVtChar: TTabSheet
        Caption = '3'
        ImageIndex = 2
        TabVisible = False
      end
    end
  end
  object datasrcReport: TDataSource
    DataSet = datasetReport
    Left = 612
    Top = 8
  end
  object datasetReport: TADODataSet
    CursorType = ctStatic
    Filtered = True
    FieldDefs = <>
    Parameters = <>
    StoreDefs = True
    Left = 648
    Top = 8
  end
  object pmnuReports: TPopupMenu
    Left = 184
    Top = 136
    object miSaveAs: TMenuItem
      Caption = 'Save as ...'
      OnClick = miSaveAsClick
    end
  end
  object dlgSave: TSaveDialog
    Filter = '*.txt|*.txt|*.csv|*.csv|*.htm|*.htm|*.rtf|*.rtf|*.xls|*.xls'
    Left = 328
    Top = 72
  end
end
