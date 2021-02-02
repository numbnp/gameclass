unit UnitFrame1;

interface

uses
  ADODb, SysUtils,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Forms,
  Classes, MemTableDataEh, Db, DataDriverEh, ADODataDriverEh, MemTableEh,
  StdCtrls, Mask, DBCtrlsEh, ComCtrls, Buttons, EhLibVCL, GridsEh,
  DBAxisGridsEh, DBGridEh, Controls, ExtCtrls, Menus, DBCtrls;

type
  TFrame1 = class(TFrame)
    mtReportList: TMemTableEh;
    dsReportList: TDataSource;
    ddrReportList: TADODataDriverEh;
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    Panel1: TPanel;
    DBGridEh2: TDBGridEh;
    Panel3: TPanel;
    bSelectTheRep: TButton;
    Splitter1: TSplitter;
    SpeedButton1: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    DBMemoEh1: TDBMemoEh;
    DBMemoEh2: TDBMemoEh;
    DBMemoEh3: TDBMemoEh;
    bTestConnection: TButton;
    DBMemoEh4: TDBMemo;
    PopupMenu1: TPopupMenu;
    ShowHideSQLMonitor1: TMenuItem;
    procedure DBMemoEh1EditButtons0Click(Sender: TObject; var Handled: Boolean);
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(
      Sender: TObject);
    procedure bSelectTheRepClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure bTestConnectionClick(Sender: TObject);
    function ADOConnectionProviderEh1ExecuteCommand(
      SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
      var Cursor: TDataSet; var FreeOnEof, Processed: Boolean): Integer;
    procedure ShowHideSQLMonitor1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Unit1, UnitTestConn, SQLMonForm;

{$R *.dfm}

procedure TFrame1.ADOConnectionProviderEh1InlineConnectionBeforeConnect(
  Sender: TObject);
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb'

  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Demos\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Demos\Data\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Demos\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Demos\Data\DBTest.mdb';

  ADOConnectionProviderEh1.InlineConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
end;

procedure TFrame1.bSelectTheRepClick(Sender: TObject);
begin
  SpeedButton1.Enabled := True;
  TForm1(Parent).SelectReport;
end;

procedure TFrame1.bTestConnectionClick(Sender: TObject);
begin
  TestConnLines(
    mtReportList.FieldByName('ConnectionParameters').AsString,
    mtReportList.FieldByName('FilePaths').AsString
  );
end;

procedure TFrame1.DBMemoEh1EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
var
  s, newS: String;
begin
  s := mtReportList.FieldByName('ConnectionParameters').AsString;
  s := TForm1(Parent).ConnectionLinesToConnectionString(s);
  newS := PromptDataSource(Handle, s);
  if newS <> s then
  begin
    mtReportList.Edit;
    mtReportList.FieldByName('ConnectionParameters').AsString := newS;
  end;
end;

procedure TFrame1.SpeedButton1Click(Sender: TObject);
begin
  TForm1(Parent).SwitchToPivotGrid;
end;

function TFrame1.ADOConnectionProviderEh1ExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof, Processed: Boolean): Integer;
begin
  Result := ADOConnectionProviderEh1.DefaultExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed);
  if fSQLMon.Visible then
    fSQLMon.AppendSQLInfo(Command);
end;

procedure TFrame1.ShowHideSQLMonitor1Click(Sender: TObject);
begin
  fSQLMon.Visible := not fSQLMon.Visible;
end;

end.
