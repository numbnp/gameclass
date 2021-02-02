object fSQLMon: TfSQLMon
  Left = 494
  Top = 148
  Width = 502
  Height = 472
  BorderStyle = bsSizeToolWin
  Caption = 'SQL Monitor'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 486
    Height = 433
    Align = alClient
    AutoFitColWidths = True
    ColumnDefValues.ToolTips = True
    DataSource = DataSource1
    DrawGraphicData = True
    DrawMemoText = True
    DynProps = <>
    Flat = True
    GridLineParams.ColorScheme = glcsThemedEh
    HorzScrollBar.ExtraPanel.VisibleItems = [gsbiRecordsInfoEh, gsbiSelAggregationInfoEh]
    IndicatorOptions = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghExtendVertLines]
    ParentShowHint = False
    SearchPanel.Enabled = True
    SearchPanel.Location = splHorzScrollBarExtraPanelEh
    ShowHint = True
    TabOrder = 0
    VertScrollBar.SmoothStep = True
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'SQLText'
        Footers = <>
        Title.Caption = 'SQL'
        Width = 273
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Params'
        Footers = <>
        Title.Caption = 'Parameters'
        Width = 156
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object MemTableEh1: TMemTableEh
    Params = <>
    Left = 64
    Top = 48
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object SQLText: TMTBlobDataFieldEh
          FieldName = 'SQLText'
          DisplayWidth = 20
          BlobType = ftMemo
          Transliterate = False
        end
        object Params: TMTBlobDataFieldEh
          FieldName = 'Params'
          DisplayWidth = 20
          BlobType = ftMemo
          Transliterate = False
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 96
    Top = 48
  end
end
