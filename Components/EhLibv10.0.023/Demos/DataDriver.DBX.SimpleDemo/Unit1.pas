unit Unit1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, MemTableDataEh, Db, DataDriverEh,
  MemTableEh, GridsEh, DBGridEh, StdCtrls, 
{$IFDEF EH_LIB_14} // XE
  DBXInterBase,
{$ELSE}
  DBXpress,
{$ENDIF}
  SqlExpr, DBXDataDriverEh, XPMan, DBCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    DBXDataDriverEh1: TDBXDataDriverEh;
    DBXConnectionProviderEh1: TDBXConnectionProviderEh;
    SQLConnection1: TSQLConnection;
    Panel1: TPanel;
    Button1: TButton;
    DBNavigator1: TDBNavigator;
    XPManifest1: TXPManifest;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure DBXDataDriverEh1BuildDataStruct(DataDriver: TDataDriverEh;
      DataStruct: TMTDataStructEh);
    procedure DBXConnectionProviderEh1InlineConnectionBeforeConnect(
      Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not DBXConnectionProviderEh1.InlineConnection.Connected then
    DBXConnectionProviderEh1.InlineConnection.Connected := True;
  MemTableEh1.Open;
end;

procedure TForm1.DBXDataDriverEh1BuildDataStruct(DataDriver: TDataDriverEh;
  DataStruct: TMTDataStructEh);
begin
  DBXDataDriverEh1.DefaultBuildDataStruct(DataStruct);
  DataStruct.FieldByName('CUST_NO').Required := False;
end;

procedure TForm1.DBXConnectionProviderEh1InlineConnectionBeforeConnect(
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

  DBXConnectionProviderEh1.InlineConnection.Params.Values['Database'] := FilePath;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBGridEh1.TitleParams.SecondColor := ApproximateColor(clBtnFace, clWindow, 128);
  DBGridEh1.Align := alClient;
end;

initialization
  DefFontData.Name := 'Tahoma';
end.