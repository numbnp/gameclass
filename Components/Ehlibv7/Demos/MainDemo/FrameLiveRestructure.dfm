object frLiveRestructure: TfrLiveRestructure
  Left = 0
  Top = 0
  Width = 505
  Height = 407
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentBackground = False
  ParentFont = False
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 505
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 505
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
      Left = 22
      Top = 4
      Width = 92
      Height = 23
      Caption = 'Main Grid'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 33
    Width = 505
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 113
      Height = 25
      Caption = 'Add New Field'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 73
    Width = 505
    Height = 334
    Align = alClient
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    IndicatorOptions = [gioShowRowIndicatorEh]
    TabOrder = 2
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Params = <>
    Left = 8
    Top = 368
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object IntField: TMTNumericDataFieldEh
          FieldName = 'IntField'
          NumericDataType = fdtSmallintEh
          AutoIncrement = False
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object StringField: TMTStringDataFieldEh
          FieldName = 'StringField'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1
            'Text1')
          (
            2
            'Text2')
          (
            3
            'Text3')
          (
            4
            'Text4')
          (
            5
            'Text5')
          (
            6
            'Text6')
          (
            7
            'Text7')
          (
            8
            'Text8')
          (
            9
            'Text9')
          (
            10
            'Text10'))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 40
    Top = 368
  end
end
