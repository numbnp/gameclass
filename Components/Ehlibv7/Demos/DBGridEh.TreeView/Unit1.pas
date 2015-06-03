unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF EH_LIB_7} XPMan, {$ENDIF}
  DBTables, DataDriverEh, Db, MemTableEh, DBGridEh, ExtCtrls,
  DBCtrls, MemTableDataEh, StdCtrls, DBClient, EhLibMTE, GridsEh,
  DBGridEhGrouping, DBGridEhToolCtrls, ToolCtrlsEh, ADODB, ADODataDriverEh;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    MemTableEh1ExpCount: TAggregateField;
    Button2: TButton;
    ADODataDriverEh1: TADODataDriverEh;
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function DBGridEh1MoveRecords(Sender: TObject; BookmarkList: TBMListEh;
      ToRecNo, TreeLevel: Integer; CheckOnly: Boolean): Boolean;
    procedure Button2Click(Sender: TObject);
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(
      Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DeleteNodeWithChildren(TreeNode: TMemRecViewEh);
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.DeleteNodeWithChildren(TreeNode: TMemRecViewEh);
var
  i: Integer;
begin
  for I := TreeNode.NodesCount-1 downto 0 do
    DeleteNodeWithChildren(TreeNode.NodeItems[I]);
  MemTableEh1.RecordsView.MemTableData.RecordsList.DeleteRecord(TreeNode.Rec.Index);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  DeleteNodeWithChildren(MemTableEh1.TreeNode);
end;

function TForm1.DBGridEh1MoveRecords(Sender: TObject; BookmarkList: TBMListEh;
  ToRecNo, TreeLevel: Integer; CheckOnly: Boolean): Boolean;
begin
  if (TreeLevel >= 2) and (TreeLevel <= 3) then
  begin
    Result := DBGridEh1.DefaultMoveDataRows(BookmarkList, ToRecNo, TreeLevel, CheckOnly);
  end else
  begin
    Result := False;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MemTableEh1.TreeList.Active := True;
  MemTableEh1.TreeList.KeyFieldName := 'ID';
  MemTableEh1.TreeList.RefParentFieldName := 'ID_PARENT';
  MemTableEh1.TreeList.DefaultNodeExpanded := True;
  MemTableEh1.Open;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  MemTableEh1.TreeList.Active := not MemTableEh1.TreeList.Active;
//  MemTableEh1.CancelUpdates;
//  MemTableEh1.Locate('ID', 25,[]);
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
  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DBGridEhCenter.FilterEditCloseUpApplyFilter := True;
  DefFontData.Name := 'Tahoma';
//  DBGridEhDebugDraw := True;
end.
