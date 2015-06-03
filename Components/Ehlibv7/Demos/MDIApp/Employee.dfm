object fEmployee: TfEmployee
  Left = 356
  Top = 262
  Width = 662
  Height = 596
  Caption = 'Employee'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 646
    Height = 37
    Align = alTop
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 8
      Top = 6
      Width = 240
      Height = 25
      DataSource = dsEmp
      Flat = True
      TabOrder = 0
    end
  end
  object gridEmp: TDBGridEh
    Left = 0
    Top = 37
    Width = 646
    Height = 521
    Align = alClient
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.Title.TitleButton = True
    ColumnDefValues.Title.ToolTips = True
    ColumnDefValues.ToolTips = True
    DataSource = dsEmp
    Flat = True
    FooterParams.Color = clWindow
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    OddRowColor = clInactiveBorder
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghIncSearch, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentShowHint = False
    RowDetailPanel.Active = True
    RowDetailPanel.Height = 300
    ShowHint = True
    SortLocal = True
    STFilter.InstantApply = True
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    TabOrder = 1
    Columns = <
      item
        EditButtons = <>
        FieldName = 'EmpNo'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'LastName'
        Footers = <>
        Width = 151
      end
      item
        EditButtons = <>
        FieldName = 'FirstName'
        Footers = <>
        Width = 123
      end
      item
        EditButtons = <>
        FieldName = 'PhoneExt'
        Footers = <>
        Width = 43
      end
      item
        EditButtons = <>
        FieldName = 'HireDate'
        Footers = <>
        Width = 108
      end
      item
        EditButtons = <>
        FieldName = 'Salary'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 538
        Height = 298
        ActivePage = TabSheet1
        Align = alClient
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = 'Orders'
          object DBGridEh2: TDBGridEh
            Left = 0
            Top = 0
            Width = 530
            Height = 270
            Align = alClient
            ColumnDefValues.Title.ToolTips = True
            ColumnDefValues.ToolTips = True
            DataSource = dsOrders
            EditActions = [geaCopyEh, geaSelectAllEh]
            Flat = True
            FooterParams.Color = clWindow
            IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
            IndicatorTitle.ShowDropDownSign = True
            IndicatorTitle.TitleButton = True
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            STFilter.InstantApply = True
            STFilter.Local = True
            STFilter.Location = stflInTitleFilterEh
            STFilter.Visible = True
            TabOrder = 0
            Columns = <
              item
                EditButtons = <>
                FieldName = 'OrderNo'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'CustNo'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'SaleDate'
                Footers = <>
                Width = 72
              end
              item
                EditButtons = <>
                FieldName = 'ShipDate'
                Footers = <>
                Width = 77
              end
              item
                EditButtons = <>
                FieldName = 'EmpNo'
                Footers = <>
                Width = 51
              end
              item
                EditButtons = <>
                FieldName = 'ShipToContact'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'ShipToAddr1'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'ShipToAddr2'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'ShipToCity'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'ShipToState'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'ShipToZip'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'ShipToCountry'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'ShipToPhone'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'ShipVIA'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'PO'
                Footers = <>
                Width = 38
              end
              item
                EditButtons = <>
                FieldName = 'Terms'
                Footers = <>
                Width = 52
              end
              item
                EditButtons = <>
                FieldName = 'PaymentMethod'
                Footers = <>
                Width = 73
              end
              item
                EditButtons = <>
                FieldName = 'ItemsTotal'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'TaxRate'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Freight'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'AmountPaid'
                Footers = <>
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
      end
    end
  end
  object mtEmp: TMemTableEh
    Active = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ddrEmp
    Left = 1072
    Top = 88
  end
  object ddrEmp: TADODataDriverEh
    ConnectionProvider = MainForm.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.SpecMacrosUsages = []
    SpecParams.Strings = (
      'AUTO_INCREMENT_FIELD=EmpNo')
    SelectCommand.CommandText.Strings = (
      'select'
      '  EmpNo'
      '  ,LastName'
      '  ,FirstName'
      '  ,PhoneExt'
      '  ,HireDate'
      '  ,Salary'
      'from'
      '  employee')
    SelectCommand.Parameters = <>
    UpdateCommand.CommandText.Strings = (
      'update employee'
      'set'
      '  LastName = :LastName,'
      '  FirstName = :FirstName,'
      '  PhoneExt = :PhoneExt,'
      '  HireDate = :HireDate,'
      '  Salary = :Salary'
      'where'
      '  EmpNo = :OLD_EmpNo')
    UpdateCommand.Parameters = <
      item
        Name = 'LastName'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'FirstName'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'PhoneExt'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'HireDate'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Salary'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'OLD_EmpNo'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    InsertCommand.CommandText.Strings = (
      'insert into employee'
      '  (LastName, FirstName, PhoneExt, HireDate, Salary)'
      'values'
      '  (:LastName, :FirstName, :PhoneExt, :HireDate, :Salary)')
    InsertCommand.Parameters = <
      item
        Name = 'LastName'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'FirstName'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'PhoneExt'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'HireDate'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Salary'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    DeleteCommand.CommandText.Strings = (
      'delete from employee'
      'where'
      '  EmpNo = :OLD_EmpNo')
    DeleteCommand.Parameters = <
      item
        Name = 'OLD_EmpNo'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    GetrecCommand.CommandText.Strings = (
      'select'
      '  EmpNo'
      '  ,LastName'
      '  ,FirstName'
      '  ,PhoneExt'
      '  ,HireDate'
      '  ,Salary'
      'from'
      '  employee'
      '  EmpNo = :OLD_EmpNo')
    GetrecCommand.Parameters = <
      item
        Name = 'OLD_EmpNo'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    Left = 1072
    Top = 120
  end
  object dsEmp: TDataSource
    DataSet = mtEmp
    Left = 1072
    Top = 56
  end
  object dsOrders: TDataSource
    DataSet = mtOrders
    Left = 1112
    Top = 56
  end
  object mtOrders: TMemTableEh
    Active = True
    DetailFields = 'EmpNo'
    FetchAllOnOpen = True
    MasterDetailSide = mdsOnProviderEh
    MasterFields = 'EmpNo'
    MasterSource = dsEmp
    Params = <>
    DataDriver = ddrOrders
    ReadOnly = True
    Left = 1112
    Top = 88
  end
  object ddrOrders: TADODataDriverEh
    ConnectionProvider = MainForm.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.SpecMacrosUsages = []
    SpecParams.Strings = (
      'AUTO_INCREMENT_FIELD=CustNo')
    SelectCommand.CommandText.Strings = (
      'select'
      '  OrderNo'
      '  ,CustNo'
      '  ,SaleDate'
      '  ,ShipDate'
      '  ,EmpNo'
      '  ,ShipToContact'
      '  ,ShipToAddr1'
      '  ,ShipToAddr2'
      '  ,ShipToCity'
      '  ,ShipToState'
      '  ,ShipToZip'
      '  ,ShipToCountry'
      '  ,ShipToPhone'
      '  ,ShipVIA'
      '  ,PO'
      '  ,Terms'
      '  ,PaymentMethod'
      '  ,ItemsTotal'
      '  ,TaxRate'
      '  ,Freight'
      '  ,AmountPaid'
      'from'
      '  orders'
      'where '
      '  EmpNo = :EmpNo')
    SelectCommand.Parameters = <
      item
        Name = 'EmpNo'
        DataType = ftInteger
        Size = 4
        Value = 1
      end>
    UpdateCommand.CommandText.Strings = (
      'update customer'
      'set'
      '  Company = :Company,'
      '  Addr1 = :Addr1,'
      '  Addr2 = :Addr2,'
      '  City = :City,'
      '  State = :State,'
      '  Zip = :Zip,'
      '  Country = :Country,'
      '  Phone = :Phone,'
      '  FAX = :FAX,'
      '  TaxRate = :TaxRate,'
      '  Contact = :Contact,'
      '  LastInvoiceDate = :LastInvoiceDate'
      'where'
      '  CustNo = :OLD_CustNo')
    UpdateCommand.Parameters = <
      item
        Name = 'Company'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Addr1'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Addr2'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'City'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'State'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Zip'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'FAX'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'TaxRate'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Contact'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'LastInvoiceDate'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'OLD_CustNo'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    InsertCommand.CommandText.Strings = (
      'insert into customer'
      '  (Company, Addr1, Addr2, City, State, Zip, Country, Phone, '
      'FAX, TaxRate, '
      '   Contact, LastInvoiceDate)'
      'values'
      '  (:Company, :Addr1, :Addr2, :City, :State, :Zip, :Country, '
      ':Phone, :FAX, '
      '   :TaxRate, :Contact, :LastInvoiceDate)')
    InsertCommand.Parameters = <
      item
        Name = 'Company'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Addr1'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Addr2'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'City'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'State'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Zip'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'FAX'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'TaxRate'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Contact'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'LastInvoiceDate'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    DeleteCommand.CommandText.Strings = (
      'delete from customer'
      'where'
      '  CustNo = :OLD_CustNo')
    DeleteCommand.Parameters = <
      item
        Name = 'OLD_CustNo'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    GetrecCommand.CommandText.Strings = (
      'select'
      '  CustNo'
      '  ,Company'
      '  ,Addr1'
      '  ,Addr2'
      '  ,City'
      '  ,State'
      '  ,Zip'
      '  ,Country'
      '  ,Phone'
      '  ,FAX'
      '  ,TaxRate'
      '  ,Contact'
      '  ,LastInvoiceDate'
      'from'
      '  customer'
      '  CustNo = :OLD_CustNo')
    GetrecCommand.Parameters = <
      item
        Name = 'OLD_CustNo'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    Left = 1112
    Top = 120
  end
end
