unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh,
  DBLookupEh, DataDriverEh, ADODataDriverEh, XPMan;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    ADODataDriverEh1: TADODataDriverEh;
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    DBGridEh2: TDBGridEh;
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
    Label4: TLabel;
    Label5: TLabel;
    dbeOrderBy: TDBEditEh;
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(
      Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bExecuteClick(Sender: TObject);
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
  ADOConnectionProviderEh1.InlineConnection.Connection.OpenSchema(siTables,
    VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('TABLE')]),
    EmptyParam, ADODataSet1);
  ADODataSet1.Locate('table_name','customer',[]);
  DBEditEh2.Font.Name := DefFontData.Name;
  bExecuteClick(Sender);
end;

procedure TForm1.bExecuteClick(Sender: TObject);
begin
  ADODataDriverEh1.MacroVars.Macros['%tb%'] := ADODataSet1['table_name'];
  if Trim(dbeOrderBy.Text) = ''
    then ADODataDriverEh1.MacroVars.SpecMacros.SortOrderMacroValue := ''
    else ADODataDriverEh1.MacroVars.SpecMacros.SortOrderMacroValue := 'order by ' + dbeOrderBy.Text;

  MemTableEh1.Close;
  MemTableEh1.Open;
  DBEditEh1.Text := ADODataDriverEh1.SelectSQL.Text;
  DBEditEh2.Text := ADODataDriverEh1.FinalSelectSQL.Text;
end;

initialization
  DefFontData.Name := 'Tahoma';
end.
