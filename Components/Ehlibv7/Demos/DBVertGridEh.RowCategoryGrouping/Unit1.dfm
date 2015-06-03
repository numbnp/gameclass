object Form1: TForm1
  Left = 335
  Top = 215
  Width = 580
  Height = 487
  Caption = 'Form1'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 292
    Top = 0
    Width = 272
    Height = 449
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 272
      Height = 28
      BorderWidth = 1
      Caption = 'ToolBar1'
      EdgeBorders = [ebLeft, ebTop]
      Flat = True
      Images = ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Hint = 'Group by Category'
        AllowAllUp = True
        Caption = 'ToolButton1'
        Down = True
        Grouped = True
        ImageIndex = 0
        Style = tbsCheck
        OnClick = ToolButton1Click
      end
      object ToolButton2: TToolButton
        Left = 23
        Top = 0
        Hint = 'Group by Empty Not Empty Value'
        AllowAllUp = True
        Caption = 'ToolButton2'
        Grouped = True
        ImageIndex = 1
        Style = tbsCheck
        OnClick = ToolButton2Click
      end
      object ToolButton3: TToolButton
        Left = 46
        Top = 0
        Hint = 'Group by Data Type'
        AllowAllUp = True
        Caption = 'ToolButton3'
        Grouped = True
        ImageIndex = 2
        Style = tbsCheck
        OnClick = ToolButton3Click
      end
      object ToolButton4: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object tbVerGridSorted: TToolButton
        Left = 77
        Top = 0
        Hint = 'Sort Alphabetically'
        AllowAllUp = True
        Caption = 'tbVerGridSorted'
        Grouped = True
        ImageIndex = 3
        Style = tbsCheck
        OnClick = tbVerGridSortedClick
      end
      object ToolButton6: TToolButton
        Left = 100
        Top = 0
        Width = 8
        Caption = 'ToolButton6'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object ToolButton5: TToolButton
        Left = 108
        Top = 0
        Caption = 'ToolButton5'
        ImageIndex = 4
        OnClick = ToolButton5Click
      end
      object ToolButton7: TToolButton
        Left = 131
        Top = 0
        Caption = 'ToolButton7'
        ImageIndex = 5
        OnClick = ToolButton7Click
      end
    end
    object DBVertGridEh1: TDBVertGridEh
      Left = 0
      Top = 28
      Width = 272
      Height = 421
      Align = alClient
      RowCategories.Active = True
      RowCategories.CategoryProps = <
        item
          Name = 'Code'
          DefaultExpanded = True
        end
        item
          Name = 'Main Data'
          DefaultExpanded = True
        end
        item
          Name = 'Location'
          DefaultExpanded = True
        end
        item
          Name = 'Rest data'
        end>
      RowCategories.ExpandingGlyphStyle = tvgsThemedEh
      RowCategories.RowMoveOptions = [crmoFieldRowMoveToOtherCategoryEh, crmoCategoryRowMove]
      Ctl3D = False
      DataColParams.MaxRowHeight = 2
      DataColParams.MaxRowLines = 3
      DataSource = DataSource1
      DrawGraphicData = True
      DrawMemoText = True
      Flat = True
      Options = [dgvhEditing, dgvhLabelCol, dgvhRowMove, dgvhColLines, dgvhRowLines, dgvhTabs, dgvhConfirmDelete, dgvhCancelOnExit]
      ParentCtl3D = False
      RowsDefValues.FitRowHeightToData = True
      TabOrder = 1
      LabelColWidth = 118
      Rows = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'gname'
          CategoryName = 'Main Data'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'latitude'
          CategoryName = 'Location'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'geonameid'
          CategoryName = 'Main Data'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'asciiname'
          CategoryName = 'Main Data'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'longitude'
          CategoryName = 'Location'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'feature_class'
          CategoryName = 'Code'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'feature_code'
          CategoryName = 'Code'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'country_code'
          CategoryName = 'Code'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'cc2'
          CategoryName = 'Code'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'admin1_code'
          CategoryName = 'Code'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'admin2_code'
          CategoryName = 'Code'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'admin3_code'
          CategoryName = 'Code'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'admin4_code'
          CategoryName = 'Code'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'population'
          CategoryName = 'Rest data'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'elevation'
          CategoryName = 'Rest data'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'dem'
          CategoryName = 'Rest data'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'timezone'
          CategoryName = 'Rest data'
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'modification_date'
          CategoryName = 'Rest data'
        end
        item
          Checkboxes = True
          DynProps = <>
          EditButtons = <>
          FieldName = 'is_checked'
          KeyList.Strings = (
            'Y'
            'N')
          CategoryName = 'Rest data'
        end>
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 292
    Height = 449
    Align = alClient
    DataGrouping.Active = True
    DataGrouping.GroupPanelVisible = True
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorParams.RecNoShowStep = 5
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghFitRowHeightToText, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
    RowHeight = 2
    RowLines = 1
    RowSizingAllowed = True
    TabOrder = 1
    TreeViewParams.GlyphStyle = tvgsExplorerThemedEh
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'geonameid'
        Footers = <>
      end
      item
        Checkboxes = False
        DynProps = <>
        EditButtons = <>
        FieldName = 'is_checked'
        Footers = <>
        Width = 19
      end
      item
        Checkboxes = True
        DynProps = <>
        EditButtons = <>
        FieldName = 'is_checked'
        Footers = <>
        KeyList.Strings = (
          'Y'
          'N')
        Width = 19
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'gname'
        Footers = <>
        Width = 80
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'asciiname'
        Footers = <>
        Width = 104
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'latitude'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'longitude'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'feature_class'
        Footers = <>
        Width = 16
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'feature_code'
        Footers = <>
        Width = 56
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'country_code'
        Footers = <>
        Width = 40
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'cc2'
        Footers = <>
        Width = 31
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin1_code'
        Footers = <>
        Width = 42
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin2_code'
        Footers = <>
        Width = 47
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin3_code'
        Footers = <>
        Width = 49
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin4_code'
        Footers = <>
        Width = 44
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'population'
        Footers = <>
        Width = 45
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'elevation'
        Footers = <>
        Width = 30
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'dem'
        Footers = <>
        Width = 47
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'timezone'
        Footers = <>
        Width = 86
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'modification_date'
        Footers = <>
        Width = 63
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object MemTableEh2: TMemTableEh
    Active = True
    CachedUpdates = True
    FieldDefs = <
      item
        Name = 'geonameid'
        DataType = ftInteger
        Precision = 15
      end
      item
        Name = 'gname'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'asciiname'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'latitude'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'longitude'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'feature_class'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'feature_code'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'country_code'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'cc2'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'admin1_code'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'admin2_code'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'admin3_code'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'admin4_code'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'population'
        DataType = ftInteger
        Precision = 15
      end
      item
        Name = 'elevation'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'dem'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'timezone'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'modification_date'
        DataType = ftDateTime
      end
      item
        Name = 'is_checked'
        DataType = ftString
        Size = 1
      end>
    FetchAllOnOpen = True
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 72
    Top = 360
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object geonameid: TMTNumericDataFieldEh
          FieldName = 'geonameid'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'geonameid'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object gname: TMTStringDataFieldEh
          FieldName = 'gname'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'gname'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object asciiname: TMTStringDataFieldEh
          FieldName = 'asciiname'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'asciiname'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object latitude: TMTNumericDataFieldEh
          FieldName = 'latitude'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'latitude'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object longitude: TMTNumericDataFieldEh
          FieldName = 'longitude'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'longitude'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object feature_class: TMTStringDataFieldEh
          FieldName = 'feature_class'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'feature_class'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object feature_code: TMTStringDataFieldEh
          FieldName = 'feature_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'feature_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object country_code: TMTStringDataFieldEh
          FieldName = 'country_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'country_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object cc2: TMTStringDataFieldEh
          FieldName = 'cc2'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'cc2'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object admin1_code: TMTStringDataFieldEh
          FieldName = 'admin1_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'admin1_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object admin2_code: TMTStringDataFieldEh
          FieldName = 'admin2_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'admin2_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object admin3_code: TMTStringDataFieldEh
          FieldName = 'admin3_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'admin3_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object admin4_code: TMTStringDataFieldEh
          FieldName = 'admin4_code'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'admin4_code'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object population: TMTNumericDataFieldEh
          FieldName = 'population'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'population'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object elevation: TMTStringDataFieldEh
          FieldName = 'elevation'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'elevation'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object dem: TMTStringDataFieldEh
          FieldName = 'dem'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'dem'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object timezone: TMTStringDataFieldEh
          FieldName = 'timezone'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'timezone'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object modification_date: TMTDateTimeDataFieldEh
          FieldName = 'modification_date'
          DateTimeDataType = fdtDateTimeEh
          DisplayLabel = 'modification_date'
          DisplayWidth = 18
        end
        object is_checked: TMTStringDataFieldEh
          FieldName = 'is_checked'
          StringDataType = fdtStringEh
          DisplayWidth = 1
          Size = 1
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            2960
            #145'Ayn '#7720'al'#257'q'#299'm'
            '`Ayn Halaqim'
            34.940080000000000000
            36.321910000000000000
            'P'
            'PPLA3'
            'SY'
            nil
            '10'
            nil
            nil
            nil
            0
            nil
            '610'
            'Asia/Damascus'
            40924d
            'Y')
          (
            5174
            #145'Ar'#299'qah'
            '`Ariqah'
            32.889810000000000000
            36.483360000000000000
            'P'
            'PPLA3'
            'SY'
            nil
            '05'
            nil
            nil
            nil
            0
            nil
            '804'
            'Asia/Damascus'
            40924d
            'Y')
          (
            12795
            'A'#351' '#350'awarah a'#351' '#350'ughr'#225
            'As Sawarah as Sughra'
            33.032670000000000000
            36.573870000000000000
            'P'
            'PPLA3'
            'SY'
            nil
            '05'
            nil
            nil
            nil
            0
            nil
            '737'
            'Asia/Damascus'
            40924d
            'Y')
          (
            14256
            #256'z'#257'dshahr'
            'Azadshahr'
            34.790880000000000000
            48.570730000000000000
            'P'
            'PPL'
            'IR'
            nil
            '09'
            nil
            nil
            nil
            514102
            nil
            '1854'
            'Asia/Tehran'
            40924d
            'N')
          (
            18918
            'Protaras'
            'Protaras'
            35.012500000000000000
            34.058330000000000000
            'P'
            'PPL'
            'CY'
            nil
            '01'
            nil
            nil
            nil
            20230
            nil
            '9'
            'Asia/Nicosia'
            39743d
            'N')
          (
            23814
            'Kahr'#299'z'
            'Kahriz'
            34.383800000000000000
            47.055300000000000000
            'P'
            'PPL'
            'IR'
            nil
            '13'
            nil
            nil
            nil
            766706
            nil
            '1302'
            'Asia/Tehran'
            40924d
            'N')
          (
            24851
            'N'#363'r'#257'b'#257'd'
            'Nurabad'
            34.073400000000000000
            47.972499999999990000
            'P'
            'PPL'
            'IR'
            nil
            '23'
            nil
            nil
            nil
            73528
            nil
            '1790'
            'Asia/Tehran'
            40924d
            nil)
          (
            30485
            'Da'#7721'asuways'
            'Dahasuways'
            15.723890000000000000
            50.729439999999990000
            'P'
            'PPLA2'
            'YE'
            nil
            '03'
            '2806'
            nil
            nil
            0
            nil
            '268'
            'Asia/Aden'
            40924d
            nil)
          (
            30490
            'Ash Shi'#7721'r'
            'Ash Shihr'
            14.758630000000000000
            49.606390000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1915'
            nil
            nil
            0
            nil
            '14'
            'Asia/Aden'
            40924d
            nil)
          (
            30543
            'Al Ghaylah'
            'Al Ghaylah'
            14.595830000000000000
            45.583329999999990000
            'P'
            'PPLA2'
            'YE'
            nil
            '20'
            '1402'
            nil
            nil
            0
            nil
            '1754'
            'Asia/Aden'
            40924d
            nil)
          (
            30616
            'Judaydah'
            'Judaydah'
            15.075120000000000000
            45.299620000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '14'
            '2607'
            nil
            nil
            0
            nil
            '1256'
            'Asia/Aden'
            40924d
            nil)
          (
            30689
            #7696'awr'#257'n'
            'Dawran'
            13.774360000000000000
            44.441960000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '18'
            '3009'
            nil
            nil
            0
            nil
            '1787'
            'Asia/Aden'
            40924d
            nil)
          (
            30696
            'Najd al Jum'#257#145#299
            'Najd al Juma`i'
            13.915810000000000000
            44.324140000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1114'
            nil
            nil
            0
            nil
            '1978'
            'Asia/Aden'
            40924d
            nil)
          (
            30714
            'Z'#807'almat al '#145'Aly'#257
            'Zalmat al `Alya'
            14.102300000000000000
            44.094040000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1108'
            nil
            nil
            0
            nil
            '2145'
            'Asia/Aden'
            40924d
            nil)
          (
            30729
            'S'#363'q ar Rab'#363#145
            'Suq ar Rabu`'
            14.511550000000000000
            44.015110000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '11'
            '2005'
            nil
            nil
            0
            nil
            '2032'
            'Asia/Aden'
            40924d
            nil)
          (
            30735
            'Ash Shuqayrah'
            'Ash Shuqayrah'
            13.134520000000000000
            43.786360000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1516'
            nil
            nil
            0
            nil
            '656'
            'Asia/Aden'
            40924d
            nil)
          (
            30740
            'Mashra'#8216'ah'
            'Mashra`ah'
            13.532350000000000000
            43.995880000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1510'
            nil
            nil
            0
            nil
            '2208'
            'Asia/Aden'
            40924d
            nil)
          (
            30748
            'Ar Rawnah'
            'Ar Rawnah'
            13.756380000000000000
            43.802860000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1504'
            nil
            nil
            0
            nil
            '1410'
            'Asia/Aden'
            40924d
            nil)
          (
            30762
            'Ar Ram'#257'd'#299
            'Ar Ramadi'
            13.956410000000000000
            43.784570000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1110'
            nil
            nil
            0
            nil
            '1173'
            'Asia/Aden'
            40924d
            nil)
          (
            30777
            'Al A'#7721'ad'
            'Al Ahad'
            14.258330000000000000
            43.641670000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '11'
            '2007'
            nil
            nil
            0
            nil
            '1240'
            'Asia/Aden'
            40924d
            nil)
          (
            30788
            'A'#7697' '#7696'il'#145
            'Ad Dil`'
            14.671990000000000000
            43.818280000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '27'
            '3103'
            nil
            nil
            0
            nil
            '2026'
            'Asia/Aden'
            40924d
            nil)
          (
            30789
            'Al Jab'#299'n'
            'Al Jabin'
            14.704010000000000000
            43.599040000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '27'
            '3102'
            nil
            nil
            0
            nil
            '2427'
            'Asia/Aden'
            40924d
            nil)
          (
            32723
            #298'stg'#257'h-e Garms'#257'r'
            'Istgah-e Garmsar'
            35.234550000000000000
            52.309420000000000000
            'P'
            'PPL'
            'IR'
            nil
            '25'
            nil
            nil
            nil
            49491
            nil
            '848'
            'Asia/Tehran'
            40924d
            nil)
          (
            32767
            'Qarchak'
            'Qarchak'
            35.439440000000000000
            51.568890000000010000
            'P'
            'PPL'
            'IR'
            nil
            '26'
            nil
            nil
            nil
            251834
            nil
            '967'
            'Asia/Tehran'
            40924d
            nil)
          (
            34703
            'S'#363'q '#350'irw'#257#7721
            'Suq Sirwah'
            15.454170000000000000
            45.016670000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '14'
            '2606'
            nil
            nil
            0
            nil
            '1477'
            'Asia/Aden'
            40924d
            nil)
          (
            34717
            'Majzar'
            'Majzar'
            15.850000000000000000
            44.775000000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '14'
            '2601'
            nil
            nil
            0
            nil
            '1206'
            'Asia/Aden'
            40924d
            nil)
          (
            34724
            'Bidbadah'
            'Bidbadah'
            15.425000000000000000
            44.700000000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '14'
            '2605'
            nil
            nil
            0
            nil
            '2099'
            'Asia/Aden'
            40924d
            nil)
          (
            34821
            'Matwa'#7721
            'Matwah'
            15.067600000000000000
            43.642130000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '16'
            '2311'
            nil
            nil
            0
            nil
            '2152'
            'Asia/Aden'
            40924d
            nil)
          (
            34827
            #350'uwayr'
            'Suwayr'
            16.181800000000000000
            43.609860000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2907'
            nil
            nil
            0
            nil
            '1269'
            'Asia/Aden'
            40924d
            nil)
          (
            34846
            'Wa'#7697'arah'
            'Wadarah'
            15.710730000000000000
            43.483210000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1723'
            nil
            nil
            0
            nil
            '1316'
            'Asia/Aden'
            40924d
            nil)
          (
            34862
            'S'#363'q Shamar'
            'Suq Shamar'
            15.885000000000000000
            43.368060000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1713'
            nil
            nil
            0
            nil
            '1177'
            'Asia/Aden'
            40924d
            nil)
          (
            34886
            'Mustab'#257#146
            'Mustaba'#39
            16.228160000000000000
            43.248950000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1706'
            nil
            nil
            0
            nil
            '247'
            'Asia/Aden'
            40940d
            nil)
          (
            34888
            'An Naz'#807#299'r'
            'An Nazir'
            16.909160000000000000
            43.262260000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '15'
            '2205'
            nil
            nil
            0
            nil
            '1782'
            'Asia/Aden'
            40940d
            nil)
          (
            41210
            'Khorram Darreh'
            'Khorram Darreh'
            36.213000000000000000
            49.196000000000000000
            'P'
            'PPL'
            'IR'
            nil
            '36'
            nil
            nil
            nil
            50528
            nil
            '1590'
            'Asia/Tehran'
            40924d
            nil)
          (
            49593
            'Yeed'
            'Yeed'
            4.550000000000000000
            43.033330000000000000
            'P'
            'PPL'
            'SO'
            nil
            '01'
            nil
            nil
            nil
            8429
            nil
            '355'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            49747
            'Xuddur'
            'Xuddur'
            4.121290000000000000
            43.889449999999990000
            'P'
            'PPLA'
            'SO'
            nil
            '01'
            nil
            nil
            nil
            0
            nil
            '493'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            50064
            'Xarardheere'
            'Xarardheere'
            4.654400000000000000
            47.857500000000000000
            'P'
            'PPL'
            'SO'
            nil
            '10'
            nil
            nil
            nil
            2018
            nil
            '226'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            50672
            'Wanlaweyn'
            'Wanlaweyn'
            2.618500000000000000
            44.893800000000000000
            'P'
            'PPL'
            'SO'
            nil
            '14'
            nil
            nil
            nil
            22022
            nil
            '93'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            50814
            'Waajid'
            'Waajid'
            3.809580000000000000
            43.246280000000000000
            'P'
            'PPL'
            'SO'
            nil
            '01'
            nil
            nil
            nil
            6666
            nil
            '381'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            51299
            'Tayeeglow'
            'Tayeeglow'
            4.018970000000001000
            44.511120000000000000
            'P'
            'PPL'
            'SO'
            nil
            '01'
            nil
            nil
            nil
            2119
            nil
            '410'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            52381
            'Saacow'
            'Saacow'
            1.627940000000000000
            42.440660000000000000
            'P'
            'PPL'
            'SO'
            nil
            '08'
            nil
            nil
            nil
            7893
            nil
            '57'
            'Africa/Mogadishu'
            40967d
            nil)
          (
            52867
            'Qoryooley'
            'Qoryooley'
            1.787840000000000000
            44.529990000000000000
            'P'
            'PPLA2'
            'SO'
            nil
            '14'
            nil
            nil
            nil
            51720
            nil
            '69'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            53157
            'Qandala'
            'Qandala'
            11.471970000000000000
            49.872820000000000000
            'P'
            'PPL'
            'SO'
            nil
            '03'
            nil
            nil
            nil
            15923
            nil
            '8'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            53372
            'Oodweyne'
            'Oodweyne'
            9.409200000000000000
            45.063970000000000000
            'P'
            'PPL'
            'SO'
            nil
            '19'
            nil
            nil
            nil
            5491
            nil
            '1055'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            53654
            'Mogadishu'
            'Mogadishu'
            2.037110000000000000
            45.343750000000000000
            'P'
            'PPLC'
            'SO'
            nil
            '02'
            nil
            nil
            nil
            2587183
            nil
            '12'
            'Africa/Mogadishu'
            40328d
            nil)
          (
            54225
            'Marka'
            'Marka'
            1.715940000000000000
            44.771660000000000000
            'P'
            'PPLA'
            'SO'
            nil
            '14'
            nil
            nil
            nil
            0
            nil
            '12'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            54460
            'Mahaddayweyne'
            'Mahaddayweyne'
            2.972600000000000000
            45.534700000000000000
            'P'
            'PPL'
            'SO'
            nil
            '13'
            nil
            nil
            nil
            8273
            nil
            '114'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            54715
            'Luuq'
            'Luuq'
            3.793760000000000000
            42.544500000000000000
            'P'
            'PPL'
            'SO'
            nil
            '06'
            nil
            nil
            nil
            33820
            nil
            '152'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            54746
            'Lughaye'
            'Lughaye'
            10.685730000000000000
            43.943970000000000000
            'P'
            'PPLA2'
            'SO'
            nil
            '21'
            nil
            nil
            nil
            0
            nil
            '9'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            55223
            'Laasqoray'
            'Laasqoray'
            11.159500000000000000
            48.196700000000000000
            'P'
            'PPLA2'
            'SO'
            nil
            '12'
            nil
            nil
            nil
            6941
            nil
            '6'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            55671
            'Kismaayo'
            'Kismaayo'
            -0.358170000000000000
            42.545360000000000000
            'P'
            'PPLA'
            'SO'
            nil
            '09'
            nil
            nil
            nil
            234852
            nil
            '11'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            56166
            'Jilib'
            'Jilib'
            0.488290000000000000
            42.785350000000000000
            'P'
            'PPL'
            'SO'
            nil
            '08'
            nil
            nil
            nil
            43694
            nil
            '25'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            56335
            'Jawhar'
            'Jawhar'
            2.780870000000000000
            45.500480000000000000
            'P'
            'PPLA'
            'SO'
            nil
            '13'
            nil
            nil
            nil
            47086
            nil
            '108'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            56399
            'Jamaame'
            'Jamaame'
            0.069680000000000000
            42.744970000000000000
            'P'
            'PPL'
            'SO'
            nil
            '09'
            nil
            nil
            nil
            185270
            nil
            '12'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            56414
            'Jalalaqsi'
            'Jalalaqsi'
            3.376600000000000000
            45.599600000000000000
            'P'
            'PPL'
            'SO'
            nil
            '07'
            nil
            nil
            nil
            9743
            nil
            '129'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            56505
            'Iskushuban'
            'Iskushuban'
            10.283700000000000000
            50.230000000000000000
            'P'
            'PPL'
            'SO'
            nil
            '03'
            nil
            nil
            nil
            5759
            nil
            '278'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            57000
            'Hobyo'
            'Hobyo'
            5.350500000000000000
            48.526800000000000000
            'P'
            'PPLA2'
            'SO'
            nil
            '10'
            nil
            nil
            nil
            12564
            nil
            '5'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            57289
            'Hargeysa'
            'Hargeysa'
            9.560000000000000000
            44.065000000000000000
            'P'
            'PPLA'
            'SO'
            nil
            '20'
            nil
            nil
            nil
            477876
            nil
            '1261'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            58933
            'Garoowe'
            'Garoowe'
            8.405360000000000000
            48.484460000000000000
            'P'
            'PPLA'
            'SO'
            nil
            '18'
            nil
            nil
            nil
            0
            nil
            '466'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            58994
            'Garbahaarrey'
            'Garbahaarrey'
            3.328920000000000000
            42.220910000000010000
            'P'
            'PPLA'
            'SO'
            nil
            '06'
            nil
            nil
            nil
            12652
            nil
            '222'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            59611
            'Gaalkacyo'
            'Gaalkacyo'
            6.769720000000000000
            47.430830000000000000
            'P'
            'PPLA'
            'SO'
            nil
            '10'
            nil
            nil
            nil
            61200
            nil
            '288'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            60019
            'Eyl'
            'Eyl'
            7.980300000000000000
            49.816400000000000000
            'P'
            'PPL'
            'SO'
            nil
            '18'
            nil
            nil
            nil
            18904
            nil
            '47'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            60457
            'Dujuuma'
            'Dujuuma'
            1.253110000000000000
            42.573770000000010000
            'P'
            'PPL'
            'SO'
            nil
            '08'
            nil
            nil
            nil
            2432
            nil
            '59'
            'Africa/Mogadishu'
            40967d
            nil)
          (
            60928
            'Dusa Marreb'
            'Dusa Marreb'
            5.535000000000000000
            46.386110000000000000
            'P'
            'PPLX'
            'SO'
            nil
            '05'
            nil
            nil
            nil
            9000
            nil
            '254'
            'Africa/Mogadishu'
            40941d
            nil)
          (
            62691
            'Ceerigaabo'
            'Ceerigaabo'
            10.616160000000000000
            47.367950000000000000
            'P'
            'PPLA'
            'SO'
            nil
            '12'
            nil
            nil
            nil
            33853
            nil
            '1786'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            62788
            'Ceeldheer'
            'Ceeldheer'
            3.848780000000000000
            47.180640000000000000
            'P'
            'PPL'
            'SO'
            nil
            '05'
            nil
            nil
            nil
            26562
            nil
            '20'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            62821
            'Ceelbuur'
            'Ceelbuur'
            4.685010000000000000
            46.617600000000000000
            'P'
            'PPL'
            'SO'
            nil
            '05'
            nil
            nil
            nil
            9031
            nil
            '153'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            62854
            'Ceek'
            'Ceek'
            8.999070000000000000
            45.358240000000000000
            'P'
            'PPL'
            'SO'
            nil
            '19'
            nil
            nil
            nil
            4325
            nil
            '865'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            63344
            'Cadale'
            'Cadale'
            2.760300000000000000
            46.322200000000000000
            'P'
            'PPL'
            'SO'
            nil
            '13'
            nil
            nil
            nil
            5385
            nil
            '7'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            63571
            'Buurhakaba'
            'Buurhakaba'
            2.802570000000000000
            44.078060000000000000
            'P'
            'PPLA2'
            'SO'
            nil
            '04'
            nil
            nil
            nil
            27792
            nil
            '277'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            63580
            'Buur Gaabo'
            'Buur Gaabo'
            -1.219330000000000000
            41.837359999999990000
            'P'
            'PPL'
            'SO'
            nil
            '09'
            nil
            nil
            nil
            3096
            nil
            '254'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            63689
            'Buulobarde'
            'Buulobarde'
            3.853750000000000000
            45.567440000000000000
            'P'
            'PPL'
            'SO'
            nil
            '07'
            nil
            nil
            nil
            16928
            nil
            '150'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            63795
            'Burco'
            'Burco'
            9.522119999999999000
            45.533630000000000000
            'P'
            'PPLA'
            'SO'
            nil
            '19'
            nil
            nil
            nil
            99270
            nil
            '1041'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            63949
            'Bu'#8217'aale'
            'Bu'#39'aale'
            1.083330000000000000
            42.583329999999990000
            'P'
            'PPLA'
            'SO'
            nil
            '08'
            nil
            nil
            nil
            0
            nil
            '44'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            64013
            'Boosaaso'
            'Boosaaso'
            11.284210000000000000
            49.181579999999990000
            'P'
            'PPLA'
            'SO'
            nil
            '03'
            nil
            nil
            nil
            74287
            nil
            '12'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            64412
            'Bereeda'
            'Bereeda'
            11.870370000000000000
            51.057950000000000000
            'P'
            'PPL'
            'SO'
            nil
            '03'
            nil
            nil
            nil
            11262
            nil
            '10'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            64435
            'Berbera'
            'Berbera'
            10.439590000000000000
            45.014320000000000000
            'P'
            'PPL'
            'SO'
            nil
            '20'
            nil
            nil
            nil
            242344
            nil
            '11'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            64460
            'Beledweyne'
            'Beledweyne'
            4.735830000000000000
            45.203610000000000000
            'P'
            'PPLA'
            'SO'
            nil
            '07'
            nil
            nil
            nil
            55410
            nil
            '182'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            64536
            'Baydhabo'
            'Baydhabo'
            3.113830000000000000
            43.649800000000000000
            'P'
            'PPLA'
            'SO'
            nil
            '04'
            nil
            nil
            nil
            129839
            nil
            '441'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            64670
            'Bargaal'
            'Bargaal'
            11.286360000000000000
            51.077300000000000000
            'P'
            'PPL'
            'SO'
            nil
            '03'
            nil
            nil
            nil
            6798
            nil
            '6'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            64814
            'Bandarbeyla'
            'Bandarbeyla'
            9.494199999999999000
            50.812200000000000000
            'P'
            'PPL'
            'SO'
            nil
            '03'
            nil
            nil
            nil
            13753
            nil
            '29'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            65170
            'Baardheere'
            'Baardheere'
            2.344640000000000000
            42.276440000000000000
            'P'
            'PPLL'
            'SO'
            nil
            '06'
            nil
            nil
            nil
            42240
            nil
            '97'
            'Africa/Mogadishu'
            38744d
            nil)
          (
            65785
            'Afgooye'
            'Afgooye'
            2.138100000000000000
            45.121200000000000000
            'P'
            'PPLA2'
            'SO'
            nil
            '14'
            nil
            nil
            nil
            65461
            nil
            '87'
            'Africa/Mogadishu'
            40924d
            nil)
          (
            66093
            'Y'#257's'#363'j'
            'Yasuj'
            30.668240000000000000
            51.587960000000000000
            'P'
            'PPLA'
            'IR'
            nil
            '05'
            nil
            nil
            nil
            0
            nil
            '1841'
            'Asia/Tehran'
            40924d
            nil)
          (
            69372
            'A'#355' '#354'aw'#299'lah'
            'At Tawilah'
            15.493890000000000000
            43.747780000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '10'
            '2702'
            nil
            nil
            0
            nil
            '2603'
            'Asia/Aden'
            40924d
            nil)
          (
            69426
            'Zinjib'#257'r'
            'Zinjibar'
            13.128710000000000000
            45.380730000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '01'
            '1210'
            nil
            nil
            0
            nil
            '20'
            'Asia/Aden'
            40924d
            nil)
          (
            69457
            'Zar'#257'jah'
            'Zarajah'
            14.866920000000000000
            44.378680000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '11'
            '2001'
            nil
            nil
            0
            nil
            '2380'
            'Asia/Aden'
            40924d
            nil)
          (
            69482
            'Az Z'#257'hir'
            'Az Zahir'
            13.966670000000000000
            45.483330000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '20'
            '1405'
            nil
            nil
            0
            nil
            '2056'
            'Asia/Aden'
            40924d
            nil)
          (
            69500
            'Zab'#299'd'
            'Zabid'
            14.195100000000000000
            43.315180000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1824'
            nil
            nil
            52590
            nil
            '114'
            'Asia/Aden'
            40924d
            nil)
          (
            69537
            'Yufrus'
            'Yufrus'
            13.455290000000000000
            43.947040000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1509'
            nil
            nil
            0
            nil
            '1261'
            'Asia/Aden'
            40924d
            nil)
          (
            69559
            'Yar'#299'm'
            'Yarim'
            14.298040000000000000
            44.377950000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1102'
            nil
            nil
            33050
            nil
            '2626'
            'Asia/Aden'
            40924d
            nil)
          (
            69640
            'Wash'#7721'ah'
            'Washhah'
            16.307740000000000000
            43.410660000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1730'
            nil
            nil
            0
            nil
            '1514'
            'Asia/Aden'
            40924d
            nil)
          (
            69684
            'Wa'#145'l'#257'n'
            'Wa`lan'
            15.070210000000000000
            44.276410000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '16'
            '2306'
            nil
            nil
            0
            nil
            '2449'
            'Asia/Aden'
            40924d
            nil)
          (
            69686
            'Dh'#299' Jal'#257'l'
            'Dhi Jalal'
            13.623780000000000000
            44.707540000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '18'
            '3008'
            nil
            nil
            0
            nil
            '1219'
            'Asia/Aden'
            40924d
            nil)
          (
            69769
            #145'Usayl'#257'n'
            '`Usaylan'
            15.032010000000000000
            45.828320000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2105'
            nil
            nil
            0
            nil
            '1036'
            'Asia/Aden'
            40924d
            nil)
          (
            69944
            #145'Ub'#257'l'
            '`Ubal'
            14.988080000000000000
            43.544440000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1811'
            nil
            nil
            0
            nil
            '494'
            'Asia/Aden'
            40924d
            nil)
          (
            70080
            'Tham'#363'd'
            'Thamud'
            17.300000000000000000
            49.916670000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1902'
            nil
            nil
            0
            nil
            '654'
            'Asia/Aden'
            40924d
            nil)
          (
            70160
            'Tar'#299'm'
            'Tarim'
            16.056940000000000000
            48.998890000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1911'
            nil
            nil
            0
            nil
            '617'
            'Asia/Aden'
            40924d
            nil)
          (
            70225
            'Ta'#8216'izz'
            'Ta`izz'
            13.579520000000000000
            44.020910000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '25'
            '1520'
            nil
            nil
            615222
            '1400'
            '1316'
            'Asia/Aden'
            40924d
            nil)
          (
            70272
            'As Suwayd'#257
            'As Suwayda'
            13.786940000000000000
            45.230400000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '24'
            '2504'
            nil
            nil
            0
            nil
            '1529'
            'Asia/Aden'
            40940d
            nil)
          (
            70346
            'Al '#145'An'#257'n'
            'Al `Anan'
            16.721880000000000000
            44.312520000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '21'
            '1610'
            nil
            nil
            100
            nil
            '2131'
            'Asia/Aden'
            40924d
            nil)
          (
            70357
            #8216'Abs'
            '`Abs'
            16.002950000000000000
            43.197240000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1704'
            nil
            nil
            0
            nil
            '194'
            'Asia/Aden'
            40940d
            nil)
          (
            70551
            #350#299'f'
            'Sif'
            15.313890000000000000
            48.330000000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1918'
            nil
            nil
            0
            nil
            '1009'
            'Asia/Aden'
            40924d
            nil)
          (
            70656
            'Shi'#7721'an as Sufl'#225
            'Shihan as Sufla'
            17.769990000000000000
            52.489250000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '03'
            '2801'
            nil
            nil
            0
            nil
            '545'
            'Asia/Aden'
            40924d
            nil)
          (
            70677
            'Shib'#257'm'
            'Shibam'
            15.509430000000000000
            43.904450000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '10'
            '2701'
            nil
            nil
            0
            nil
            '2587'
            'Asia/Aden'
            40924d
            nil)
          (
            70759
            'Ash Sharyah'
            'Ash Sharyah'
            14.356590000000000000
            45.022440000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '20'
            '1419'
            nil
            nil
            0
            nil
            '2010'
            'Asia/Aden'
            40924d
            nil)
          (
            70808
            'Sharas'
            'Sharas'
            15.712330000000000000
            43.649250000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1719'
            nil
            nil
            0
            nil
            '1024'
            'Asia/Aden'
            40924d
            nil)
          (
            70910
            'Shah'#257'rat al Gh'#299's'
            'Shaharat al Ghis'
            16.184110000000000000
            43.702280000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2905'
            nil
            nil
            0
            nil
            '2518'
            'Asia/Aden'
            40924d
            nil)
          (
            70979
            'Sayy'#257'n'
            'Sayyan'
            15.171770000000000000
            44.324420000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '16'
            '2305'
            nil
            nil
            69404
            nil
            '2482'
            'Asia/Aden'
            40924d
            nil)
          (
            71005
            'Say'#7721#363't'
            'Sayhut'
            15.210560000000000000
            51.245560000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '03'
            '2807'
            nil
            nil
            0
            nil
            '8'
            'Asia/Aden'
            40924d
            nil)
          (
            71136
            #350'an'#257#146
            'Sana'#39
            15.400000000000000000
            47.766670000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1920'
            nil
            nil
            0
            nil
            '896'
            'Asia/Aden'
            40940d
            nil)
          (
            71137
            'Sanaa'
            'Sanaa'
            15.354720000000000000
            44.206670000000000000
            'P'
            'PPLC'
            'YE'
            nil
            '26'
            '1301'
            nil
            nil
            1937451
            nil
            '2253'
            'Asia/Aden'
            40924d
            nil)
          (
            71273
            'Sa'#7721'ar'
            'Sahar'
            15.315860000000000000
            44.308580000000000000
            'P'
            'PPL'
            'YE'
            nil
            '16'
            '2305'
            nil
            nil
            31859
            nil
            '2372'
            'Asia/Aden'
            40924d
            nil)
          (
            71282
            'S'#257'h'
            'Sah'
            15.577220000000000000
            48.850560000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1909'
            nil
            nil
            0
            nil
            '827'
            'Asia/Aden'
            40924d
            nil)
          (
            71334
            #350'a'#145'dah'
            'Sa`dah'
            16.940210000000000000
            43.763940000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '15'
            '2215'
            nil
            nil
            0
            nil
            '1876'
            'Asia/Aden'
            40924d
            nil)
          (
            71481
            'Ri'#7721#257'b'
            'Rihab'
            14.227620000000000000
            44.188140000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1101'
            nil
            nil
            0
            nil
            '1540'
            'Asia/Aden'
            40924d
            nil)
          (
            71491
            'Rad'#257#145
            'Rada`'
            14.415100000000000000
            44.837090000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '20'
            '1413'
            nil
            nil
            0
            nil
            '2125'
            'Asia/Aden'
            40924d
            nil)
          (
            71549
            'Ar Raydah'
            'Ar Raydah'
            15.035000000000000000
            50.479170000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1913'
            nil
            nil
            0
            nil
            '10'
            'Asia/Aden'
            40924d
            nil)
          (
            71558
            'Raydah'
            'Raydah'
            15.814210000000000000
            44.040850000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2911'
            nil
            nil
            0
            nil
            '2190'
            'Asia/Aden'
            40924d
            nil)
          (
            71687
            'Ru'#7697#363'm'
            'Rudum'
            14.085100000000000000
            47.743140000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2117'
            nil
            nil
            0
            nil
            '166'
            'Asia/Aden'
            40940d
            nil)
          (
            71799
            'Qulansiyah'
            'Qulansiyah'
            12.683330000000000000
            53.483330000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1927'
            nil
            nil
            3500
            nil
            '9'
            'Asia/Aden'
            40924d
            nil)
          (
            71834
            'Qishn'
            'Qishn'
            15.422780000000000000
            51.681390000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '03'
            '2808'
            nil
            nil
            0
            nil
            '7'
            'Asia/Aden'
            40924d
            nil)
          (
            71904
            'Qa'#145#355'abah'
            'Qa`tabah'
            13.854930000000000000
            44.705800000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '18'
            '3003'
            nil
            nil
            0
            nil
            '1331'
            'Asia/Aden'
            40924d
            nil)
          (
            72181
            'Ni'#351#257'b'
            'Nisab'
            14.516670000000000000
            46.500000000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2110'
            nil
            nil
            0
            nil
            '1078'
            'Asia/Aden'
            40924d
            nil)
          (
            72430
            'Al Musaym'#299'r'
            'Al Musaymir'
            13.443890000000000000
            44.615280000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '24'
            '2509'
            nil
            nil
            3
            nil
            '639'
            'Asia/Aden'
            40924d
            nil)
          (
            72519
            'Mukayr'#257's'
            'Mukayras'
            13.944280000000000000
            45.670740000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '20'
            '1408'
            nil
            nil
            0
            nil
            '2161'
            'Asia/Aden'
            40924d
            nil)
          (
            72557
            'M'#363'd'#299'yah'
            'Mudiyah'
            13.928400000000000000
            46.082540000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '01'
            '1202'
            nil
            nil
            0
            nil
            '843'
            'Asia/Aden'
            40940d
            nil)
          (
            72561
            'Markaz Mudhaykirah'
            'Markaz Mudhaykirah'
            13.889530000000000000
            43.968800000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1117'
            nil
            nil
            0
            nil
            '1806'
            'Asia/Aden'
            40924d
            nil)
          (
            72647
            'Manwakh'
            'Manwakh'
            16.807780000000000000
            48.109170000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1904'
            nil
            nil
            0
            nil
            '824'
            'Asia/Aden'
            40924d
            nil)
          (
            72746
            'Mayfa'#8216'ah'
            'Mayfa`ah'
            14.270420000000000000
            47.561200000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2116'
            nil
            nil
            0
            nil
            '414'
            'Asia/Aden'
            40940d
            nil)
          (
            72752
            'Maidi'
            'Maidi'
            16.321010000000000000
            42.812990000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1703'
            nil
            nil
            0
            nil
            '10'
            'Asia/Aden'
            40924d
            nil)
          (
            72760
            'Mawza'#8216
            'Mawza`'
            13.268310000000000000
            43.509930000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1508'
            nil
            nil
            0
            nil
            '202'
            'Asia/Aden'
            40924d
            nil)
          (
            72781
            'M'#257'wiyah'
            'Mawiyah'
            13.582940000000000000
            44.347680000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1501'
            nil
            nil
            0
            nil
            '1315'
            'Asia/Aden'
            40924d
            nil)
          (
            72855
            'Al Jawl'
            'Al Jawl'
            14.456250000000000000
            48.280660000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1924'
            nil
            nil
            0
            nil
            '349'
            'Asia/Aden'
            40924d
            nil)
          (
            73091
            'Man'#257'khah'
            'Manakhah'
            15.074220000000000000
            43.741560000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '16'
            '2310'
            nil
            nil
            0
            nil
            '2263'
            'Asia/Aden'
            40924d
            nil)
          (
            73100
            'Mil'#257#7721
            'Milah'
            14.416170000000000000
            44.786220000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '20'
            '1416'
            nil
            nil
            0
            nil
            '2177'
            'Asia/Aden'
            40924d
            nil)
          (
            73125
            'Al Mal'#257#7721#299#355
            'Al Malahit'
            16.768480000000000000
            43.275820000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '15'
            '2207'
            nil
            nil
            0
            nil
            '388'
            'Asia/Aden'
            40940d
            nil)
          (
            73325
            'Al M'#257'f'#363'd'
            'Al Mafud'
            15.342640000000000000
            47.252170000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2104'
            nil
            nil
            0
            nil
            '1054'
            'Asia/Aden'
            40924d
            nil)
          (
            73331
            'Maf'#7721'aq'
            'Mafhaq'
            15.101620000000000000
            43.903040000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '16'
            '2309'
            nil
            nil
            0
            nil
            '1646'
            'Asia/Aden'
            40924d
            nil)
          (
            73365
            'Al Mad'#299'd'
            'Al Madid'
            15.644530000000000000
            44.473370000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '16'
            '2303'
            nil
            nil
            0
            nil
            '2091'
            'Asia/Aden'
            40924d
            nil)
          (
            73409
            'Ma'#8216'bar'
            'Ma`bar'
            14.793950000000000000
            44.293540000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '11'
            '2002'
            nil
            nil
            0
            nil
            '2329'
            'Asia/Aden'
            40924d
            nil)
          (
            73422
            'Al Ma'#145'all'#257#146
            'Al Ma`alla'#39
            12.789870000000000000
            45.002440000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '02'
            '2406'
            nil
            nil
            0
            nil
            '13'
            'Asia/Aden'
            40924d
            nil)
          (
            73504
            'Lawdar'
            'Lawdar'
            13.882820000000000000
            45.868590000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '01'
            '1204'
            nil
            nil
            0
            nil
            '993'
            'Asia/Aden'
            40924d
            nil)
          (
            73560
            'La'#7721'ij'
            'Lahij'
            13.056670000000000000
            44.881940000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '24'
            '2514'
            nil
            nil
            23375
            nil
            '136'
            'Asia/Aden'
            40924d
            nil)
          (
            73638
            'Ku'#7721'l'#257'n '#145'Af'#257'r'
            'Kuhlan `Afar'
            15.733090000000000000
            43.719020000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1718'
            nil
            nil
            0
            nil
            '2368'
            'Asia/Aden'
            40924d
            nil)
          (
            73650
            'Ku'#8216'aydinah'
            'Ku`aydinah'
            15.821040000000000000
            43.337200000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1722'
            nil
            nil
            0
            nil
            '945'
            'Asia/Aden'
            40924d
            nil)
          (
            73668
            'Kit'#257'f'
            'Kitaf'
            17.031650000000000000
            44.109050000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '15'
            '2214'
            nil
            nil
            0
            nil
            '1953'
            'Asia/Aden'
            40924d
            nil)
          (
            73685
            'Kilmia'
            'Kilmia'
            12.185760000000000000
            52.233320000000000000
            'P'
            'PPL'
            'YE'
            nil
            '04'
            '1927'
            nil
            nil
            2013
            '85'
            '10'
            'Asia/Aden'
            40578d
            nil)
          (
            73786
            'Khawr Maksar'
            'Khawr Maksar'
            12.812270000000000000
            45.033370000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '02'
            '2408'
            nil
            nil
            0
            nil
            '6'
            'Asia/Aden'
            40924d
            nil)
          (
            73788
            'Khawrah'
            'Khawrah'
            14.432010000000000000
            46.154350000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2109'
            nil
            nil
            0
            nil
            '1199'
            'Asia/Aden'
            40924d
            nil)
          (
            73861
            'Khamir'
            'Khamir'
            15.987920000000000000
            43.953620000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2919'
            nil
            nil
            0
            nil
            '2465'
            'Asia/Aden'
            40924d
            nil)
          (
            74116
            'Juban'
            'Juban'
            14.011640000000000000
            44.874600000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '18'
            '3001'
            nil
            nil
            0
            nil
            '2056'
            'Asia/Aden'
            40924d
            nil)
          (
            74167
            'Ji'#7721#257'nah'
            'Jihanah'
            15.226280000000000000
            44.482440000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '16'
            '2316'
            nil
            nil
            0
            nil
            '2249'
            'Asia/Aden'
            40924d
            nil)
          (
            74185
            'Jiblah'
            'Jiblah'
            13.921620000000000000
            44.146680000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1112'
            nil
            nil
            0
            nil
            '2003'
            'Asia/Aden'
            40924d
            nil)
          (
            74219
            'Jawf al Maqb'#257'bah'
            'Jawf al Maqbabah'
            13.837830000000000000
            45.834880000000000000
            'P'
            'PPL'
            'YE'
            nil
            '01'
            '1204'
            nil
            nil
            14175
            nil
            '919'
            'Asia/Aden'
            40924d
            nil)
          (
            74368
            'Ja'#145#257'r'
            'Ja`ar'
            13.223000000000000000
            45.305580000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '01'
            '1211'
            nil
            nil
            0
            nil
            '71'
            'Asia/Aden'
            40924d
            nil)
          (
            74477
            'Ibb'
            'Ibb'
            13.966670000000000000
            44.183330000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '23'
            '1118'
            nil
            nil
            234837
            nil
            '1931'
            'Asia/Aden'
            40924d
            nil)
          (
            74490
            #7720#363'th'
            'Huth'
            16.231140000000000000
            43.968540000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2902'
            nil
            nil
            0
            nil
            '1889'
            'Asia/Aden'
            40924d
            nil)
          (
            74499
            'As Sal'#257'sil'
            'As Salasil'
            16.479590000000000000
            48.831530000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1903'
            nil
            nil
            0
            nil
            '1004'
            'Asia/Aden'
            40924d
            nil)
          (
            74785
            'Al '#8216'Abr'
            'Al `Abr'
            16.133330000000000000
            47.233330000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1906'
            nil
            nil
            0
            nil
            '951'
            'Asia/Aden'
            40924d
            nil)
          (
            74906
            #7720'ays'
            'Hays'
            13.931700000000000000
            43.483100000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1819'
            nil
            nil
            0
            nil
            '211'
            'Asia/Aden'
            40924d
            nil)
          (
            74938
            #7720'ayf'#257'n'
            'Hayfan'
            13.317780000000000000
            44.280110000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1517'
            nil
            nil
            0
            nil
            '1588'
            'Asia/Aden'
            40924d
            nil)
          (
            75000
            #7720'awf'
            'Hawf'
            16.633330000000000000
            53.033330000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '03'
            nil
            nil
            nil
            0
            nil
            '14'
            'Asia/Aden'
            40924d
            nil)
          (
            75034
            #7720'a'#351'wayn'
            'Haswayn'
            15.591940000000000000
            52.102220000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '03'
            '2809'
            nil
            nil
            0
            nil
            '10'
            'Asia/Aden'
            40924d
            nil)
          (
            75133
            #7720'ar'#299'b'
            'Harib'
            14.931560000000000000
            45.503560000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '14'
            '2609'
            nil
            nil
            0
            nil
            '1161'
            'Asia/Aden'
            40924d
            nil)
          (
            75163
            #7720'ara'#7697
            'Harad'
            16.409650000000000000
            43.058830000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1702'
            nil
            nil
            0
            nil
            '105'
            'Asia/Aden'
            40924d
            nil)
          (
            75239
            #7720'amm'#257'm '#145'Al'#299
            'Hammam `Ali'
            14.663710000000000000
            44.147630000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '11'
            '2012'
            nil
            nil
            0
            nil
            '1635'
            'Asia/Aden'
            40924d
            nil)
          (
            75337
            #7720'ajjah'
            'Hajjah'
            15.694250000000000000
            43.605820000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '22'
            '1728'
            nil
            nil
            43549
            nil
            '1795'
            'Asia/Aden'
            40924d
            nil)
          (
            75357
            'Mad'#299'nat Lab'#145#363's'
            'Madinat Lab`us'
            13.866670000000000000
            45.250000000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '24'
            '2502'
            nil
            nil
            0
            nil
            '2281'
            'Asia/Aden'
            40924d
            nil)
          (
            75427
            'Tamrida'
            'Tamrida'
            12.650000000000000000
            54.033330000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1926'
            nil
            nil
            8545
            nil
            '22'
            'Asia/Aden'
            40924d
            nil)
          (
            75504
            #7720'ab'#299'l al Jabr'
            'Habil al Jabr'
            13.604220000000000000
            44.985780000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '24'
            '2505'
            nil
            nil
            0
            nil
            '697'
            'Asia/Aden'
            40924d
            nil)
          (
            75508
            'Al '#7720'ab'#299'layn'
            'Al Habilayn'
            13.520020000000000000
            44.850760000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '24'
            '2507'
            nil
            nil
            0
            nil
            '630'
            'Asia/Aden'
            40924d
            nil)
          (
            75518
            #7720'abb'#257'n'
            'Habban'
            14.354110000000000000
            47.076490000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2114'
            nil
            nil
            0
            nil
            '973'
            'Asia/Aden'
            40924d
            nil)
          (
            75539
            #7720'ab'#257'bah'
            'Hababah'
            15.544180000000000000
            43.875630000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2917'
            nil
            nil
            0
            nil
            '2604'
            'Asia/Aden'
            40924d
            nil)
          (
            75618
            'Ghayl B'#257' Waz'#299'r'
            'Ghayl Ba Wazir'
            14.776110000000000000
            49.366110000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1917'
            nil
            nil
            0
            nil
            '87'
            'Asia/Aden'
            40924d
            nil)
          (
            76089
            'Dhub'#257'b'
            'Dhubab'
            12.943050000000000000
            43.410240000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1507'
            nil
            nil
            0
            nil
            '5'
            'Asia/Aden'
            40924d
            nil)
          (
            76125
            'Dh'#299' N'#257#145'im'
            'Dhi Na`im'
            14.105740000000000000
            45.448070000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '20'
            '1406'
            nil
            nil
            0
            nil
            '1956'
            'Asia/Aden'
            40924d
            nil)
          (
            76147
            'Dhayb'#299'n'
            'Dhaybin'
            15.977120000000000000
            44.129170000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2909'
            nil
            nil
            0
            nil
            '1876'
            'Asia/Aden'
            40924d
            nil)
          (
            76154
            'Dh'#299' as Suf'#257'l'
            'Dhi as Sufal'
            13.834460000000000000
            44.114690000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1116'
            nil
            nil
            37997
            nil
            '1857'
            'Asia/Aden'
            40924d
            nil)
          (
            76184
            'Dham'#257'r'
            'Dhamar'
            14.542740000000000000
            44.405140000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '11'
            '2008'
            nil
            nil
            0
            nil
            '2421'
            'Asia/Aden'
            40924d
            nil)
          (
            76362
            #7696'awr'#257'n ad Daydah'
            'Dawran ad Daydah'
            14.739270000000000000
            44.206640000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '11'
            '2011'
            nil
            nil
            0
            nil
            '2395'
            'Asia/Aden'
            40940d
            nil)
          (
            76482
            'D'#257'r an Na'#351'r'
            'Dar an Nasr'
            13.558210000000000000
            44.016340000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1511'
            nil
            nil
            0
            nil
            '1809'
            'Asia/Aden'
            40924d
            nil)
          (
            76699
            'Bur'#363'm'
            'Burum'
            14.363610000000000000
            48.979720000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1925'
            nil
            nil
            0
            nil
            '44'
            'Asia/Aden'
            40924d
            nil)
          (
            76927
            'Bayt '#145'Adh'#257'qah'
            'Bayt `Adhaqah'
            15.615760000000000000
            43.702280000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2916'
            nil
            nil
            0
            nil
            '2575'
            'Asia/Aden'
            40924d
            nil)
          (
            76930
            'As S'#363'q al Jad'#299'd'
            'As Suq al Jadid'
            15.824960000000000000
            44.062040000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2910'
            nil
            nil
            0
            nil
            '2190'
            'Asia/Aden'
            40924d
            nil)
          (
            76991
            'Bayt al Faq'#299'h'
            'Bayt al Faqih'
            14.516350000000000000
            43.324460000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1817'
            nil
            nil
            34204
            nil
            '151'
            'Asia/Aden'
            40924d
            nil)
          (
            77017
            'Bay'#7721#257'n'
            'Bayhan'
            14.800670000000000000
            45.718890000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2107'
            nil
            nil
            0
            '2'
            '1127'
            'Asia/Aden'
            40924d
            nil)
          (
            77278
            'Ban'#299' '#7720'ujj'#257'j'
            'Bani Hujjaj'
            15.416670000000000000
            43.316670000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '10'
            '2705'
            nil
            nil
            0
            nil
            '721'
            'Asia/Aden'
            40924d
            nil)
          (
            77307
            'Ban'#299' Bakr'
            'Bani Bakr'
            13.933330000000000000
            45.266670000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '24'
            '2501'
            nil
            nil
            0
            nil
            '2154'
            'Asia/Aden'
            40924d
            nil)
          (
            77408
            'B'#257'jil'
            'Bajil'
            15.058350000000000000
            43.285060000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1810'
            nil
            nil
            48218
            nil
            '191'
            'Asia/Aden'
            40924d
            nil)
          (
            77504
            'Az Zuhrah'
            'Az Zuhrah'
            15.723770000000000000
            42.995820000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1801'
            nil
            nil
            0
            nil
            '70'
            'Asia/Aden'
            40924d
            nil)
          (
            77515
            'Az Zayd'#299'yah'
            'Az Zaydiyah'
            15.328510000000000000
            43.008120000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1807'
            nil
            nil
            0
            nil
            '61'
            'Asia/Aden'
            40924d
            nil)
          (
            77529
            'Az Z'#257'hir'
            'Az Zahir'
            16.317990000000000000
            44.488180000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '21'
            '1604'
            nil
            nil
            0
            nil
            '1200'
            'Asia/Aden'
            40924d
            nil)
          (
            77594
            'Al '#7720'ajab'
            'Al Hajab'
            14.851920000000000000
            45.529040000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2106'
            nil
            nil
            0
            '2'
            '1203'
            'Asia/Aden'
            40924d
            nil)
          (
            77636
            'Al '#145'Aw'#257'bil'
            'Al `Awabil'
            13.837540000000000000
            44.864310000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '18'
            '3004'
            nil
            nil
            0
            nil
            '2058'
            'Asia/Aden'
            40924d
            nil)
          (
            77646
            'At Turbah'
            'At Turbah'
            13.212700000000000000
            44.124150000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1515'
            nil
            nil
            0
            nil
            '1877'
            'Asia/Aden'
            40924d
            nil)
          (
            77655
            'Al Tu'#7721'ayt'#257#146
            'Al Tuhayta'#39
            14.183560000000000000
            43.226370000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1826'
            nil
            nil
            0
            nil
            '64'
            'Asia/Aden'
            40924d
            nil)
          (
            77662
            'At Taw'#257'h'#299
            'At Tawahi'
            12.784710000000000000
            44.980200000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '02'
            '2405'
            nil
            nil
            0
            nil
            '33'
            'Asia/Aden'
            40924d
            nil)
          (
            77726
            #8216'Ataq'
            '`Ataq'
            14.537660000000000000
            46.831870000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '05'
            '2113'
            nil
            nil
            0
            nil
            '1148'
            'Asia/Aden'
            40924d
            nil)
          (
            77772
            'As S'#363'dah'
            'As Sudah'
            15.958610000000000000
            43.780830000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2913'
            nil
            nil
            0
            nil
            '2035'
            'Asia/Aden'
            40924d
            nil)
          (
            77791
            'As Sayy'#257'n'#299
            'As Sayyani'
            13.842660000000000000
            44.173950000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1115'
            nil
            nil
            0
            nil
            '1865'
            'Asia/Aden'
            40924d
            nil)
          (
            77800
            'A'#351' '#350'awma'#145'ah'
            'As Sawma`ah'
            14.085050000000000000
            45.801020000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '20'
            '1404'
            nil
            nil
            0
            nil
            '2040'
            'Asia/Aden'
            40924d
            nil)
          (
            77803
            'Al Bil'#257'd'
            'Al Bilad'
            16.138060000000000000
            49.291670000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1912'
            nil
            nil
            0
            nil
            '561'
            'Asia/Aden'
            40924d
            nil)
          (
            77809
            'As Saw'#257'd'#299'yah'
            'As Sawadiyah'
            14.301130000000000000
            45.221480000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '20'
            '1411'
            nil
            nil
            0
            nil
            '1962'
            'Asia/Aden'
            40924d
            nil)
          (
            77843
            'A'#351' '#350'al'#299'f'
            'As Salif'
            15.305580000000000000
            42.670670000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1804'
            nil
            nil
            0
            nil
            '3'
            'Asia/Aden'
            40924d
            nil)
          (
            77862
            'Said'
            'Said'
            14.330110000000000000
            46.872920000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2112'
            nil
            nil
            0
            nil
            '1253'
            'Asia/Aden'
            40924d
            nil)
          (
            77872
            'A'#351' '#350'afaqayn'
            'As Safaqayn'
            15.378970000000000000
            43.421210000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '10'
            '2706'
            nil
            nil
            0
            nil
            '2157'
            'Asia/Aden'
            40924d
            nil)
          (
            77881
            'As Saddah'
            'As Saddah'
            14.122100000000000000
            44.421390000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1106'
            nil
            nil
            0
            nil
            '2205'
            'Asia/Aden'
            40924d
            nil)
          (
            77940
            'Ash Shaykh '#145'Uthm'#257'n'
            'Ash Shaykh `Uthman'
            12.876780000000000000
            44.993090000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '02'
            '2402'
            nil
            nil
            0
            nil
            '12'
            'Asia/Aden'
            40924d
            nil)
          (
            77946
            'Ash Sha'#355#355
            'Ash Shatt'
            12.893570000000000000
            44.035710000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '24'
            '2513'
            nil
            nil
            0
            nil
            '237'
            'Asia/Aden'
            40924d
            nil)
          (
            77980
            'Ash Sh'#257'hil'
            'Ash Shahil'
            15.866560000000000000
            43.404950000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1721'
            nil
            nil
            0
            nil
            '1596'
            'Asia/Aden'
            40924d
            nil)
          (
            77985
            'Ash Shagh'#257'dirah'
            'Ash Shaghadirah'
            15.620000000000000000
            43.520560000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1725'
            nil
            nil
            0
            nil
            '1283'
            'Asia/Aden'
            40924d
            nil)
          (
            78019
            'Asd'#257's'
            'Asdas'
            15.766010000000000000
            45.081510000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '14'
            '2602'
            nil
            nil
            0
            nil
            '1102'
            'Asia/Aden'
            40924d
            nil)
          (
            78112
            'Marb'#257#355
            'Marbat'
            14.205670000000000000
            46.388110000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2111'
            nil
            nil
            0
            nil
            '1547'
            'Asia/Aden'
            40924d
            nil)
          (
            78137
            'Ar Raw'#7697'ah'
            'Ar Rawdah'
            15.432510000000000000
            44.223990000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '26'
            '1310'
            nil
            nil
            0
            nil
            '2219'
            'Asia/Aden'
            40924d
            nil)
          (
            78141
            'Ar Raw'#7697'ah'
            'Ar Rawdah'
            14.467250000000000000
            47.276380000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2115'
            nil
            nil
            0
            nil
            '839'
            'Asia/Aden'
            40924d
            nil)
          (
            78379
            'An N'#257'dirah'
            'An Nadirah'
            14.096280000000000000
            44.475590000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1104'
            nil
            nil
            0
            nil
            '2154'
            'Asia/Aden'
            40924d
            nil)
          (
            78428
            #145'Amr'#257'n'
            '`Amran'
            15.659400000000000000
            43.943850000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '19'
            '2915'
            nil
            nil
            0
            nil
            '2239'
            'Asia/Aden'
            40924d
            nil)
          (
            78448
            #8216'Amd'
            '`Amd'
            15.300000000000000000
            47.983330000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1921'
            nil
            nil
            0
            nil
            '1270'
            'Asia/Aden'
            40924d
            nil)
          (
            78471
            'Al Wuday'#8216
            'Al Wuday`'
            13.772100000000000000
            46.017860000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '01'
            '1208'
            nil
            nil
            0
            nil
            '796'
            'Asia/Aden'
            40924d
            nil)
          (
            78543
            'Al '#8216'Udayn'
            'Al `Udayn'
            13.969180000000000000
            43.996730000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1111'
            nil
            nil
            0
            nil
            '1282'
            'Asia/Aden'
            40924d
            nil)
          (
            78566
            'Al Qur'#7721
            'Al Qurh'
            16.733330000000000000
            51.483330000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '03'
            '2805'
            nil
            nil
            0
            nil
            '621'
            'Asia/Aden'
            40924d
            nil)
          (
            78675
            'Al Qan'#257'wi'#351
            'Al Qanawis'
            15.492770000000000000
            43.134330000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1806'
            nil
            nil
            0
            nil
            '96'
            'Asia/Aden'
            40924d
            nil)
          (
            78699
            'Al Qaflah'
            'Al Qaflah'
            16.318970000000000000
            43.767919999999990000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2904'
            nil
            nil
            0
            nil
            '1305'
            'Asia/Aden'
            40924d
            nil)
          (
            78708
            'Qaryat al Q'#257'bil'
            'Qaryat al Qabil'
            15.450330000000000000
            44.127680000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '26'
            '1310'
            nil
            nil
            0
            nil
            '2250'
            'Asia/Aden'
            40924d
            nil)
          (
            78713
            #256'l Ma'#145#363'dah'
            'Al Ma`udah'
            14.210550000000000000
            45.387320000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '20'
            '1407'
            nil
            nil
            0
            nil
            '2006'
            'Asia/Aden'
            40967d
            nil)
          (
            78742
            'Al Mun'#299'rah'
            'Al Munirah'
            15.320240000000000000
            42.929360000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1805'
            nil
            nil
            0
            nil
            '36'
            'Asia/Aden'
            40924d
            nil)
          (
            78754
            'Al Mukall'#257
            'Al Mukalla'
            14.542480000000000000
            49.124240000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '04'
            '1929'
            nil
            nil
            258132
            nil
            '39'
            'Asia/Aden'
            40924d
            nil)
          (
            78776
            'Al Misr'#257'kh'
            'Al Misrakh'
            13.460590000000000000
            44.020430000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1512'
            nil
            nil
            0
            nil
            '1354'
            'Asia/Aden'
            40924d
            nil)
          (
            78814
            'Al Mil'#257#7721
            'Al Milah'
            13.426110000000000000
            44.825560000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '24'
            '2508'
            nil
            nil
            0
            nil
            '530'
            'Asia/Aden'
            40924d
            nil)
          (
            78823
            'Al Mighl'#257'f'
            'Al Mighlaf'
            15.287100000000000000
            43.189140000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1808'
            nil
            nil
            0
            nil
            '132'
            'Asia/Aden'
            40924d
            nil)
          (
            78905
            'Markaz al Mar'#299'r'
            'Markaz al Marir'
            13.981780000000000000
            43.595470000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1818'
            nil
            nil
            0
            nil
            '328'
            'Asia/Aden'
            40924d
            nil)
          (
            78909
            'Al Mar'#257'wi'#145'ah'
            'Al Marawi`ah'
            14.830690000000000000
            43.153910000000010000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1813'
            nil
            nil
            0
            nil
            '77'
            'Asia/Aden'
            40924d
            nil)
          (
            78929
            'Al Man'#351#363'r'#299'yah'
            'Al Mansuriyah'
            14.685600000000000000
            43.299220000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1816'
            nil
            nil
            0
            nil
            '122'
            'Asia/Aden'
            40924d
            nil)
          (
            78931
            'Al Man'#351#363'rah'
            'Al Mansurah'
            12.860190000000000000
            44.981660000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '02'
            '2403'
            nil
            nil
            0
            nil
            '16'
            'Asia/Aden'
            40924d
            nil)
          (
            78964
            'Al Makh'#257'dir'
            'Al Makhadir'
            14.122240000000000000
            44.197960000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '23'
            '1107'
            nil
            nil
            0
            nil
            '1725'
            'Asia/Aden'
            40924d
            nil)
          (
            78977
            'Al Ma'#7721'w'#299't'
            'Al Mahwit'
            15.470070000000000000
            43.544810000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '10'
            '2708'
            nil
            nil
            0
            nil
            '2124'
            'Asia/Aden'
            40924d
            nil)
          (
            78991
            'Al Ma'#7721'fid'
            'Al Mahfid'
            14.058470000000000000
            46.913280000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '01'
            '1201'
            nil
            nil
            0
            nil
            '660'
            'Asia/Aden'
            40940d
            nil)
          (
            79006
            'Al Ma'#7721#257'bishah'
            'Al Mahabishah'
            15.947580000000000000
            43.435870000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '22'
            '1715'
            nil
            nil
            0
            nil
            '1570'
            'Asia/Aden'
            40924d
            nil)
          (
            79050
            'Al Lu'#7721'ayyah'
            'Al Luhayyah'
            15.703090000000000000
            42.690930000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1802'
            nil
            nil
            0
            nil
            '6'
            'Asia/Aden'
            40924d
            nil)
          (
            79088
            'Kirsh'
            'Kirsh'
            13.364730000000000000
            44.490460000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '24'
            '2510'
            nil
            nil
            0
            nil
            '716'
            'Asia/Aden'
            40924d
            nil)
          (
            79131
            'Al Khawkhah'
            'Al Khawkhah'
            13.807100000000000000
            43.249300000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1820'
            nil
            nil
            0
            nil
            '10'
            'Asia/Aden'
            40924d
            nil)
          (
            79219
            'Al Jurbah'
            'Al Jurbah'
            13.791500000000000000
            45.158940000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '24'
            '2503'
            nil
            nil
            0
            nil
            '2260'
            'Asia/Aden'
            40924d
            nil)
          (
            79284
            'Al Jarr'#257#7721#299
            'Al Jarrahi'
            14.132540000000000000
            43.388450000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1825'
            nil
            nil
            0
            nil
            '163'
            'Asia/Aden'
            40924d
            nil)
          (
            79384
            'Al '#7720'usayn'
            'Al Husayn'
            13.791990000000000000
            44.768859999999990000
            'P'
            'PPLA2'
            'YE'
            nil
            '18'
            '3005'
            nil
            nil
            0
            nil
            '1386'
            'Asia/Aden'
            40924d
            nil)
          (
            79393
            #7720'uray'#7697'ah'
            'Huraydah'
            15.598610000000000000
            48.182780000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1928'
            nil
            nil
            0
            nil
            '838'
            'Asia/Aden'
            40924d
            nil)
          (
            79415
            'Al '#7720'udaydah'
            'Al Hudaydah'
            14.797810000000000000
            42.954520000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '08'
            '1821'
            nil
            nil
            617871
            nil
            '10'
            'Asia/Aden'
            40924d
            nil)
          (
            79455
            'Al '#7720'azm'
            'Al Hazm'
            16.164060000000000000
            44.776920000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '21'
            '1605'
            nil
            nil
            0
            nil
            '1116'
            'Asia/Aden'
            40924d
            nil)
          (
            79478
            'Al Qa'#355'n'
            'Al Qatn'
            15.840560000000000000
            48.455560000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1907'
            nil
            nil
            0
            nil
            '684'
            'Asia/Aden'
            40924d
            nil)
          (
            79531
            'Al '#7720'arf'
            'Al Harf'
            16.363950000000000000
            44.094209999999990000
            'P'
            'PPLA2'
            'YE'
            nil
            '19'
            '2901'
            nil
            nil
            0
            nil
            '1570'
            'Asia/Aden'
            40924d
            nil)
          (
            79609
            #7720'ajar al Mush'#257#146'ikh'
            'Hajar al Musha'#39'ikh'
            16.133330000000000000
            47.833329999999990000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1905'
            nil
            nil
            0
            nil
            '1236'
            'Asia/Aden'
            40924d
            nil)
          (
            79700
            'Al Ghayz'#807'ah'
            'Al Ghayzah'
            16.207870000000000000
            52.176049999999990000
            'P'
            'PPLA'
            'YE'
            nil
            '03'
            '2804'
            nil
            nil
            0
            nil
            '17'
            'Asia/Aden'
            40924d
            nil)
          (
            79836
            'Al Bay'#7697#257#146
            'Al Bayda'#39
            13.985230000000000000
            45.572719999999990000
            'P'
            'PPLA'
            'YE'
            nil
            '20'
            '1409'
            nil
            nil
            37821
            nil
            '2005'
            'Asia/Aden'
            40924d
            nil)
          (
            79845
            'Al B'#257#355'inah'
            'Al Batinah'
            15.483330000000000000
            48.433330000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1919'
            nil
            nil
            0
            nil
            '948'
            'Asia/Aden'
            40924d
            nil)
          (
            79967
            'Al '#145#256'qir'
            'Al `Aqir'
            14.568160000000000000
            45.911560000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '05'
            '2108'
            nil
            nil
            0
            '2'
            '1202'
            'Asia/Aden'
            40924d
            nil)
          (
            80105
            'A'#7721'war'
            'Ahwar'
            13.520190000000000000
            46.713670000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '01'
            '1209'
            nil
            nil
            0
            nil
            '36'
            'Asia/Aden'
            40924d
            nil)
          (
            80309
            'Ad Durayhim'#299
            'Ad Durayhimi'
            14.637020000000000000
            43.055050000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1814'
            nil
            nil
            0
            nil
            '25'
            'Asia/Aden'
            40924d
            nil)
          (
            80331
            'Ad D'#299's ash Sharq'#299'yah'
            'Ad Dis ash Sharqiyah'
            14.908060000000000000
            49.947780000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1914'
            nil
            nil
            0
            nil
            '74'
            'Asia/Aden'
            40924d
            nil)
          (
            80336
            'Ad Dimnah'
            'Ad Dimnah'
            13.453980000000000000
            44.181680000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '25'
            '1513'
            nil
            nil
            0
            nil
            '1236'
            'Asia/Aden'
            40924d
            nil)
          (
            80379
            'Ad Dann'
            'Ad Dann'
            14.351800000000000000
            43.852750000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '11'
            '2006'
            nil
            nil
            0
            nil
            '2480'
            'Asia/Aden'
            40924d
            nil)
          (
            80383
            'Az'#807' Z'#807'al'#299#145'ah'
            'Az Zali`ah'
            15.016670000000000000
            48.016670000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '04'
            '1922'
            nil
            nil
            0
            nil
            '1398'
            'Asia/Aden'
            40924d
            nil)
          (
            80384
            'Dhalie'
            'Dhalie'
            13.695720000000000000
            44.731370000000000000
            'P'
            'PPLA'
            'YE'
            nil
            '18'
            '3006'
            nil
            nil
            0
            nil
            '1517'
            'Asia/Aden'
            40924d
            nil)
          (
            80393
            'Dhahi'
            'Dhahi'
            15.214670000000000000
            43.069740000000000000
            'P'
            'PPLA2'
            'YE'
            nil
            '08'
            '1809'
            nil
            nil
            0
            nil
            '78'
            'Asia/Aden'
            40924d
            nil)
          (
            80509
            'Bard'#299'yah'
            'Bardiyah'
            31.756150000000000000
            25.086530000000000000
            'P'
            'PPL'
            'LY'
            nil
            '42'
            nil
            nil
            nil
            9149
            nil
            '92'
            'Africa/Tripoli'
            40924d
            nil)
          (
            81302
            'Tobruk'
            'Tobruk'
            32.083610000000000000
            23.976390000000000000
            'P'
            'PPLA'
            'LY'
            nil
            '79'
            nil
            nil
            nil
            121052
            nil
            '20'
            'Africa/Tripoli'
            40924d
            nil)
          (
            81604
            'Sul'#363'q'
            'Suluq'
            31.668180000000000000
            20.252050000000000000
            'P'
            'PPL'
            'LY'
            nil
            '54'
            nil
            nil
            nil
            15543
            nil
            '55'
            'Africa/Tripoli'
            40924d
            nil)
          (
            86049
            'Gialo'
            'Gialo'
            29.033330000000000000
            21.550000000000000000
            'P'
            'PPL'
            'LY'
            nil
            '25'
            nil
            nil
            nil
            3334
            nil
            '41'
            'Africa/Tripoli'
            40924d
            nil)
          (
            87205
            'Darnah'
            'Darnah'
            32.767040000000000000
            22.636690000000000000
            'P'
            'PPLA'
            'LY'
            nil
            '70'
            nil
            nil
            nil
            78782
            nil
            '9'
            'Africa/Tripoli'
            40924d
            nil)
          (
            88319
            'Benghazi'
            'Benghazi'
            32.116670000000000000
            20.066670000000000000
            'P'
            'PPLA'
            'LY'
            nil
            '69'
            nil
            nil
            nil
            650629
            nil
            '4'
            'Africa/Tripoli'
            40924d
            nil)
          (
            88380
            'Az Zuwayt'#299'nah'
            'Az Zuwaytinah'
            30.952200000000000000
            20.120220000000000000
            'P'
            'PPL'
            'LY'
            nil
            '47'
            nil
            nil
            nil
            21015
            nil
            '7'
            'Africa/Tripoli'
            40924d
            nil)
          (
            88533
            'Awjilah'
            'Awjilah'
            29.108060000000000000
            21.286940000000000000
            'P'
            'PPL'
            'LY'
            nil
            '47'
            nil
            nil
            nil
            6610
            nil
            '41'
            'Africa/Tripoli'
            40924d
            nil)
          (
            88562
            'At T'#257'j'
            'At Taj'
            24.204870000000000000
            23.285700000000000000
            'P'
            'PPL'
            'LY'
            nil
            '08'
            nil
            nil
            nil
            46050
            nil
            '379'
            'Africa/Tripoli'
            40924d
            nil)
          (
            88834
            'Al '#145#256'q'#363'r'#299'yah'
            'Al `Aquriyah'
            32.534140000000000000
            20.579110000000000000
            'P'
            'PPL'
            'LY'
            nil
            '43'
            nil
            nil
            nil
            23164
            nil
            '16'
            'Africa/Tripoli'
            40924d
            nil)
          (
            88835
            'Al Qubbah'
            'Al Qubbah'
            32.761620000000000000
            22.242370000000000000
            'P'
            'PPL'
            'LY'
            nil
            '11'
            nil
            nil
            nil
            53064
            nil
            '605'
            'Africa/Tripoli'
            40924d
            nil)
          (
            88903
            'Al Marj'
            'Al Marj'
            32.487980000000000000
            20.831740000000000000
            'P'
            'PPLA'
            'LY'
            nil
            '66'
            nil
            nil
            nil
            85315
            nil
            '333'
            'Africa/Tripoli'
            40924d
            nil)
          (
            88930
            'Al Kufrah'
            'Al Kufrah'
            24.166670000000000000
            23.269620000000000000
            'P'
            'PPLA'
            'LY'
            nil
            '65'
            nil
            nil
            nil
            0
            nil
            '388'
            'Africa/Tripoli'
            40924d
            nil)
          (
            88962
            'Al Jawf'
            'Al Jawf'
            24.198900000000000000
            23.290930000000000000
            'P'
            'PPL'
            'LY'
            'LY'
            '08'
            nil
            nil
            nil
            17320
            nil
            '391'
            'Africa/Tripoli'
            40621d
            nil)
          (
            88967
            'Al Jaghb'#363'b'
            'Al Jaghbub'
            29.742620000000000000
            24.516760000000000000
            'P'
            'PPL'
            'LY'
            'LY'
            '42'
            nil
            nil
            nil
            2768
            nil
            '11'
            'Africa/Tripoli'
            40621d
            nil)
          (
            89055
            'Al Bay'#7697#257#146
            'Al Bayda'#39
            32.762720000000000000
            21.755060000000000000
            'P'
            'PPLA'
            'LY'
            nil
            '63'
            nil
            nil
            nil
            206180
            nil
            '631'
            'Africa/Tripoli'
            40924d
            nil)
          (
            89087
            'Al Aby'#257'r'
            'Al Abyar'
            32.190000000000000000
            20.596530000000000000
            'P'
            'PPL'
            'LY'
            nil
            '02'
            nil
            nil
            nil
            32563
            nil
            '289'
            'Africa/Tripoli'
            40621d
            nil)
          (
            89113
            'Ajdabiya'
            'Ajdabiya'
            30.755450000000000000
            20.226260000000000000
            'P'
            'PPLA'
            'LY'
            nil
            '83'
            nil
            nil
            nil
            134358
            nil
            '3'
            'Africa/Tripoli'
            40812d
            nil)
          (
            89570
            'Z'#257'kh'#363
            'Zakhu'
            37.148170000000000000
            42.700080000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '08'
            nil
            nil
            nil
            95052
            nil
            '450'
            'Asia/Baghdad'
            40924d
            nil)
          (
            89824
            'Umm Qa'#351'r'
            'Umm Qasr'
            30.040540000000000000
            47.916770000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '02'
            nil
            nil
            nil
            107620
            '9'
            '14'
            'Asia/Baghdad'
            40924d
            nil)
          (
            90026
            'Tozkhurmato'
            'Tozkhurmato'
            34.890460000000000000
            44.629940000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '18'
            nil
            nil
            nil
            59886
            nil
            '228'
            'Asia/Baghdad'
            40924d
            nil)
          (
            90150
            'Tikr'#299't'
            'Tikrit'
            34.607120000000000000
            43.678220000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '18'
            nil
            nil
            nil
            42477
            nil
            '112'
            'Asia/Baghdad'
            40924d
            nil)
          (
            90353
            'Qa'#7697#257#146' Talk'#299'f'
            'Qada'#39' Talkif'
            36.489440000000000000
            43.119170000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '15'
            nil
            nil
            nil
            23524
            nil
            '274'
            'Asia/Baghdad'
            40924d
            nil)
          (
            90708
            'S'#299'nah'
            'Sinah'
            36.809019999999990000
            43.038860000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '08'
            nil
            nil
            nil
            128776
            nil
            '611'
            'Asia/Baghdad'
            40924d
            nil)
          (
            91597
            'S'#257'marr'#257#146
            'Samarra'#39
            34.196630000000000000
            43.873900000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '18'
            nil
            nil
            nil
            158508
            nil
            '69'
            'Asia/Baghdad'
            40967d
            nil)
          (
            91812
            'N'#257#7721#299'yat Saddat al Hind'#299'yah'
            'Nahiyat Saddat al Hindiyah'
            32.715570000000000000
            44.278570000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '06'
            nil
            nil
            nil
            30622
            nil
            '23'
            'Asia/Baghdad'
            40967d
            nil)
          (
            92002
            'R'#257'wand'#363'z'
            'Rawanduz'
            36.616310000000000000
            44.531110000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '11'
            nil
            nil
            nil
            22943
            nil
            '705'
            'Asia/Baghdad'
            40924d
            nil)
          (
            92004
            'R'#257'wah'
            'Rawah'
            34.479349999999990000
            41.908490000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '01'
            nil
            nil
            nil
            20580
            nil
            '161'
            'Asia/Baghdad'
            40967d
            nil)
          (
            92430
            'Qa'#7697#257#146' al '#7720'amd'#257'n'#299'yah'
            'Qada'#39' al Hamdaniyah'
            36.271460000000000000
            43.373730000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '15'
            nil
            nil
            nil
            28448
            nil
            '270'
            'Asia/Baghdad'
            40924d
            nil)
          (
            93709
            'Mandal'#299
            'Mandali'
            33.748100000000000000
            45.555030000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '10'
            nil
            nil
            nil
            29785
            nil
            '141'
            'Asia/Baghdad'
            41004d
            nil)
          (
            94220
            'K'#363'ysinjaq'
            'Kuysinjaq'
            36.082140000000000000
            44.627780000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '11'
            nil
            nil
            nil
            44987
            nil
            '602'
            'Asia/Baghdad'
            40940d
            nil)
          (
            94298
            'Kifr'#299
            'Kifri'
            34.695870000000000000
            44.966100000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '10'
            nil
            nil
            nil
            30143
            nil
            '236'
            'Asia/Baghdad'
            40924d
            nil)
          (
            94787
            'Kirkuk'
            'Kirkuk'
            35.468060000000000000
            44.392220000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '13'
            nil
            nil
            nil
            601433
            nil
            '346'
            'Asia/Baghdad'
            40924d
            nil)
          (
            94824
            'Karbala'
            'Karbala'
            32.616030000000000000
            44.024880000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '12'
            nil
            nil
            nil
            434450
            nil
            '32'
            'Asia/Baghdad'
            40791d
            nil)
          (
            95446
            'Erbil'
            'Erbil'
            36.192570000000010000
            44.010620000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '11'
            nil
            nil
            nil
            932800
            nil
            '426'
            'Asia/Baghdad'
            40924d
            nil)
          (
            95788
            'H'#299't'
            'Hit'
            33.636640000000000000
            42.827680000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '01'
            nil
            nil
            nil
            31901
            nil
            '66'
            'Asia/Baghdad'
            40967d
            nil)
          (
            96205
            #7720'alabjah'
            'Halabjah'
            35.177780000000000000
            45.986109999999990000
            'P'
            'PPL'
            'IQ'
            nil
            '05'
            nil
            nil
            nil
            57333
            nil
            '711'
            'Asia/Baghdad'
            40542d
            nil)
          (
            96309
            #7720'ad'#299'thah'
            'Hadithah'
            34.134770000000000000
            42.377240000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '01'
            nil
            nil
            nil
            30925
            nil
            '149'
            'Asia/Baghdad'
            40967d
            nil)
          (
            96994
            'Dah'#363'k'
            'Dahuk'
            36.869500000000000000
            42.993980000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '08'
            nil
            nil
            nil
            0
            nil
            '570'
            'Asia/Baghdad'
            40924d
            nil)
          (
            97417
            'Chamcham'#257'l'
            'Chamchamal'
            35.536530000000000000
            44.831670000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '05'
            nil
            nil
            nil
            75634
            nil
            '707'
            'Asia/Baghdad'
            40924d
            nil)
          (
            97783
            'Bayj'#299
            'Bayji'
            34.931140000000000000
            43.487000000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '18'
            nil
            nil
            nil
            36454
            nil
            '115'
            'Asia/Baghdad'
            40924d
            nil)
          (
            97990
            'Ba'#145'q'#363'bah'
            'Ba`qubah'
            33.746600000000000000
            44.643660000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '10'
            nil
            nil
            nil
            152550
            nil
            '41'
            'Asia/Baghdad'
            40967d
            nil)
          (
            98012
            'Paynjuwayn'
            'Paynjuwayn'
            35.618300000000000000
            45.954100000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '05'
            nil
            nil
            nil
            27116
            nil
            '1281'
            'Asia/Baghdad'
            40924d
            nil)
          (
            98112
            'Balad'
            'Balad'
            34.014850000000000000
            44.145740000000010000
            'P'
            'PPL'
            'IQ'
            nil
            '18'
            nil
            nil
            nil
            42088
            nil
            '53'
            'Asia/Baghdad'
            40967d
            nil)
          (
            98182
            'Baghdad'
            'Baghdad'
            33.340580000000000000
            44.400880000000000000
            'P'
            'PPLC'
            'IQ'
            nil
            '07'
            nil
            nil
            nil
            5672513
            nil
            '41'
            'Asia/Baghdad'
            40924d
            nil)
          (
            98245
            'Az Zubayr'
            'Az Zubayr'
            30.394470000000000000
            47.701140000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '02'
            nil
            nil
            nil
            122676
            nil
            '12'
            'Asia/Baghdad'
            40924d
            nil)
          (
            98459
            'A'#351' '#350'uwayrah'
            'As Suwayrah'
            32.925560000000000000
            44.775830000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '16'
            nil
            nil
            nil
            42354
            nil
            '32'
            'Asia/Baghdad'
            40924d
            nil)
          (
            98463
            'As Sulaym'#257'n'#299'yah'
            'As Sulaymaniyah'
            35.561130000000000000
            45.437490000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '05'
            nil
            nil
            nil
            723170
            nil
            '846'
            'Asia/Baghdad'
            40924d
            nil)
          (
            98530
            'As Samawah'
            'As Samawah'
            31.331980000000000000
            45.294400000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '03'
            nil
            nil
            nil
            152890
            nil
            '15'
            'Asia/Baghdad'
            40791d
            nil)
          (
            98589
            'N'#257#7721'iyat ash Shin'#257'f'#299'yah'
            'Nahiyat ash Shinafiyah'
            31.583760000000000000
            44.646750000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '04'
            nil
            nil
            nil
            22643
            nil
            '18'
            'Asia/Baghdad'
            41004d
            nil)
          (
            98622
            'Ash Sha'#355'rah'
            'Ash Shatrah'
            31.409060000000000000
            46.172700000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '09'
            nil
            nil
            nil
            82732
            nil
            '2'
            'Asia/Baghdad'
            41004d
            nil)
          (
            98629
            'Ash Sh'#257'm'#299'yah'
            'Ash Shamiyah'
            31.962570000000000000
            44.600750000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '04'
            nil
            nil
            nil
            57661
            nil
            '14'
            'Asia/Baghdad'
            41004d
            nil)
          (
            98677
            'Ar Ru'#355'bah'
            'Ar Rutbah'
            33.037180000000000000
            40.285860000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '01'
            nil
            nil
            nil
            22370
            nil
            '618'
            'Asia/Baghdad'
            40967d
            nil)
          (
            98685
            'Ar Rumaythah'
            'Ar Rumaythah'
            31.528450000000000000
            45.203770000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '03'
            nil
            nil
            nil
            47248
            nil
            '9'
            'Asia/Baghdad'
            41004d
            nil)
          (
            98717
            'Ar Ram'#257'd'#299
            'Ar Ramadi'
            33.420560000000000000
            43.307780000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '01'
            nil
            nil
            nil
            274539
            nil
            '48'
            'Asia/Baghdad'
            40967d
            nil)
          (
            98854
            'An N'#257#351'ir'#299'yah'
            'An Nasiriyah'
            31.057990000000000000
            46.257260000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '09'
            nil
            nil
            nil
            400249
            nil
            '8'
            'Asia/Baghdad'
            41004d
            nil)
          (
            98860
            'An Najaf al Ashraf'
            'An Najaf al Ashraf'
            31.989200000000000000
            44.329100000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '17'
            nil
            nil
            nil
            482576
            nil
            '60'
            'Asia/Baghdad'
            41004d
            nil)
          (
            98885
            #145'Anat al Qad'#299'mah'
            '`Anat al Qadimah'
            34.469340000000000000
            41.942240000000000000
            'P'
            'PPLW'
            'IQ'
            nil
            '01'
            nil
            nil
            nil
            19719
            nil
            '180'
            'Asia/Baghdad'
            40967d
            nil)
          (
            99010
            'Imam Qasim'
            'Imam Qasim'
            32.297990000000000000
            44.682820000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '06'
            nil
            nil
            nil
            36992
            nil
            '30'
            'Asia/Baghdad'
            41004d
            nil)
          (
            99039
            'Al Musayyib'
            'Al Musayyib'
            32.783960000000000000
            44.276620000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '06'
            nil
            nil
            nil
            42901
            nil
            '22'
            'Asia/Baghdad'
            40967d
            nil)
          (
            99060
            'Al Mishkh'#257'b'
            'Al Mishkhab'
            31.804360000000000000
            44.489300000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '17'
            nil
            nil
            nil
            23189
            nil
            '13'
            'Asia/Baghdad'
            41004d
            nil)
          (
            99062
            'Al Miqd'#257'd'#299'yah'
            'Al Miqdadiyah'
            33.978610000000010000
            44.936940000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '10'
            nil
            nil
            nil
            50698
            nil
            '60'
            'Asia/Baghdad'
            40924d
            nil)
          (
            99071
            'Al Maw'#351'il al Jad'#299'dah'
            'Al Mawsil al Jadidah'
            36.334640000000000000
            43.097770000000000000
            'P'
            'PPLX'
            'IQ'
            nil
            '15'
            nil
            nil
            nil
            2065597
            nil
            '248'
            'Asia/Baghdad'
            40924d
            nil)
          (
            99072
            'Mosul'
            'Mosul'
            36.335000000000000000
            43.118890000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '15'
            nil
            nil
            nil
            1739800
            nil
            '228'
            'Asia/Baghdad'
            40924d
            nil)
          (
            99097
            'Al Majar al Kabir'
            'Al Majar al Kabir'
            31.572320000000000000
            47.175290000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '14'
            nil
            nil
            nil
            35515
            nil
            '8'
            'Asia/Baghdad'
            40791d
            nil)
          (
            99131
            'Al K'#363't'
            'Al Kut'
            32.512800000000000000
            45.818170000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '16'
            nil
            nil
            nil
            315162
            nil
            '19'
            'Asia/Baghdad'
            41004d
            nil)
          (
            99169
            'Kh'#257'li'#351
            'Khalis'
            33.808090000000000000
            44.533440000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '10'
            nil
            nil
            nil
            70046
            nil
            '28'
            'Asia/Baghdad'
            40967d
            nil)
          (
            99306
            #145'Al'#299' al Gharb'#299
            '`Ali al Gharbi'
            32.461860000000000000
            46.687940000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '14'
            nil
            nil
            nil
            19711
            nil
            '12'
            'Asia/Baghdad'
            41004d
            nil)
          (
            99344
            'Al Hind'#299'yah'
            'Al Hindiyah'
            32.542170000000000000
            44.221110000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '12'
            nil
            nil
            nil
            57490
            nil
            '16'
            'Asia/Baghdad'
            40967d
            nil)
          (
            99347
            'Al '#7720'illah'
            'Al Hillah'
            32.463670000000000000
            44.419630000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '06'
            nil
            nil
            nil
            289709
            nil
            '25'
            'Asia/Baghdad'
            41004d
            nil)
          (
            99350
            'Al '#7720'ayy'
            'Al Hayy'
            32.174190000000000000
            46.043450000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '16'
            nil
            nil
            nil
            78272
            nil
            '20'
            'Asia/Baghdad'
            41004d
            nil)
          (
            99369
            'Al H'#257'rithah'
            'Al Harithah'
            30.718610000000000000
            47.720830000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '02'
            nil
            nil
            nil
            92395
            nil
            '3'
            'Asia/Baghdad'
            40924d
            nil)
          (
            99434
            'Nahiyat Ghammas'
            'Nahiyat Ghammas'
            31.743110000000000000
            44.619600000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '04'
            nil
            nil
            nil
            30909
            nil
            '18'
            'Asia/Baghdad'
            40791d
            nil)
          (
            99439
            'N'#257#7721'iyat al Fuh'#363'd'
            'Nahiyat al Fuhud'
            30.969720000000000000
            46.722780000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '09'
            nil
            nil
            nil
            21551
            nil
            '5'
            'Asia/Baghdad'
            38734d
            nil)
          (
            99446
            'Al F'#257'w'
            'Al Faw'
            29.977630000000000000
            48.474120000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '02'
            nil
            nil
            nil
            104569
            nil
            '2'
            'Asia/Baghdad'
            40924d
            nil)
          (
            99454
            'Al Fall'#363'jah'
            'Al Fallujah'
            33.355810000000000000
            43.786120000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '01'
            nil
            nil
            nil
            190159
            nil
            '42'
            'Asia/Baghdad'
            40967d
            nil)
          (
            99532
            'Al Ba'#351'rah'
            'Al Basrah'
            30.533020000000000000
            47.797470000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '02'
            nil
            nil
            nil
            2600000
            nil
            '3'
            'Asia/Baghdad'
            41004d
            nil)
          (
            99548
            'Al '#145'Az'#299'z'#299'yah'
            'Al `Aziziyah'
            32.909410000000000000
            45.063590000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '16'
            nil
            nil
            nil
            44751
            nil
            '27'
            'Asia/Baghdad'
            40967d
            nil)
          (
            99608
            'Al '#145'Am'#257'rah'
            'Al `Amarah'
            31.835880000000000000
            47.144000000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '14'
            nil
            nil
            nil
            323302
            nil
            '10'
            'Asia/Baghdad'
            41004d
            nil)
          (
            99738
            #8216'Afak'
            '`Afak'
            32.064300000000000000
            45.247430000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '04'
            nil
            nil
            nil
            21888
            nil
            '23'
            'Asia/Baghdad'
            41004d
            nil)
          (
            99759
            'Ad Dujayl'
            'Ad Dujayl'
            33.846670000000000000
            44.234440000000000000
            'P'
            'PPL'
            'IQ'
            nil
            '18'
            nil
            nil
            nil
            26362
            nil
            '46'
            'Asia/Baghdad'
            40924d
            nil)
          (
            99762
            'Ad D'#299'w'#257'n'#299'yah'
            'Ad Diwaniyah'
            31.992890000000000000
            44.925520000000000000
            'P'
            'PPLA'
            'IQ'
            nil
            '04'
            nil
            nil
            nil
            318801
            nil
            '24'
            'Asia/Baghdad'
            41004d
            nil))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh2
    Left = 104
    Top = 328
  end
  object ImageList1: TImageList
    Left = 56
    Top = 168
    Bitmap = {
      494C010106000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000626864006366640000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006565650065656500656565006565650065656500656565000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005D6C63002A804B00267B46005E686200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005F68630000993A000094380000943800008F3600656565000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005A746400327F4F00009D3B00009739002D7849005B6E62000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005F69630008A4430000A13D0000A13D0000993A00656565000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000536E5D00387E530000A03D0000A03D00009E3C000096390035754D005669
      5D00000000000000000000000000000000000000000000000000000000006B75
      6F006169640044865D000DA6470001A13E0001A13E00009C3B003B7652006565
      6500576D5F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000506B
      5A006565650059896B001DAC530001A13E0000A13D00009E3C00307F4E00596A
      6000506B5A000000000000000000000000000000000000000000000000000000
      00006B756F00699479003AB669000DA6470004A2400001A13E00357F5100576D
      5F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000666B680031AD600003A23F0000A13D00009E3C00596B60000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000686D6A006C9D7F0036B5660013A84B00318852005E6A62000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000676C68005EBE830042B96F0040B96E001FAC5500596B60000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000696E6B006DA78300449764005F6B6300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000696C6A0065656500656565006565650065656500656565000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000666867006467650000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C2C2C20098989800989898009898
      9800989898009898980098989800989898009898980098989800989898009898
      98009898980098989800A9A9A90000000000C2C2C20098989800989898009898
      9800989898009898980098989800989898009898980098989800989898009898
      98009898980098989800A9A9A90000000000C2C2C20098989800989898009898
      9800989898009898980098989800989898009898980098989800989898009898
      98009898980098989800A9A9A9000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000099999900EEEEEE00EAEAEA00EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00EAEAEA00EEEEEE00999999000000000099999900EEEEEE00EAEAEA00EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00EAEAEA00EEEEEE00999999000000000099999900EEEEEE00EAEAEA00EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00EAEAEA00EEEEEE00999999000000000000000000000000000000FF000000
      000000000000000000000000FF00000000000000000000000000000000005858
      5800000000005858580000000000000000009B9B9B00EFEFEF00EBEBEB00EBEB
      EB00EBEBEB00EBEBEB006EADEB00241CED00241CED00301CED0088AED5004686
      B20088AEC900EFEFEF009B9B9B00000000009B9B9B00EFEFEF00EBEBEB00EBEB
      EB00EBEBEB00EBEBEB00CDEBEB002446ED00241CED004155E40088AEC9004686
      B20088AEC900EFEFEF009B9B9B00000000009B9B9B00EFEFEF00EBEBEB00EBEB
      EB00EBEBEB00EBEBEB0090CCEB004B1CED00EBCCED004686B20088AEC9004686
      B20088AEC900EFEFEF009B9B9B00000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D00F0F0F000ECECEC00ECEC
      EC00ECECEC0090CDEC00241CED00CE8DED00ECECEC0090CDEC00B06AED00ECEC
      EC00ECECEC00F0F0F0009D9D9D00000000009D9D9D00F0F0F000ECECEC00ECEC
      EC00ECECEC00ECECEC00B0ECEC00241CED00241CED009046ED00ECECEC00ECEC
      EC00ECECEC00F0F0F0009D9D9D00000000009D9D9D00F0F0F000ECECEC00ECEC
      EC00ECECEC00ECECEC0090CDEC004B1CED00ECCDED00ECECEC00ECECEC00ECEC
      EC00ECECEC00F0F0F0009D9D9D00000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000585858000A0A
      0A000A0B0A000A0A0A005858580000000000A0A0A000F1F1F100EEEEEE00EEEE
      EE00EEEEEE004B8FEE006F1CED00EEEEEE00EEEEEE004686B20089B0CA004686
      B20089B0CA00F1F1F100A0A0A00000000000A0A0A000F1F1F100EEEEEE00EEEE
      EE00EEEEEE00EEEEEE006FB0EE006F1CED0091CFEE002A1CE400899ADC004686
      B20089B0CA00F1F1F100A0A0A00000000000A0A0A000F1F1F100EEEEEE00EEEE
      EE00EEEEEE00EEEEEE0091CFEE004B1CED00EECFEE004686B20089B0CA004686
      B20089B0CA00F1F1F100A0A0A000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000171818001717
      170017171700171717001718170000000000A3A3A300F2F2F200EFEFEF00EFEF
      EF00EFEFEF004B8FEF00701CED00EFEFEE00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00F2F2F200A3A3A30000000000A3A3A300F2F2F200EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00246CEE00B16CED00D1EFEF002446EE00B16CED00EFEF
      EF00EFEFEF00F2F2F200A3A3A30000000000A3A3A300F2F2F200EFEFEF00EFEF
      EF00EFEFEF00EFEFEF0091D0EF004B1CED00EFD0EE00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00F2F2F200A3A3A3000000000000000000000000000000FF000000
      000000000000000000000000FF00000000000000000000000000000000000000
      000027272600000000000000000000000000A5A5A500F4F4F4008CB2CB004686
      B1004686B1002A55BC00301CED008CB2D600F1F1F1004686B2008AB1CB004686
      B2008AB1CB00F4F4F400A5A5A50000000000A5A5A500F4F4F4008CB2CB004686
      B1004686B1003B86B100241CDA008C85E200F1F1F1003066B200491CED004686
      C7008AB1CB00F4F4F400A5A5A50000000000A5A5A500F4F4F4008CB2CB004686
      B1004686B1004686B1003576B100381CE700F1D1EF004686B2008AB1CB004686
      B2008AB1CB00F4F4F400A5A5A5000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000038383800000000000000000000000000A8A8A800F5F5F5004686B2005BD4
      FF005BD4FF0049D4FF00241CF3003B43ED00F3F3F30094D4F300B56DEE00F3F3
      F300F3F3F300F5F5F500A8A8A80000000000A8A8A800F5F5F5004686B2005BD4
      FF005BD4FF00389DFF002D1CED004676D000F3F3F300B5F3F300241CEF00F3B3
      EF00F3F3F300F5F5F500A8A8A80000000000A8A8A800F5F5F5004686B2005BD4
      FF005BD4FF005BD4FF0041B9FF002A1CE400F3D4F100F3F3F300F3F3F300F3F3
      F300F3F3F300F5F5F500A8A8A800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004C4B4C00000000000000000000000000ABABAB00F6F6F6004686B20076DD
      FF0076DDFF0076DDFF0050C1FF00241CE400241CED00301CED008CB2D7004686
      B2008CB2CC00F6F6F600ABABAB0000000000ABABAB00F6F6F6004686B20076DD
      FF0076DDFF002465F9005043ED004686BC00F4F4F4004686B2002454D7003531
      ED008CB2D200F6F6F600ABABAB0000000000ABABAB00F6F6F6004686B20076DD
      FF0076DDFF00241CF100241CED00241CED00241CED002A1CED008C9CDD004686
      B2008CB2CC00F6F6F600ABABAB00000000000000000000000000FF0000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      000060606000000000000000000000000000ACACAC00F8F8F8004686B20091E6
      FF0091E6FF0091E6FF0091E6FF004686B200F6F6F600F6F6F600F6F6F600F6F6
      F600F6F6F600F8F8F800ACACAC0000000000ACACAC00F8F8F8004686B20091E6
      FF0091E6FF0091E6FF0091E6FF004686B200F6F6F600F6F6F600F6F6F600F6F6
      F600F6F6F600F8F8F800ACACAC0000000000ACACAC00F8F8F8004686B20091E6
      FF0091E6FF0091E6FF0091E6FF004686B200F6F6F600F6F6F600F6F6F600F6F6
      F600F6F6F600F8F8F800ACACAC00000000000000000000000000FF0000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      000075757500000000000000000000000000AFAFAF00F9F9F9004686B200A3EC
      FF00A3ECFF004686B2004686B2008FB5CE00F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F9F9F900AFAFAF0000000000AFAFAF00F9F9F9004686B200A3EC
      FF00A3ECFF004686B2004686B2008FB5CE00F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F9F9F900AFAFAF0000000000AFAFAF00F9F9F9004686B200A3EC
      FF00A3ECFF004686B2004686B2008FB5CE00F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F9F9F900AFAFAF00000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      00008A8A8A00000000000000000000000000B1B1B100FAFAFA0090B5CF004786
      B2004786B20090B5CF00F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9
      F900F9F9F900FAFAFA00B1B1B10000000000B1B1B100FAFAFA0090B5CF004786
      B2004786B20090B5CF00F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9
      F900F9F9F900FAFAFA00B1B1B10000000000B1B1B100FAFAFA0090B5CF004786
      B2004786B20090B5CF00F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9
      F900F9F9F900FAFAFA00B1B1B10000000000000000000000000000000000FF00
      000000000000FF00000000000000000000000000000000000000000000000000
      0000A09F9F00000000000000000000000000B3B3B300FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00B3B3B30000000000B3B3B300FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00B3B3B30000000000B3B3B300FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00B3B3B30000000000000000000000000000000000FF00
      000000000000FF00000000000000000000000000000000000000000000000000
      0000B3B3B300000000000000000000000000D3D3D300B4B4B400B4B4B400B4B4
      B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B400B4B4B400B4B4B400D3D3D30000000000D3D3D300B4B4B400B4B4B400B4B4
      B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B400B4B4B400B4B4B400D3D3D30000000000D3D3D300B4B4B400B4B4B400B4B4
      B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B400B4B4B400B4B4B400D3D3D300000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000C7C7C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000D8D8D900000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000FE7FF81F00000000FC3FF81F00000000
      F81FF81F00000000F00FE00700000000E007F00F00000000F81FF81F00000000
      F81FFC3F00000000F81FFE7F00000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFFFFFFFFFF000100010001C1F7
      000100010001DDE3000100010001EFE3000100010001F7C1000100010001FBC1
      000100010001DDF7000100010001C1F7000100010001FFF7000100010001DDF7
      000100010001DDF7000100010001C1F7000100010001EBF7000100010001EBF7
      000100010001F7F7FFFFFFFFFFFFF7F700000000000000000000000000000000
      000000000000}
  end
end
