    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object ID: TMTNumericDataFieldEh
          FieldName = 'ID'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'ID'
          DisplayWidth = 10
          currency = False
          Precision = 0
        end
        object ID_PARENT: TMTNumericDataFieldEh
          FieldName = 'ID_PARENT'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'ID_PARENT'
          DisplayWidth = 10
          currency = False
          Precision = 0
        end
        object NAME: TMTStringDataFieldEh
          FieldName = 'NAME'
          StringDataType = fdtStringEh
          DisplayLabel = 'NAME'
          DisplayWidth = 30
          Size = 30
        end
        object Expanded: TMTNumericDataFieldEh
          FieldName = 'Expanded'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'Expanded'
          DisplayWidth = 10
          currency = False
          Precision = 0
        end
        object Visible: TMTNumericDataFieldEh
          FieldName = 'Visible'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'Visible'
          DisplayWidth = 10
          currency = False
          Precision = 0
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1
            0
            'ROOT1'
            1
            1)
          (
            2
            0
            'ROOT2'
            1
            1)
          (
            3
            0
            'ROOT3'
            1
            1)
          (
            4
            1
            'CHILD1'
            1
            1)
          (
            5
            1
            'CHILD2'
            1
            1)
          (
            6
            1
            'CHILD3'
            1
            1)
          (
            7
            2
            'CHILD4'
            1
            1)
          (
            8
            2
            'CHILD5'
            1
            1)
          (
            9
            2
            'CHILD6'
            1
            1)
          (
            10
            3
            'CHILD7'
            1
            1)
          (
            11
            3
            'CHILD8'
            1
            1)
          (
            12
            3
            'CHILD9'
            1
            1)
          (
            13
            1
            'CHILD10'
            1
            1)
          (
            14
            1
            'CHILD11'
            1
            1)
          (
            15
            1
            'CHILD12'
            1
            1)
          (
            16
            2
            'CHILD13'
            1
            1)
          (
            17
            2
            'CHILD14'
            1
            1)
          (
            18
            2
            'CHILD15'
            1
            1)
          (
            19
            3
            'CHILD16'
            1
            1)
          (
            20
            3
            'CHILD17'
            1
            1)
          (
            21
            5
            'SUBCH1'
            1
            1)
          (
            22
            5
            'SUBCH2'
            1
            1)
          (
            23
            5
            'SUBCH3'
            1
            1)
          (
            24
            5
            'SUBCH4'
            1
            1)
          (
            25
            22
            'SUBSUB1'
            1
            1))
      end
    end
