object Form1: TForm1
  Left = 316
  Top = 125
  Width = 495
  Height = 459
  Caption = 'DataDriver.IBx.SimpleDemo - InterBase Connection'
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
    479
    421)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 64
    Width = 395
    Height = 313
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
    Width = 479
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object DBNavigator1: TDBNavigator
      Left = 96
      Top = 8
      Width = 240
      Height = 25
      DataSource = DataSource1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 10
      Top = 8
      Width = 70
      Height = 25
      Caption = 'Open Query'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 424
    Top = 32
  end
  object MemTableEh1: TMemTableEh
    Params = <>
    DataDriver = IBXDataDriverEh1
    Left = 424
    Top = 64
  end
  object IBXDataDriverEh1: TIBXDataDriverEh
    ConnectionProvider = IBXConnectionProviderEh1
    MacroVars.Macros = <>
    SelectCommand.Params = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  CUSTOMER')
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
        Name = 'CUST_NO'
        ParamType = ptUnknown
      end
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
      
        '  (CUST_NO, CUSTOMER, CONTACT_FIRST, CONTACT_LAST, PHONE_NO, ADD' +
        'RESS_LINE1, '
      
        '   ADDRESS_LINE2, CITY, STATE_PROVINCE, COUNTRY, POSTAL_CODE, ON' +
        '_HOLD)'
      'values'
      
        '  (:CUST_NO, :CUSTOMER, :CONTACT_FIRST, :CONTACT_LAST, :PHONE_NO' +
        ', :ADDRESS_LINE1, '
      
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
    OnBuildDataStruct = IBXDataDriverEh1BuildDataStruct
    Left = 424
    Top = 96
  end
  object IBXConnectionProviderEh1: TIBXConnectionProviderEh
    InlineConnection.DatabaseName = 'C:\CodeGear\InterBase\examples\database\employee.gdb'
    InlineConnection.Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    InlineConnection.UseAtDesignTime = True
    InlineConnection.UseAtRunTime = True
    InlineConnectionBeforeConnect = IBXConnectionProviderEh1InlineConnectionBeforeConnect
    Left = 424
    Top = 128
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = 'C:\CodeGear\InterBase\examples\database\employee.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 424
    Top = 160
  end
  object XPManifest1: TXPManifest
    Top = 384
  end
end
