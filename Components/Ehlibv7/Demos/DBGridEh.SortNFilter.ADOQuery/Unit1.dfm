object Form1: TForm1
  Left = 469
  Top = 210
  Width = 708
  Height = 497
  Caption = 'DBGridEh - SortAndFilter in ADO Query'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    692
    459)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 203
    Width = 122
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'ADOQuery1.SQL property'
  end
  object Label2: TLabel
    Left = 323
    Top = 205
    Width = 120
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'ADOQuery1.Sort property'
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 432
    Height = 13
    Caption = 
      'Sort And Filter The Data in Grid to see how it changes ADOQuery ' +
      'properties'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 323
    Top = 253
    Width = 123
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'ADOQuery1.Filter property'
  end
  object Label5: TLabel
    Left = 320
    Top = 316
    Width = 330
    Height = 117
    Anchors = [akLeft, akRight, akBottom]
    Caption = 
      '-- For Sorting And Filtering'#13#10'  EhLibADO unit is in the uses cla' +
      'use'#13#10#13#10'-- For Sorting'#13#10'DBGridEh1.OptionsEh = [*,dghAutoSortMarki' +
      'ng, dghMultiSortMarking]'#13#10'DBGridEh1.ColumnDefValues.Title.TitleB' +
      'utton = True'#13#10'    '#13#10'-- For Filtering'#13#10'DBGridEh1.STFilter.Visible' +
      ' = True'
    WordWrap = True
  end
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 32
    Width = 527
    Height = 157
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.DropDownSizing = True
    ColumnDefValues.Title.TitleButton = True
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    FooterParams.Color = clWindow
    GridLineParams.ColorScheme = glcsThemedEh
    IndicatorOptions = [gioShowRowIndicatorEh]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
    STFilter.Visible = True
    TabOrder = 0
    TitleParams.MultiTitle = True
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'OrderNo'
        Footers = <>
        Width = 63
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CustNo'
        Footers = <>
        Width = 63
      end
      item
        DynProps = <>
        DropDownRows = 27
        DropDownWidth = -1
        EditButtons = <>
        FieldName = 'CustNameLookup'
        Footers = <>
        Width = 157
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'SaleDate'
        Footers = <>
        Width = 86
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipDate'
        Footers = <>
        Width = 76
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'EmpNo'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipToContact'
        Footers = <>
        Width = 82
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipToAddr1'
        Footers = <>
        Width = 42
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipToAddr2'
        Footers = <>
        Width = 83
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipToCity'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipToState'
        Footers = <>
        Width = 83
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipToZip'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipToCountry'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipToPhone'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ShipVIA'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'PO'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Terms'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'PaymentMethod'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ItemsTotal'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'TaxRate'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Freight'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'AmountPaid'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBEditEh1: TDBEditEh
    Left = 10
    Top = 220
    Width = 273
    Height = 227
    Anchors = [akLeft, akBottom]
    AutoSize = False
    DynProps = <>
    EditButtons = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = cl3DDkShadow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Text = 'DBEditEh1'
    Visible = True
  end
  object bSortLocal: TButton
    Left = 546
    Top = 64
    Width = 137
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Sort is on Server'
    TabOrder = 2
    OnClick = bSortLocalClick
  end
  object DBEditEh2: TDBEditEh
    Left = 320
    Top = 222
    Width = 364
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    DynProps = <>
    EditButtons = <>
    TabOrder = 3
    Text = 'DBEditEh2'
    Visible = True
  end
  object bFilterIsLocal: TButton
    Left = 546
    Top = 32
    Width = 137
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Filter is on Server'
    TabOrder = 4
    OnClick = bFilterIsLocalClick
  end
  object DBEditEh3: TDBEditEh
    Left = 320
    Top = 270
    Width = 364
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    DynProps = <>
    EditButtons = <>
    TabOrder = 5
    Text = 'DBEditEh3'
    Visible = True
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    OnDataChange = DataSource1DataChange
    Left = 40
    Top = 200
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    BeforeOpen = ADOQuery1BeforeOpen
    Parameters = <>
    SQL.Strings = (
      'select * '
      'from orders'
      'where'
      '1=1 AND 1=1')
    Left = 8
    Top = 200
    object ADOQuery1OrderNo: TAutoIncField
      FieldName = 'OrderNo'
      ReadOnly = True
    end
    object ADOQuery1CustNo: TIntegerField
      FieldName = 'CustNo'
    end
    object ADOQuery1SaleDate: TDateTimeField
      FieldName = 'SaleDate'
    end
    object ADOQuery1ShipDate: TDateTimeField
      FieldName = 'ShipDate'
    end
    object ADOQuery1EmpNo: TIntegerField
      FieldName = 'EmpNo'
    end
    object ADOQuery1ShipToContact: TWideStringField
      FieldName = 'ShipToContact'
    end
    object ADOQuery1ShipToAddr1: TWideStringField
      FieldName = 'ShipToAddr1'
      Size = 30
    end
    object ADOQuery1ShipToAddr2: TWideStringField
      FieldName = 'ShipToAddr2'
      Size = 30
    end
    object ADOQuery1ShipToCity: TWideStringField
      FieldName = 'ShipToCity'
      Size = 15
    end
    object ADOQuery1ShipToState: TWideStringField
      FieldName = 'ShipToState'
    end
    object ADOQuery1ShipToZip: TWideStringField
      FieldName = 'ShipToZip'
      Size = 10
    end
    object ADOQuery1ShipToCountry: TWideStringField
      FieldName = 'ShipToCountry'
    end
    object ADOQuery1ShipToPhone: TWideStringField
      FieldName = 'ShipToPhone'
      Size = 15
    end
    object ADOQuery1ShipVIA: TWideStringField
      FieldName = 'ShipVIA'
      Size = 7
    end
    object ADOQuery1PO: TWideStringField
      FieldName = 'PO'
      Size = 15
    end
    object ADOQuery1Terms: TWideStringField
      FieldName = 'Terms'
      Size = 6
    end
    object ADOQuery1PaymentMethod: TWideStringField
      FieldName = 'PaymentMethod'
      Size = 7
    end
    object ADOQuery1ItemsTotal: TFloatField
      FieldName = 'ItemsTotal'
    end
    object ADOQuery1TaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object ADOQuery1Freight: TFloatField
      FieldName = 'Freight'
    end
    object ADOQuery1AmountPaid: TFloatField
      FieldName = 'AmountPaid'
    end
    object ADOQuery1CustNameLookup: TStringField
      FieldKind = fkLookup
      FieldName = 'CustNameLookup'
      LookupDataSet = ADOQuery2
      LookupKeyFields = 'CustNo'
      LookupResultField = 'Company'
      KeyFields = 'CustNo'
      Size = 30
      Lookup = True
    end
  end
  object XPManifest1: TXPManifest
    Left = 65512
    Top = 64
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Delphi7\EhLib\De' +
      'mos\Data\DBTest.mdb;Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    BeforeConnect = ADOConnection1BeforeConnect
    Top = 424
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * '
      'from customer'
      'order by Company')
    Left = 32
    Top = 424
  end
end
