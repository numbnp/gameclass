unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
// Add EhLibADO in any module of the project
  EhLibADO,
  MemTableDataEh, Db, ADODB, MemTableEh, GridsEh, DBGridEh, XPMan,
  StdCtrls, Mask, DBCtrlsEh, DbUtilsEh;

type
  TForm1 = class(TForm)
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    XPManifest1: TXPManifest;
    DBEditEh1: TDBEditEh;
    bSortLocal: TButton;
    Label1: TLabel;
    DBEditEh2: TDBEditEh;
    Label2: TLabel;
    bFilterIsLocal: TButton;
    Label3: TLabel;
    DBEditEh3: TDBEditEh;
    Label4: TLabel;
    Label5: TLabel;
    ADOConnection1: TADOConnection;
    ADOQuery2: TADOQuery;
    ADOQuery1OrderNo: TAutoIncField;
    ADOQuery1CustNo: TIntegerField;
    ADOQuery1SaleDate: TDateTimeField;
    ADOQuery1ShipDate: TDateTimeField;
    ADOQuery1EmpNo: TIntegerField;
    ADOQuery1ShipToContact: TWideStringField;
    ADOQuery1ShipToAddr1: TWideStringField;
    ADOQuery1ShipToAddr2: TWideStringField;
    ADOQuery1ShipToCity: TWideStringField;
    ADOQuery1ShipToState: TWideStringField;
    ADOQuery1ShipToZip: TWideStringField;
    ADOQuery1ShipToCountry: TWideStringField;
    ADOQuery1ShipToPhone: TWideStringField;
    ADOQuery1ShipVIA: TWideStringField;
    ADOQuery1PO: TWideStringField;
    ADOQuery1Terms: TWideStringField;
    ADOQuery1PaymentMethod: TWideStringField;
    ADOQuery1ItemsTotal: TFloatField;
    ADOQuery1TaxRate: TFloatField;
    ADOQuery1Freight: TFloatField;
    ADOQuery1AmountPaid: TFloatField;
    ADOQuery1CustNameLookup: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure ADOQuery1BeforeOpen(DataSet: TDataSet);
    procedure bSortLocalClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure bFilterIsLocalClick(Sender: TObject);
    procedure ADOConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Label3.Font.Name := Font.Name;
  DBEditEh1.Font.Name := Font.Name;

// As MSAccess doesn't support /**/ commencts in the SQL use the other trick
  DbUtilsEh.SQLFilterMarker := '1=1 AND';

  ADOQuery1.Open;
end;

procedure TForm1.ADOQuery1BeforeOpen(DataSet: TDataSet);
begin
  DBEditEh1.Text := ADOQuery1.SQL.Text;
end;

procedure TForm1.bSortLocalClick(Sender: TObject);
var
  i: Integer;
begin
  if DBGridEh1.SortLocal then
  begin
    for i := 0 to DBGridEh1.Columns.Count-1 do
      DBGridEh1.Columns[i].Title.SortMarker := smNoneEh;
    DBGridEh1.DefaultApplySorting;

    DBGridEh1.SortLocal := False;
    bSortLocal.Caption := 'Sort is on Server';
  end else
  begin
    for i := 0 to DBGridEh1.Columns.Count-1 do
      DBGridEh1.Columns[i].Title.SortMarker := smNoneEh;
    DBGridEh1.DefaultApplySorting;

    DBGridEh1.SortLocal := True;
    bSortLocal.Caption := 'Sort is on Client';
  end;
end;

procedure TForm1.bFilterIsLocalClick(Sender: TObject);
begin
  if DBGridEh1.STFilter.Local then
  begin
    DBGridEh1.ClearFilter;
    DBGridEh1.ApplyFilter;

    DBGridEh1.STFilter.Local := False;
    bFilterIsLocal.Caption := 'Filter is on Server';
  end else
  begin
    DBGridEh1.ClearFilter;
    DBGridEh1.ApplyFilter;

    DBGridEh1.STFilter.Local := True;
    bFilterIsLocal.Caption := 'Filter is on Client';
  end;
end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  DBEditEh2.Text := ADOQuery1.Sort;
  DBEditEh3.Text := ADOQuery1.Filter;
end;

procedure TForm1.ADOConnection1BeforeConnect(Sender: TObject);
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb';

  ADOConnection1.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
end;

initialization
  DefFontData.Name := 'Tahoma';
end.

