object Form1: TForm1
  Left = 428
  Top = 208
  Width = 654
  Height = 472
  Caption = 'DBGridEh.HideDuplicates Demo'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    638
    434)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 16
    Width = 612
    Height = 396
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    FooterParams.Color = clWindow
    GridLineParams.ColorScheme = glcsThemedEh
    IndicatorOptions = [gioShowRowIndicatorEh]
    TabOrder = 0
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'OrderNo'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'SaleDate'
        Footers = <>
        Width = 79
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipDate'
        Footers = <>
        Width = 80
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'EmpNo'
        Footers = <>
        HideDuplicates = True
        Width = 49
        OnGetHideDuplicatesValue = DBGridEh1Columns3GetHideDuplicatesValue
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'LastName'
        Footers = <>
        HideDuplicates = True
        Width = 78
        OnGetHideDuplicatesValue = DBGridEh1Columns3GetHideDuplicatesValue
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'FirstName'
        Footers = <>
        HideDuplicates = True
        Width = 65
        OnGetHideDuplicatesValue = DBGridEh1Columns3GetHideDuplicatesValue
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'HireDate'
        Footers = <>
        HideDuplicates = True
        OnGetHideDuplicatesValue = DBGridEh1Columns3GetHideDuplicatesValue
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
      'FILE NAME=C:\Program Files\Common Files\System\OLE DB\Data Links' +
      '\DBDEMOS.udl'
    CursorType = ctStatic
    TableName = 'customer'
    Left = 184
    Top = 304
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'SELECT '
      ' orders.OrderNo, '
      ' orders.SaleDate, '
      ' orders.ShipDate, '
      ' orders.EmpNo, '
      ' employee.LastName, '
      ' employee.FirstName, '
      ' employee.HireDate'
      'FROM employee '
      '  INNER JOIN orders ON employee.EmpNo = orders.EmpNo'
      'WHERE (((employee.LastName)="Baldwin"));')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 248
    Top = 400
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
    Left = 280
    Top = 400
  end
end
