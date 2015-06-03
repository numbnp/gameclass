object Form1: TForm1
  Left = 375
  Top = 124
  Width = 592
  Height = 578
  Caption = 'Using DataDriver.Macros'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    576
    540)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 177
    Top = 9
    Width = 256
    Height = 13
    Caption = 'ADODataDriverEh1.SelectSQL command with Macros'
  end
  object Label2: TLabel
    Left = 177
    Top = 145
    Width = 46
    Height = 13
    Caption = 'Final SQL'
  end
  object Label3: TLabel
    Left = 8
    Top = 313
    Width = 64
    Height = 13
    Caption = 'Query Result '
  end
  object Label4: TLabel
    Left = 9
    Top = 8
    Width = 128
    Height = 26
    Caption = 'List of available tables - for %tb% macro'
    WordWrap = True
  end
  object Label5: TLabel
    Left = 8
    Top = 228
    Width = 104
    Height = 26
    Caption = 'Order By FieldNo - for %SortOrder% macro'
    WordWrap = True
  end
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 329
    Width = 554
    Height = 202
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    DynProps = <>
    FooterParams.Color = clWindow
    IndicatorOptions = [gioShowRowIndicatorEh]
    TabOrder = 0
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBGridEh2: TDBGridEh
    Left = 9
    Top = 40
    Width = 152
    Height = 177
    DataSource = dsTablesList
    DynProps = <>
    IndicatorOptions = [gioShowRowIndicatorEh]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Table_name'
        Footers = <>
        Width = 116
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBEditEh1: TDBEditEh
    Left = 177
    Top = 25
    Width = 386
    Height = 113
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    DynProps = <>
    EditButtons = <>
    TabOrder = 2
    Text = 'DBEditEh1'
    Visible = True
    WordWrap = True
  end
  object DBEditEh2: TDBEditEh
    Left = 176
    Top = 161
    Width = 387
    Height = 113
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    DynProps = <>
    EditButtons = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    Text = 'DBEditEh1'
    Visible = True
    WordWrap = True
  end
  object bExecute: TButton
    Left = 176
    Top = 281
    Width = 75
    Height = 25
    Caption = 'Execute'
    TabOrder = 4
    OnClick = bExecuteClick
  end
  object dbeOrderBy: TDBEditEh
    Left = 8
    Top = 256
    Width = 145
    Height = 21
    DynProps = <>
    EditButtons = <>
    TabOrder = 5
    Text = '1'
    Visible = True
  end
  object MemTableEh1: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ADODataDriverEh1
    Left = 56
    Top = 296
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
    Left = 224
    Top = 153
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.SpecMacrosUsages = [smuFilterAsWhereClauseEh, smuUseSortOrderMacroEh, smuSortOrderAsOrderByClauseEh]
    MacroVars.Macros = <
      item
        Name = '%tb%'
        Value = 'customer'
      end>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  %tb%'
      '%SortOrder%')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 480
    Top = 456
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
    Left = 512
    Top = 456
  end
  object mtTablesList: TMemTableEh
    Active = True
    Params = <>
    Left = 224
    Top = 121
    object mtTablesListTableName: TStringField
      FieldName = 'TableName'
      Size = 255
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object TableName: TMTStringDataFieldEh
          FieldName = 'TableName'
          StringDataType = fdtStringEh
          Size = 255
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            'Table1'))
      end
    end
  end
  object dsTablesList: TDataSource
    DataSet = ADODataSet1
    Left = 192
    Top = 121
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 224
    Top = 185
  end
end
