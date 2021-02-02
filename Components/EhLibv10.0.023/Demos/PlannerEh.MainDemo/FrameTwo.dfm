inherited frFrameTwo: TfrFrameTwo
  Width = 676
  Height = 576
  object Splitter2: TSplitter
    Left = 209
    Top = 71
    Width = 8
    Height = 505
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 676
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 676
      Height = 34
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
      Left = 41
      Top = 7
      Width = 57
      Height = 19
      Caption = 'Demo2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 125
      Top = 12
      Width = 126
      Height = 13
      Caption = 'Load events from DataSet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 34
      Width = 676
      Height = 2
      Align = alBottom
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 36
    Width = 676
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object bFillPlanner: TButton
      Left = 8
      Top = 6
      Width = 169
      Height = 25
      Caption = 'Load events'
      TabOrder = 0
      OnClick = bFillPlannerClick
    end
    object bDayRange: TButton
      Left = 216
      Top = 6
      Width = 120
      Height = 25
      Hint = 'Day View Mode'
      Caption = 'Day View'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = bDayRangeClick
    end
    object bWeekRange: TButton
      Left = 336
      Top = 6
      Width = 120
      Height = 25
      Hint = 'Week View Mode'
      Caption = 'Week View'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = bWeekRangeClick
    end
    object bMonthRange: TButton
      Left = 456
      Top = 6
      Width = 120
      Height = 25
      Hint = 'Month View Mode'
      Caption = 'Month View'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = bMonthRangeClick
    end
  end
  object CalPickerPanel: TPanel
    Left = 0
    Top = 71
    Width = 209
    Height = 505
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'CalPickerPanel'
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 0
      Top = 353
      Width = 209
      Height = 8
      Cursor = crVSplit
      Align = alTop
      ResizeStyle = rsUpdate
    end
    object gridResouce: TDBGridEh
      Left = 0
      Top = 361
      Width = 209
      Height = 144
      Align = alClient
      AutoFitColWidths = True
      DataSource = DataSource2
      DynProps = <>
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      GridLineParams.ColorScheme = glcsThemedEh
      IndicatorOptions = [gioShowRowIndicatorEh, gioShowRowselCheckboxesEh]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentFont = False
      TabOrder = 0
      Columns = <
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'mid'
          Footers = <>
          Width = 28
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'mname'
          Footers = <>
          Width = 129
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object CalendarPickerEh1: TPlannerCalendarPickerEh
      Left = 0
      Top = 0
      Width = 209
      Height = 353
      PlannerControl = PlannerControlEh1
      Align = alTop
      ParentCtl3D = False
      ParentColor = False
      TabOrder = 1
    end
  end
  object PageControl1: TPageControl
    Left = 217
    Top = 71
    Width = 459
    Height = 505
    ActivePage = tbPlannerSheet
    Align = alClient
    TabOrder = 3
    object tbPlannerSheet: TTabSheet
      Caption = 'Planner'
      object PlannerControlEh1: TPlannerControlEh
        Left = 0
        Top = 0
        Width = 451
        Height = 477
        ActivePlannerView = PlannerWeekViewEh1
        PlannerDataSource = PlannerDataSourceEh1
        Align = alClient
        PrintService.ColorSchema = pcsFullColorEh
        TabOrder = 0
        object PlannerDayViewEh1: TPlannerDayViewEh
          Left = 0
          Top = 41
          Width = 447
          Height = 432
        end
        object PlannerWeekViewEh1: TPlannerWeekViewEh
          Left = 0
          Top = 41
          Width = 447
          Height = 432
        end
        object PlannerMonthViewEh1: TPlannerMonthViewEh
          Left = 0
          Top = 41
          Width = 447
          Height = 432
        end
        object PlannerVertDayslineViewEh1: TPlannerVertDayslineViewEh
          Left = 0
          Top = 41
          Width = 447
          Height = 432
        end
        object PlannerVertHourslineViewEh1: TPlannerVertHourslineViewEh
          Left = 0
          Top = 41
          Width = 447
          Height = 432
        end
        object PlannerHorzHourslineViewEh1: TPlannerHorzHourslineViewEh
          Left = 0
          Top = 41
          Width = 447
          Height = 432
        end
        object PlannerHorzDayslineViewEh1: TPlannerHorzDayslineViewEh
          Left = 0
          Top = 41
          Width = 447
          Height = 432
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'DataSource'
      ImageIndex = 1
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 493
        Height = 548
        Align = alClient
        DataSource = DataSource1
        DynProps = <>
        Flat = True
        HorzScrollBar.ExtraPanel.Visible = True
        HorzScrollBar.Height = 20
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
        TabOrder = 0
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object mtPlannerData: TMemTableEh
    Params = <>
    DataDriver = ADODataDriverEh1
    Top = 65486
  end
  object mtResource: TMemTableEh
    Params = <>
    DataDriver = ADODataDriverEh2
    Top = 65486
  end
  object DataSource2: TDataSource
    DataSet = mtResource
    Top = 65486
  end
  object PlannerDataSourceEh1: TPlannerDataSourceEh
    ItemSourceParams.DataSet = mtPlannerData
    ItemSourceParams.FieldsMap = <
      item
        DataSetFieldName = 'Id'
        PropertyName = 'ItemID'
      end
      item
        DataSetFieldName = 'title'
        PropertyName = 'Title'
      end
      item
        DataSetFieldName = 'start_time'
        PropertyName = 'StartTime'
      end
      item
        DataSetFieldName = 'end_time'
        PropertyName = 'EndTime'
      end
      item
        DataSetFieldName = 'all_day'
        PropertyName = 'AllDay'
      end
      item
        DataSetFieldName = 'res_id'
        PropertyName = 'ResourceID'
      end
      item
        DataSetFieldName = 'color'
        PropertyName = 'FillColor'
        OnReadValue = PlannerDataSourceEh1TPlannerItemSourceParamsEhFieldMap6ReadValue
      end>
    Top = 65486
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select'
      '*'
      'from'
      '  time_events')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Top = 65486
  end
  object DataSource1: TDataSource
    DataSet = mtPlannerData
    Top = 65486
  end
  object ADODataDriverEh2: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  members')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Top = 65486
  end
  object CompoManEh1: TCompoManEh
    Left = 224
    Top = 65528
    VisibleComponentListPos = (
      'ADODataDriverEh1,608,24'
      'ADODataDriverEh2,176,560'
      'DataSource1,344,312'
      'DataSource2,0,592'
      'mtPlannerData,504,8'
      'mtResource,421,-15'
      'PlannerDataSourceEh1,301,-9')
  end
end
