object Frame4: TFrame4
  Left = 0
  Top = 0
  Width = 435
  Height = 266
  Align = alClient
  TabOrder = 0
  DesignSize = (
    435
    266)
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 8
    Width = 417
    Height = 249
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColumnDefValues.Title.TitleButton = True
    DataGrouping.Active = True
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    FooterParams.Color = clWindow
    GridLineParams.DataVertLines = False
    GridLineParams.DataHorzLines = True
    GridLineParams.GridBoundaries = True
    GridLineParams.ColorScheme = glcsThemedEh
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorParams.FillStyle = cfstSolidEh
    EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
    EmptyDataInfo.Font.Color = clSilver
    EmptyDataInfo.Font.Height = -11
    EmptyDataInfo.Font.Name = 'MS Sans Serif'
    EmptyDataInfo.Font.Style = []
    EmptyDataInfo.ParentFont = False
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove]
    SearchPanel.Enabled = True
    SortLocal = True
    TabOrder = 0
    TitleParams.SortMarkerStyle = smstFrameEh
    TitleParams.FillStyle = cfstGradientEh
    TitleParams.BorderInFillStyle = True
    VertScrollBar.VisibleMode = sbAlwaysShowEh
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CustNo'
        Footers = <>
        Width = 60
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Company'
        Footers = <>
        Width = 115
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Addr1'
        Footers = <>
        Width = 125
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Addr2'
        Footers = <>
        Width = 84
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'City'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'State'
        Footers = <>
        Width = 79
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 696
    Top = 504
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'FILE NAME=C:\Program Files (x86)\Common Files\System\OLE DB\Data' +
      ' Links\DBDEMOS.udl'
    CursorType = ctStatic
    TableName = 'customer'
    Left = 712
    Top = 464
  end
end
