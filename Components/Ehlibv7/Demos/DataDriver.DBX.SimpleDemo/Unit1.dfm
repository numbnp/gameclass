object Form1: TForm1
  Left = 328
  Top = 216
  Width = 493
  Height = 459
  Caption = 'DataDriver.DBX.SimpleDemo - InterBase Connection'
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
    477
    421)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 48
    Width = 380
    Height = 369
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
        FieldName = 'CUST_NO'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CUSTOMER'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CONTACT_FIRST'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CONTACT_LAST'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'PHONE_NO'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ADDRESS_LINE1'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ADDRESS_LINE2'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CITY'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'STATE_PROVINCE'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'COUNTRY'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'POSTAL_CODE'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ON_HOLD'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 477
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      477
      41)
    object Button1: TButton
      Left = -131
      Top = 8
      Width = 70
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Open Query'
      TabOrder = 0
      OnClick = Button1Click
    end
    object DBNavigator1: TDBNavigator
      Left = 96
      Top = 8
      Width = 240
      Height = 25
      DataSource = DataSource1
      TabOrder = 1
    end
    object Button2: TButton
      Left = 8
      Top = 8
      Width = 70
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Open Query'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 424
    Top = 72
  end
  object MemTableEh1: TMemTableEh
    FetchAllOnOpen = True
    Params = <>
    DataDriver = DBXDataDriverEh1
    Left = 424
    Top = 104
  end
  object DBXDataDriverEh1: TDBXDataDriverEh
    ConnectionProvider = DBXConnectionProviderEh1
    MacroVars.Macros = <>
    SelectCommand.Params = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  CUSTOMER'
      '')
    UpdateCommand.Params = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMER'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CONTACT_FIRST'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CONTACT_LAST'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_NO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ADDRESS_LINE1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ADDRESS_LINE2'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CITY'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'STATE_PROVINCE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'COUNTRY'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'POSTAL_CODE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ON_HOLD'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_CUST_NO'
        ParamType = ptUnknown
      end>
    UpdateCommand.CommandText.Strings = (
      'update CUSTOMER'
      'set'
      '  CUSTOMER = :CUSTOMER,'
      '  CONTACT_FIRST = :CONTACT_FIRST,'
      '  CONTACT_LAST = :CONTACT_LAST,'
      '  PHONE_NO = :PHONE_NO,'
      '  ADDRESS_LINE1 = :ADDRESS_LINE1,'
      '  ADDRESS_LINE2 = :ADDRESS_LINE2,'
      '  CITY = :CITY,'
      '  STATE_PROVINCE = :STATE_PROVINCE,'
      '  COUNTRY = :COUNTRY,'
      '  POSTAL_CODE = :POSTAL_CODE,'
      '  ON_HOLD = :ON_HOLD'
      'where'
      '  CUST_NO = :OLD_CUST_NO')
    InsertCommand.Params = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMER'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CONTACT_FIRST'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CONTACT_LAST'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_NO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ADDRESS_LINE1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ADDRESS_LINE2'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CITY'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'STATE_PROVINCE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'COUNTRY'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'POSTAL_CODE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ON_HOLD'
        ParamType = ptUnknown
      end>
    InsertCommand.CommandText.Strings = (
      'insert into CUSTOMER'
      
        '  (CUSTOMER, CONTACT_FIRST, CONTACT_LAST, PHONE_NO, ADDRESS_LINE' +
        '1, ADDRESS_LINE2, '
      '   CITY, STATE_PROVINCE, COUNTRY, POSTAL_CODE, ON_HOLD)'
      'values'
      
        '  (:CUSTOMER, :CONTACT_FIRST, :CONTACT_LAST, :PHONE_NO, :ADDRESS' +
        '_LINE1, '
      
        '   :ADDRESS_LINE2, :CITY, :STATE_PROVINCE, :COUNTRY, :POSTAL_COD' +
        'E, :ON_HOLD)')
    DeleteCommand.Params = <
      item
        DataType = ftUnknown
        Name = 'OLD_CUST_NO'
        ParamType = ptUnknown
      end>
    DeleteCommand.CommandText.Strings = (
      'delete from CUSTOMER'
      'where'
      '  CUST_NO = :OLD_CUST_NO')
    GetrecCommand.Params = <
      item
        DataType = ftUnknown
        Name = 'OLD_CUST_NO'
        ParamType = ptUnknown
      end>
    GetrecCommand.CommandText.Strings = (
      'select *'
      'from'
      '  CUSTOMER'
      'where'
      '  CUST_NO = :OLD_CUST_NO')
    DynaSQLParams.Options = []
    SpecParams.Strings = (
      'GENERATOR=CUST_NO_GEN'
      'GENERATOR_FIELD=CUST_NO'
      'AUTO_INCREMENT_FIELD=CUST_NO')
    OnBuildDataStruct = DBXDataDriverEh1BuildDataStruct
    Left = 424
    Top = 136
  end
  object DBXConnectionProviderEh1: TDBXConnectionProviderEh
    SQLConnection = SQLConnection1
    InlineConnection.ConnectionName = 'IBConnection'
    InlineConnection.DriverName = 'Interbase'
    InlineConnection.GetDriverFunc = 'getSQLDriverINTERBASE'
    InlineConnection.LibraryName = 'dbexpint.dll'
    InlineConnection.LoginPrompt = False
    InlineConnection.Params.Strings = (
      'DriverName=Interbase'
      'Database=C:\CodeGear\InterBase\examples\database\employee.gdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    InlineConnection.VendorLib = 'gds32.dll'
    InlineConnection.Connected = True
    InlineConnection.UseAtDesignTime = True
    InlineConnection.UseAtRunTime = True
    ServerType = 'Interbase'
    InlineConnectionBeforeConnect = DBXConnectionProviderEh1InlineConnectionBeforeConnect
    Left = 424
    Top = 168
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'IbDemos'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=<>\employee.gdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    Left = 424
    Top = 200
  end
  object XPManifest1: TXPManifest
    Top = 392
  end
end
