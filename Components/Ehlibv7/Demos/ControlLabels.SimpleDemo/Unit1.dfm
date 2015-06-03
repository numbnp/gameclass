object Form1: TForm1
  Left = 375
  Top = 124
  Width = 588
  Height = 365
  Caption = 'Form1'
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    572
    327)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 240
    Width = 546
    Height = 77
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    DynProps = <>
    FooterParams.Color = clWindow
    IndicatorOptions = [gioShowRowIndicatorEh]
    TabOrder = 0
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Name'
        Footers = <>
        Width = 96
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Capital'
        Footers = <>
        Width = 105
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Continent'
        Footers = <>
        Width = 125
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
  object DBEditEh1: TDBEditEh
    Left = 120
    Top = 24
    Width = 121
    Height = 21
    ControlLabel.Width = 28
    ControlLabel.Height = 13
    ControlLabel.Visible = True
    DataField = 'Name'
    DataSource = DataSource1
    DynProps = <>
    EditButtons = <>
    TabOrder = 1
    Visible = True
  end
  object DBEditEh2: TDBEditEh
    Left = 120
    Top = 64
    Width = 121
    Height = 21
    ControlLabel.Width = 32
    ControlLabel.Height = 13
    ControlLabel.Visible = True
    DataField = 'Capital'
    DataSource = DataSource1
    DynProps = <>
    EditButtons = <>
    TabOrder = 2
    Visible = True
  end
  object DBEditEh3: TDBEditEh
    Left = 120
    Top = 104
    Width = 121
    Height = 21
    ControlLabel.Width = 45
    ControlLabel.Height = 13
    ControlLabel.Visible = True
    DataField = 'Continent'
    DataSource = DataSource1
    DynProps = <>
    EditButtons = <>
    TabOrder = 3
    Visible = True
  end
  object DBNumberEditEh1: TDBNumberEditEh
    Left = 120
    Top = 144
    Width = 121
    Height = 21
    ControlLabel.Width = 22
    ControlLabel.Height = 13
    ControlLabel.Visible = True
    DataField = 'Area'
    DataSource = DataSource1
    DynProps = <>
    EditButtons = <>
    TabOrder = 4
    Visible = True
  end
  object DBNumberEditEh2: TDBNumberEditEh
    Left = 120
    Top = 184
    Width = 121
    Height = 21
    ControlLabel.Width = 50
    ControlLabel.Height = 13
    ControlLabel.Visible = True
    DataField = 'Population'
    DataSource = DataSource1
    DynProps = <>
    EditButtons = <>
    TabOrder = 5
    Visible = True
  end
  object GroupBox1: TGroupBox
    Left = 368
    Top = 8
    Width = 185
    Height = 217
    Anchors = [akTop, akRight]
    Caption = ' ControlLabelLocation '
    TabOrder = 6
    object DBComboBoxEh1: TDBComboBoxEh
      Left = 16
      Top = 47
      Width = 153
      Height = 21
      ControlLabel.Width = 66
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Label Position'
      ControlLabel.Visible = True
      ControlLabelLocation.Spacing = 5
      DynProps = <>
      DropDownBox.Rows = 17
      EditButtons = <>
      LimitTextToListValues = True
      TabOrder = 0
      Text = 'DBComboBoxEh1'
      Visible = True
      OnChange = DBComboBoxEh1Change
    end
    object DBNumberEditEh3: TDBNumberEditEh
      Left = 16
      Top = 88
      Width = 153
      Height = 21
      ControlLabel.Width = 57
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Label Offset'
      ControlLabel.Visible = True
      DynProps = <>
      EditButton.Style = ebsUpDownEh
      EditButton.Visible = True
      EditButtons = <>
      TabOrder = 1
      Visible = True
      OnChange = DBNumberEditEh3Change
    end
    object DBNumberEditEh4: TDBNumberEditEh
      Left = 16
      Top = 176
      Width = 153
      Height = 21
      ControlLabel.Width = 68
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Label Spacing'
      ControlLabel.Visible = True
      DynProps = <>
      EditButton.Style = ebsUpDownEh
      EditButton.Visible = True
      EditButtons = <>
      TabOrder = 2
      Value = 3.000000000000000000
      Visible = True
      OnChange = DBNumberEditEh4Change
    end
    object DBComboBoxEh2: TDBComboBoxEh
      Left = 16
      Top = 127
      Width = 153
      Height = 21
      ControlLabel.Width = 102
      ControlLabel.Height = 13
      ControlLabel.Caption = 'Label Spacing Bound'
      ControlLabel.Visible = True
      ControlLabelLocation.Spacing = 5
      DynProps = <>
      DropDownBox.Rows = 17
      EditButtons = <>
      LimitTextToListValues = True
      TabOrder = 3
      Text = 'DBComboBoxEh1'
      Visible = True
      OnChange = DBComboBoxEh2Change
    end
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
end
