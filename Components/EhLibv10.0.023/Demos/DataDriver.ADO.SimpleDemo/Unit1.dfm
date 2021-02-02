object Form1: TForm1
  Left = 328
  Top = 269
  Width = 591
  Height = 452
  Caption = 'DataDriver.ADO.SimpleDemo - MSAccess Connection'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  DesignSize = (
    575
    414)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 32
    Top = 72
    Width = 505
    Height = 329
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    GridLineParams.GridBoundaries = True
    GridLineParams.VertEmptySpaceStyle = dessNonEh
    IndicatorOptions = [gioShowRowIndicatorEh]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghColumnResize, dghColumnMove]
    TabOrder = 0
    TitleParams.BorderInFillStyle = True
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'VendorNo'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'VendorName'
        Footers = <>
        Width = 119
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Address1'
        Footers = <>
        Width = 137
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Address2'
        Footers = <>
        Width = 23
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'City'
        Footers = <>
        Width = 96
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'State'
        Footers = <>
        Width = 27
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Zip'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Country'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Phone'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'FAX'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Preferred'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 575
    Height = 70
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 225
      Height = 57
      AutoSize = False
      Caption = 
        'Update, Insert and Delete Data to see what SQLs DataDriver sends' +
        ' to the Server.'
      WordWrap = True
    end
    object DBNavigator1: TDBNavigator
      Left = 256
      Top = 8
      Width = 240
      Height = 25
      DataSource = DataSource1
      TabOrder = 0
    end
    object Button1: TButton
      Left = 421
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Show SQLMon'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 256
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Reopen'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Top = 32
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Params = <>
    DataDriver = ADODataDriverEh1
    Top = 64
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
      '  vendors')
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
    Top = 96
  end
  object ADOConnectionProviderEh1: TADOConnectionProviderEh
    InlineConnection.Connected = True
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\..\D' +
      'ata\DBTest.mdb;Persist Security Info=False'
    InlineConnection.Mode = cmShareDenyNone
    InlineConnection.Provider = 'Microsoft.Jet.OLEDB.4.0'
    ServerType = 'MSAccess'
    OnExecuteCommand = ADOConnectionProviderEh1ExecuteCommand
    InlineConnectionBeforeConnect = ADOConnectionProviderEh1InlineConnectionBeforeConnect
    Top = 128
  end
end
