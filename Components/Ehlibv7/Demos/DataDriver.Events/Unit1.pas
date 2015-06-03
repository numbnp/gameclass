unit Unit1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF EH_LIB_7} XPMan, {$ENDIF}
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Db, GridsEh, DBGridEh, DBTables, DataDriverEh, MemTableEh, MemTableDataEh,
  DBCtrlsEh, StdCtrls, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  ADODB, ADODataDriverEh;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    Label1: TLabel;
    ADODataDriverEh1: TADODataDriverEh;
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    procedure DataSetDriverEh1BuildDataStruct(DataDriver: TDataDriverEh;
      DataStruct: TMTDataStructEh);
    procedure DataSetDriverEh1ReadRecord(DataDriver: TDataDriverEh;
      MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
      var ProviderEOF: Boolean);
    procedure MemTableEh1SetFieldValue(MemTable: TCustomMemTableEh;
      Field: TField; var Value: Variant);
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(
      Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.DataSetDriverEh1BuildDataStruct(DataDriver: TDataDriverEh;
  DataStruct: TMTDataStructEh);
var
  DataField: TMTDataFieldEh;
begin
  DataDriver.DefaultBuildDataStruct(DataStruct);

  DataField := DataStruct.CreateField(TMTDateTimeDataFieldEh);
  DataField.FieldName := 'LastInvoiceDate1';
  TMTDateTimeDataFieldEh(DataField).DateTimeDataType :=  fdtDateEh;

  DataField := DataStruct.CreateField(TMTDateTimeDataFieldEh);
  DataField.FieldName := 'LastInvoiceTime1';
  TMTDateTimeDataFieldEh(DataField).DateTimeDataType :=  fdtTimeEh;
end;

procedure TForm1.DataSetDriverEh1ReadRecord(DataDriver: TDataDriverEh;
  MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
  var ProviderEOF: Boolean);
var
  Val: Variant;
begin
  DataDriver.DefaultReadRecord(MemTableData, MemRec, ProviderEOF);
  Val := MemRec.DataValues['LastInvoiceDate', dvvValueEh];
  if not VarIsNull(Val) then
  begin
    MemRec.DataValues['LastInvoiceDate1', dvvValueEh] := Integer(Trunc(Val));
    MemRec.DataValues['LastInvoiceTime1', dvvValueEh] := Frac(Val);
  end;
end;

procedure TForm1.MemTableEh1SetFieldValue(MemTable: TCustomMemTableEh;
  Field: TField; var Value: Variant);
begin
  if (Field.FieldName = 'LastInvoiceDate1') then
  begin
    if not VarIsNull(Value) and Value < EncodeDate(1900, 1, 1) then
      raise Exception.Create('Date is too low');
    MemTable.FieldByName('LastInvoiceDate').AsDateTime
      := MemTable.FieldByName('LastInvoiceTime1').AsDateTime + Field.AsDateTime;

  end;
  if (Field.FieldName = 'LastInvoiceTime1') then
    MemTable.FieldByName('LastInvoiceDate').AsDateTime
      := MemTable.FieldByName('LastInvoiceDate1').AsDateTime + Field.AsDateTime;
end;

procedure TForm1.ADOConnectionProviderEh1InlineConnectionBeforeConnect(
  Sender: TObject);
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb';

  ADOConnectionProviderEh1.InlineConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
end;

initialization
  DefFontData.Name := 'Tahoma';
end.
