object Form1: TForm1
  Left = 416
  Top = 211
  Width = 694
  Height = 593
  Caption = 'Using DataDriver.Macros'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    678
    555)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 254
    Width = 281
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'ADODataDriverEh1.SelectSQL command with SpecMacros'
  end
  object Label2: TLabel
    Left = 354
    Top = 254
    Width = 46
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = 'Final SQL'
  end
  object Label3: TLabel
    Left = 8
    Top = 9
    Width = 239
    Height = 13
    Caption = 'Sort and filter data to see SQL Command changing'
  end
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 25
    Width = 656
    Height = 215
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColumnDefValues.Title.TitleButton = True
    DataSource = DataSource1
    DynProps = <>
    FooterParams.Color = clWindow
    IndicatorOptions = [gioShowRowIndicatorEh]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
    STFilter.InstantApply = True
    STFilter.Visible = True
    TabOrder = 0
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'VNo'
        Footers = <>
        STFilter.DataField = 'Vendors.VendorNo'
        OnFillSTFilterListValues = DBGridEh1Columns0FillSTFilterListValues
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'VName'
        Footers = <>
        STFilter.DataField = 'Vendors.VendorName'
        OnFillSTFilterListValues = DBGridEh1Columns0FillSTFilterListValues
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'VPreferred'
        Footers = <>
        STFilter.DataField = 'Vendors.Preferred'
        OnFillSTFilterListValues = DBGridEh1Columns0FillSTFilterListValues
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'PNo'
        Footers = <>
        STFilter.DataField = 'Parts.PartNo'
        OnFillSTFilterListValues = DBGridEh1Columns0FillSTFilterListValues
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'PDescription'
        Footers = <>
        STFilter.DataField = 'Parts.Description'
        Width = 154
        OnFillSTFilterListValues = DBGridEh1Columns0FillSTFilterListValues
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'PCost'
        Footers = <>
        STFilter.DataField = 'Parts.Cost'
        OnFillSTFilterListValues = DBGridEh1Columns0FillSTFilterListValues
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'IQty'
        Footers = <>
        STFilter.DataField = 'Items.Qty'
        Width = 41
        OnFillSTFilterListValues = DBGridEh1Columns0FillSTFilterListValues
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBEditEh1: TDBEditEh
    Left = 9
    Top = 270
    Width = 317
    Height = 244
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    DynProps = <>
    EditButtons = <>
    TabOrder = 1
    Text = 'DBEditEh1'
    Visible = True
    WordWrap = True
  end
  object DBEditEh2: TDBEditEh
    Left = 355
    Top = 270
    Width = 305
    Height = 244
    Anchors = [akRight, akBottom]
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
    TabOrder = 2
    Text = 'DBEditEh1'
    Visible = True
    WordWrap = True
  end
  object bExecute: TButton
    Left = 8
    Top = 526
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Execute'
    TabOrder = 3
    OnClick = bExecuteClick
  end
  object MemTableEh1: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ADODataDriverEh1
    Left = 56
    Top = 438
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 88
    Top = 438
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'FILE NAME=C:\Program Files (x86)\Common Files\System\OLE DB\Data' +
      ' Links\DBDEMOS.udl'
    CursorType = ctStatic
    TableName = 'country'
    Left = 56
    Top = 495
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.SpecMacrosUsages = [smuUseFilterMacroEh, smuFilterWithANDPrecedingEh, smuUseSortOrderMacroEh, smuSortOrderWithCommaPrecedingEh]
    MacroVars.Macros = <
      item
        Name = '%tb%'
        Value = 'customer'
      end>
    SelectCommand.CommandText.Strings = (
      'SELECT'
      ' Vendors.VendorNo As VNo,'
      ' Vendors.VendorName As VName,'
      ' Vendors.Preferred As VPreferred,'
      ' Parts.PartNo As PNo,'
      ' Parts.Description As PDescription,'
      ' Parts.Cost As PCost,'
      ' Items.Qty As IQty'
      ''
      'FROM Vendors, Parts, Items'
      'WHERE '
      '  Vendors.VendorNo = Parts.VendorNo AND'
      '  Parts.PartNo = Items.PartNo'
      '  %Filter%'
      'ORDER BY Vendors.VendorName %SortOrder%')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    OnExecuteCommand = ADODataDriverEh1ExecuteCommand
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
    Left = 56
    Top = 463
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
    Left = 24
    Top = 463
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 56
    Top = 527
  end
end
