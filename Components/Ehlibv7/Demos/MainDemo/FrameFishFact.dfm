object frFishFact: TfrFishFact
  Left = 0
  Top = 0
  Width = 592
  Height = 482
  TabOrder = 0
  object gridFish: TDBGridEh
    Left = 0
    Top = 33
    Width = 592
    Height = 449
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
    IndicatorOptions = [gioShowRecNoEh]
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    IndicatorTitle.UseGlobalMenu = False
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghFrozen3D, dghFooter3D, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghHotTrack, dghExtendVertLines]
    ParentCtl3D = False
    ParentShowHint = False
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
        DynProps = <>
        EditButtons = <>
        FieldName = 'SpeciesId'
        Footers = <>
        Width = 49
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Notes'
        Footers = <>
        STFilter.Visible = False
        Width = 347
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Graphic'
        Footers = <>
        STFilter.Visible = False
        Width = 193
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Category'
        Footers = <>
        Width = 78
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Common_name'
        Footers = <>
        Width = 291
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Species_Name'
        Footers = <>
        Width = 128
      end
      item
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
      Width = 85
      Height = 23
      Caption = 'Fish Fact'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 8
    Top = 184
  end
  object MemTableEh1: TMemTableEh
    Active = True
    CachedUpdates = True
    Params = <>
    DataDriver = ADODataDriverEh1
    Left = 40
    Top = 184
    object MemTableEh1Category: TWideStringField
      FieldName = 'Category'
      Size = 50
    end
    object MemTableEh1Common_name: TWideStringField
      FieldName = 'Common_name'
      Size = 255
    end
    object MemTableEh1Graphic: TBlobField
      FieldName = 'Graphic'
      BlobType = ftGraphic
    end
    object MemTableEh1Length: TFloatField
      FieldName = 'Length'
    end
    object MemTableEh1Notes: TMemoField
      FieldName = 'Notes'
      BlobType = ftMemo
    end
    object MemTableEh1Species_Name: TWideStringField
      FieldName = 'Species_Name'
      Size = 255
    end
    object MemTableEh1SpeciesId: TAutoIncField
      FieldName = 'SpeciesId'
    end
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh2
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select'
      '  Category'
      '  ,Common_name'
      '  ,Graphic'
      '  ,Length'
      '  ,Notes'
      '  ,Species_Name'
      '  ,SpeciesId'
      'from'
      '  Biolife')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 72
    Top = 184
  end
end
