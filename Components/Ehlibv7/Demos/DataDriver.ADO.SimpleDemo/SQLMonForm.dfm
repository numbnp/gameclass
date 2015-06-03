object fSQLMon: TfSQLMon
  Left = 429
  Top = 160
  Width = 502
  Height = 472
  BorderStyle = bsSizeToolWin
  Caption = 'SQL Monitor'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 486
    Height = 434
    Align = alClient
    AutoFitColWidths = True
    ColumnDefValues.ToolTips = True
    DataSource = DataSource1
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
        DynProps = <>
        EditButtons = <>
        FieldName = 'SQLText'
        Footers = <>
        Title.Caption = 'SQL'
        Width = 273
      end
      item
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
    Active = True
    Params = <>
    Left = 64
    Top = 48
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object SQLText: TMTStringDataFieldEh
          FieldName = 'SQLText'
          StringDataType = fdtWideStringEh
          DisplayWidth = 20
          Size = 1000
        end
        object Params: TMTStringDataFieldEh
          FieldName = 'Params'
          StringDataType = fdtWideStringEh
          DisplayWidth = 20
          Size = 1000
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
