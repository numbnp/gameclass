inherited frFrameOne: TfrFrameOne
  Width = 684
  Height = 594
  object Splitter2: TSplitter
    Left = 209
    Top = 75
    Width = 8
    Height = 519
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 684
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
      Width = 141
      Height = 13
      Caption = 'Fill PlannerSource in the code'
    end
    object Bevel1: TBevel
      Left = 0
      Top = 34
      Width = 684
      Height = 2
      Align = alBottom
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 36
    Width = 684
    Height = 39
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
      TabOrder = 5
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
      TabOrder = 6
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
      TabOrder = 7
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
      TabOrder = 8
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
      TabOrder = 9
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
      TabOrder = 10
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
      TabOrder = 11
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
      TabOrder = 12
      OnClick = bHorzTimeBand4Click
    end
    object bYearPlannerView: TButton
      Left = 666
      Top = 6
      Width = 40
      Height = 25
      Hint = 'Horizontal Time Band - Month by Days'
      BiDiMode = bdLeftToRight
      Caption = 'YE'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      OnClick = bYearPlannerViewClick
    end
  end
  object CalPickerPanel: TPanel
    Left = 0
    Top = 75
    Width = 209
    Height = 519
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
      Height = 158
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
    Top = 75
    Width = 467
    Height = 519
    ActivePage = tbPlannerSheet
    Align = alClient
    TabOrder = 3
    object tbPlannerSheet: TTabSheet
      Caption = 'Planner'
      object PlannerControlEh1: TPlannerControlEh
        Left = 0
        Top = 0
        Width = 459
        Height = 491
        ActivePlannerView = PlannerDayViewEh1
        PlannerDataSource = PlannerDataSourceEh1
        TimeSpanParams.PopupMenu = ppmPlanItem
        Align = alClient
        PrintService.ColorSchema = pcsFullColorEh
        TabOrder = 0
        OnCheckPlannerItemInteractiveChanging = PlannerControlEh1CheckPlannerItemInteractiveChanging
        OnDrawSpanItem = PlannerControlEh1DrawSpanItem
        OnPlannerSpanItemContextPopup = PlannerControlEh1PlannerSpanItemContextPopup
        OnContextPopup = PlannerControlEh1ContextPopup
        object PlannerDayViewEh1: TPlannerDayViewEh
          Left = 0
          Top = 41
          Width = 455
          Height = 446
          PopupMenu = ppmHours
          OnContextPopup = PlannerDayViewEh1ContextPopup
          OnReadPlannerDataItem = PlannerDayViewEh1ReadPlannerDataItem
        end
        object PlannerWeekViewEh1: TPlannerWeekViewEh
          Left = 0
          Top = 41
          Width = 455
          Height = 446
        end
        object PlannerMonthViewEh1: TPlannerMonthViewEh
          Left = 0
          Top = 41
          Width = 455
          Height = 446
        end
        object PlannerVertDayslineViewEh1: TPlannerVertDayslineViewEh
          Left = 0
          Top = 41
          Width = 455
          Height = 446
        end
        object PlannerVertHourslineViewEh1: TPlannerVertHourslineViewEh
          Left = 0
          Top = 41
          Width = 455
          Height = 446
        end
        object PlannerHorzHourslineViewEh1: TPlannerHorzHourslineViewEh
          Left = 0
          Top = 41
          Width = 455
          Height = 446
        end
        object PlannerHorzDayslineViewEh1: TPlannerHorzDayslineViewEh
          Left = 0
          Top = 41
          Width = 455
          Height = 446
        end
        object PlannerHorzYearViewEh1: TPlannerHorzYearViewEh
          Left = 0
          Top = 41
          Width = 578
          Height = 447
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'DataSource'
      ImageIndex = 1
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 459
        Height = 491
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
    Active = True
    Params = <>
    Left = 496
    Top = 65520
    object MemTableData: TMemTableDataEh
      AutoIncCurValue = -19
      object DataStruct: TMTDataStructEh
        object Id: TMTNumericDataFieldEh
          FieldName = 'Id'
          NumericDataType = fdtAutoIncEh
          AutoIncrement = True
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object StartTime: TMTDateTimeDataFieldEh
          FieldName = 'StartTime'
          DateTimeDataType = fdtDateTimeEh
          DisplayWidth = 20
        end
        object EndTime: TMTDateTimeDataFieldEh
          FieldName = 'EndTime'
          DateTimeDataType = fdtDateTimeEh
          DisplayWidth = 20
        end
        object Title: TMTStringDataFieldEh
          FieldName = 'Title'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 2000
        end
        object Body: TMTStringDataFieldEh
          FieldName = 'Body'
          StringDataType = fdtStringEh
          DisplayWidth = 10
          Size = 2000
        end
        object AllDay: TMTBooleanDataFieldEh
          FieldName = 'AllDay'
          DisplayWidth = 5
        end
        object FillColor: TMTStringDataFieldEh
          FieldName = 'FillColor'
          StringDataType = fdtStringEh
          DisplayWidth = 8
        end
        object ResourceID: TMTNumericDataFieldEh
          FieldName = 'ResourceID'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayWidth = 5
          currency = False
          Precision = 15
        end
        object InPlanner: TMTBooleanDataFieldEh
          FieldName = 'InPlanner'
          DisplayWidth = 5
        end
        object Category: TMTNumericDataFieldEh
          FieldName = 'Category'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayWidth = 5
          currency = False
          Precision = 15
        end
        object ReadOnly: TMTBooleanDataFieldEh
          FieldName = 'ReadOnly'
          DisplayWidth = 5
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            -2
            42018.0208333333d
            42018.5104166667d
            'Long event'
            
              'Detail info'#13#10'Planner have a field to store detial information ab' +
              'out the event'
            False
            nil
            0
            True
            1
            False)
          (
            -3
            42018.0625d
            42018.2395833333d
            'Busy time'
            ''
            False
            nil
            0
            True
            2
            False)
          (
            -4
            42018.4375d
            42018.6458333334d
            'Travel to office'
            ''
            False
            nil
            0
            True
            3
            False)
          (
            -5
            42002.0208333333d
            42002.0833333333d
            'Lunch time 1234'
            ''
            False
            nil
            0
            True
            1
            False)
          (
            -6
            42029.9166666667d
            42042.3333333333d
            'Long event 8d'
            ''
            False
            nil
            0
            True
            2
            False)
          (
            -7
            42017.5833333333d
            42019.5833333333d
            'Long event 3d'
            ''
            False
            nil
            0
            True
            2
            False)
          (
            -8
            42018.0208333333d
            42018.3541666666d
            'Event for Resource 1'
            ''
            False
            nil
            1
            True
            1
            False)
          (
            -9
            42018d
            42024.6666666667d
            'New Item 7d'
            ''
            False
            nil
            0
            True
            1
            False)
          (
            -11
            42009.125d
            42019.5d
            'New Item 1111'
            ''
            False
            nil
            0
            True
            2
            False)
          (
            -12
            42020d
            42022.7083333333d
            'New Item'
            ''
            False
            nil
            0
            True
            3
            False)
          (
            -13
            42018.0208333333d
            42018.5833333333d
            'New Item RES2'
            ''
            False
            nil
            2
            True
            3
            False)
          (
            -14
            42018.0208333333d
            42018.3958333333d
            'New Item res3'
            ''
            False
            nil
            3
            True
            3
            False)
          (
            -15
            42018.0833333333d
            42018.7291666667d
            'New Item'
            ''
            False
            nil
            0
            True
            3
            False)
          (
            -16
            42018.1875d
            42018.4166666667d
            'New Item. Read Only'
            ''
            False
            nil
            0
            True
            1
            True)
          (
            -17
            42018.7916666667d
            42018.9791666667d
            'New Item'
            ''
            False
            nil
            0
            True
            1
            False)
          (
            -18
            42018.2708333333d
            42018.3958333333d
            'New Item'
            ''
            False
            nil
            0
            True
            1
            False))
      end
    end
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
  object ppmHours: TPopupMenu
    Left = 661
    Top = 3
    object mi60Min: TMenuItem
      Tag = 5
      Caption = '60 Minutes'
      OnClick = mi60MinClick
    end
    object mi30Min: TMenuItem
      Tag = 4
      Caption = '30 Minutes'
      OnClick = mi60MinClick
    end
    object mi15Min: TMenuItem
      Tag = 3
      Caption = '15 Minutes'
      OnClick = mi60MinClick
    end
    object mi10Min: TMenuItem
      Tag = 2
      Caption = '10 Minutes'
      OnClick = mi60MinClick
    end
    object mi6Min: TMenuItem
      Tag = 1
      Caption = '6 Minutes'
      OnClick = mi60MinClick
    end
    object mi5Min: TMenuItem
      Caption = '5 Minutes'
      OnClick = mi60MinClick
    end
  end
  object ppmPlanItem: TPopupMenu
    Left = 661
    Top = 91
    object miPlanItemEdit: TMenuItem
      Caption = 'Edit'
      OnClick = miPlanItemEditClick
    end
    object miPlanItemDelete: TMenuItem
      Caption = 'Delete'
      OnClick = miPlanItemDeleteClick
    end
  end
end
