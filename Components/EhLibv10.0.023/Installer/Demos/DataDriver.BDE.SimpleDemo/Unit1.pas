unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  XPMan,
  DBGridEhToolCtrls, MemTableDataEh, Db, ADODB, DataDriverEh, ADODataDriverEh,
  MemTableEh, GridsEh, DBGridEh, StdCtrls, IBDatabase, IBXDataDriverEh,
  BDEDataDriverEh, DBTables, EhLibMTE, DBCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    BDEDataDriverEh1: TBDEDataDriverEh;
    Database2_IBLocal: TDatabase;
    BDEConnectionProviderEh1: TBDEConnectionProviderEh;
    XPManifest1: TXPManifest;
    Panel1: TPanel;
    Button1: TButton;
    DBNavigator1: TDBNavigator;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BDEConnectionProviderEh1InlineConnectionBeforeConnect(
      Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BDEConnectionProviderEh1InlineConnectionBeforeConnect(
  Sender: TObject);
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\employee.gdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\employee.gdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\employee.gdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\employee.gdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\employee.gdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\employee.gdb';

  BDEConnectionProviderEh1.InlineConnection.Params.Values['SERVER NAME'] := FilePath;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
//  IBXConnectionProviderEh1.ServerType := '';
//  ADOConnectionProviderEh1.Free;
  MemTableEh1.Open;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBGridEh1.TitleParams.SecondColor := ApproximateColor(clBtnFace, clWindow, 128);
  DBGridEh1.Align := alClient;
end;

initialization
  DefFontData.Name := 'Tahoma';
end.
