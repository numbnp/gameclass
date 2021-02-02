unit DataMod;

interface

uses
  SysUtils, Classes, MemTableDataEh, MemTableEh,
  Db, ADODB;

type
  TMainDataModule = class(TDataModule)
    MemTableEh1: TMemTableEh;
    MemTableEh1OrderNo: TFloatField;
    MemTableEh1CustNo: TFloatField;
    MemTableEh1SaleDate: TDateTimeField;
    MemTableEh1ShipDate: TDateTimeField;
    MemTableEh1EmpNo: TIntegerField;
    MemTableEh1ShipToContact: TWideStringField;
    MemTableEh1ShipToAddr1: TWideStringField;
    MemTableEh1ShipToAddr2: TWideStringField;
    MemTableEh1ShipToCity: TWideStringField;
    MemTableEh1ShipToState: TWideStringField;
    MemTableEh1ShipToZip: TWideStringField;
    MemTableEh1ShipToCountry: TWideStringField;
    MemTableEh1ShipToPhone: TWideStringField;
    MemTableEh1ShipVIA: TWideStringField;
    MemTableEh1PO: TWideStringField;
    MemTableEh1Terms: TWideStringField;
    MemTableEh1PaymentMethod: TWideStringField;
    MemTableEh1ItemsTotal: TFloatField;
    MemTableEh1TaxRate: TFloatField;
    MemTableEh1Freight: TFloatField;
    MemTableEh1AmountPaid: TFloatField;
    DataSource1: TDataSource;
    mtFishFact: TMemTableEh;
    dsFisgFact: TDataSource;
    ADOTable1: TADOTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainDataModule: TMainDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
