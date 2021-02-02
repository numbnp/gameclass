unit Unit1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
{$IFDEF EH_LIB_7}
  {$IFNDEF EH_LIB_16}
    XPMan,
  {$ENDIF}
{$ENDIF}
  Controls, Forms, Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, MemTableDataEh, Db, ADODB, DataDriverEh, ADODataDriverEh,
  MemTableEh, GridsEh, DBGridEh, DBCtrls, ExtCtrls, StdCtrls, DynVarsEh,
  EhLibVCL, DBAxisGridsEh;

type
  TForm1 = class(TForm)
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    ADODataDriverEh1: TADODataDriverEh;
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function ADOConnectionProviderEh1ExecuteCommand(
      SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
      var Cursor: TDataSet; var FreeOnEof, Processed: Boolean): Integer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses SQLMonForm;

{$R *.dfm}

procedure TForm1.ADOConnectionProviderEh1InlineConnectionBeforeConnect(Sender: TObject);
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
{$IFDEF CPUX64}
    'Provider=Microsoft.ACE.OLEDB.12.0;User ID=Admin;'+
{$ELSE}
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
{$ENDIF}
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBGridEh1.Align := alClient;
end;

procedure TForm1.WMMove(var Message: TWMMove);
begin
  inherited;
  fSQLMon.SetBounds(Left + Width + 10, Top, 300, Height);
end;

function TForm1.ADOConnectionProviderEh1ExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof, Processed: Boolean): Integer;
begin
  Result := ADOConnectionProviderEh1.DefaultExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed);
  fSQLMon.AppendSQLInfo(Command);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  fSQLMon.Visible := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  MemTableEh1.Close;
  MemTableEh1.Open;
end;

initialization
  DefFontData.Name := 'Tahoma';
end.
