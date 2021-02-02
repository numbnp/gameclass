object ToolsDataModule: TToolsDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 106
  Width = 215
  object mtSpecDays: TMemTableEh
    Active = True
    Filtered = True
    Params = <>
    Left = 48
    Top = 14
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object country_code: TMTStringDataFieldEh
          FieldName = 'country_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'country_code'
          DisplayWidth = 10
          Size = 10
          Transliterate = True
        end
        object year_from: TMTNumericDataFieldEh
          FieldName = 'year_from'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'year_from'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object year_to: TMTNumericDataFieldEh
          FieldName = 'year_to'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'year_to'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object date_month: TMTNumericDataFieldEh
          FieldName = 'date_month'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'date_month'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object date_day: TMTNumericDataFieldEh
          FieldName = 'date_day'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'date_day'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object day_type: TMTNumericDataFieldEh
          FieldName = 'day_type'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'day_type'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object description: TMTStringDataFieldEh
          FieldName = 'description'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'description'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            'US'
            2016
            9999
            1
            1
            1
            'New Year'#39's Day')
          (
            'US'
            2016
            9999
            1
            18
            1
            'Robert E. Lee, Martin Luther King, Jr.'#39's Birthday')
          (
            'US'
            2016
            9999
            2
            9
            1
            'Mardi Gras')
          (
            'US'
            2016
            9999
            2
            15
            1
            'George Washington, Thomas Jefferson'#39's Birthday')
          (
            'US'
            2016
            9999
            4
            25
            1
            'Confederate Memorial Day')
          (
            'US'
            2016
            9999
            5
            30
            1
            'National Memorial Day')
          (
            'US'
            2016
            9999
            6
            6
            1
            'Jefferson Davis'#39' Birthday')
          (
            'US'
            2016
            9999
            7
            4
            1
            'Independence Day')
          (
            'US'
            2016
            9999
            9
            5
            1
            'Labor Day')
          (
            'US'
            2016
            9999
            10
            10
            1
            'Columbus Day, Fraternal Day, American Indian Heritage Day')
          (
            'US'
            2016
            9999
            11
            11
            1
            'Veterans Day')
          (
            'US'
            2016
            9999
            11
            24
            1
            'Thanksgiving')
          (
            'US'
            2016
            9999
            12
            26
            1
            'Christmas Day')
          (
            'FR'
            0
            9999
            1
            1
            1
            'Jour de l'#39'an')
          (
            'FR'
            0
            0
            0
            0
            1
            'Lundi de P'#226'ques')
          (
            'FR'
            1900
            9999
            5
            1
            1
            'F'#234'te du Travail')
          (
            'FR'
            1945
            9999
            5
            8
            1
            'Victoire du 8 Mai 1945')
          (
            'FR'
            0
            0
            0
            0
            1
            'Jeudi de l'#39'Ascension')
          (
            'FR'
            0
            0
            0
            0
            1
            'Lundi de Pentec'#244'te')
          (
            'FR'
            1900
            9999
            7
            14
            1
            'F'#234'te Nationale')
          (
            'FR'
            0
            9999
            8
            15
            1
            'Assomption')
          (
            'FR'
            1900
            9999
            11
            1
            1
            'La Toussaint')
          (
            'FR'
            1918
            9999
            11
            11
            1
            'Armistice 1918')
          (
            'FR'
            1900
            9999
            12
            25
            1
            'No'#235'l'))
      end
    end
  end
end
