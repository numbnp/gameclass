object frPlanner: TfrPlanner
  Left = 0
  Top = 0
  Width = 718
  Height = 647
  TabOrder = 0
  object Splitter2: TSplitter
    Left = 209
    Top = 95
    Width = 8
    Height = 552
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 718
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 718
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
      Caption = 'Demo1'
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
      Width = 140
      Height = 13
      Caption = 'Fill PlannerSource in the code'
    end
    object Bevel1: TBevel
      Left = 0
      Top = 34
      Width = 718
      Height = 2
      Align = alBottom
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 36
    Width = 718
    Height = 59
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object bFillPlanner: TButton
      Left = 8
      Top = 6
      Width = 105
      Height = 25
      Caption = 'Fill PlannerSource'
      TabOrder = 0
      OnClick = bFillPlannerClick
    end
    object bDayRange: TButton
      Left = 216
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Day View Mode'
      Caption = 'D'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = bDayRangeClick
    end
    object bWeekRange: TButton
      Left = 255
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Week View Mode'
      Caption = 'W'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = bWeekRangeClick
    end
    object bMonthRange: TButton
      Left = 294
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Month View Mode'
      Caption = 'M'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = bMonthRangeClick
    end
    object NewPlanItem: TButton
      Left = 119
      Top = 6
      Width = 75
      Height = 25
      Caption = 'New Item'
      TabOrder = 4
      OnClick = NewPlanItemClick
    end
    object DBCheckBoxEh1: TDBCheckBoxEh
      Left = 8
      Top = 37
      Width = 132
      Height = 17
      Caption = 'Hide not working hours'
      DynProps = <>
      TabOrder = 5
      Visible = False
    end
    object bVertTimeBand1: TButton
      Left = 340
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Vertical Time Band - Day by Hours'
      BiDiMode = bdLeftToRight
      Caption = 'VH1'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = bVertTimeBand1Click
    end
    object bHorzTimeBand1: TButton
      Left = 504
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Horizontal Time Band - Day by Hours'
      BiDiMode = bdLeftToRight
      Caption = 'HH1'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = bHorzTimeBand1Click
    end
    object bVertTimeBand2: TButton
      Left = 380
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Vertical Time Band - Week by Hours'
      BiDiMode = bdLeftToRight
      Caption = 'VH2'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = bVertTimeBand2Click
    end
    object bVertTimeBand3: TButton
      Left = 419
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Vertical Time Band - Week by Days'
      BiDiMode = bdLeftToRight
      Caption = 'VD1'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = bVertTimeBand3Click
    end
    object bVertTimeBand4: TButton
      Left = 458
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Vertical Time Band - Month by Days'
      BiDiMode = bdLeftToRight
      Caption = 'VD2'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = bVertTimeBand4Click
    end
    object bHorzTimeBand2: TButton
      Left = 543
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Horizontal Time Band - Week by Hours'
      BiDiMode = bdLeftToRight
      Caption = 'HH2'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = bHorzTimeBand2Click
    end
    object bHorzTimeBand3: TButton
      Left = 582
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Horizontal Time Band - Week by Days'
      BiDiMode = bdLeftToRight
      Caption = 'HD1'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      OnClick = bHorzTimeBand3Click
    end
    object bHorzTimeBand4: TButton
      Left = 621
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Horizontal Time Band - Month by Days'
      BiDiMode = bdLeftToRight
      Caption = 'HD2'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      OnClick = bHorzTimeBand4Click
    end
  end
  object CalPickerPanel: TPanel
    Left = 0
    Top = 95
    Width = 209
    Height = 552
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'CalPickerPanel'
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 0
      Top = 329
      Width = 209
      Height = 8
      Cursor = crVSplit
      Align = alTop
      ResizeStyle = rsUpdate
    end
    object gridResouce: TDBGridEh
      Left = 0
      Top = 337
      Width = 209
      Height = 215
      Align = alClient
      AutoFitColWidths = True
      DataSource = DataSource2
      DynProps = <>
      Flat = True
      GridLineParams.ColorScheme = glcsThemedEh
      IndicatorOptions = [gioShowRowIndicatorEh, gioShowRowselCheckboxesEh]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      TabOrder = 0
      Columns = <
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Id'
          Footers = <>
          Width = 17
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          Width = 91
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object CalendarPickerEh1: TPlannerCalendarPickerEh
      Left = 0
      Top = 0
      Width = 209
      Height = 329
      PlannerControl = PlannerControlEh1
      Align = alTop
      Color = 16316664
      HolidaysFont.Charset = DEFAULT_CHARSET
      HolidaysFont.Color = clWindowText
      HolidaysFont.Height = -11
      HolidaysFont.Name = 'Tahoma'
      HolidaysFont.Style = []
      HolidaysFontStored = True
      ParentCtl3D = False
      ParentColor = False
      TabOrder = 1
    end
  end
  object PageControl1: TPageControl
    Left = 217
    Top = 95
    Width = 501
    Height = 552
    ActivePage = tbPlannerSheet
    Align = alClient
    TabOrder = 3
    object tbPlannerSheet: TTabSheet
      Caption = 'Planner'
      object PlannerControlEh1: TPlannerControlEh
        Left = 0
        Top = 0
        Width = 493
        Height = 524
        ActivePlannerView = PlannerDayViewEh1
        PlannerDataSource = PlannerDataSourceEh1
        Align = alClient
        PrintService.ColorSchema = pcsFullColorEh
        TabOrder = 0
        OnCheckPlannerItemInteractiveChanging = PlannerControlEh1CheckPlannerItemInteractiveChanging
        object PlannerDayViewEh1: TPlannerDayViewEh
          Left = 0
          Top = 41
          Width = 489
          Height = 479
        end
        object PlannerWeekViewEh1: TPlannerWeekViewEh
          Left = 0
          Top = 41
          Width = 489
          Height = 479
        end
        object PlannerMonthViewEh1: TPlannerMonthViewEh
          Left = 0
          Top = 41
          Width = 489
          Height = 479
        end
        object PlannerVertDayslineViewEh1: TPlannerVertDayslineViewEh
          Left = 0
          Top = 41
          Width = 489
          Height = 479
        end
        object PlannerVertHourslineViewEh1: TPlannerVertHourslineViewEh
          Left = 0
          Top = 41
          Width = 489
          Height = 479
        end
        object PlannerHorzHourslineViewEh1: TPlannerHorzHourslineViewEh
          Left = 0
          Top = 41
          Width = 489
          Height = 479
        end
        object PlannerHorzDayslineViewEh1: TPlannerHorzDayslineViewEh
          Left = 0
          Top = 41
          Width = 489
          Height = 479
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
        Height = 524
        Align = alClient
        DataSource = DataSource1
        DynProps = <>
        Flat = True
        HorzScrollBar.ExtraPanel.Visible = True
        HorzScrollBar.Height = 20
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
        TabOrder = 0
        Columns = <
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'Id'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'StartTime'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'EndTime'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'Title'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'Body'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'AllDay'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'FillColor'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ResourceID'
            Footers = <>
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'InPlanner'
            Footers = <>
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object mtPlannerData: TMemTableEh
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 496
    Top = 65520
  end
  object mtResource: TMemTableEh
    Active = True
    Params = <>
    Left = 421
    Top = 65521
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object Id: TMTNumericDataFieldEh
          FieldName = 'Id'
          NumericDataType = fdtSmallintEh
          AutoIncrement = False
          DisplayWidth = 20
          currency = False
          Precision = 15
        end
        object Name: TMTStringDataFieldEh
          FieldName = 'Name'
          StringDataType = fdtWideStringEh
          DisplayWidth = 20
          Size = 200
        end
        object Activity: TMTStringDataFieldEh
          FieldName = 'Activity'
          StringDataType = fdtWideStringEh
          DisplayWidth = 30
          Size = 200
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1
            'Roberto Nelson'
            'Mining and treasure hunting')
          (
            2
            'Bruce Young'
            'Compound interest and investments')
          (
            3
            'Kim Lambert'
            'Theft, forgery and Facebook')
          (
            4
            'Leslie Johnson'
            'Inheritance and conglomerates')
          (
            5
            'Phil Forest'
            'Oil and gas')
          (
            6
            'K. J. Weston'
            'Defense')
          (
            7
            'Terri Lee'
            'Marauding')
          (
            8
            'Stewart Hall'
            'Inheritance and defense')
          (
            9
            'Katherine Young'
            'Real estate')
          (
            10
            'Chris Papadopoulos'
            'Inheritance'))
      end
    end
  end
  object DataSource2: TDataSource
    DataSet = mtResource
    Top = 592
  end
  object PlannerDataSourceEh1: TPlannerDataSourceEh
    ItemSourceParams.FieldsMap = <>
    OnApplyUpdateToDataStorage = PlannerDataSourceEh1ApplyUpdateToDataStorage
    Left = 141
    Top = 65527
  end
  object DataSource1: TDataSource
    DataSet = mtPlannerData
    Left = 568
    Top = 65528
  end
  object CompoManEh1: TCompoManEh
    Left = 328
    Top = 65528
    VisibleComponentListPos = ()
  end
end
