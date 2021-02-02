object Form1: TForm1
  Left = 463
  Top = 170
  Width = 575
  Height = 467
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poScreenCenter
  OldCreateOrder = False
  DesignSize = (
    559
    429)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 7
    Width = 436
    Height = 51
    AutoSize = False
    Caption = 
      'You can use TDataSetDriverEh.OnBuildDataStruct and ReadRecord ev' +
      'ents to convert data that transfer from DataDriver to MemTable.'#13 +
      #10'For example to divide DataTime field to Data and Time.'
    WordWrap = True
  end
  object DBGridEh1: TDBGridEh
    Left = 16
    Top = 64
    Width = 529
    Height = 353
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    FooterParams.Color = clWindow
    IndicatorOptions = [gioShowRowIndicatorEh]
    TabOrder = 0
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CustNo'
        Footers = <>
        Width = 50
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Company'
        Footers = <>
        Width = 97
      end
      item
        Color = cl3DLight
        DynProps = <>
        EditButtons = <>
        FieldName = 'LastInvoiceDate'
        Footers = <>
        ReadOnly = True
        Width = 133
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'LastInvoiceDate1'
        Footers = <>
        Width = 103
      end
      item
        DisplayFormat = 'HH:MM:SS'
        DynProps = <>
        EditButtons = <>
        FieldName = 'LastInvoiceTime1'
        Footers = <>
        Width = 107
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object MemTableEh1: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ADODataDriverEh1
    OnSetFieldValue = MemTableEh1SetFieldValue
    Left = 52
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 20
    Top = 80
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  customer')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    OnBuildDataStruct = DataSetDriverEh1BuildDataStruct
    OnReadRecord = DataSetDriverEh1ReadRecord
    Left = 152
    Top = 80
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
    Left = 184
    Top = 80
  end
end
