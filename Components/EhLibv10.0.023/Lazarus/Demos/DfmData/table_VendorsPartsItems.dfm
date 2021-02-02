object MemTableData: TMemTableDataEh
  object DataStruct: TMTDataStructEh
    object VNo: TMTNumericDataFieldEh
      FieldName = 'VNo'
      NumericDataType = fdtFloatEh
      AutoIncrement = False
      DisplayLabel = 'Vendor of parts|Vendor Number|1'
      DisplayWidth = 17
      DisplayFormat = 'VN 0000'
      currency = False
      Precision = 15
    end
    object VName: TMTStringDataFieldEh
      FieldName = 'VName'
      StringDataType = fdtStringEh
      DisplayLabel = 'Vendor of parts|Vendor Name|2'
      DisplayWidth = 24
      Size = 30
      Transliterate = True
    end
    object PNo: TMTNumericDataFieldEh
      FieldName = 'PNo'
      NumericDataType = fdtFloatEh
      AutoIncrement = False
      Alignment = taLeftJustify
      DisplayLabel = 'Parts|PN|3'
      DisplayWidth = 15
      DisplayFormat = 'PN-00000'
      currency = False
      Precision = 15
    end
    object PDescription: TMTStringDataFieldEh
      FieldName = 'PDescription'
      StringDataType = fdtStringEh
      DisplayLabel = 'Parts|Description|4'
      DisplayWidth = 18
      Size = 30
      Transliterate = True
    end
    object PCost: TMTNumericDataFieldEh
      FieldName = 'PCost'
      NumericDataType = fdtCurrencyEh
      AutoIncrement = False
      DisplayLabel = 'Parts|Cost|5'
      DisplayWidth = 9
      DisplayFormat = '#,##0.0000'
      currency = True
      Precision = 15
    end
    object IQty: TMTNumericDataFieldEh
      FieldName = 'IQty'
      NumericDataType = fdtIntegerEh
      AutoIncrement = False
      DisplayLabel = 'Items|Qry|6'
      DisplayWidth = 21
      currency = False
      Precision = 15
    end
    object VPreferred: TMTBooleanDataFieldEh
      FieldName = 'VPreferred'
      DisplayLabel = 'VPreferred'
      DisplayWidth = 5
    end
  end
  object RecordsList: TRecordsListEh
    Data = (
      (
        1.000000000000000000
        'Cacor Corporation'
        26.000000000000000000
        'Wrist Band Thermometer (C)'
        64800c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        26.000000000000000000
        'Wrist Band Thermometer (C)'
        64800c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        20.000000000000000000
        'Direct Sighting Compass'
        125820c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        20.000000000000000000
        'Direct Sighting Compass'
        125820c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        20.000000000000000000
        'Direct Sighting Compass'
        125820c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        20.000000000000000000
        'Direct Sighting Compass'
        125820c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        1
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        1
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        1
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        1
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        1
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        1
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        1
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        1
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        1
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        1
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        1
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        1
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        18.000000000000000000
        'Depth/Pressure Gauge'
        762200c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        1
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        1
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        1
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        1
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        1
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        1
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        1
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        1
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        1
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        1
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        1
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        1
        False)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        1
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        1
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        1
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        1
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        1
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        1
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        1
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        1
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        1
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        1
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        1
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        1
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        1
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        1
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        1
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        1
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        1
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        1
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        1
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        1
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        1
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        1
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        26.000000000000000000
        'Wrist Band Thermometer (C)'
        64800c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        20.000000000000000000
        'Direct Sighting Compass'
        125820c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        2
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        2
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        2
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        2
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        2
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        2
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        2
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        2
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        2
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        2
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        2
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        2
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        2
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        2
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        2
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        2
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        2
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        2
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        18.000000000000000000
        'Depth/Pressure Gauge'
        762200c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        18.000000000000000000
        'Depth/Pressure Gauge'
        762200c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        18.000000000000000000
        'Depth/Pressure Gauge'
        762200c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        21.000000000000000000
        'Dive Computer'
        769700c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        21.000000000000000000
        'Dive Computer'
        769700c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        2
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        2
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        2
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        2
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        2
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        2
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        2
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        2
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        2
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        2
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        2
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        2
        False)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        2
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        2
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        2
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        2
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        2
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        2
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        2
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        2
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        2
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        2
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        2
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        2
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        2
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        2
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        2
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        2
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        2
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        2
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        2
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        49.000000000000000000
        'Towable Video Camera (Color)'
        14845500c
        2
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        49.000000000000000000
        'Towable Video Camera (Color)'
        14845500c
        2
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        26.000000000000000000
        'Wrist Band Thermometer (C)'
        64800c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        26.000000000000000000
        'Wrist Band Thermometer (C)'
        64800c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        20.000000000000000000
        'Direct Sighting Compass'
        125820c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        20.000000000000000000
        'Direct Sighting Compass'
        125820c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        3
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        3
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        3
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        3
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        3
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        3
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        3
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        3
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        3
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        3
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        18.000000000000000000
        'Depth/Pressure Gauge'
        762200c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        21.000000000000000000
        'Dive Computer'
        769700c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        3
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        3
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        3
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        3
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        3
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        3
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        54.000000000000000000
        'Underwater Altimeter'
        1435000c
        3
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        3
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        3
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        3
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        3
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        3
        False)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        3
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        57.000000000000000000
        'Underwater Metal Detector'
        4405100c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        57.000000000000000000
        'Underwater Metal Detector'
        4405100c
        3
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        3
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        3
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        3
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        56.000000000000000000
        'Marine Magnetometer'
        5455800c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        3
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        3
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        3
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        3
        True)
      (
        13.000000000000000000
        'Nautical Compressors'
        59.000000000000000000
        'Air Compressor'
        9868500c
        3
        True)
      (
        13.000000000000000000
        'Nautical Compressors'
        59.000000000000000000
        'Air Compressor'
        9868500c
        3
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        3
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        3
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        3
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        49.000000000000000000
        'Towable Video Camera (Color)'
        14845500c
        3
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        49.000000000000000000
        'Towable Video Camera (Color)'
        14845500c
        3
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        49.000000000000000000
        'Towable Video Camera (Color)'
        14845500c
        3
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        49.000000000000000000
        'Towable Video Camera (Color)'
        14845500c
        3
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        26.000000000000000000
        'Wrist Band Thermometer (C)'
        64800c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        20.000000000000000000
        'Direct Sighting Compass'
        125820c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        4
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        4
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        4
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        4
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        4
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        4
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        4
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        4
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        4
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        4
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        4
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        18.000000000000000000
        'Depth/Pressure Gauge'
        762200c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        21.000000000000000000
        'Dive Computer'
        769700c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        4
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        4
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        4
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        4
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        4
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        4
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        4
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        4
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        4
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        4
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        4
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        4
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        4
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        4
        False)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        4
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        4
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        4
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        4
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        4
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        53.000000000000000000
        'Boat Towable Metal Detector'
        3160500c
        4
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        57.000000000000000000
        'Underwater Metal Detector'
        4405100c
        4
        False)
      (
        6.000000000000000000
        'Techniques'
        2.000000000000000000
        'Underwater Diver Vehicle'
        5040000c
        4
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        56.000000000000000000
        'Marine Magnetometer'
        5455800c
        4
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        4
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        4
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        4
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        4
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        4
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        4
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        4
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        4
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        4
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        4
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        4
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        49.000000000000000000
        'Towable Video Camera (Color)'
        14845500c
        4
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        5
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        5
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        5
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        5
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        5
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        55.000000000000000000
        'Sonar System'
        2151100c
        5
        False)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        5
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        57.000000000000000000
        'Underwater Metal Detector'
        4405100c
        5
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        56.000000000000000000
        'Marine Magnetometer'
        5455800c
        5
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        5
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        5
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        5
        True)
      (
        13.000000000000000000
        'Nautical Compressors'
        59.000000000000000000
        'Air Compressor'
        9868500c
        5
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        5
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        49.000000000000000000
        'Towable Video Camera (Color)'
        14845500c
        5
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        6
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        6
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        6
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        6
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        6
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        18.000000000000000000
        'Depth/Pressure Gauge'
        762200c
        6
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        21.000000000000000000
        'Dive Computer'
        769700c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        6
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        6
        False)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        6
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        6
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        6
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        58.000000000000000000
        'Underwater Metal Detector'
        3383000c
        6
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        56.000000000000000000
        'Marine Magnetometer'
        5455800c
        6
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        6
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        6
        True)
      (
        13.000000000000000000
        'Nautical Compressors'
        59.000000000000000000
        'Air Compressor'
        9868500c
        6
        True)
      (
        13.000000000000000000
        'Nautical Compressors'
        59.000000000000000000
        'Air Compressor'
        9868500c
        6
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        7
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        7
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        7
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        7
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        7
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        7
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        7
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        7
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        7
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        7
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        7
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        7
        False)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        7
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        7
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        7
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        58.000000000000000000
        'Underwater Metal Detector'
        3383000c
        7
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        7
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        7
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        7
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        7
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        7
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        7
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        8
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        8
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        8
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        8
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        8
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        8
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        8
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        8
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        8
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        8
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        8
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        8
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        51.000000000000000000
        'Video Light'
        1475795c
        8
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        8
        False)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        8
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        8
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        8
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        8
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        8
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        8
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        8
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        8
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        26.000000000000000000
        'Wrist Band Thermometer (C)'
        64800c
        9
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        9
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        9
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        9
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        9
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        9
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        9
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        9
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        9
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        9
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        10
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        10
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        10
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        10
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        21.000000000000000000
        'Dive Computer'
        769700c
        10
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        10
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        10
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        10
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        10
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        10
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        10
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        10
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        10
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        10
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        10
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        55.000000000000000000
        'Sonar System'
        2151100c
        10
        False)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        10
        True)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        10
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        11
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        11
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        21.000000000000000000
        'Dive Computer'
        769700c
        11
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        11
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        11
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        9.000000000000000000
        'Second Stage Regulator'
        999000c
        11
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        11
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        12
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        12
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        12
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        12
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        12
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        12
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        12
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        12
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        13
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        13
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        13
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        13
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        13
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        26.000000000000000000
        'Wrist Band Thermometer (C)'
        64800c
        14
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        26.000000000000000000
        'Wrist Band Thermometer (C)'
        64800c
        14
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        14
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        14
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        14
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        14
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        14
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        14
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        14
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        54.000000000000000000
        'Underwater Altimeter'
        1435000c
        14
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        14
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        15
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        15
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        15
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        15
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        15
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        15
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        15
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        15
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        15
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        52.000000000000000000
        'Boat Towable Metal Detector'
        2036600c
        15
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        41.000000000000000000
        'Halogen Flashlight'
        191840c
        16
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        16
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        25.000000000000000000
        'Depth/Pressure Gauge (Analog)'
        392700c
        16
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        44.000000000000000000
        '71.4 cu ft Tank'
        585000c
        16
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        16
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        18.000000000000000000
        'Depth/Pressure Gauge'
        762200c
        16
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        18.000000000000000000
        'Depth/Pressure Gauge'
        762200c
        16
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        16
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        13.000000000000000000
        'Electronic Console'
        1209000c
        16
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        16
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        17
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        17
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        17
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        17
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        17
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        18
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        18
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        18
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        18
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        3.000000000000000000
        'Regulator System'
        1175000c
        18
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        18
        True)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        18
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        20.000000000000000000
        'Direct Sighting Compass'
        125820c
        19
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        19
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        19
        True)
      (
        21.000000000000000000
        'Dive Canada'
        11.000000000000000000
        'Second Stage Regulator'
        957900c
        19
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        45.000000000000000000
        '75.8 cu ft Tank'
        963500c
        19
        True)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        19
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        19
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        20
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        20
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        20
        False)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        20
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        20
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        20
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        20
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        20
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        20
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        20
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        26.000000000000000000
        'Wrist Band Thermometer (C)'
        64800c
        21
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        21
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        21
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        21
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        18.000000000000000000
        'Depth/Pressure Gauge'
        762200c
        21
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        21
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        21
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        22
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        22
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        22
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        22
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        21.000000000000000000
        'Dive Computer'
        769700c
        22
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        22
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        22
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        22
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        49.000000000000000000
        'Towable Video Camera (Color)'
        14845500c
        22
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        24.000000000000000000
        'Depth/Pressure Gauge (Digital)'
        536400c
        23
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        23
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        29.000000000000000000
        'Front Clip Stabilizing Vest'
        1288000c
        23
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        23
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        23
        False)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        23
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        32.000000000000000000
        'Safety Knife'
        131200c
        24
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        38.000000000000000000
        'Large Stainless Steel Knife'
        376000c
        24
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        24
        False)
      (
        15.000000000000000000
        'Dive Time'
        4.000000000000000000
        'Second Stage Regulator'
        1241000c
        24
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        24
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        24
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        24
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        25
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        16.000000000000000000
        'Compass Console Mount'
        101500c
        25
        True)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        25
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        25
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        36.000000000000000000
        'Medium Stainless Steel Knife'
        343000c
        25
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        25
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        6.000000000000000000
        'Second Stage Regulator'
        735300c
        25
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        18.000000000000000000
        'Depth/Pressure Gauge'
        762200c
        25
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        25
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        5.000000000000000000
        'Regulator System'
        1193500c
        25
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        43.000000000000000000
        '95.1 cu ft Tank'
        1300000c
        25
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        19.000000000000000000
        'Electronic Console w/ options'
        1890000c
        25
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        46.000000000000000000
        'Remotely Operated Video System'
        7107000c
        25
        False)
      (
        6.000000000000000000
        'Techniques'
        1.000000000000000000
        'Dive kayak'
        13567500c
        25
        False)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        54.000000000000000000
        'Underwater Altimeter'
        1435000c
        26
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        15.000000000000000000
        'Personal Dive Sonar'
        728500c
        32
        True)
      (
        10.000000000000000000
        'Aqua Research Corp.'
        48.000000000000000000
        'Towable Video Camera (B&W)'
        8595700c
        32
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        34
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        34
        True)
      (
        3.000000000000000000
        'J.W.  Luscher Mfg.'
        57.000000000000000000
        'Underwater Metal Detector'
        4405100c
        34
        False)
      (
        15.000000000000000000
        'Dive Time'
        33.000000000000000000
        'Medium Titanium Knife'
        267665c
        35
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        14.000000000000000000
        'Depth/Pressure Gauge'
        483000c
        35
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        37.000000000000000000
        'Divers Knife and Sheath'
        273000c
        42
        True)
      (
        21.000000000000000000
        'Dive Canada'
        27.000000000000000000
        'Dive Computer'
        2535000c
        43
        True)
      (
        13.000000000000000000
        'Nautical Compressors'
        59.000000000000000000
        'Air Compressor'
        9868500c
        43
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        45
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        17.000000000000000000
        'Compass (meter only)'
        249600c
        45
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        10.000000000000000000
        'First Stage Regulator'
        646000c
        45
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        45
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        8.000000000000000000
        'Alternate Inflation Regulator'
        858000c
        45
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        45
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        47.000000000000000000
        'Marine Super VHS Video Package'
        11241000c
        45
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        7.000000000000000000
        'Regulator System'
        1548000c
        46
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        23.000000000000000000
        'Wrist Band Thermometer (F)'
        79200c
        54
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        50.000000000000000000
        'Camera and Case'
        527780c
        54
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        42.000000000000000000
        '60.6 cu ft Tank'
        572800c
        54
        True)
      (
        21.000000000000000000
        'Dive Canada'
        12.000000000000000000
        'Depth/Pressure Gauge Console'
        733200c
        54
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        30.000000000000000000
        'Trim Fit Stabilizing Vest'
        1382500c
        54
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        28.000000000000000000
        'Stabilizing Vest'
        1462000c
        55
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        34.000000000000000000
        'Chisel Point Knife'
        143500c
        56
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        39.000000000000000000
        'Krypton Flashlight'
        206770c
        65
        False)
      (
        4.000000000000000000
        'Scuba Professionals'
        31.000000000000000000
        'Welded Seam Stabilizing Vest'
        1092000c
        65
        True)
      (
        1.000000000000000000
        'Cacor Corporation'
        22.000000000000000000
        'Navigation Compass'
        91770c
        71
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        87
        True)
      (
        4.000000000000000000
        'Scuba Professionals'
        35.000000000000000000
        'Flashlight'
        292500c
        89
        True)
      (
        22.000000000000000000
        'Dive & Surf'
        40.000000000000000000
        'Flashlight (Rechargeable)'
        509850c
        120
        False))
  end
end
