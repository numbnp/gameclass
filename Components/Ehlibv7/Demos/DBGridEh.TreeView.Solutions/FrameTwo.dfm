object frFrameTwo: TfrFrameTwo
  Left = 0
  Top = 0
  Width = 435
  Height = 266
  Align = alClient
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      435
      73)
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 435
      Height = 73
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
      Left = 41
      Top = 7
      Width = 73
      Height = 23
      Caption = 'Demo 2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object bReopen: TButton
      Left = 40
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Reopen'
      TabOrder = 0
      OnClick = bReopenClick
    end
    object Memo1: TMemo
      Left = 120
      Top = 8
      Width = 305
      Height = 57
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      Lines.Strings = (
        
          'Dynamic progressive downloading of child nodes on expanding of p' +
          'arent nodes.'
        
          'Assume that we query returns information about availability of c' +
          'hild nodes for the parent node in an individual field.'
        'It puts a '#39'+'#39' sign where it is expected to be child nodes.')
      ParentColor = True
      ReadOnly = True
      TabOrder = 1
      WantReturns = False
      WordWrap = False
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 73
    Width = 435
    Height = 193
    Align = alClient
    DataSource = DataSource1
    DynProps = <>
    EditActions = [geaCopyEh, geaDeleteEh, geaSelectAllEh]
    Flat = True
    FooterParams.Color = clWindow
    FrozenCols = 1
    GridLineParams.GridBoundaries = True
    GridLineParams.ColorScheme = glcsThemedEh
    GridLineParams.VertEmptySpaceStyle = dessNonEh
    IndicatorOptions = [gioShowRowIndicatorEh]
    IndicatorParams.VertLines = True
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDblClickOptimizeColWidth, dghDialogFind, dghRecordMoving, dghColumnResize, dghColumnMove]
    STFilter.Local = True
    TabOrder = 1
    TitleParams.VertLines = True
    TitleParams.HorzLines = True
    TreeViewParams.ShowTreeLines = False
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'NODNAME'
        Footers = <>
        Width = 220
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID'
        Footers = <>
        Width = 48
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID_PARENT'
        Footers = <>
        Width = 63
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Expanded'
        Footer.FieldName = 'ExpCount'
        Footer.ValueType = fvtFieldValue
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Visible'
        Footers = <>
        Width = 38
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SpecParams.Strings = (
      'AUTO_INCREMENT_FIELD=VendorNo')
    SelectCommand.CommandText.Strings = (
      'select *, '
      
        ' (select count(*) from TestTree t1 where t1.id_parent = t.id ) a' +
        's ChildrenCount'
      'from'
      '  TestTree t'
      'where id_parent = 0')
    SelectCommand.Parameters = <>
    UpdateCommand.CommandText.Strings = (
      'update vendors'
      'set'
      '  VendorName = :VendorName,'
      '  Address1 = :Address1,'
      '  Address2 = :Address2,'
      '  City = :City,'
      '  State = :State,'
      '  Zip = :Zip,'
      '  Country = :Country,'
      '  Phone = :Phone,'
      '  FAX = :FAX,'
      '  Preferred = :Preferred'
      'where'
      '  VendorNo = :OLD_VendorNo')
    UpdateCommand.Parameters = <
      item
        Name = 'VendorName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Address1'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Address2'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'City'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'State'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Zip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Country'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Phone'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'FAX'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Preferred'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'OLD_VendorNo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    InsertCommand.CommandText.Strings = (
      'insert into vendors'
      
        '  (VendorName, Address1, Address2, City, State, Zip, Country, Ph' +
        'one, FAX, '
      '   Preferred)'
      'values'
      
        '  (:VendorName, :Address1, :Address2, :City, :State, :Zip, :Coun' +
        'try, :Phone, '
      '   :FAX, :Preferred)')
    InsertCommand.Parameters = <
      item
        Name = 'VendorName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Address1'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Address2'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'City'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'State'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Zip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Country'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Phone'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'FAX'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Preferred'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    DeleteCommand.CommandText.Strings = (
      'delete from vendors'
      'where'
      '  VendorNo = :OLD_VendorNo')
    DeleteCommand.Parameters = <
      item
        Name = 'OLD_VendorNo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    GetrecCommand.CommandText.Strings = (
      'select *'
      'from'
      '  vendors'
      'where'
      '  VendorNo = :OLD_VendorNo')
    GetrecCommand.Parameters = <
      item
        Name = 'OLD_VendorNo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 8
    Top = 288
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 8
    Top = 256
  end
  object MemTableEh1: TMemTableEh
    CachedUpdates = True
    FieldDefs = <
      item
        Name = 'ChildrenCount'
        DataType = ftInteger
        Precision = 15
      end
      item
        Name = 'ID'
        DataType = ftInteger
        Precision = 15
      end
      item
        Name = 'ID_PARENT'
        DataType = ftInteger
        Precision = 15
      end
      item
        Name = 'NODNAME'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Expanded'
        DataType = ftInteger
        Precision = 15
      end
      item
        Name = 'Visible'
        DataType = ftInteger
        Precision = 15
      end>
    FetchAllOnOpen = True
    IndexDefs = <
      item
        Name = 'MemTableEh1Index1'
        Fields = 'ID'
        Options = [ixPrimary]
      end>
    Params = <>
    DataDriver = ADODataDriverEh1
    StoreDefs = True
    TreeList.Active = True
    TreeList.KeyFieldName = 'ID'
    TreeList.RefParentFieldName = 'ID_PARENT'
    Left = 8
    Top = 224
    object MemTableEh1ExpCount: TAggregateField
      FieldName = 'ExpCount'
      Active = True
      Expression = 'SUM(Expanded)'
    end
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'select *, '
      
        ' (select count(*) from TestTree t1 where t1.id_parent = t.id ) a' +
        's ChildrenCount'
      'from'
      '  TestTree t'
      'where id_parent = :id_parent')
    Left = 8
    Top = 328
  end
end
