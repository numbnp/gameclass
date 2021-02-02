unit DM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, PrnDbgeh, ImgList, MemTableEh, DataDriverEh,
  EhLibMTE, MemTableDataEh, ADODB, Db;

type
  TDataModule1 = class(TDataModule)
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    ImageList2: TImageList;
    ilArrows: TImageList;
    ImageList1: TImageList;
    DataSource1: TDataSource;
    dsVendors: TDataSource;
    dstCustomer: TDataSource;
    dsCustomer2: TDataSource;
    dsCustomer: TDataSource;
    dsEmployee: TDataSource;
    dsPartsDescriprion: TDataSource;
    ilYesNo: TImageList;
    mtQuery1: TMemTableEh;
    mtTable1: TMemTableEh;
    mtTable2: TMemTableEh;
    mttEmployee: TMemTableEh;
    mtqCustomer: TMemTableEh;
    mtqCustomer2: TMemTableEh;
    dsdTable1: TDataSetDriverEh;
    dsdTable2: TDataSetDriverEh;
    dsdtEmployee: TDataSetDriverEh;
    dsdqCustomer: TDataSetDriverEh;
    dsdqCustomer2: TDataSetDriverEh;
    mtQuery1VNo: TFloatField;
    mtQuery1VName: TStringField;
    mtQuery1PNo: TFloatField;
    mtQuery1PDescription: TStringField;
    mtQuery1PCost: TCurrencyField;
    mtQuery1IQty: TIntegerField;
    mtQuery1VPreferred: TBooleanField;
    mtQuery1VName1: TStringField;
    mtFish: TMemTableEh;
    mtFishSpeciesNo: TFloatField;
    mtFishCategory: TStringField;
    mtFishCommon_Name: TStringField;
    mtFishSpeciesName: TStringField;
    mtFishLengthcm: TFloatField;
    mtFishLength_In: TFloatField;
    mtFishNotes: TMemoField;
    mtFishGraphic: TGraphicField;
    ddFish: TDataSetDriverEh;
    dsFish: TDataSource;
    ilPaymentType: TImageList;
    mttEmployeeEmpNo: TIntegerField;
    mttEmployeeLastName: TStringField;
    mttEmployeeFirstName: TStringField;
    mttEmployeePhoneExt: TStringField;
    mttEmployeeHireDate: TDateTimeField;
    mttEmployeeSalary: TFloatField;
    mttEmployeeSalaryType: TIntegerField;
    dsCustomersRDP: TDataSource;
    ddrCustomersRDP: TDataSetDriverEh;
    mtCustomersRDP: TMemTableEh;
    mtOrdersRDP: TMemTableEh;
    ddOrdersRDP: TDataSetDriverEh;
    dsOrdersRDP: TDataSource;
    mtTreeView: TMemTableEh;
    mtTreeViewExpCount: TAggregateField;
    dsTreeView: TDataSource;
    dsdQuery1: TDataSetDriverEh;
    Table1: TADOTable;
    ADOConnection1: TADOConnection;
    Table2: TADOTable;
    qrPartsDescriprion: TADOQuery;
    tOrdersRDP: TADOTable;
    tCustomersRDP: TADOTable;
    tFish: TADOTable;
    qCustomer2: TADOQuery;
    qCustomer: TADOQuery;
    tEmployee: TADOTable;
    tCustomer: TADOTable;
    Query1: TADOQuery;
    Query1VName: TStringField;
    Query1PDescription: TStringField;
    Query1PCost: TCurrencyField;
    Query1IQty: TIntegerField;
    Query1VName1: TStringField;
    Query1VPreferred: TBooleanField;
    Query1VNo: TAutoIncField;
    Query1PNo: TAutoIncField;
    tEmployeeEmpNo: TIntegerField;
    tEmployeeLastName: TStringField;
    tEmployeeFirstName: TStringField;
    tEmployeePhoneExt: TStringField;
    tEmployeeHireDate: TDateTimeField;
    tEmployeeSalary: TFloatField;
    tEmployeeSalaryType: TIntegerField;
    qrVendors: TADOQuery;
    qrVendorsVendorName: TStringField;
    qrVendorsAddress1: TStringField;
    qrVendorsAddress2: TStringField;
    qrVendorsCity: TStringField;
    qrVendorsState: TStringField;
    qrVendorsZip: TStringField;
    qrVendorsCountry: TStringField;
    qrVendorsPhone: TStringField;
    qrVendorsFAX: TStringField;
    qrVendorsPreferred: TBooleanField;
    qrVendorsVendorNo: TAutoIncField;
    ADOBioConnection: TADOConnection;
    procedure tEmployeeCalcFields(DataSet: TDataSet);
    procedure mttEmployeeCalcFields(DataSet: TDataSet);
    procedure ADOConnection1BeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure ADOBioConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.DFM}

procedure TDataModule1.tEmployeeCalcFields(DataSet: TDataSet);
begin
  if (tEmployeeSalary.AsFloat < 15000) then
    tEmployeeSalaryType.AsFloat := 5
  else if (tEmployeeSalary.AsFloat < 20000) then
    tEmployeeSalaryType.AsFloat := 4
  else if (tEmployeeSalary.AsFloat < 25000) then
    tEmployeeSalaryType.AsFloat := 3
  else if (tEmployeeSalary.AsFloat < 30000) then
    tEmployeeSalaryType.AsFloat := 2
  else if (tEmployeeSalary.AsFloat < 50000) then
    tEmployeeSalaryType.AsFloat := 1
  else
    tEmployeeSalaryType.AsFloat := 0;
end;

procedure TDataModule1.mttEmployeeCalcFields(DataSet: TDataSet);
begin
  if (mttEmployee.FieldByName('Salary').AsFloat < 15000) then
    mttEmployee.FieldByName('SalaryType').AsFloat := 5
  else if (mttEmployee.FieldByName('Salary').AsFloat < 20000) then
    mttEmployee.FieldByName('SalaryType').AsFloat := 4
  else if (mttEmployee.FieldByName('Salary').AsFloat < 25000) then
    mttEmployee.FieldByName('SalaryType').AsFloat := 3
  else if (mttEmployee.FieldByName('Salary').AsFloat < 30000) then
    mttEmployee.FieldByName('SalaryType').AsFloat := 2
  else if (mttEmployee.FieldByName('Salary').AsFloat < 50000) then
    mttEmployee.FieldByName('SalaryType').AsFloat := 1
  else
    mttEmployee.FieldByName('SalaryType').AsFloat := 0;
end;

procedure TDataModule1.ADOConnection1BeforeConnect(Sender: TObject);
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

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ComponentCount-1 do
  begin
    if Components[i] is TMemTableEh then
      TMemTableEh(Components[i]).Open;
  end;
end;

procedure TDataModule1.ADOBioConnectionBeforeConnect(Sender: TObject);
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\Biolife.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\Biolife.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\Biolife.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\Biolife.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\Biolife.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\Biolife.mdb';

  ADOBioConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
end;

end.
