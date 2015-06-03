object Form1: TForm1
  Left = 490
  Top = 201
  Width = 648
  Height = 362
  Caption = 'DBGridEh.LookupFilter '
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    632
    324)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 96
    Width = 209
    Height = 13
    Caption = 'Lookup1 - Filtering from the start of the string'
  end
  object Label2: TLabel
    Left = 32
    Top = 192
    Width = 209
    Height = 13
    Caption = 'Lookup2 - Filtering from any part of the string'
  end
  object Label3: TLabel
    Left = 374
    Top = 14
    Width = 92
    Height = 13
    Caption = 'ListDataSet.Filter = '
  end
  object Label4: TLabel
    Left = 374
    Top = 56
    Width = 39
    Height = 13
    Caption = 'Base list'
  end
  object Label5: TLabel
    Left = 374
    Top = 160
    Width = 49
    Height = 13
    Caption = 'Filtered list'
  end
  object DBLookupComboboxEh1: TDBLookupComboboxEh
    Left = 32
    Top = 120
    Width = 265
    Height = 19
    AlwaysShowBorder = True
    DropDownBox.Columns = <
      item
        FieldName = 'Company'
      end
      item
        FieldName = 'City'
        Width = 50
      end
      item
        FieldName = 'Country'
        Width = 50
      end>
    DropDownBox.ListSource = dsFilteredList
    DropDownBox.ListSourceAutoFilter = True
    DropDownBox.Options = [dlgColumnResizeEh, dlgColLinesEh]
    DropDownBox.AutoDrop = True
    DropDownBox.Rows = 27
    DropDownBox.ShowTitles = True
    DropDownBox.Sizable = True
    DropDownBox.Width = -1
    EditButtons = <>
    Flat = True
    KeyField = 'CustNo'
    ListField = 'Company'
    ListSource = dsBaseList
    TabOrder = 0
    Visible = True
    OnDropDownBoxApplyTextFilter = DBLookupComboboxEh1DropDownBoxApplyTextFilter
  end
  object DBLookupComboboxEh2: TDBLookupComboboxEh
    Left = 32
    Top = 216
    Width = 265
    Height = 19
    AlwaysShowBorder = True
    DropDownBox.Columns = <
      item
        FieldName = 'Company'
      end
      item
        FieldName = 'City'
        Width = 50
      end
      item
        FieldName = 'Country'
        Width = 50
      end>
    DropDownBox.ListSource = dsFilteredList
    DropDownBox.ListSourceAutoFilter = True
    DropDownBox.ListSourceAutoFilterType = lsftContainsEh
    DropDownBox.Options = [dlgColumnResizeEh, dlgColLinesEh]
    DropDownBox.AutoDrop = True
    DropDownBox.Rows = 27
    DropDownBox.ShowTitles = True
    DropDownBox.Sizable = True
    DropDownBox.Width = -1
    EditButtons = <>
    Flat = True
    KeyField = 'CustNo'
    ListField = 'Company'
    ListSource = dsBaseList
    Style = csDropDownEh
    TabOrder = 1
    Visible = True
  end
  object DBEditEh1: TDBEditEh
    Left = 374
    Top = 28
    Width = 234
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DynProps = <>
    EditButtons = <>
    TabOrder = 2
    Visible = True
  end
  object DBGridEh2: TDBGridEh
    Left = 374
    Top = 72
    Width = 234
    Height = 81
    Anchors = [akLeft, akTop, akRight]
    ColumnDefValues.AlwaysShowEditButton = True
    Ctl3D = False
    DataSource = dsBaseList
    DynProps = <>
    Flat = True
    GridLineParams.DataHorzLines = False
    GridLineParams.GridBoundaries = True
    IndicatorOptions = [gioShowRowIndicatorEh]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentCtl3D = False
    EditButtonsShowOptions = [sebShowOnlyForCurRowEh]
    TabOrder = 3
    TitleParams.FillStyle = cfstGradientEh
    TitleParams.BorderInFillStyle = True
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 374
    Top = 176
    Width = 234
    Height = 138
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColumnDefValues.AlwaysShowEditButton = True
    Ctl3D = False
    DataSource = dsFilteredList
    DynProps = <>
    Flat = True
    GridLineParams.DataHorzLines = False
    GridLineParams.GridBoundaries = True
    IndicatorOptions = [gioShowRowIndicatorEh]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentCtl3D = False
    EditButtonsShowOptions = [sebShowOnlyForCurRowEh]
    TabOrder = 4
    TitleParams.FillStyle = cfstGradientEh
    TitleParams.BorderInFillStyle = True
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object mteBaseList: TMemTableEh
    Active = True
    Params = <>
    Options = [mtoTextFieldsCaseInsensitive]
    SortOrder = 'Company desc'
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object CustNo: TMTNumericDataFieldEh
          FieldName = 'CustNo'
          NumericDataType = fdtAutoIncEh
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
            1
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
            2
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
            3
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
            4
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
            5
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
            6
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
            7
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
            8
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
            9
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
            10
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
            11
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
            12
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
            13
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
            14
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
            15
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
            16
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
            17
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
            18
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
            19
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
            20
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
            21
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
            22
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
            23
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
            24
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
            25
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
            26
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
            27
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
            28
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
            29
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
            30
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
            31
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
            32
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
            33
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
            34
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
            35
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
            36
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
            37
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
            38
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
            39
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
            40
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
            41
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
            42
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
            43
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
            44
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
            45
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
            46
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
            47
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
            48
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
            49
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
            50
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
            51
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
            52
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
            53
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
            54
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
            55
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
  object dsBaseList: TDataSource
    DataSet = mteBaseList
    Top = 32
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Delphi7\EhLib\De' +
      'mos\Data\DBTest.mdb;Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    BeforeConnect = ADOConnection1BeforeConnect
    Left = 424
    Top = 344
  end
  object mteFilteredList: TMemTableEh
    Active = True
    ExternalMemData = mteBaseList
    Params = <>
    Options = [mtoTextFieldsCaseInsensitive]
    Left = 320
    Top = 8
  end
  object dsFilteredList: TDataSource
    DataSet = mteFilteredList
    OnDataChange = dsFilteredListDataChange
    Left = 320
    Top = 40
  end
end
