object frFrameDropDownForms: TfrFrameDropDownForms
  Left = 0
  Top = 0
  Width = 435
  Height = 266
  Align = alClient
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      435
      33)
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 435
      Height = 33
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
      Top = 2
      Width = 166
      Height = 23
      Caption = 'DropDown Forms'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Memo1: TMemo
      Left = 213
      Top = 8
      Width = 404
      Height = 17
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      Lines.Strings = (
        'Advanced way of using DropDownForms.')
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
      WordWrap = False
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 33
    Width = 435
    Height = 233
    Align = alClient
    ColumnDefValues.AlwaysShowEditButton = True
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    FooterParams.Color = clWindow
    FrozenCols = 2
    IndicatorOptions = [gioShowRowIndicatorEh]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleParams.MultiTitle = True
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'PartNo'
        Footers = <>
        Title.Caption = 'Part No'
        Width = 48
      end
      item
        DynProps = <>
        DropDownFormParams.DropDownFormClassName = 'TDropDownMemoEdit'
        DropDownFormParams.PassParams = pspFieldValueEh
        EditButtons = <>
        FieldName = 'Description'
        Footers = <>
        Title.Caption = 'Part Description'
        Width = 134
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'VendorNo'
        Footers = <>
        Title.Caption = 'Vendor|No'
        Width = 38
      end
      item
        DynProps = <>
        DropDownFormParams.DropDownFormClassName = 'TDDFVendors'
        DropDownFormParams.PassParams = pspRecordValuesEh
        DropDownFormParams.AssignBackFieldNames = 'VendorNo;VendorName'
        EditButtons = <>
        FieldName = 'VendorName'
        Footers = <>
        Title.Caption = 'Vendor|Name'
        Width = 145
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Cost'
        Footers = <>
        Width = 61
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ListPrice'
        Footers = <>
        Width = 54
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'OnHand'
        Footers = <>
        Width = 40
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'OnOrder'
        Footers = <>
        Width = 47
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object mtVendors: TMemTableEh
    Active = True
    FetchAllOnOpen = True
    Params = <>
    Left = 168
    Top = 381
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object VendorNo: TMTNumericDataFieldEh
          FieldName = 'VendorNo'
          NumericDataType = fdtAutoIncEh
          AutoIncrement = False
          DisplayLabel = 'VendorNo'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object VendorName: TMTStringDataFieldEh
          FieldName = 'VendorName'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'VendorName'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object Address1: TMTStringDataFieldEh
          FieldName = 'Address1'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Address1'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object Address2: TMTStringDataFieldEh
          FieldName = 'Address2'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Address2'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object City: TMTStringDataFieldEh
          FieldName = 'City'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'City'
          DisplayWidth = 20
          Transliterate = True
        end
        object Country: TMTStringDataFieldEh
          FieldName = 'Country'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Country'
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
        object Phone: TMTStringDataFieldEh
          FieldName = 'Phone'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Phone'
          DisplayWidth = 15
          Size = 15
          Transliterate = True
        end
        object Preferred: TMTBooleanDataFieldEh
          FieldName = 'Preferred'
          DisplayLabel = 'Preferred'
          DisplayWidth = 5
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
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            36
            '2122'
            nil
            nil
            nil
            nil
            nil
            nil
            False
            nil
            nil)
          (
            1
            'Cacor Corporation'
            '161 Southfield Rd'
            nil
            'Southfield'
            'U.S.A.'
            '708-555-7547'
            '708-555-9555'
            True
            'OH'
            '60093')
          (
            2
            'Underwater'
            '50 N 3rd Street'
            nil
            'Indianapolis'
            'U.S.A.'
            nil
            '317-555-4523'
            True
            'IN'
            '46208')
          (
            3
            'J.W.  Luscher Mfg.'
            '65 Addams Street'
            nil
            'Berkely'
            'U.S.A.'
            '508-555-8949'
            '800-555-4744'
            False
            'MA'
            '02779')
          (
            4
            'Scuba Professionals'
            '3105 East Brace'
            nil
            'Rancho Dominguez'
            'U.S.A.'
            nil
            '213-555-7850'
            True
            'CA'
            '90221')
          (
            5
            'Divers'#39'  Supply Shop'
            '5208 University Dr'
            nil
            'Macon'
            'U.S.A.'
            '912-555-8474'
            '912-555-6790'
            False
            'GA'
            '20865')
          (
            6
            'Techniques'
            '52 Dolphin Drive'
            nil
            'Redwood City'
            'U.S.A.'
            '415-555-1276'
            '415-555-1410'
            False
            'CA'
            '94065-1086')
          (
            7
            'Perry Scuba'
            '3443 James Ave'
            nil
            'Hapeville'
            'U.S.A.'
            '404-555-8280'
            '800-555-6220'
            True
            'GA'
            '30354')
          (
            8
            'Beauchat, Inc.'
            '45900 SW 2nd Ave'
            nil
            'Ft Lauderdale'
            'U.S.A.'
            '305-555-6739'
            '305-555-7242'
            True
            'FL'
            '33315')
          (
            9
            'Amor Aqua'
            '42 West 29th Street'
            nil
            'New York'
            'U.S.A.'
            '212-555-7286'
            '800-555-6880'
            True
            'NY'
            '10011')
          (
            10
            'Aqua Research Corp.'
            'P.O. Box 998'
            nil
            'Cornish'
            'U.S.A.'
            nil
            '603-555-2254'
            True
            'NH'
            '03745')
          (
            11
            'B&K Undersea Photo'
            '116 W 7th Street'
            nil
            'New York'
            'U.S.A.'
            '212-555-7474'
            '800-555-5662'
            False
            'NY'
            '10011')
          (
            12
            'Diving International Unlimited'
            '1148 David Drive'
            nil
            'San Diego'
            'U.S.A.'
            nil
            '800-555-8439'
            True
            'DA'
            '92102')
          (
            13
            'Nautical Compressors'
            '65 NW 167 Street'
            nil
            'Miami'
            'U.S.A.'
            '305-555-0268'
            '305-555-5554'
            True
            'FL'
            '33015')
          (
            14
            'Glen Specialties, Inc.'
            '17663 Campbell Lane'
            nil
            'Huntington Beach'
            'U.S.A.'
            '714-555-6539'
            '714-555-5100'
            True
            'CA'
            '92647')
          (
            15
            'Dive Time'
            '20 Miramar Ave'
            nil
            'Long Beach'
            'U.S.A.'
            '213-555-1390'
            '213-555-3708'
            True
            'CA'
            '90815')
          (
            16
            'Undersea Systems, Inc.'
            '18112 Gotham Street'
            nil
            'Huntington Beach'
            'U.S.A.'
            nil
            '800-555-3483'
            True
            'CA'
            '92648')
          (
            17
            'Felix Diving'
            '310 S Michigan Ave'
            nil
            'Chicago'
            'U.S.A.'
            '312-555-1586'
            '800-555-3549'
            False
            'IL'
            '60607')
          (
            18
            'Central Valley Skin Divers'
            '160 Jameston Ave'
            nil
            'Jamaica'
            'U.S.A.'
            nil
            '718-555-5772'
            False
            'NY'
            '11432')
          (
            19
            'Parkway Dive Shop'
            '241 Kelly Street'
            nil
            'South Amboy'
            'U.S.A.'
            nil
            '908-555-5300'
            True
            'NJ'
            '08879')
          (
            20
            'Marine Camera & Dive'
            '117 South Valley Rd'
            nil
            'San Diego'
            'U.S.A.'
            '619-555-6499'
            '619-555-0604'
            True
            'CA'
            '92121')
          (
            21
            'Dive Canada'
            '275 W Ninth Ave'
            nil
            'Vancouver'
            'Canada'
            '604-555-3749'
            '604-555-2681'
            True
            'British Columbia'
            'V6K 1P9')
          (
            22
            'Dive & Surf'
            'P.O. Box 20210'
            nil
            'Indianapolis'
            'U.S.A.'
            nil
            '317-555-4523'
            False
            'IN'
            '46208')
          (
            23
            'Fish Research Labs'
            '29 Wilkins Rd Dept. SD'
            nil
            'Los Banos'
            'U.S.A.'
            '203-555-0416'
            '209-555-3292'
            True
            'CA'
            '93635')
          (
            26
            '322'
            nil
            nil
            nil
            nil
            nil
            nil
            False
            nil
            nil))
      end
    end
  end
  object MemTableEh1: TMemTableEh
    Active = True
    FetchAllOnOpen = True
    Params = <>
    Left = 56
    Top = 304
    object MemTableEh1Cost: TFloatField
      FieldName = 'Cost'
    end
    object MemTableEh1Description: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object MemTableEh1ListPrice: TFloatField
      FieldName = 'ListPrice'
    end
    object MemTableEh1OnHand: TFloatField
      FieldName = 'OnHand'
    end
    object MemTableEh1OnOrder: TFloatField
      FieldName = 'OnOrder'
    end
    object MemTableEh1PartNo: TAutoIncField
      FieldName = 'PartNo'
    end
    object MemTableEh1VendorNo: TIntegerField
      FieldName = 'VendorNo'
    end
    object MemTableEh1VandorName: TStringField
      FieldName = 'VendorName'
      Size = 200
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object Cost: TMTNumericDataFieldEh
          FieldName = 'Cost'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'Cost'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object Description: TMTStringDataFieldEh
          FieldName = 'Description'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Description'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object ListPrice: TMTNumericDataFieldEh
          FieldName = 'ListPrice'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'ListPrice'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object OnHand: TMTNumericDataFieldEh
          FieldName = 'OnHand'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'OnHand'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object OnOrder: TMTNumericDataFieldEh
          FieldName = 'OnOrder'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'OnOrder'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object PartNo: TMTNumericDataFieldEh
          FieldName = 'PartNo'
          NumericDataType = fdtAutoIncEh
          AutoIncrement = False
          DisplayLabel = 'PartNo'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object VendorNo: TMTNumericDataFieldEh
          FieldName = 'VendorNo'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'VendorNo'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object VendorName: TMTStringDataFieldEh
          FieldName = 'VendorName'
          StringDataType = fdtStringEh
          DisplayLabel = 'VendorName'
          DisplayWidth = 200
          Size = 200
          Transliterate = True
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1356.750000000000000000
            'Dive kayak'
            3999.950000000000000000
            24.000000000000000000
            16.000000000000000000
            1
            6
            nil)
          (
            504.000000000000000000
            'Underwater Diver Vehicle'
            1680.000000000000000000
            5.000000000000000000
            3.000000000000000000
            2
            6
            nil)
          (
            117.500000000000000000
            'Regulator System'
            250.000000000000000000
            165.000000000000000000
            216.000000000000000000
            3
            4
            nil)
          (
            124.100000000000000000
            'Second Stage Regulator'
            365.000000000000000000
            98.000000000000000000
            88.000000000000000000
            4
            15
            nil)
          (
            119.350000000000000000
            'Regulator System'
            341.000000000000000000
            75.000000000000000000
            70.000000000000000000
            5
            4
            nil)
          (
            73.530000000000000000
            'Second Stage Regulator'
            171.000000000000000000
            37.000000000000000000
            35.000000000000000000
            6
            4
            nil)
          (
            154.800000000000000000
            'Regulator System'
            430.000000000000000000
            166.000000000000000000
            100.000000000000000000
            7
            4
            nil)
          (
            85.800000000000000000
            'Alternate Inflation Regulator'
            260.000000000000000000
            47.000000000000000000
            43.000000000000000000
            8
            4
            nil)
          (
            99.900000000000000000
            'Second Stage Regulator'
            270.000000000000000000
            128.000000000000000000
            135.000000000000000000
            9
            4
            nil)
          (
            64.600000000000000000
            'First Stage Regulator'
            170.000000000000000000
            146.000000000000000000
            140.000000000000000000
            10
            4
            nil)
          (
            95.790000000000000000
            'Second Stage Regulator'
            309.000000000000000000
            13.000000000000000000
            10.000000000000000000
            11
            21
            nil)
          (
            73.319999999999990000
            'Depth/Pressure Gauge Console'
            188.000000000000000000
            25.000000000000000000
            24.000000000000000000
            12
            21
            nil)
          (
            120.900000000000000000
            'Electronic Console'
            390.000000000000000000
            13.000000000000000000
            12.000000000000000000
            13
            4
            nil)
          (
            48.300000000000000000
            'Depth/Pressure Gauge'
            105.000000000000000000
            226.000000000000000000
            225.000000000000000000
            14
            4
            nil)
          (
            72.850000000000000000
            'Personal Dive Sonar'
            235.000000000000000000
            46.000000000000000000
            45.000000000000000000
            15
            4
            nil)
          (
            10.150000000000000000
            'Compass Console Mount'
            29.000000000000000000
            211.000000000000000000
            300.000000000000000000
            16
            4
            nil)
          (
            24.960000000000000000
            'Compass (meter only)'
            52.000000000000000000
            168.000000000000000000
            183.000000000000000000
            17
            4
            nil)
          (
            76.220000000000000000
            'Depth/Pressure Gauge'
            206.000000000000000000
            128.000000000000000000
            120.000000000000000000
            18
            4
            nil)
          (
            189.000000000000000000
            'Electronic Console w/ options'
            420.000000000000000000
            24.000000000000000000
            23.000000000000000000
            19
            4
            nil)
          (
            12.582000000000000000
            'Direct Sighting Compass'
            34.950000000000000000
            15.000000000000000000
            12.000000000000000000
            20
            1
            nil)
          (
            76.970000000000000000
            'Dive Computer'
            179.000000000000000000
            5.000000000000000000
            2.000000000000000000
            21
            1
            nil)
          (
            9.177000000000000000
            'Navigation Compass'
            19.950000000000000000
            8.000000000000000000
            20.000000000000000000
            22
            1
            nil)
          (
            7.920000000000000000
            'Wrist Band Thermometer (F)'
            18.000000000000000000
            6.000000000000000000
            3.000000000000000000
            23
            1
            nil)
          (
            53.640000000000000000
            'Depth/Pressure Gauge (Digital)'
            149.000000000000000000
            12.000000000000000000
            10.000000000000000000
            24
            1
            nil)
          (
            39.270000000000000000
            'Depth/Pressure Gauge (Analog)'
            119.000000000000000000
            16.000000000000000000
            15.000000000000000000
            25
            1
            nil)
          (
            6.480000000000000000
            'Wrist Band Thermometer (C)'
            18.000000000000000000
            12.000000000000000000
            10.000000000000000000
            26
            1
            nil)
          (
            253.500000000000000000
            'Dive Computer'
            650.000000000000000000
            45.000000000000000000
            43.000000000000000000
            27
            21
            nil)
          (
            146.200000000000000000
            'Stabilizing Vest'
            430.000000000000000000
            56.000000000000000000
            67.000000000000000000
            28
            4
            nil)
          (
            128.800000000000000000
            'Front Clip Stabilizing Vest'
            280.000000000000000000
            45.000000000000000000
            56.000000000000000000
            29
            4
            nil)
          (
            138.250000000000000000
            'Trim Fit Stabilizing Vest'
            395.000000000000000000
            63.000000000000000000
            61.000000000000000000
            30
            4
            nil)
          (
            109.200000000000000000
            'Welded Seam Stabilizing Vest'
            280.000000000000000000
            62.000000000000000000
            60.000000000000000000
            31
            4
            nil)
          (
            13.120000000000000000
            'Safety Knife'
            41.000000000000000000
            16.000000000000000000
            30.000000000000000000
            32
            4
            nil)
          (
            26.766500000000000000
            'Medium Titanium Knife'
            56.950000000000000000
            4.000000000000000000
            3.000000000000000000
            33
            15
            nil)
          (
            14.350000000000000000
            'Chisel Point Knife'
            41.000000000000000000
            14.000000000000000000
            35.000000000000000000
            34
            4
            nil)
          (
            29.250000000000000000
            'Flashlight'
            65.000000000000000000
            28.000000000000000000
            27.000000000000000000
            35
            4
            nil)
          (
            34.300000000000000000
            'Medium Stainless Steel Knife'
            70.000000000000000000
            30.000000000000000000
            23.000000000000000000
            36
            4
            nil)
          (
            27.300000000000000000
            'Divers Knife and Sheath'
            70.000000000000000000
            24.000000000000000000
            23.000000000000000000
            37
            4
            nil)
          (
            37.600000000000000000
            'Large Stainless Steel Knife'
            80.000000000000000000
            16.000000000000000000
            15.000000000000000000
            38
            4
            nil)
          (
            20.677000000000000000
            'Krypton Flashlight'
            44.950000000000000000
            46.000000000000000000
            76.000000000000000000
            39
            22
            nil)
          (
            50.985000000000000000
            'Flashlight (Rechargeable)'
            169.950000000000000000
            16.000000000000000000
            36.000000000000000000
            40
            22
            nil)
          (
            19.184000000000000000
            'Halogen Flashlight'
            59.950000000000000000
            19.000000000000000000
            18.000000000000000000
            41
            22
            nil)
          (
            57.280000000000000000
            '60.6 cu ft Tank'
            179.000000000000000000
            8.000000000000000000
            4.000000000000000000
            42
            4
            nil)
          (
            130.000000000000000000
            '95.1 cu ft Tank'
            325.000000000000000000
            16.000000000000000000
            14.000000000000000000
            43
            4
            nil)
          (
            58.500000000000000000
            '71.4 cu ft Tank'
            195.000000000000000000
            102.000000000000000000
            100.000000000000000000
            44
            4
            nil)
          (
            96.350000000000000000
            '75.8 cu ft Tank'
            235.000000000000000000
            38.000000000000000000
            31.000000000000000000
            45
            4
            nil)
          (
            710.700000000000000000
            'Remotely Operated Video System'
            2369.000000000000000000
            13.000000000000000000
            12.000000000000000000
            46
            3
            nil)
          (
            1124.100000000000000000
            'Marine Super VHS Video Package'
            2498.000000000000000000
            3.000000000000000000
            1.000000000000000000
            47
            22
            nil)
          (
            859.570000000000000000
            'Towable Video Camera (B&W)'
            1999.000000000000000000
            12.000000000000000000
            21.000000000000000000
            48
            10
            nil)
          (
            1484.550000000000000000
            'Towable Video Camera (Color)'
            3299.000000000000000000
            16.000000000000000000
            39.000000000000000000
            49
            10
            nil)
          (
            52.778000000000000000
            'Camera and Case'
            119.950000000000000000
            14.000000000000000000
            12.000000000000000000
            50
            22
            nil)
          (
            147.579500000000000000
            'Video Light'
            359.950000000000000000
            5.000000000000000000
            1.000000000000000000
            51
            22
            nil)
          (
            203.660000000000000000
            'Boat Towable Metal Detector'
            599.000000000000000000
            13.000000000000000000
            12.000000000000000000
            52
            3
            nil)
          (
            316.050000000000000000
            'Boat Towable Metal Detector'
            735.000000000000000000
            14.000000000000000000
            11.000000000000000000
            53
            3
            nil)
          (
            143.500000000000000000
            'Underwater Altimeter'
            350.000000000000000000
            38.000000000000000000
            34.000000000000000000
            54
            3
            nil)
          (
            215.110000000000000000
            'Sonar System'
            439.000000000000000000
            3.000000000000000000
            120.000000000000000000
            55
            3
            nil)
          (
            545.580000000000100000
            'Marine Magnetometer'
            1299.000000000000000000
            56.000000000000000000
            55.000000000000000000
            56
            3
            nil)
          (
            440.510000000000000000
            'Underwater Metal Detector'
            899.000000000000000000
            29.000000000000000000
            24.000000000000000000
            57
            3
            nil)
          (
            338.300000000000000000
            'Underwater Metal Detector'
            995.000000000000000000
            45.000000000000000000
            41.000000000000000000
            58
            3
            nil)
          (
            986.850000000000000000
            'Air Compressor'
            2295.000000000000000000
            5.000000000000000000
            2.000000000000000000
            59
            13
            nil)
          (
            nil
            'w'
            nil
            nil
            nil
            61
            nil
            nil)
          (
            nil
            'new'
            nil
            nil
            nil
            62
            1
            nil))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 96
    Top = 312
  end
end
