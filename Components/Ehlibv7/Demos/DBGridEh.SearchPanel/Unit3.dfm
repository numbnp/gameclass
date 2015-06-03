object Frame3: TFrame3
  Left = 0
  Top = 0
  Width = 455
  Height = 416
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 304
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 57
    Width = 455
    Height = 359
    Align = alClient
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
    SearchPanel.Location = splExternal
    SortLocal = True
    TabOrder = 0
    TitleParams.SortMarkerStyle = smstFrameEh
    TitleParams.FillStyle = cfstSolidEh
    TitleParams.BorderInFillStyle = True
    VertScrollBar.VisibleMode = sbAlwaysShowEh
    Columns = <
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
        FieldName = 'CustNo'
        Footers = <>
        Width = 60
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
  object Button4: TButton
    Left = 520
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Ext Seach'
    TabOrder = 1
    OnClick = Button4Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 455
    Height = 57
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 522
    DesignSize = (
      455
      57)
    object Label1: TLabel
      Left = 17
      Top = 38
      Width = 26
      Height = 13
      Caption = 'Panel'
    end
    object Bevel1: TBevel
      Left = 49
      Top = 44
      Width = 395
      Height = 2
      Anchors = [akLeft, akTop, akRight]
      ExplicitWidth = 461
    end
    object DBEditEh1: TDBEditEh
      Left = 17
      Top = 10
      Width = 185
      Height = 21
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Text = 'Search...'
      TabOrder = 0
      Visible = True
      OnChange = DBEditEh1Change
      OnEnter = DBEditEh1Enter
      OnExit = DBEditEh1Exit
    end
    object Button1: TButton
      Left = 208
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Filter'
      TabOrder = 1
      OnClick = Button1Click
      OnEnter = DBEditEh1Enter
      OnExit = DBEditEh1Exit
    end
    object Button2: TButton
      Left = 288
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Find Next >'
      TabOrder = 2
      OnClick = Button2Click
      OnEnter = DBEditEh1Enter
      OnExit = DBEditEh1Exit
    end
    object Button3: TButton
      Left = 368
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Find Prev <'
      TabOrder = 3
      OnClick = Button3Click
      OnEnter = DBEditEh1Enter
      OnExit = DBEditEh1Exit
    end
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Params = <>
    Left = 592
    Top = 288
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
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Company'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object Addr1: TMTStringDataFieldEh
          FieldName = 'Addr1'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Addr1'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object Addr2: TMTStringDataFieldEh
          FieldName = 'Addr2'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Addr2'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object City: TMTStringDataFieldEh
          FieldName = 'City'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'City'
          DisplayWidth = 15
          Size = 15
          Transliterate = True
        end
        object State: TMTStringDataFieldEh
          FieldName = 'State'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'State'
          DisplayWidth = 20
          Transliterate = True
        end
        object Zip: TMTStringDataFieldEh
          FieldName = 'Zip'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Zip'
          DisplayWidth = 10
          Size = 10
          Transliterate = True
        end
        object Country: TMTStringDataFieldEh
          FieldName = 'Country'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Country'
          DisplayWidth = 20
          Transliterate = True
        end
        object Phone: TMTStringDataFieldEh
          FieldName = 'Phone'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Phone'
          DisplayWidth = 15
          Size = 15
          Transliterate = True
        end
        object FAX: TMTStringDataFieldEh
          FieldName = 'FAX'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'FAX'
          DisplayWidth = 15
          Size = 15
          Transliterate = True
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
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Contact'
          DisplayWidth = 20
          Transliterate = True
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
            34732d)
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
            34655d)
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
            34625d)
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
            33633d)
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
            33683d)
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
            34646d)
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
            34731d)
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
            34647d)
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
            34533d)
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
            33061d)
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
            34433d)
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
            33367d)
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
            34706d)
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
            34260d)
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
            33841d)
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
            34701d)
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
            34644d)
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
            33032d)
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
            32683d)
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
            33547d)
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
            33231d)
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
            32692d)
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
            34498d)
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
            34373d)
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
            34430d)
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
            34459d)
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
            34393d)
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
            34527d)
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
            34536d)
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
            34601d)
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
            34703d)
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
            34627d)
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
            34664d)
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
            34547d)
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
            34210d)
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
            34100d)
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
            34670d)
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
            34267d)
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
            34343d)
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
            34684d)
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
            34571d)
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
            32872d)
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
            34651d)
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
            34227d)
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
            34475d)
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
            34735d)
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
            34352d)
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
            34362d)
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
            34707d)
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
            34431d)
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
            32592d)
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
            34349d)
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
            34733d)
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
            34618d)
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
            35004d))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 504
    Top = 288
  end
end
