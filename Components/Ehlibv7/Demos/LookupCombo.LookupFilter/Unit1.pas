unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEh, MemTableDataEh, Db, ADODB, MemTableEh, StdCtrls, Mask,
  DBCtrlsEh, DBLookupEh, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  XPMan,
  DataDriverEh, ADODataDriverEh, GridsEh, EhLibMTE;

type
  TForm1 = class(TForm)
    DBLookupComboboxEh1: TDBLookupComboboxEh;
    mteBaseList: TMemTableEh;
    dsBaseList: TDataSource;
    DBLookupComboboxEh2: TDBLookupComboboxEh;
    ADOConnection1: TADOConnection;
    Label1: TLabel;
    Label2: TLabel;
    DBEditEh1: TDBEditEh;
    Label3: TLabel;
    DBGridEh2: TDBGridEh;
    mteFilteredList: TMemTableEh;
    dsFilteredList: TDataSource;
    DBGridEh1: TDBGridEh;
    Label4: TLabel;
    Label5: TLabel;
    procedure ADODataDriverEh1UpdateRecord(DataDriver: TDataDriverEh;
      MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh);
    procedure DBGridEh1Columns3NotInList(Sender: TObject; NewText: String;
      var RecheckInList: Boolean);
    procedure ADOConnection1BeforeConnect(Sender: TObject);
    procedure DBLookupComboboxEh1DropDownBoxApplyTextFilter(
      Sender: TObject; DataSet: TDataSet; FieldName: String;
      Operation: TLSAutoFilterTypeEh; FilterText: String);
    procedure dsFilteredListDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    function GetConnectionString: String;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ADODataDriverEh1UpdateRecord(DataDriver: TDataDriverEh;
  MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh);
begin
//  
end;

procedure TForm1.DBGridEh1Columns3NotInList(Sender: TObject;
  NewText: String; var RecheckInList: Boolean);
begin
//
end;

procedure TForm1.ADOConnection1BeforeConnect(Sender: TObject);
begin
  ADOConnection1.ConnectionString := GetConnectionString;
end;

function TForm1.GetConnectionString: String;
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb';

  Result :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
end;

procedure TForm1.DBLookupComboboxEh1DropDownBoxApplyTextFilter(
  Sender: TObject; DataSet: TDataSet; FieldName: String;
  Operation: TLSAutoFilterTypeEh; FilterText: String);
begin
  TDBLookupComboboxEh(Sender).DefaultDropDownBoxApplyTextFilter(DataSet,
    FieldName, Operation, FilterText);
end;

procedure TForm1.dsFilteredListDataChange(Sender: TObject; Field: TField);
begin
  DBEditEh1.Text := mteFilteredList.Filter;
end;

initialization
  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
end.

