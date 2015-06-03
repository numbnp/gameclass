unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, ADODB, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DBVertGridsEh, ExtCtrls, GridsEh, DBAxisGridsEh,
  DBGridEh, MemTableEh, DataDriverEh, ADODataDriverEh, DBCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    ADODataDriverEh1: TADODataDriverEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Button1: TButton;
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(
      Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
  if FileExists(ExtractFilePath(ParamStr(0))+'\cities10000.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\cities10000.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\cities10000.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\cities10000.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\cities10000.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\cities10000.mdb';

  ADOConnectionProviderEh1.InlineConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  DBGridEh1.StartLoadingStatus;
  try
    MemTableEh1.Close;
    MemTableEh1.Open;
  finally
    DBGridEh1.FinishLoadingStatus;
  end;
end;

initialization
  DefFontData.Name := 'Tahoma';
end.
