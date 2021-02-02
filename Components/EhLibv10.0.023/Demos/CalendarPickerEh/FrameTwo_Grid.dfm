object frFrameTwoGrid: TfrFrameTwoGrid
  Left = 0
  Top = 0
  Width = 435
  Height = 266
  Align = alClient
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 186
    Top = 36
    Width = 8
    Height = 230
    Align = alRight
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 435
      Height = 36
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
      Left = 9
      Top = 7
      Width = 322
      Height = 23
      Caption = 'Popup Calendar in Grid cell editor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 36
    Width = 186
    Height = 230
    Align = alClient
    AllowedSelections = [gstRecordBookmarks, gstRectangle, gstColumns]
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.EditButtonDrawBackTime = edbtWhenHotEh
    DataSource = DataSource1
    DynProps = <>
    EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
    FooterParams.Color = clWindow
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    TabOrder = 1
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButtons = <>
        FieldName = 'DateTimeField'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButtons = <>
        FieldName = 'DateField'
        Footers = <>
      end
      item
        ButtonStyle = cbsAltDropDown
        CellButtons = <>
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButton.Visible = True
        EditButtons = <>
        FieldName = 'TimeField'
        Footers = <>
      end
      item
        CellButtons = <>
        DisplayFormat = 'DD/MM/YYYY HH:NN'
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButtons = <>
        FieldName = 'DateTimeField2'
        Footers = <>
        Title.Caption = 'Date + Hour:Min Format'
        Width = 132
        OnGetCellParams = DBGridEh1Columns3GetCellParams
      end
      item
        ButtonStyle = cbsAltDropDown
        CellButtons = <>
        DisplayFormat = 'HH:NN'
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButton.Visible = True
        EditButtons = <>
        FieldName = 'TimeField2'
        Footers = <>
        Title.Caption = 'Hour:Min Format'
        OnGetCellParams = DBGridEh1Columns3GetCellParams
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBVertGridEh1: TDBVertGridEh
    Left = 194
    Top = 36
    Width = 241
    Height = 230
    Align = alRight
    AllowedSelections = []
    RowCategories.CategoryProps = <>
    PrintService.ColorSchema = pcsFullColorEh
    DataSource = DataSource1
    DrawGraphicData = True
    DrawMemoText = True
    RowsDefValues.AlwaysShowEditButton = True
    RowsDefValues.EditButtonDrawBackTime = edbtWhenHotEh
    TabOrder = 2
    LabelColWidth = 119
    Rows = <
      item
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButton.DrawBackTime = edbtAlwaysEh
        EditButtons = <>
        FieldName = 'DateTimeField'
      end
      item
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButtons = <>
        FieldName = 'DateField'
      end
      item
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButtons = <>
        FieldName = 'TimeField'
      end
      item
        DisplayFormat = 'DD/MM/YYYY HH:NN'
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButtons = <>
        FieldName = 'DateTimeField2'
        RowLabel.Caption = 'Date + Hour:Min Format'
        OnGetCellParams = DBVertGridEh1Rows3GetCellParams
      end
      item
        DisplayFormat = 'HH:NN'
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButtons = <>
        FieldName = 'TimeField2'
        RowLabel.Caption = 'Hour:Min Format'
      end>
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Params = <>
    Left = 64
    Top = 384
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object Name: TMTStringDataFieldEh
          FieldName = 'Name'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Name'
          DisplayWidth = 24
          Size = 24
          Transliterate = True
        end
        object Capital: TMTStringDataFieldEh
          FieldName = 'Capital'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Capital'
          DisplayWidth = 24
          Size = 24
          Transliterate = True
        end
        object Continent: TMTStringDataFieldEh
          FieldName = 'Continent'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Continent'
          DisplayWidth = 24
          Size = 24
          Transliterate = True
        end
        object Area: TMTNumericDataFieldEh
          FieldName = 'Area'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'Area'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object Population: TMTNumericDataFieldEh
          FieldName = 'Population'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'Population'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object DateTimeField: TMTDateTimeDataFieldEh
          FieldName = 'DateTimeField'
          DateTimeDataType = fdtDateTimeEh
          DisplayWidth = 20
        end
        object DateField: TMTDateTimeDataFieldEh
          FieldName = 'DateField'
          DateTimeDataType = fdtDateEh
          DisplayWidth = 20
        end
        object TimeField: TMTDateTimeDataFieldEh
          FieldName = 'TimeField'
          DateTimeDataType = fdtTimeEh
          DisplayWidth = 20
        end
        object DateTimeField2: TMTDateTimeDataFieldEh
          FieldName = 'DateTimeField2'
          DateTimeDataType = fdtDateTimeEh
          DisplayLabel = 'DTField2'
          DisplayWidth = 20
        end
        object TimeField2: TMTDateTimeDataFieldEh
          FieldName = 'TimeField2'
          DateTimeDataType = fdtTimeEh
          DisplayWidth = 20
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            'Argentina'
            'Buenos Aires'
            'South America'
            2777815.000000000000000000
            32300003.000000000000000000
            42548.437962963d
            42559d
            0.520833333333333d
            42559.1409722222d
            0.142361111111111d)
          (
            'Bolivia'
            'La Paz'
            'South America'
            1098575.000000000000000000
            7300000.000000000000000000
            42401d
            42401d
            0.114583333333333d
            42573d
            0.59375d)
          (
            'Brazil'
            'Brasilia'
            'South America'
            8511196.000000000000000000
            150400000.000000000000000000
            42522.5208333333d
            42522d
            0.155555555555556d
            nil
            nil))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 152
    Top = 384
  end
end
