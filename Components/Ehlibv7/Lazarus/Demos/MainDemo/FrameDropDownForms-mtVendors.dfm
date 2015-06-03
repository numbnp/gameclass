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
