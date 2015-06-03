object frRowAsPanel: TfrRowAsPanel
  Left = 0
  Top = 0
  Width = 753
  Height = 406
  Color = clBtnFace
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object DBGridEh5: TDBGridEh
    Left = 0
    Top = 33
    Width = 753
    Height = 373
    Align = alClient
    AutoFitColWidths = True
    Border.EdgeBorders = [ebTop, ebRight]
    Ctl3D = False
    DataSource = DataSource1
    DrawGraphicData = True
    DrawMemoText = True
    DynProps = <>
    Flat = True
    FooterParams.Color = clWindow
    GridLineParams.ColorScheme = glcsThemedEh
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentCtl3D = False
    RowDetailPanel.Height = 300
    RowSizingAllowed = True
    RowPanel.Active = True
    TabOrder = 0
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
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        Footers = <>
        Width = 480
        InRowLinePos = 1
        InRowLineHeight = 4
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Category'
        Footers = <>
        Width = 91
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Common_name'
        Footers = <>
        Width = 115
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Species_Name'
        Footers = <>
        Title.Caption = 'Species Name'
        Width = 152
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Length'
        Footers = <>
        Title.Caption = 'Length (cm)'
        Width = 69
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Graphic'
        Footers = <>
        Title.Alignment = taCenter
        Width = 203
        InRowLineHeight = 5
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Length_In'
        Footers = <>
        Visible = False
        Width = 47
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 753
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 753
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
    object Label2: TLabel
      Left = 22
      Top = 4
      Width = 130
      Height = 23
      Caption = 'Row As Panel'
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
    Left = 384
    Top = 224
  end
  object MemTableEh1: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ADODataDriverEh1
    AfterOpen = MemTableEh1AfterOpen
    Left = 384
    Top = 280
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh2
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select * from biolife')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 384
    Top = 336
  end
end
