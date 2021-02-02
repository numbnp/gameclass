object Form1: TForm1
  Left = 421
  Top = 199
  Width = 841
  Height = 545
  Caption = 'Form1'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 3
    Top = 63
    Width = 8
    Height = 443
    ResizeStyle = rsUpdate
  end
  object PivotGridToolBoxEh1: TPivotGridToolBoxEh
    Left = 0
    Top = 63
    Width = 3
    Height = 443
    PivotDataSource = PivotDataSourceEh1
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'PivotGridToolBoxEh1'
    DoubleBuffered = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 825
    Height = 63
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 180
      Top = 47
      Width = 213
      Height = 13
      Caption = 'The maximum permissible load on the device.'
    end
    object bLoadSourceData: TButton
      Left = 180
      Top = 0
      Width = 149
      Height = 41
      Caption = 'Reload Data'
      TabOrder = 0
      OnClick = bLoadSourceDataClick
    end
    object bBuildPivotData: TButton
      Left = 9
      Top = 0
      Width = 152
      Height = 57
      Caption = 'Build Pivot data'
      TabOrder = 1
      OnClick = bBuildPivotDataClick
    end
  end
  object PageControl1: TPageControl
    Left = 11
    Top = 63
    Width = 814
    Height = 443
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Pivot Grid'
      object PivotGridEh1: TPivotGridEh
        Left = 0
        Top = 0
        Width = 806
        Height = 415
        Hint = 'Hint Text'
        Options = [pgoColSizingEh, pgoEditingEh, pgoWantTabEh, pgoGrandTotalColumnEh, pgoGrandTotalRowEh]
        PivotDataSource = PivotDataSourceEh1
        OnGetDataCellEditorParams = PivotGridEh1GetDataCellEditorParams
        OnSetDataCellEditorValue = PivotGridEh1SetDataCellEditorValue
        Align = alClient
        ContraColCount = 0
        PrintService.ColorSchema = pcsFullColorEh
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        ShowToolTips = False
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Source Data'
      ImageIndex = 1
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 806
        Height = 415
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.ToolTips = True
        DataSource = DataSource1
        DynProps = <>
        Flat = True
        ParentShowHint = False
        ShowHint = True
        STFilter.Local = True
        STFilter.Location = stflInTitleFilterEh
        STFilter.Visible = True
        TabOrder = 0
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object PivotDataSourceEh1: TPivotDataSourceEh
    DataSet = MemTableEh1
    PivotFields = <
      item
        FieldName = 'DeviceId'
        SourceFieldName = 'DeviceId'
      end
      item
        FieldName = 'Date'
        SourceFieldName = 'Date'
      end
      item
        FieldName = 'MaxLoad'
        SourceFieldName = 'MaxLoad'
      end>
    DefaultDateTimeSliceLevels = [dtslYearEh, dtslMonthEh, dtslWeekEh, dtslDayEh, dtslHourEh]
    ValueFieldDefs = <>
    Left = 192
    Top = 408
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Params = <>
    Left = 192
    Top = 368
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object DeviceId: TMTStringDataFieldEh
          FieldName = 'DeviceId'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object Date: TMTDateTimeDataFieldEh
          FieldName = 'Date'
          DateTimeDataType = fdtDateEh
          DisplayWidth = 20
        end
        object MaxLoad: TMTNumericDataFieldEh
          FieldName = 'MaxLoad'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayWidth = 20
          currency = False
          Precision = 15
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            'Device1'
            33239d
            8.000000000000000000)
          (
            'Device1'
            33240d
            7.000000000000000000)
          (
            'Device1'
            33241d
            8.000000000000000000)
          (
            'Device1'
            33242d
            7.000000000000000000)
          (
            'Device1'
            33243d
            8.000000000000000000)
          (
            'Device1'
            33244d
            9.000000000000000000)
          (
            'Device1'
            33245d
            9.000000000000000000)
          (
            'Device1'
            33246d
            9.000000000000000000)
          (
            'Device1'
            33247d
            9.000000000000000000)
          (
            'Device1'
            33248d
            8.000000000000000000)
          (
            'Device1'
            33249d
            8.000000000000000000)
          (
            'Device1'
            33250d
            7.000000000000000000)
          (
            'Device1'
            33251d
            7.000000000000000000)
          (
            'Device1'
            33252d
            7.000000000000000000)
          (
            'Device1'
            33253d
            7.000000000000000000)
          (
            'Device2'
            33239d
            5.000000000000000000)
          (
            'Device2'
            33240d
            4.000000000000000000)
          (
            'Device2'
            33241d
            4.000000000000000000)
          (
            'Device2'
            33242d
            5.000000000000000000)
          (
            'Device2'
            33243d
            5.000000000000000000)
          (
            'Device2'
            33244d
            6.000000000000000000)
          (
            'Device2'
            33245d
            6.000000000000000000)
          (
            'Device2'
            33246d
            6.000000000000000000)
          (
            'Device2'
            33247d
            6.000000000000000000)
          (
            'Device2'
            33248d
            6.000000000000000000)
          (
            'Device2'
            33249d
            6.000000000000000000)
          (
            'Device2'
            33250d
            5.000000000000000000)
          (
            'Device2'
            33251d
            5.000000000000000000)
          (
            'Device2'
            33252d
            5.000000000000000000)
          (
            'Device2'
            33253d
            5.000000000000000000)
          (
            'Device3'
            33239d
            6.000000000000000000)
          (
            'Device3'
            33240d
            6.000000000000000000)
          (
            'Device3'
            33241d
            6.000000000000000000)
          (
            'Device3'
            33242d
            6.000000000000000000)
          (
            'Device3'
            33243d
            6.000000000000000000)
          (
            'Device3'
            33244d
            6.000000000000000000)
          (
            'Device3'
            33245d
            6.000000000000000000)
          (
            'Device3'
            33246d
            6.000000000000000000)
          (
            'Device3'
            33247d
            6.000000000000000000)
          (
            'Device3'
            33248d
            6.000000000000000000)
          (
            'Device3'
            33249d
            6.000000000000000000)
          (
            'Device3'
            33250d
            6.000000000000000000)
          (
            'Device3'
            33251d
            6.000000000000000000)
          (
            'Device3'
            33252d
            6.000000000000000000)
          (
            'Device3'
            33253d
            6.000000000000000000)
          (
            'Device4'
            33239d
            9.000000000000000000)
          (
            'Device4'
            33240d
            7.000000000000000000)
          (
            'Device4'
            33241d
            6.000000000000000000)
          (
            'Device4'
            33242d
            5.000000000000000000)
          (
            'Device4'
            33243d
            5.000000000000000000)
          (
            'Device4'
            33244d
            5.000000000000000000)
          (
            'Device4'
            33245d
            5.000000000000000000)
          (
            'Device4'
            33246d
            5.000000000000000000)
          (
            'Device4'
            33247d
            5.000000000000000000)
          (
            'Device4'
            33248d
            5.000000000000000000)
          (
            'Device4'
            33249d
            5.000000000000000000)
          (
            'Device4'
            33250d
            6.000000000000000000)
          (
            'Device4'
            33251d
            6.000000000000000000)
          (
            'Device4'
            33252d
            7.000000000000000000)
          (
            'Device4'
            33253d
            7.000000000000000000)
          (
            'Device5'
            33239d
            9.000000000000000000)
          (
            'Device5'
            33240d
            9.000000000000000000)
          (
            'Device5'
            33241d
            9.000000000000000000)
          (
            'Device5'
            33242d
            9.000000000000000000)
          (
            'Device5'
            33243d
            9.000000000000000000)
          (
            'Device5'
            33244d
            9.000000000000000000)
          (
            'Device5'
            33245d
            9.000000000000000000)
          (
            'Device5'
            33246d
            9.000000000000000000)
          (
            'Device5'
            33247d
            9.000000000000000000)
          (
            'Device5'
            33248d
            9.000000000000000000)
          (
            'Device5'
            33249d
            9.000000000000000000)
          (
            'Device5'
            33250d
            9.000000000000000000)
          (
            'Device5'
            33251d
            9.000000000000000000)
          (
            'Device5'
            33252d
            9.000000000000000000)
          (
            'Device5'
            33253d
            9.000000000000000000))
      end
    end
  end
  object DataSource1: TDataSource
    Left = 360
    Top = 256
  end
end
