unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh,
  DBLookupEh, DataDriverEh, ADODataDriverEh, XPMan,
  EhLibMTE;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    ADODataDriverEh1: TADODataDriverEh;
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    DBEditEh1: TDBEditEh;
    Label1: TLabel;
    DBEditEh2: TDBEditEh;
    Label2: TLabel;
    bExecute: TButton;
    mtTablesList: TMemTableEh;
    dsTablesList: TDataSource;
    mtTablesListTableName: TStringField;
    ADODataSet1: TADODataSet;
    Label3: TLabel;
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(
      Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bExecuteClick(Sender: TObject);
    function ADODataDriverEh1ExecuteCommand(DataDriver: TADODataDriverEh;
      Command: TADOCommandEh; var Cursor: TDataSet;
      var FreeOnEof: Boolean): Integer;
    procedure DBGridEh1Columns0FillSTFilterListValues(
      Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings;
      var Processed: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

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

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBEditEh2.Font.Name := DefFontData.Name;
  bExecuteClick(Sender);
end;

procedure TForm1.bExecuteClick(Sender: TObject);
begin
  MemTableEh1.Close;
  MemTableEh1.Open;
end;

function TForm1.ADODataDriverEh1ExecuteCommand(
  DataDriver: TADODataDriverEh; Command: TADOCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
begin
  DBEditEh1.Text := ADODataDriverEh1.SelectSQL.Text;
  DBEditEh2.Text := ADODataDriverEh1.FinalSelectSQL.Text;
  Result := DataDriver.DefaultExecuteCommand(Command, Cursor, FreeOnEof);
end;

procedure TForm1.DBGridEh1Columns0FillSTFilterListValues(
  Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings;
  var Processed: Boolean);
begin
  Sender.DefaultFillSTFilterListCommandValues(Column, Items);
  Processed := True;
end;

initialization
  DefFontData.Name := 'Tahoma';
end.
