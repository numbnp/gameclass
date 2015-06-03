object Form1: TForm1
  Left = 31
  Top = 301
  Width = 1183
  Height = 583
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1167
    Height = 545
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 1159
        Height = 517
        Align = alClient
        AllowedSelections = [gstRecordBookmarks, gstRectangle, gstAll]
        ColumnDefValues.AlwaysShowEditButton = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        Ctl3D = True
        DataGrouping.Active = True
        DataGrouping.Color = clGradientInactiveCaption
        DataGrouping.Font.Charset = DEFAULT_CHARSET
        DataGrouping.Font.Color = clWindowText
        DataGrouping.Font.Height = -12
        DataGrouping.Font.Name = 'Microsoft Sans Serif'
        DataGrouping.Font.Style = [fsBold]
        DataGrouping.GroupLevels = <
          item
            ColumnName = 'Column_6_Country'
          end>
        DataGrouping.Footers = <
          item
            Visible = True
            ColumnItems = <
              item
              end
              item
              end
              item
              end
              item
              end
              item
                ValueType = gfvCountEh
              end
              item
              end
              item
              end
              item
                ValueType = gfvMaxEh
              end
              item
              end
              item
              end
              item
              end
              item
              end
              item
              end
              item
              end
              item
                ValueType = gfvSumEh
              end
              item
              end
              item
              end
              item
              end
              item
              end
              item
              end
              item
              end
              item
              end
              item
              end
              item
              end
              item
              end
              item
              end>
          end>
        DataGrouping.GroupPanelVisible = True
        DataGrouping.ParentColor = False
        DataGrouping.ParentFont = False
        DataSource = DataSource1
        DynProps = <>
        EditActions = [geaCopyEh, geaSelectAllEh]
        EvenRowColor = clWindow
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        FooterRowCount = 1
        FooterParams.Color = clBtnFace
        IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghIncSearch, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        RowDetailPanel.Height = 200
        RowSizingAllowed = True
        ShowHint = True
        SortLocal = True
        STFilter.InstantApply = True
        STFilter.Local = True
        STFilter.Visible = True
        TabOrder = 0
        TitleParams.MultiTitle = True
        TitleParams.VTitleMargin = 5
        VertScrollBar.SmoothStep = True
        OnActiveGroupingStructChanged = DBGridEh1ActiveGroupingStructChanged
        Columns = <
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'CustNo'
            Footers = <>
            STFilter.ListField = 'CustNo'
            Title.Caption = 'CustNo 1'
            Width = 78
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Country'
            Footers = <>
            Visible = False
            Width = 75
            InRowLinePos = 1
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Company'
            Footers = <>
            Title.Caption = 'City|Company 2'
            Width = 98
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'City'
            Footers = <>
            Title.Caption = 'City|City 5'
            Width = 95
            InRowLinePos = 1
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Addr1'
            Footers = <>
            Title.Caption = 'Addr1 3'
            Width = 68
          end
          item
            DynProps = <>
            EditButtons = <
              item
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000430B0000430B00000000000000000000FF00FFFF00FF
                  FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                  00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                  694731694731694731FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6947316947
                  31694731FF00FFFF00FFFF00FFFF00FF694731BFAD9F694731FF00FFFF00FFFF
                  00FFFF00FFFF00FFFF00FF694731BFAD9F694731FF00FFFF00FFFF00FFFF00FF
                  694731694731694731181E23181E23181E23181E23181E23181E236947316947
                  31694731FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7787919CD6EB2384BC23
                  84BC2384BC2384BC2384BC181E23FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FF778791B7E8F59CD6EB80C3E065B1D64B9FCC2384BC181E23FF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF778791C4F1FAB7E8F59C
                  D6EB80C3E073BADB2384BC181E23FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FF778791C4F1FAC4F1FAB7E8F5A9DFF08ECCE52384BC181E23FF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF778791C4F1FAC4F1FAC4
                  F1FAC4F1FAA9DFF02384BC181E23FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FF778791C4F1FAC4F1FAC4F1FAC4F1FAC4F1FAA9DFF0181E23FF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FF69473169473169473177879177879177
                  8791778791778791778791694731694731694731FF00FFFF00FFFF00FFFF00FF
                  694731BFAD9F694731FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF694731BFAD
                  9F694731FF00FFFF00FFFF00FFFF00FF694731694731694731FF00FFFF00FFFF
                  00FFFF00FFFF00FFFF00FF694731694731694731FF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                  00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
                Style = ebsGlyphEh
              end>
            FieldName = 'Addr2'
            Footers = <>
            Title.Caption = 'Addr2 4'
            Width = 75
            InRowLinePos = 1
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Country'
            Footers = <>
            Visible = False
            Width = 98
          end
          item
            Checkboxes = True
            DynProps = <>
            EditButtons = <>
            FieldName = 'State'
            Footers = <>
            KeyList.Strings = (
              'HI'
              '')
            Title.Caption = 'State 6'
            Width = 54
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Zip'
            Footers = <>
            Width = 41
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Phone'
            Footers = <>
            Width = 41
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'FAX'
            Footers = <>
            Width = 40
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'TaxRate'
            Footers = <>
            Width = 41
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Contact'
            Footers = <>
            Width = 41
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'LastInvoiceDate'
            Footers = <>
            Width = 40
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'CustNo'
            Footers = <>
            Width = 80
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Company'
            Footers = <>
            Width = 36
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Addr1'
            Footers = <>
            Width = 40
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Addr2'
            Footers = <>
            Width = 27
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'City'
            Footers = <>
            Width = 44
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'State'
            Footers = <>
            Width = 52
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Zip'
            Footers = <>
            Width = 52
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Phone'
            Footers = <>
            Width = 40
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'FAX'
            Footers = <>
            Width = 52
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'TaxRate'
            Footers = <>
            Width = 52
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Contact'
            Footers = <>
            Width = 52
          end
          item
            ButtonStyle = cbsEllipsis
            DynProps = <>
            EditButtons = <>
            FieldName = 'LastInvoiceDate'
            Footers = <>
            Width = 52
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object gridFish: TDBGridEh
        Left = 0
        Top = 0
        Width = 1159
        Height = 517
        Align = alClient
        ColumnDefValues.AlwaysShowEditButton = True
        ColumnDefValues.Title.TitleButton = True
        Ctl3D = True
        DataGrouping.Active = True
        DataGrouping.GroupLevels = <
          item
            Color = clWindow
            ColumnName = 'Column_3_Category'
            ParentColor = False
          end>
        DataGrouping.GroupPanelVisible = True
        DataSource = dsFish
        DrawGraphicData = True
        DrawMemoText = True
        DynProps = <>
        EditActions = [geaCopyEh, geaSelectAllEh]
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        FooterParams.Color = clBtnFace
        GridLineParams.VertEmptySpaceStyle = dessNonEh
        IndicatorOptions = [gioShowRecNoEh]
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        IndicatorTitle.UseGlobalMenu = False
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghFrozen3D, dghFooter3D, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghAutoFitRowHeight]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SortLocal = True
        STFilter.Local = True
        STFilter.Location = stflInTitleFilterEh
        STFilter.Visible = True
        TabOrder = 0
        VertScrollBar.SmoothStep = True
        Columns = <
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Species No'
            Footers = <>
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Notes'
            Footers = <>
            STFilter.Visible = False
            Width = 347
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Graphic'
            Footers = <>
            STFilter.Visible = False
            Width = 193
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Category'
            Footers = <>
            Visible = False
            Width = 78
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Common_Name'
            Footers = <>
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Species Name'
            Footers = <>
            Width = 128
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Length (cm)'
            Footers = <>
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Length_In'
            Footers = <>
            Width = 106
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = mtTable1
    Left = 974
    Top = 374
  end
  object mtTable1: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    Left = 978
    Top = 399
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object CustNo: TMTNumericDataFieldEh
          FieldName = 'CustNo'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'CustNo'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object Company: TMTStringDataFieldEh
          FieldName = 'Company'
          StringDataType = fdtStringEh
          DisplayLabel = 'Company'
          DisplayWidth = 30
          Size = 30
        end
        object Addr1: TMTStringDataFieldEh
          FieldName = 'Addr1'
          StringDataType = fdtStringEh
          DisplayLabel = 'Addr1'
          DisplayWidth = 30
          Size = 30
        end
        object Addr2: TMTStringDataFieldEh
          FieldName = 'Addr2'
          StringDataType = fdtStringEh
          DisplayLabel = 'Addr2'
          DisplayWidth = 30
          Size = 30
        end
        object City: TMTStringDataFieldEh
          FieldName = 'City'
          StringDataType = fdtStringEh
          DisplayLabel = 'City'
          DisplayWidth = 15
          Size = 15
        end
        object State: TMTStringDataFieldEh
          FieldName = 'State'
          StringDataType = fdtStringEh
          DisplayLabel = 'State'
          DisplayWidth = 20
        end
        object Zip: TMTStringDataFieldEh
          FieldName = 'Zip'
          StringDataType = fdtStringEh
          DisplayLabel = 'Zip'
          DisplayWidth = 10
          Size = 10
        end
        object Country: TMTStringDataFieldEh
          FieldName = 'Country'
          StringDataType = fdtStringEh
          DisplayLabel = 'Country'
          DisplayWidth = 20
        end
        object Phone: TMTStringDataFieldEh
          FieldName = 'Phone'
          StringDataType = fdtStringEh
          DisplayLabel = 'Phone'
          DisplayWidth = 15
          Size = 15
        end
        object FAX: TMTStringDataFieldEh
          FieldName = 'FAX'
          StringDataType = fdtStringEh
          DisplayLabel = 'FAX'
          DisplayWidth = 15
          Size = 15
        end
        object TaxRate: TMTNumericDataFieldEh
          FieldName = 'TaxRate'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'TaxRate'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object Contact: TMTStringDataFieldEh
          FieldName = 'Contact'
          StringDataType = fdtStringEh
          DisplayLabel = 'Contact'
          DisplayWidth = 20
        end
        object LastInvoiceDate: TMTDateTimeDataFieldEh
          FieldName = 'LastInvoiceDate'
          DateTimeDataType = fdtDateTimeEh
          DisplayLabel = 'LastInvoiceDate'
          DisplayWidth = 18
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d)
          (
            1221.000000000000000000
            'Kauai Dive Shoppe'
            '4-976 Sugarloaf Hwy'
            'Suite 103'
            'Kapaa Kauai'
            'HI'
            '94766-1234'
            'US'
            '808-555-0269'
            '808-555-0278'
            8.500000000000000000
            'Erica Norman'
            34732.0451736111d)
          (
            1231.000000000000000000
            'Unisco'
            'PO Box Z-547'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '809-555-3915'
            '809-555-4958'
            0.000000000000000000
            'George Weathers'
            34655.5906597222d)
          (
            1351.000000000000000000
            'Sight Diver'
            '1 Neptune Lane'
            nil
            'Kato Paphos'
            nil
            nil
            'Cyprus'
            '357-6-876708'
            '357-6-870943'
            0.000000000000000000
            'Phyllis Spooner'
            34625.8059027778d)
          (
            1354.000000000000000000
            'Cayman Divers World Unlimited'
            'PO Box 541'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '011-5-697044'
            '011-5-697064'
            0.000000000000000000
            'Joe Bailey'
            33633.0839814815d)
          (
            1356.000000000000000000
            'Tom Sawyer Diving Centre'
            '632-1 Third Frydenhoj'
            nil
            'Christiansted'
            'St. Croix'
            '00820'
            'US Virgin Islands'
            '504-798-3022'
            '504-798-7772'
            0.000000000000000000
            'Chris Thomas'
            33683.3997685185d)
          (
            1380.000000000000000000
            'Blue Jack Aqua Center'
            '23-738 Paddington Lane'
            'Suite 310'
            'Waipahu'
            'HI'
            '99776'
            'US'
            '401-609-7623'
            '401-609-9403'
            0.000000000000000000
            'Ernest Barratt'
            34646.9737037037d)
          (
            1384.000000000000000000
            'VIP Divers Club'
            '32 Main St.'
            nil
            'Christiansted'
            'St. Croix'
            '02800'
            'US Virgin Islands'
            '809-453-5976'
            '809-453-5932'
            0.000000000000000000
            'Russell Christopher'
            34731.7815162037d)
          (
            1510.000000000000000000
            'Ocean Paradise'
            'PO Box 8745'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '808-555-8231'
            '808-555-8450'
            0.000000000000000000
            'Paul Gardner'
            34647.0571990741d)
          (
            1513.000000000000000000
            'Fantastique Aquatica'
            'Z32 999 #12A-77 A.A.'
            nil
            'Bogota'
            nil
            nil
            'Columbia'
            '057-1-773434'
            '057-1-773421'
            0.000000000000000000
            'Susan Wong'
            34533.720150463d)
          (
            1551.000000000000000000
            'Marmot Divers Club'
            '872 Queen St.'
            nil
            'Kitchener'
            'Ontario'
            'G3N 2E1'
            'Canada'
            '416-698-0399'
            '426-698-0399'
            0.000000000000000000
            'Joyce Marsh'
            33061.1812268519d)
          (
            1560.000000000000000000
            'The Depth Charge'
            '15243 Underwater Fwy.'
            nil
            'Marathon'
            'FL'
            '35003'
            'US'
            '800-555-3798'
            '800-555-0353'
            0.000000000000000000
            'Sam Witherspoon'
            34433.3436574074d)
          (
            1563.000000000000000000
            'Blue Sports'
            '203 12th Ave. Box 746'
            nil
            'Giribaldi'
            'OR'
            '91187'
            'US'
            '610-772-6704'
            '610-772-6898'
            0.000000000000000000
            'Theresa Kunec'
            33367.5039583333d)
          (
            1624.000000000000000000
            'Makai SCUBA Club'
            'PO Box 8534'
            nil
            'Kailua-Kona'
            'HI'
            '94756'
            'US'
            '317-649-9098'
            '317-649-6787'
            0.000000000000000000
            'Donna Siaus'
            34706.5802083333d)
          (
            1645.000000000000000000
            'Action Club'
            'PO Box 5451-F'
            nil
            'Sarasota'
            'FL'
            '32274'
            'US'
            '813-870-0239'
            '813-870-0282'
            0.000000000000000000
            'Michael Spurling'
            34260.5959027778d)
          (
            1651.000000000000000000
            'Jamaica SCUBA Centre'
            'PO Box 68'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '011-3-697043'
            '011-3-697043'
            0.000000000000000000
            'Barbara Harvey'
            33841.0137731481d)
          (
            1680.000000000000000000
            'Island Finders'
            '6133 1/3 Stone Avenue'
            nil
            'St Simons Isle'
            'GA'
            '32521'
            'US'
            '713-423-5675'
            '713-423-5676'
            0.000000000000000000
            'Desmond Ortega'
            34701.3983796296d)
          (
            1984.000000000000000000
            'Adventure Undersea'
            'PO Box 744'
            nil
            'Belize City'
            nil
            nil
            'Belize'
            '011-34-09054'
            '011-34-09064'
            0.000000000000000000
            'Gloria Gonzales'
            34644.6914583333d)
          (
            2118.000000000000000000
            'Blue Sports Club'
            '63365 Nez Perce Street'
            nil
            'Largo'
            'FL'
            '34684'
            'US'
            '612-897-0342'
            '612-897-0348'
            0.000000000000000000
            'Harry Bathbone'
            33032.4729861111d)
          (
            2135.000000000000000000
            'Frank'#39's Divers Supply'
            '1455 North 44th St.'
            nil
            'Eugene'
            'OR'
            '90427'
            'US'
            '503-555-2778'
            '503-555-2769'
            0.000000000000000000
            'Lloyd Fellows'
            32683.437337963d)
          (
            2156.000000000000000000
            'Davy Jones'#39' Locker'
            '246 South 16th Place'
            nil
            'Vancouver'
            'BC'
            'K8V 9P1'
            'Canada'
            '803-509-0112'
            '803-509-0553'
            0.000000000000000000
            'Tanya Wagner'
            33547.0142361111d)
          (
            2163.000000000000000000
            'SCUBA Heaven'
            'PO Box Q-8874'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '011-32-09485'
            '011-32-09485'
            0.000000000000000000
            'Robert Michelind'
            33231.8047685185d)
          (
            2165.000000000000000000
            'Shangri-La Sports Center'
            'PO Box D-5495'
            nil
            'Freeport'
            nil
            nil
            'Bahamas'
            '011-32-08574'
            '011-32-44938'
            0.000000000000000000
            'Frank Paniagua'
            32692.6477893519d)
          (
            2315.000000000000000000
            'Divers of Corfu, Inc.'
            'Marmoset Place 54'
            nil
            'Ayios Matthaios'
            'Corfu'
            nil
            'Greece'
            '30-661-88364'
            '30-661-05943'
            0.000000000000000000
            'Charles Lopez'
            34498.3475925926d)
          (
            2354.000000000000000000
            'Kirk Enterprises'
            '42 Aqua Lane'
            nil
            'Houston'
            'TX'
            '77079'
            'US'
            '713-556-6437'
            '713-556-1073'
            0.000000000000000000
            'Rudolph Claus'
            34373.6095486111d)
          (
            2975.000000000000000000
            'George Bean & Co.'
            '#73 King Salmon Way'
            nil
            'Lugoff'
            'NC'
            '29078'
            'US'
            '803-438-2771'
            '803-438-3003'
            0.000000000000000000
            'Bill Wyers'
            34430.0145138889d)
          (
            2984.000000000000000000
            'Professional Divers, Ltd.'
            '4734 Melinda St.'
            nil
            'Hoover'
            'AL'
            '32145'
            'US'
            '205-555-8333'
            '205-555-4054'
            0.000000000000000000
            'Shirley Mathers'
            34459.7209606481d)
          (
            3041.000000000000000000
            'Divers of Blue-green'
            '634 Complex Ave.'
            nil
            'Pelham'
            'AL'
            '32145'
            'US'
            '205-555-7184'
            '205-555-6059'
            0.000000000000000000
            'Nancy Bean'
            34393.8121990741d)
          (
            3042.000000000000000000
            'Gold Coast Supply'
            '223-B Houston Place'
            nil
            'Mobile'
            'AL'
            '30696'
            'US'
            '205-555-2640'
            '205-555-4094'
            0.000000000000000000
            'Elaine Falls'
            34527.084537037d)
          (
            3051.000000000000000000
            'San Pablo Dive Center'
            '1701-D N Broadway'
            nil
            'Santa Maria'
            'CA'
            '95443'
            'US'
            '823-044-2910'
            '823-044-2990'
            0.000000000000000000
            'Patricia O'#39'Brien'
            34536.3611689815d)
          (
            3052.000000000000000000
            'Underwater Sports Co.'
            '351-A Sarasota St.'
            nil
            'San Jose'
            'CA'
            '92195'
            'US'
            '408-867-0594'
            '408-867-0094'
            0.000000000000000000
            'Dave Walling'
            34601.6301388889d)
          (
            3053.000000000000000000
            'American SCUBA Supply'
            '1739 Atlantic Avenue'
            nil
            'Lomita'
            'CA'
            '91770'
            'US'
            '213-654-0092'
            '213-654-0095'
            0.000000000000000000
            'Lynn Cinciripini'
            34703.568599537d)
          (
            3054.000000000000000000
            'Catamaran Dive Club'
            'Box 264 Pleasure Point'
            nil
            'Catalina Island'
            'CA'
            '90740'
            'US'
            '213-223-0941'
            '213-223-2324'
            0.000000000000000000
            'Nicole Dupont'
            34627.0003240741d)
          (
            3055.000000000000000000
            'Diver'#39's Grotto'
            '24601 Universal Lane'
            nil
            'Downey'
            'CA'
            '94220'
            'US'
            '213-432-0093'
            '213-432-4821'
            0.000000000000000000
            'Peter Owen'
            34664.7352893519d)
          (
            3151.000000000000000000
            'Fisherman'#39's Eye'
            'PO Box 7542'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-555-4680'
            '809-555-4689'
            0.000000000000000000
            'Bethan Lewis'
            34547.1940277778d)
          (
            3158.000000000000000000
            'Action Diver Supply'
            'Blue Spar Box #3'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-500211'
            '22-44-500596'
            0.000000000000000000
            'Marianne Miles'
            34210.1186921296d)
          (
            3615.000000000000000000
            'Marina SCUBA Center'
            'PO Box 82438 Zulu 7831'
            nil
            'Caracas'
            nil
            nil
            'Venezuela'
            '58-33-66222'
            '58-33-66049'
            0.000000000000000000
            'Stephen Bryant'
            34100.8503472222d)
          (
            3984.000000000000000000
            'Blue Glass Happiness'
            '6345 W. Shore Lane'
            nil
            'Santa Monica'
            'CA'
            '90410'
            'US'
            '213-555-1984'
            '213-555-1995'
            0.000000000000000000
            'Christine Taylor'
            34670.0000810185d)
          (
            4312.000000000000000000
            'Divers of Venice'
            '220 Elm Street'
            nil
            'Venice'
            'FL'
            '39224'
            'US'
            '813-443-2356'
            '813-443-9842'
            0.000000000000000000
            'Simone Green'
            34267.8489583333d)
          (
            4531.000000000000000000
            'On-Target SCUBA'
            '7-73763 Nanakawa Road'
            nil
            'Winnipeg'
            'Manitoba'
            'J2R 5T3'
            'Canada'
            '416-445-0988'
            '416-445-0223'
            0.000000000000000000
            'Bram Phillips'
            34343.1894444444d)
          (
            4652.000000000000000000
            'Jamaica Sun, Inc.'
            'PO Box 643'
            nil
            'Runaway Bay'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2746'
            '809-555-0929'
            0.000000000000000000
            'Jonathan West'
            34684.2295486111d)
          (
            4684.000000000000000000
            'Underwater Fantasy'
            'PO Box 842'
            nil
            'Ocho Rios'
            'Jamaica'
            nil
            'West Indies'
            '809-555-2214'
            '809-555-2234'
            0.000000000000000000
            'Grant Ainsworth'
            34571.7852083333d)
          (
            5132.000000000000000000
            'Princess Island SCUBA'
            'PO Box 32 Waiyevo'
            nil
            'Taveuni'
            nil
            nil
            'Fiji'
            '679-311923'
            '679-311203'
            0.000000000000000000
            'Anne Mariachi'
            32872.3890856481d)
          (
            5151.000000000000000000
            'Central Underwater Supplies'
            'PO Box 737'
            nil
            'Johannesburg'
            nil
            '2042'
            'Republic So. Africa'
            '27-11-4432458'
            '27-11-4433259'
            0.000000000000000000
            'Maria Eventosh'
            34651.0697106481d)
          (
            5163.000000000000000000
            'Safari Under the Sea'
            'PO Box 7456'
            nil
            'Grand Cayman'
            nil
            nil
            'British West Indies'
            '809-409-4233'
            '809-409-3002'
            0.000000000000000000
            'Anna Rack'
            34227.7746527778d)
          (
            5165.000000000000000000
            'Larry'#39's Diving School'
            '3562 NW Bruce Street'
            nil
            'Milwaukie'
            'OR'
            '96277'
            'US'
            '503-403-7777'
            '503-403-0059'
            0.000000000000000000
            'Isabelle Neece'
            34475.9603819444d)
          (
            5384.000000000000000000
            'Tora Tora Tora'
            'PO Box H-4573'
            nil
            'Nassau'
            nil
            nil
            'Bahamas'
            '809-898-0043'
            '809-898-9864'
            0.000000000000000000
            'Kevin Rider'
            34735.2366435185d)
          (
            5412.000000000000000000
            'Vashon Ventures'
            '743 Keyhole Court'
            nil
            'Honolulu'
            'HI'
            '92856'
            'US'
            '532-099-0423'
            '532-099-6654'
            0.000000000000000000
            'Susan Smith'
            34352.0734953704d)
          (
            5432.000000000000000000
            'Divers-for-Hire'
            'G.O. P Box 91'
            nil
            'Suva'
            nil
            nil
            'Fiji'
            '679-804576'
            '679-059345'
            0.000000000000000000
            'Joe Hatter'
            34362.8352777778d)
          (
            5515.000000000000000000
            'Ocean Adventures'
            'PO Box 466 Kihei'
            nil
            'Maui'
            'HI'
            '95736'
            'US'
            '776-868-9334'
            '776-868-9553'
            0.000000000000000000
            'Paul Still'
            34707.6914351852d)
          (
            6215.000000000000000000
            'Underwater SCUBA Company'
            'PO Box Sn 91'
            nil
            'Somerset'
            nil
            'SXBN'
            'Bermuda'
            '809-555-1225'
            '809-555-2445'
            0.000000000000000000
            'Michael Grossman'
            34431.9811342593d)
          (
            6312.000000000000000000
            'Aquatic Drama'
            '921 Everglades Way'
            nil
            'Tampa'
            'FL'
            '30643'
            'US'
            '613-442-7654'
            '613-442-7678'
            0.000000000000000000
            'Gillian Owen'
            32592.1964351852d)
          (
            6516.000000000000000000
            'The Diving Company'
            'PO Box 8535'
            nil
            'St. Thomas'
            nil
            '00820'
            'US Virgin Islands'
            '22-44-50098'
            '22-44-09878'
            0.000000000000000000
            'Brian Miles'
            34349.5283564815d)
          (
            6582.000000000000000000
            'Norwest'#39'er SCUBA Limited'
            'PO Box 6834'
            nil
            'Paget'
            nil
            'PSBZ'
            'Bermuda'
            '778-123-0745'
            '778-123-9705'
            0.000000000000000000
            'Angela Jones'
            34733.2829861111d)
          (
            6812.000000000000000000
            'Waterspout SCUBA Center'
            '7865 NE Barber Ct.'
            nil
            'Portland'
            'OR'
            '99271'
            'US'
            '503-654-2434'
            '503-654-9986'
            0.000000000000000000
            'Richard Houser'
            34618.4246875d)
          (
            9841.000000000000000000
            'Neptune'#39's Trident Supply'
            'PO Box 129'
            nil
            'Negril'
            'Jamaica'
            nil
            'West Indies'
            '778-897-3546'
            '778-897-6643'
            0.000000000000000000
            'Louise Franks'
            35004.2722800926d))
      end
    end
  end
  object mtFish: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ADOddFish
    Left = 1088
    Top = 144
    object mtFishSpeciesNo: TFloatField
      FieldName = 'Species No'
    end
    object mtFishCategory: TStringField
      FieldName = 'Category'
      Size = 15
    end
    object mtFishCommon_Name: TStringField
      FieldName = 'Common_Name'
      Size = 30
    end
    object mtFishSpeciesName: TStringField
      FieldName = 'Species Name'
      Size = 40
    end
    object mtFishLengthcm: TFloatField
      FieldName = 'Length (cm)'
    end
    object mtFishLength_In: TFloatField
      FieldName = 'Length_In'
    end
    object mtFishNotes: TMemoField
      FieldName = 'Notes'
      BlobType = ftMemo
    end
    object mtFishGraphic: TGraphicField
      FieldName = 'Graphic'
      BlobType = ftGraphic
    end
  end
  object dsFish: TDataSource
    DataSet = mtFish
    Left = 1088
    Top = 112
  end
  object ADOddFish: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select * from Biolife')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 1052
    Top = 200
  end
  object ADOConnectionProviderEh1: TADOConnectionProviderEh
    InlineConnection.Connected = True
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\..\D' +
      'ata\DBTest.mdb;Persist Security Info=False'
    InlineConnection.Mode = cmShareDenyNone
    InlineConnection.Provider = 'Microsoft.Jet.OLEDB.4.0'
    ServerType = 'MSAccess'
    InlineConnectionBeforeConnect = ADOConnectionProviderEh1InlineConnectionBeforeConnect
    Left = 1052
    Top = 232
  end
end
