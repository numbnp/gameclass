unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, MemTableDataEh, Db, ADODB, DataDriverEh, ADODataDriverEh,
  MemTableEh, GridsEh, DBGridEh, StdCtrls, IBDatabase, IBXDataDriverEh,
  DBCtrls, ExtCtrls, XPMan;

type
  TForm1 = class(TForm)
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    IBXDataDriverEh1: TIBXDataDriverEh;
    IBXConnectionProviderEh1: TIBXConnectionProviderEh;
    IBDatabase1: TIBDatabase;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    Button2: TButton;
    XPManifest1: TXPManifest;
    procedure Button1Click(Sender: TObject);
    procedure IBXConnectionProviderEh1InlineConnectionBeforeConnect(
      Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IBXDataDriverEh1BuildDataStruct(DataDriver: TDataDriverEh;
      DataStruct: TMTDataStructEh);
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
  MemTableEh1.Open;
end;

procedure TForm1.IBXConnectionProviderEh1InlineConnectionBeforeConnect(Sender: TObject);
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\employee.gdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\employee.gdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\employee.gdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\employee.gdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\employee.gdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\employee.gdb';

  IBXConnectionProviderEh1.InlineConnection.DatabaseName := FilePath;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBGridEh1.TitleParams.SecondColor := ApproximateColor(clBtnFace, clWindow, 128);
  DBGridEh1.Align := alClient;
end;

procedure TForm1.IBXDataDriverEh1BuildDataStruct(DataDriver: TDataDriverEh;
  DataStruct: TMTDataStructEh);
begin
  DataDriver.DefaultBuildDataStruct(DataStruct);
  DataStruct.FieldByName('CUST_NO').Required := False;
end;

initialization
  DefFontData.Name := 'Tahoma';
end.
