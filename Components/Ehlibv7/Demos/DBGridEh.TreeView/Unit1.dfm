object Form1: TForm1
  Left = 458
  Top = 187
  Width = 509
  Height = 345
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    493
    307)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 16
    Top = 40
    Width = 473
    Height = 257
    Anchors = [akLeft, akTop, akRight, akBottom]
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
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDblClickOptimizeColWidth, dghDialogFind, dghRecordMoving, dghColumnResize, dghColumnMove]
    STFilter.Local = True
    STFilter.Visible = True
    TabOrder = 0
    TitleParams.VertLines = True
    TitleParams.HorzLines = True
    TreeViewParams.GlyphStyle = tvgsExplorerThemedEh
    TreeViewParams.ShowTreeLines = False
    OnMoveRecords = DBGridEh1MoveRecords
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
  object DBNavigator1: TDBNavigator
    Left = 19
    Top = 6
    Width = 220
    Height = 25
    DataSource = DataSource1
    Flat = True
    TabOrder = 1
  end
  object Button1: TButton
    Left = 176
    Top = 8
    Width = 70
    Height = 24
    Caption = 'Button1'
    TabOrder = 2
    Visible = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 252
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    Visible = False
    OnClick = Button2Click
  end
  object MemTableEh1: TMemTableEh
    Active = True
    CachedUpdates = True
    FieldDefs = <
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
    Top = 16
    object MemTableEh1ExpCount: TAggregateField
      FieldName = 'ExpCount'
      Active = True
      Expression = 'SUM(Expanded)'
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 8
    Top = 48
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SpecParams.Strings = (
      'AUTO_INCREMENT_FIELD=VendorNo')
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  TestTree')
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
    Top = 128
  end
  object ADOConnectionProviderEh1: TADOConnectionProviderEh
    InlineConnection.Connected = True
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\..\D' +
      'ata\DBTest.mdb;Persist Security Info=False'
    InlineConnection.Mode = cmShareDenyNone
    InlineConnection.Provider = 'Microsoft.Jet.OLEDB.4.0'
    ServerType = 'MSAccess'
    InlineConnectionBeforeConnect = ADOConnectionProviderEh1InlineConnectionBeforeConnect
    Left = 8
    Top = 160
  end
end
