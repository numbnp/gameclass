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
