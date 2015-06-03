object Form1: TForm1
  Left = 343
  Top = 122
  Width = 632
  Height = 459
  Caption = 'DataDriver.BDE.SimpleDemo - InterBase Connection'
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
    616
    421)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 40
    Top = 56
    Width = 489
    Height = 357
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = 16776957
    ColumnDefValues.Title.TitleButton = True
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    GridLineParams.GridBoundaries = True
    GridLineParams.ColorScheme = glcsThemedEh
    GridLineParams.VertEmptySpaceStyle = dessNonEh
    IndicatorOptions = [gioShowRowIndicatorEh]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghRowHighlight, dghDialogFind, dghColumnResize, dghColumnMove]
    SortLocal = True
    TabOrder = 0
    TitleParams.FillStyle = cfstGradientEh
    TitleParams.BorderInFillStyle = True
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CUST_NO'
        Footers = <>
        Title.Alignment = taRightJustify
        Width = 63
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
    Width = 616
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      616
      41)
    object Button1: TButton
      Left = 8
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
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Top = 16
  end
  object MemTableEh1: TMemTableEh
    Params = <>
    DataDriver = BDEDataDriverEh1
    Top = 48
  end
  object BDEDataDriverEh1: TBDEDataDriverEh
    ConnectionProvider = BDEConnectionProviderEh1
    MacroVars.SpecMacrosUsages = [smuUseFilterMacroEh]
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
      '  %table%'
      'where'
      '  CUST_NO = :OLD_CUST_NO')
    DynaSQLParams.Options = []
    SpecParams.Strings = (
      'AUTO_INCREMENT_FIELD=CUST_NO'
      'GENERATOR_FIELD=CUST_NO'
      'GENERATOR=CUST_NO_GEN')
    Top = 80
  end
  object Database2_IBLocal: TDatabase
    DatabaseName = 'NewDb'
    DriverName = 'INTRBASE'
    LoginPrompt = False
    Params.Strings = (
      'SERVER NAME=C:\CodeGear\InterBase\examples\database\employee.gdb'
      'USER NAME=sysdba'
      'OPEN MODE=READ/WRITE'
      'SCHEMA CACHE SIZE=8'
      'LANGDRIVER='
      'SQLQRYMODE='
      'SQLPASSTHRU MODE=SHARED AUTOCOMMIT'
      'SCHEMA CACHE TIME=-1'
      'MAX ROWS=-1'
      'BATCH COUNT=200'
      'ENABLE SCHEMA CACHE=FALSE'
      'SCHEMA CACHE DIR='
      'ENABLE BCD=FALSE'
      'BLOBS TO CACHE=64'
      'BLOB SIZE=32'
      'WAIT ON LOCKS=FALSE'
      'COMMIT RETAIN=FALSE'
      'ROLE NAME='
      'PASSWORD=masterkey')
    SessionName = 'Default'
    Top = 144
  end
  object BDEConnectionProviderEh1: TBDEConnectionProviderEh
    InlineConnection.DatabaseName = 'Ggg'
    InlineConnection.DriverName = 'INTRBASE'
    InlineConnection.Params.Strings = (
      'SERVER NAME=C:\CodeGear\InterBase\examples\database\employee.gdb'
      'USER NAME=sysdba'
      'OPEN MODE=READ/WRITE'
      'SCHEMA CACHE SIZE=8'
      'LANGDRIVER='
      'SQLQRYMODE='
      'SQLPASSTHRU MODE=SHARED AUTOCOMMIT'
      'SCHEMA CACHE TIME=-1'
      'MAX ROWS=-1'
      'BATCH COUNT=200'
      'ENABLE SCHEMA CACHE=FALSE'
      'SCHEMA CACHE DIR='
      'ENABLE BCD=FALSE'
      'BLOBS TO CACHE=64'
      'BLOB SIZE=32'
      'WAIT ON LOCKS=FALSE'
      'COMMIT RETAIN=FALSE'
      'ROLE NAME='
      'PASSWORD=masterkey')
    InlineConnection.UseAtDesignTime = True
    InlineConnection.UseAtRunTime = True
    ServerType = 'Interbase'
    InlineConnectionBeforeConnect = BDEConnectionProviderEh1InlineConnectionBeforeConnect
    Top = 112
  end
  object XPManifest1: TXPManifest
    Left = 576
    Top = 56
  end
end
