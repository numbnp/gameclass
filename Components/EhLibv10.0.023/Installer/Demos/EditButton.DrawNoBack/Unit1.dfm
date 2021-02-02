object Form1: TForm1
  Left = 334
  Top = 179
  Width = 658
  Height = 484
  Caption = 'Form1'
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  DesignSize = (
    642
    445)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 240
    Width = 449
    Height = 197
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColumnDefValues.AlwaysShowEditButton = True
    DataSource = DataSource1
    DynProps = <>
    FooterParams.Color = clWindow
    GridLineParams.ColorScheme = glcsThemedEh
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    TabOrder = 0
    Columns = <
      item
        ButtonStyle = cbsAltDropDown
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButton.Visible = True
        EditButtons = <>
        FieldName = 'Name'
        Footers = <>
        Width = 96
      end
      item
        DynProps = <>
        EditButton.Images.NormalImages = ImageList1
        EditButton.Images.HotImages = ImageList1
        EditButton.Images.PressedImages = ImageList1
        EditButton.Images.DisabledImages = ImageList1
        EditButton.Style = ebsGlyphEh
        EditButton.Visible = True
        EditButtons = <>
        FieldName = 'Capital'
        Footers = <>
        Width = 81
      end
      item
        DynProps = <>
        EditButtons = <
          item
            Images.NormalImages = ImageList1
            Images.NormalIndex = 1
            Images.HotIndex = 1
            Images.PressedIndex = 1
            Images.DisabledIndex = 1
            Style = ebsGlyphEh
          end>
        FieldName = 'Continent'
        Footers = <>
        Width = 99
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Area'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Population'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'ComboBox1'
    Visible = False
  end
  object DateTimePicker1: TDateTimePicker
    Left = 151
    Top = 8
    Width = 105
    Height = 21
    Date = 42485.486634594910000000
    Time = 42485.486634594910000000
    TabOrder = 2
    Visible = False
  end
  object Button1: TButton
    Left = 327
    Top = 8
    Width = 290
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'DrawBackTime = edbtWhenHotEh'
    TabOrder = 3
    OnClick = Button1Click
  end
  object DBEditEh1: TDBEditEh
    Left = 8
    Top = 48
    Width = 121
    Height = 21
    AutoSelect = False
    DynProps = <>
    EditButtons = <
      item
        DefaultAction = False
        Images.NormalImages = ImageList1
        Images.HotImages = ImageList1
        Images.PressedImages = ImageList1
        Images.DisabledImages = ImageList1
        Style = ebsGlyphEh
      end>
    TabOrder = 4
    Text = 'DBEditEh1'
    Visible = True
  end
  object DBDateTimeEditEh1: TDBDateTimeEditEh
    Left = 8
    Top = 75
    Width = 121
    Height = 21
    DynProps = <>
    EditButtons = <
      item
        Visible = False
      end>
    Kind = dtkDateEh
    TabOrder = 5
    Visible = True
  end
  object DBEditEh2: TDBEditEh
    Left = 8
    Top = 176
    Width = 265
    Height = 21
    DynProps = <>
    EditButtons = <
      item
        DefaultAction = True
        Style = ebsAltDropDownEh
      end
      item
        DefaultAction = False
      end
      item
        DefaultAction = False
        Style = ebsEllipsisEh
      end
      item
        DefaultAction = False
        Images.NormalImages = ImageList1
        Images.HotImages = ImageList1
        Images.PressedImages = ImageList1
        Images.DisabledImages = ImageList1
        Style = ebsGlyphEh
      end
      item
        DefaultAction = False
        Style = ebsMinusEh
      end
      item
        DefaultAction = False
        Style = ebsPlusEh
      end
      item
        DefaultAction = False
        Style = ebsUpDownEh
      end
      item
        DefaultAction = False
        Style = ebsAltUpDownEh
      end>
    TabOrder = 6
    Text = 'DBEditEh2'
    Visible = True
  end
  object Button2: TButton
    Left = 152
    Top = 44
    Width = 121
    Height = 25
    Caption = '< Next button style'
    TabOrder = 7
    OnClick = Button2Click
  end
  object DBNumberEditEh1: TDBNumberEditEh
    Left = 8
    Top = 102
    Width = 121
    Height = 21
    DynProps = <>
    EditButton.Visible = True
    EditButtons = <>
    TabOrder = 8
    Visible = True
  end
  object DBComboBoxEh1: TDBComboBoxEh
    Left = 8
    Top = 136
    Width = 121
    Height = 21
    DynProps = <>
    EditButtons = <>
    TabOrder = 9
    Text = 'DBComboBoxEh1'
    Visible = True
  end
  object DBDateTimeEditEh2: TDBDateTimeEditEh
    Left = 152
    Top = 75
    Width = 121
    Height = 21
    DynProps = <>
    EditButton.Style = ebsAltDropDownEh
    EditButtons = <
      item
        Visible = False
      end>
    Kind = dtkDateEh
    TabOrder = 10
    Visible = True
  end
  object DBNumberEditEh2: TDBNumberEditEh
    Left = 152
    Top = 102
    Width = 121
    Height = 21
    DynProps = <>
    EditButton.Style = ebsAltDropDownEh
    EditButton.Visible = True
    EditButtons = <>
    TabOrder = 11
    Visible = True
  end
  object DBComboBoxEh2: TDBComboBoxEh
    Left = 152
    Top = 136
    Width = 121
    Height = 21
    DynProps = <>
    EditButton.Style = ebsAltDropDownEh
    EditButtons = <>
    TabOrder = 12
    Text = 'DBComboBoxEh1'
    Visible = True
  end
  object DBEditEh3: TDBEditEh
    Left = 8
    Top = 203
    Width = 265
    Height = 21
    DynProps = <>
    EditButtons = <
      item
        DefaultAction = True
        Style = ebsAltDropDownEh
      end
      item
        DefaultAction = False
      end
      item
        DefaultAction = False
        Style = ebsEllipsisEh
      end
      item
        DefaultAction = False
        Images.NormalImages = ImageList1
        Images.HotImages = ImageList1
        Images.PressedImages = ImageList1
        Images.DisabledImages = ImageList1
        Style = ebsGlyphEh
      end
      item
        DefaultAction = False
        Style = ebsMinusEh
      end
      item
        DefaultAction = False
        Style = ebsPlusEh
      end
      item
        DefaultAction = False
        Style = ebsUpDownEh
      end
      item
        DefaultAction = False
        Style = ebsAltUpDownEh
      end
      item
      end
      item
      end
      item
      end
      item
      end>
    TabOrder = 13
    Text = 'DBEditEh2'
    Visible = True
  end
  object Button3: TButton
    Left = 327
    Top = 39
    Width = 290
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'DrawBackTime = edbtNeverEh'
    TabOrder = 14
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 326
    Top = 70
    Width = 290
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'DrawBackTime = edbtAlwaysEh'
    TabOrder = 15
    OnClick = Button4Click
  end
  object DBVertGridEh1: TDBVertGridEh
    Left = 472
    Top = 240
    Width = 137
    Height = 193
    AllowedSelections = []
    Anchors = [akTop, akRight, akBottom]
    RowCategories.CategoryProps = <>
    PrintService.ColorSchema = pcsFullColorEh
    DataSource = DataSource1
    DrawGraphicData = True
    DrawMemoText = True
    RowsDefValues.AlwaysShowEditButton = True
    TabOrder = 16
    Rows = <
      item
        ButtonStyle = cbsDropDown
        DynProps = <>
        EditButton.Visible = True
        EditButtons = <>
        FieldName = 'Name'
      end
      item
        ButtonStyle = cbsAltDropDown
        DynProps = <>
        EditButton.Style = ebsAltDropDownEh
        EditButton.Visible = True
        EditButtons = <>
        FieldName = 'Capital'
      end
      item
        ButtonStyle = cbsEllipsis
        DynProps = <>
        EditButton.Style = ebsEllipsisEh
        EditButton.Visible = True
        EditButtons = <>
        FieldName = 'Continent'
      end
      item
        ButtonStyle = cbsAltUpDown
        DynProps = <>
        EditButton.Style = ebsAltUpDownEh
        EditButton.Visible = True
        EditButtons = <>
        FieldName = 'Area'
      end
      item
        DynProps = <>
        EditButtons = <
          item
            Style = ebsGlyphEh
          end
          item
            Style = ebsEllipsisEh
          end>
        FieldName = 'Population'
      end>
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Params = <>
    Left = 56
    Top = 296
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object Name: TMTStringDataFieldEh
          FieldName = 'Name'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Name'
          DisplayWidth = 24
          Size = 24
          Transliterate = True
        end
        object Capital: TMTStringDataFieldEh
          FieldName = 'Capital'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Capital'
          DisplayWidth = 24
          Size = 24
          Transliterate = True
        end
        object Continent: TMTStringDataFieldEh
          FieldName = 'Continent'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Continent'
          DisplayWidth = 24
          Size = 24
          Transliterate = True
        end
        object Area: TMTNumericDataFieldEh
          FieldName = 'Area'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'Area'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object Population: TMTNumericDataFieldEh
          FieldName = 'Population'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'Population'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            'Argentina'
            'Buenos Aires'
            'South America'
            2777815.000000000000000000
            32300003.000000000000000000)
          (
            'Bolivia'
            'La Paz'
            'South America'
            1098575.000000000000000000
            7300000.000000000000000000)
          (
            'Brazil'
            'Brasilia'
            'South America'
            8511196.000000000000000000
            150400000.000000000000000000)
          (
            'Canada'
            'Ottawa'
            'North America'
            9976147.000000000000000000
            26500000.000000000000000000)
          (
            'Chile'
            'Santiago'
            'South America'
            756943.000000000000000000
            13200000.000000000000000000)
          (
            'Colombia'
            'Bagota'
            'South America'
            1138907.000000000000000000
            33000000.000000000000000000)
          (
            'Cuba'
            'Havana'
            'North America'
            114524.000000000000000000
            10600000.000000000000000000)
          (
            'Ecuador'
            'Quito'
            'South America'
            455502.000000000000000000
            10600000.000000000000000000)
          (
            'El Salvador'
            'San Salvador'
            'North America'
            20865.000000000000000000
            5300000.000000000000000000)
          (
            'Guyana'
            'Georgetown'
            'South America'
            214969.000000000000000000
            800000.000000000000000000)
          (
            'Jamaica'
            'Kingston'
            'North America'
            11424.000000000000000000
            2500000.000000000000000000)
          (
            'Mexico'
            'Mexico City'
            'North America'
            1967180.000000000000000000
            88600000.000000000000000000)
          (
            'Nicaragua'
            'Managua'
            'North America'
            139000.000000000000000000
            3900000.000000000000000000)
          (
            'Paraguay'
            'Asuncion'
            'South America'
            406576.000000000000000000
            4660000.000000000000000000)
          (
            'Peru'
            'Lima'
            'South America'
            1285215.000000000000000000
            21600000.000000000000000000)
          (
            'United States of America'
            'Washington'
            'North America'
            9363130.000000000000000000
            249200000.000000000000000000)
          (
            'Uruguay'
            'Montevideo'
            'South America'
            176140.000000000000000000
            3002000.000000000000000000)
          (
            'Venezuela'
            'Caracas'
            'South America'
            912047.000000000000000000
            19700000.000000000000000000))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 88
    Top = 296
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'FILE NAME=C:\Program Files (x86)\Common Files\System\OLE DB\Data' +
      ' Links\DBDEMOS.udl'
    CursorType = ctStatic
    TableName = 'country'
    Left = 184
    Top = 304
  end
  object ImageList1: TImageList
    Height = 10
    Width = 10
    Left = 320
    Top = 448
    Bitmap = {
      494C0101020008003C000A000A00FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000280000000A00000001002000000000004006
      0000000000000000000000000000000000000000000000000000000000400101
      01C6020202FF020202FF020202F1000000740000000A00000000000000000000
      0000000000000000000000000000000000000101013400000001000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000059050505E90303
      03C2000000660000006001010194060606F3030303A50000000A000000000000
      000000000000000000000000001F020202E00000005000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000400A0A0AF20B0B0BFF0808
      08D10000001D0000000000000000000000410B0B0BF102020282000000000000
      0000000000000000000000000040070707FF0000004000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000A0A0AC60A0A0AC50B0B0BD21010
      10FF0C0C0CD30000002A00000000000000000202026A0E0E0EE1000000000000
      000000000000000000000000003F0E0E0EFF0000003F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000161616FF02020266000000230F0F
      0FD4151515FF0F0F0FD4000000260000000000000017141414F0000000000000
      0000000000000000000000000047151515FF0000004700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001B1B1BFF0202025F000000000000
      002A121212D31A1A1AFF121212D3000000270000000A151515E6000000000000
      0000000000000000000D0F0F0FC1191919EF0F0F0FC10000000D000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001B1B1BEB0B0B0B95000000000000
      000000000026171717D41F1F1FFF151515CE050505671C1C1CEC000000000000
      0000000000030B0B0B9F131313CB00000029131313CB0B0B0B9F000000030000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000005050574222222F30101013F0000
      00000000000000000027181818CE242424FF252525FF0D0D0DA9000000000000
      00000505056C282828FF161616C80A0A0A98161616C8282828FF0505056D0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000009111111A5262626EA0606
      066B000000180000000F070707662A2A2AFF242424E30000002C000000000101
      0142292929F02D2D2DFF2E2E2EFF2E2E2EFF2E2E2EFF2D2D2DFF292929EF0101
      013A000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000009080808812525
      25DD2A2A2AEF252525E5282828EB111111A90000002E00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000A000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000280000000A0000000100010000000000500000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000}
  end
end
