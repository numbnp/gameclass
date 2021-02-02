inherited frFrameThree: TfrFrameThree
  Width = 715
  Height = 662
  object Splitter2: TSplitter
    Left = 209
    Top = 95
    Width = 8
    Height = 567
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 715
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 715
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
      Caption = 'Demo3'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 119
      Top = 11
      Width = 89
      Height = 13
      Caption = 'Custom Edit Dialog'
    end
    object Bevel1: TBevel
      Left = 0
      Top = 34
      Width = 715
      Height = 2
      Align = alBottom
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 36
    Width = 715
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
    object bEditPlanItem: TButton
      Left = 119
      Top = 6
      Width = 91
      Height = 47
      Caption = 'Edit Item'
      TabOrder = 1
      OnClick = bEditPlanItemClick
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
      TabOrder = 2
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
      TabOrder = 3
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
      TabOrder = 4
      OnClick = bMonthRangeClick
    end
  end
  object CalPickerPanel: TPanel
    Left = 0
    Top = 95
    Width = 209
    Height = 567
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'CalPickerPanel'
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 0
      Top = 361
      Width = 209
      Height = 8
      Cursor = crVSplit
      Align = alTop
      ResizeStyle = rsUpdate
    end
    object gridResouce: TDBGridEh
      Left = 0
      Top = 369
      Width = 209
      Height = 198
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
      Height = 361
      PlannerControl = PlannerControlEh1
      Align = alTop
      ParentCtl3D = False
      ParentColor = False
      TabOrder = 1
    end
  end
  object PageControl1: TPageControl
    Left = 217
    Top = 95
    Width = 498
    Height = 567
    ActivePage = tbPlannerSheet
    Align = alClient
    TabOrder = 3
    object tbPlannerSheet: TTabSheet
      Caption = 'Planner'
      object PlannerControlEh1: TPlannerControlEh
        Left = 0
        Top = 0
        Width = 490
        Height = 539
        ActivePlannerView = PlannerDayViewEh1
        PlannerDataSource = PlannerDataSourceEh1
        Align = alClient
        PrintService.ColorSchema = pcsFullColorEh
        TabOrder = 0
        OnActivePlannerViewChanged = PlannerControlEh1ActivePlannerViewChanged
        OnCheckPlannerItemInteractiveChanging = PlannerControlEh1CheckPlannerItemInteractiveChanging
        OnPlannerItemInteractiveChanged = PlannerControlEh1PlannerItemInteractiveChanged
        OnShowPlanItemDialog = PlannerControlEh1ShowPlanItemDialog
        object PlannerDayViewEh1: TPlannerDayViewEh
          Left = 0
          Top = 41
          Width = 486
          Height = 494
          OnSelectionChanged = PlannerDayViewEh1SelectionChanged
        end
        object PlannerWeekViewEh1: TPlannerWeekViewEh
          Left = 0
          Top = 41
          Width = 486
          Height = 494
        end
        object PlannerMonthViewEh1: TPlannerMonthViewEh
          Left = 0
          Top = 41
          Width = 486
          Height = 494
        end
        object PlannerVertDayslineViewEh1: TPlannerVertDayslineViewEh
          Left = 0
          Top = 41
          Width = 486
          Height = 494
        end
        object PlannerVertHourslineViewEh1: TPlannerVertHourslineViewEh
          Left = 0
          Top = 41
          Width = 486
          Height = 494
        end
        object PlannerHorzHourslineViewEh1: TPlannerHorzHourslineViewEh
          Left = 0
          Top = 41
          Width = 486
          Height = 494
        end
        object PlannerHorzDayslineViewEh1: TPlannerHorzDayslineViewEh
          Left = 0
          Top = 41
          Width = 486
          Height = 494
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
        DataSource = PlannerDataSource
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
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'Category'
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
      AutoIncCurValue = -4
      object DataStruct: TMTDataStructEh
        object Id: TMTNumericDataFieldEh
          FieldName = 'Id'
          NumericDataType = fdtAutoIncEh
          AutoIncrement = True
          DisplayWidth = 5
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
          DisplayWidth = 20
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
          DisplayWidth = 8
          currency = False
          Precision = 15
        end
        object InPlanner: TMTBooleanDataFieldEh
          FieldName = 'InPlanner'
          DisplayWidth = 20
        end
        object Category: TMTNumericDataFieldEh
          FieldName = 'Category'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayWidth = 5
          currency = False
          Precision = 15
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            -1
            42017.0833333333d
            42017.4270833333d
            'Long event'
            
              'Detail info Planner have a field to store detial information abo' +
              'ut the event'
            nil
            nil
            0
            nil
            1)
          (
            -2
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            True
            2)
          (
            -3
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            True
            3))
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
    Left = 341
    Top = 65535
  end
  object PlannerDataSource: TDataSource
    DataSet = mtPlannerData
    Left = 560
    Top = 65520
  end
end
