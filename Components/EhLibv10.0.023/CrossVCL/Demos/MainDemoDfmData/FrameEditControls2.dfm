object frEditControls2: TfrEditControls2
  Left = 0
  Top = 0
  Width = 592
  Height = 482
  TabOrder = 0
  object gridFish: TDBGridEh
    Left = 0
    Top = 281
    Width = 592
    Height = 201
    Align = alClient
    Border.EdgeBorders = [ebTop, ebBottom]
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.Title.TitleButton = True
    Ctl3D = True
    DataSource = DataSource1
    DrawGraphicData = True
    DrawMemoText = True
    DynProps = <>
    EditActions = [geaCopyEh, geaSelectAllEh]
    Flat = True
    FooterParams.Color = clBtnFace
    GridLineParams.ColorScheme = glcsThemedEh
    HorzScrollBar.ExtraPanel.NavigatorButtons = [nbFirstEh, nbPriorEh, nbNextEh, nbLastEh]
    HorzScrollBar.ExtraPanel.Visible = True
    HorzScrollBar.Height = 25
    IndicatorOptions = [gioShowRecNoEh]
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    IndicatorTitle.UseGlobalMenu = False
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghFrozen3D, dghFooter3D, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentCtl3D = False
    ParentShowHint = False
    RowHeight = 2
    RowLines = 2
    ShowHint = True
    SortLocal = True
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    SumList.Active = True
    TabOrder = 0
    TitleParams.MultiTitle = True
    VertScrollBar.SmoothStep = True
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'SpeciesId'
        Footers = <>
        Width = 49
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Notes'
        Footers = <>
        STFilter.Visible = False
        Width = 155
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Graphic'
        Footers = <>
        STFilter.Visible = False
        Width = 119
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Category'
        Footers = <>
        Width = 78
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Common_name'
        Footers = <>
        Width = 291
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Species_Name'
        Footers = <>
        Width = 128
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Length'
        Footers = <>
        Width = 49
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 592
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 592
      Height = 33
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnPaint = PaintBox1Paint
    end
    object Label1: TLabel
      Left = 22
      Top = 4
      Width = 143
      Height = 23
      Caption = 'Edit Controls 2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 33
    Width = 592
    Height = 248
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object DBMemoEh1: TDBMemoEh
      Left = 11
      Top = 127
      Width = 160
      Height = 97
      AutoSize = False
      DataField = 'Notes'
      DataSource = DataSource1
      DynProps = <>
      EditButtons = <
        item
        end>
      TabOrder = 0
      Visible = True
      WantReturns = True
    end
    object DBMemoEh2: TDBMemoEh
      Left = 11
      Top = 23
      Width = 160
      Height = 97
      ControlLabel.Width = 91
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Notes - DBMemoEh'
      ControlLabel.Visible = True
      AutoSize = False
      DataField = 'Notes'
      DataSource = DataSource1
      DynProps = <>
      EditButtons = <
        item
          Style = ebsEllipsisEh
        end>
      TabOrder = 1
      Visible = True
      WantReturns = True
    end
    object DBImageEh1: TDBImageEh
      Left = 185
      Top = 128
      Width = 160
      Height = 96
      Color = clInfoBk
      DataField = 'Graphic'
      DataSource = DataSource1
      DynProps = <>
      EditButton.Visible = True
      TabOrder = 2
    end
    object DBImageEh2: TDBImageEh
      Left = 185
      Top = 24
      Width = 160
      Height = 96
      ControlLabel.Width = 101
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Graphic - DBImageEh'
      ControlLabel.Visible = True
      Color = clInfoBk
      DataField = 'Graphic'
      DataSource = DataSource1
      DynProps = <>
      EditButton.Style = ebsEllipsisEh
      EditButton.Visible = True
      TabOrder = 3
    end
    object DBRichEditEh1: TDBRichEditEh
      Left = 351
      Top = 127
      Width = 160
      Height = 97
      DataField = 'RichNotes'
      DataSource = DataSource1
      EditButtons = <
        item
        end>
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ScrollBars = ssVertical
      TabOrder = 4
    end
    object DBRichEditEh2: TDBRichEditEh
      Left = 351
      Top = 23
      Width = 160
      Height = 97
      ControlLabel.Width = 121
      ControlLabel.Height = 13
      ControlLabel.Caption = 'RichNotes - DBRichEditEh'
      ControlLabel.Visible = True
      DataField = 'RichNotes'
      DataSource = DataSource1
      EditButtons = <
        item
          Style = ebsEllipsisEh
        end>
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TabOrder = 5
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 8
    Top = 424
  end
  object MemTableEh1: TMemTableEh
    CachedUpdates = True
    FieldDefs = <
      item
        Name = 'SpeciesId'
        DataType = ftAutoInc
        Precision = 15
      end
      item
        Name = 'Notes'
        DataType = ftMemo
      end
      item
        Name = 'Graphic'
        DataType = ftGraphic
      end
      item
        Name = 'Category'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'Common_name'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Species_Name'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Length'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'ADate'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'AnmlClass'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'AnmlFamily'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'AnmlGenus'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'AnmlKingdom'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'AnmlOrder'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'AnmlPhylum'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'AnmlSpecies'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Ocean'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'PngGraphic'
        DataType = ftBlob
      end
      item
        Name = 'RichNotes'
        DataType = ftGraphic
      end>
    IndexDefs = <>
    Params = <>
    DataDriver = SQLDataDriverEh1
    StoreDefs = True
    Left = 40
    Top = 424
    object MemTableEh1SpeciesId: TAutoIncField
      FieldName = 'SpeciesId'
    end
    object MemTableEh1Notes: TMemoField
      FieldName = 'Notes'
      BlobType = ftMemo
    end
    object MemTableEh1Graphic: TBlobField
      FieldName = 'Graphic'
      BlobType = ftGraphic
    end
    object MemTableEh1Category: TWideStringField
      FieldName = 'Category'
      Size = 50
    end
    object MemTableEh1Common_name: TWideStringField
      FieldName = 'Common_name'
      Size = 255
    end
    object MemTableEh1Species_Name: TWideStringField
      FieldName = 'Species_Name'
      Size = 255
    end
    object MemTableEh1Length: TFloatField
      FieldName = 'Length'
    end
    object MemTableEh1ADate: TWideStringField
      FieldName = 'ADate'
      Size = 255
    end
    object MemTableEh1AnmlClass: TWideStringField
      FieldName = 'AnmlClass'
      Size = 255
    end
    object MemTableEh1AnmlFamily: TWideStringField
      FieldName = 'AnmlFamily'
      Size = 255
    end
    object MemTableEh1AnmlGenus: TWideStringField
      FieldName = 'AnmlGenus'
      Size = 255
    end
    object MemTableEh1AnmlKingdom: TWideStringField
      FieldName = 'AnmlKingdom'
      Size = 255
    end
    object MemTableEh1AnmlOrder: TWideStringField
      FieldName = 'AnmlOrder'
      Size = 255
    end
    object MemTableEh1AnmlPhylum: TWideStringField
      FieldName = 'AnmlPhylum'
      Size = 255
    end
    object MemTableEh1AnmlSpecies: TWideStringField
      FieldName = 'AnmlSpecies'
      Size = 255
    end
    object MemTableEh1Ocean: TWideStringField
      FieldName = 'Ocean'
      Size = 255
    end
    object MemTableEh1PngGraphic: TBlobField
      FieldName = 'PngGraphic'
    end
    object MemTableEh1RichNotes: TMemoField
      FieldName = 'RichNotes'
      BlobType = ftMemo
    end
  end
  object SQLDataDriverEh1: TSQLDataDriverEh
    DeleteCommand.Params = <>
    DynaSQLParams.Options = []
    GetrecCommand.Params = <>
    InsertCommand.Params = <>
    SelectCommand.Params = <>
    SelectCommand.CommandText.Strings = (
      'select'
      '  ADate'
      '  ,AnmlClass'
      '  ,AnmlFamily'
      '  ,AnmlGenus'
      '  ,AnmlKingdom'
      '  ,AnmlOrder'
      '  ,AnmlPhylum'
      '  ,AnmlSpecies'
      '  ,Category'
      '  ,Common_name'
      '  ,Graphic'
      '  ,Length'
      '  ,Notes'
      '  ,Ocean'
      '  ,PngGraphic'
      '  ,RichNotes'
      '  ,Species_Name'
      '  ,SpeciesId'
      'from'
      '  Biolife2')
    UpdateCommand.Params = <>
    ConnectionProvider = Form1.SQLConnectionProviderEh1
    MacroVars.Macros = <>
    SpecParams.Strings = (
      'table=table_Biolife2')
    Left = 72
    Top = 424
  end
end
