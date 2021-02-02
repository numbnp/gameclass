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
      StringDataType = fdtStringEh
      DisplayLabel = 'VendorName'
      DisplayWidth = 30
      Size = 30
      Transliterate = True
    end
    object Address1: TMTStringDataFieldEh
      FieldName = 'Address1'
      StringDataType = fdtStringEh
      DisplayLabel = 'Address1'
      DisplayWidth = 30
      Size = 30
      Transliterate = True
    end
    object Address2: TMTStringDataFieldEh
      FieldName = 'Address2'
      StringDataType = fdtStringEh
      DisplayLabel = 'Address2'
      DisplayWidth = 30
      Size = 30
      Transliterate = True
    end
    object City: TMTStringDataFieldEh
      FieldName = 'City'
      StringDataType = fdtStringEh
      DisplayLabel = 'City'
      DisplayWidth = 20
      Transliterate = True
    end
    object State: TMTStringDataFieldEh
      FieldName = 'State'
      StringDataType = fdtStringEh
      DisplayLabel = 'State'
      DisplayWidth = 20
      Transliterate = True
    end
    object Zip: TMTStringDataFieldEh
      FieldName = 'Zip'
      StringDataType = fdtStringEh
      DisplayLabel = 'Zip'
      DisplayWidth = 10
      Size = 10
      Transliterate = True
    end
    object Country: TMTStringDataFieldEh
      FieldName = 'Country'
      StringDataType = fdtStringEh
      DisplayLabel = 'Country'
      DisplayWidth = 15
      Size = 15
      Transliterate = True
    end
    object Phone: TMTStringDataFieldEh
      FieldName = 'Phone'
      StringDataType = fdtStringEh
      DisplayLabel = 'Phone'
      DisplayWidth = 15
      Size = 15
      Transliterate = True
    end
    object FAX: TMTStringDataFieldEh
      FieldName = 'FAX'
      StringDataType = fdtStringEh
      DisplayLabel = 'FAX'
      DisplayWidth = 15
      Size = 15
      Transliterate = True
    end
    object Preferred: TMTBooleanDataFieldEh
      FieldName = 'Preferred'
      DisplayLabel = 'Preferred'
      DisplayWidth = 5
    end
  end
  object RecordsList: TRecordsListEh
    Data = (
      (
        9
        'Amor Aqua'
        '42 West 29th Street'
        nil
        'New York'
        'NY'
        '10011'
        'U.S.A.'
        '800-555-6880'
        '212-555-7286'
        True)
      (
        10
        'Aqua Research Corp.'
        'P.O. Box 998'
        nil
        'Cornish'
        'NH'
        '03745'
        'U.S.A.'
        '603-555-2254'
        nil
        True)
      (
        11
        'B&K Undersea Photo'
        '116 W 7th Street'
        nil
        'New York'
        'NY'
        '10011'
        'U.S.A.'
        '800-555-5662'
        '212-555-7474'
        False)
      (
        8
        'Beauchat, Inc.'
        '45900 SW 2nd Ave'
        nil
        'Ft Lauderdale'
        'FL'
        '33315'
        'U.S.A.'
        '305-555-7242'
        '305-555-6739'
        True)
      (
        1
        'Cacor Corporation'
        '161 Southfield Rd'
        nil
        'Southfield'
        'OH'
        '60093'
        'U.S.A.'
        '708-555-9555'
        '708-555-7547'
        True)
      (
        18
        'Central Valley Skin Divers'
        '160 Jameston Ave'
        nil
        'Jamaica'
        'NY'
        '11432'
        'U.S.A.'
        '718-555-5772'
        nil
        False)
      (
        22
        'Dive & Surf'
        'P.O. Box 20210'
        nil
        'Indianapolis'
        'IN'
        '46208'
        'U.S.A.'
        '317-555-4523'
        nil
        False)
      (
        21
        'Dive Canada'
        '275 W Ninth Ave'
        nil
        'Vancouver'
        'British Columbia'
        'V6K 1P9'
        'Canada'
        '604-555-2681'
        '604-555-3749'
        True)
      (
        15
        'Dive Time'
        '20 Miramar Ave'
        nil
        'Long Beach'
        'CA'
        '90815'
        'U.S.A.'
        '213-555-3708'
        '213-555-1390'
        True)
      (
        5
        'Divers'#39'  Supply Shop'
        '5208 University Dr'
        nil
        'Macon'
        'GA'
        '20865'
        'U.S.A.'
        '912-555-6790'
        '912-555-8474'
        False)
      (
        12
        'Diving International Unlimited'
        '1148 David Drive'
        nil
        'San Diego'
        'DA'
        '92102'
        'U.S.A.'
        '800-555-8439'
        nil
        True)
      (
        17
        'Felix Diving'
        '310 S Michigan Ave'
        nil
        'Chicago'
        'IL'
        '60607'
        'U.S.A.'
        '800-555-3549'
        '312-555-1586'
        False)
      (
        23
        'Fish Research Labs'
        '29 Wilkins Rd Dept. SD'
        nil
        'Los Banos'
        'CA'
        '93635'
        'U.S.A.'
        '209-555-3292'
        '203-555-0416'
        True)
      (
        14
        'Glen Specialties, Inc.'
        '17663 Campbell Lane'
        nil
        'Huntington Beach'
        'CA'
        '92647'
        'U.S.A.'
        '714-555-5100'
        '714-555-6539'
        True)
      (
        3
        'J.W.  Luscher Mfg.'
        '65 Addams Street'
        nil
        'Berkely'
        'MA'
        '02779'
        'U.S.A.'
        '800-555-4744'
        '508-555-8949'
        False)
      (
        20
        'Marine Camera & Dive'
        '117 South Valley Rd'
        nil
        'San Diego'
        'CA'
        '92121'
        'U.S.A.'
        '619-555-0604'
        '619-555-6499'
        True)
      (
        13
        'Nautical Compressors'
        '65 NW 167 Street'
        nil
        'Miami'
        'FL'
        '33015'
        'U.S.A.'
        '305-555-5554'
        '305-555-0268'
        True)
      (
        19
        'Parkway Dive Shop'
        '241 Kelly Street'
        nil
        'South Amboy'
        'NJ'
        '08879'
        'U.S.A.'
        '908-555-5300'
        nil
        True)
      (
        7
        'Perry Scuba'
        '3443 James Ave'
        nil
        'Hapeville'
        'GA'
        '30354'
        'U.S.A.'
        '800-555-6220'
        '404-555-8280'
        True)
      (
        4
        'Scuba Professionals'
        '3105 East Brace'
        nil
        'Rancho Dominguez'
        'CA'
        '90221'
        'U.S.A.'
        '213-555-7850'
        nil
        True)
      (
        6
        'Techniques'
        '52 Dolphin Drive'
        nil
        'Redwood City'
        'CA'
        '94065-1086'
        'U.S.A.'
        '415-555-1410'
        '415-555-1276'
        False)
      (
        16
        'Undersea Systems, Inc.'
        '18112 Gotham Street'
        nil
        'Huntington Beach'
        'CA'
        '92648'
        'U.S.A.'
        '800-555-3483'
        nil
        True)
      (
        2
        'Underwater'
        '50 N 3rd Street'
        nil
        'Indianapolis'
        'IN'
        '46208'
        'U.S.A.'
        '317-555-4523'
        nil
        True))
  end
end
