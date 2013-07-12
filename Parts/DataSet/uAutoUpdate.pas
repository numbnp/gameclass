//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит описание и реализацию класса TAutoUpdate.
// Класс реализует механизм обновления оторванных GCDataSet'ов
//
//////////////////////////////////////////////////////////////////////////////
unit uAutoUpdate;

interface

uses
  Classes,
  ExtCtrls,
  ADODB,
  uGCDataSet,
  uY2KCommon,
  uAutoUpdateCollection;

type

  TAutoUpdate = class(TObject)
  private
    Ftmr: TTimer;
    Fcnn: TADOConnection;
    FnLastId: Integer;
    FCollection: TAutoUpdateCollection;

    procedure OnTimer(Sender: TObject);
    procedure SetInterval(AValue: Cardinal);
    function GetInterval: Cardinal;
    procedure SetActive(AValue: Boolean);
    function GetActive: Boolean;
  protected
  public
    // constructor / destructor
    constructor Create(AConnection: TADOConnection);
    destructor Destroy(); override;

    procedure ImmediatelyUpdate;
    procedure Init;
    function Add( //добавить новый GCDataSet или не добавить если есть
        AGCDataSet: TGCDataSet;
        AstrTableName: String;
        AnTableId: Integer): Boolean;

    property Interval: Cardinal read GetInterval write SetInterval;
    property Active: Boolean read GetActive write SetActive;
    property Connection: TADOConnection read Fcnn write Fcnn;
  end; // TGCDataSet
var
  GAutoUpdate: TAutoUpdate;

implementation

uses
  SysUtils,
  uSQLTools,
  DB,
  uAccountSystem,
  uRegistry,
  uPMJobs;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

// Exceptions: EAssertionFailed
constructor TAutoUpdate.Create(AConnection: TADOConnection);
begin
  inherited Create();
  Fcnn := AConnection;
  Ftmr := TTimer.Create(Nil);
  Ftmr.Enabled := False;
  Ftmr.Interval := 5000;
  Ftmr.OnTimer := OnTimer;
  FCollection := TAutoUpdateCollection.Create;

  Active := True;
  GAccountSystem := TAccountSystem.Create(Self);
  GRegistry := TGCRegistry.Create(Self);
  GPMJobs := TPMJobs.Create(Self);
end; // TAutoUpdate.Create



destructor TAutoUpdate.Destroy();
begin
  FreeAndNilWithAssert(Ftmr);
  FreeAndNilWithAssert(FCollection);
  inherited Destroy();
end; // TAutoUpdate.Destroy



procedure TAutoUpdate.OnTimer(Sender: TObject);
begin
  ImmediatelyUpdate;
end; // TAutoUpdate.OnTimer

procedure TAutoUpdate.SetInterval(AValue: Cardinal);
begin
  Ftmr.Interval := AValue;
end; // TAutoUpdate.SetInterval

function TAutoUpdate.GetInterval: Cardinal;
begin
  Result := Ftmr.Interval;
end; // TAutoUpdate.GetInterval

procedure TAutoUpdate.SetActive(AValue: Boolean);
begin
  if (Ftmr.Enabled = False) and (AValue = True) then
    Init;
  Ftmr.Enabled := AValue;
end; // TAutoUpdate.SetActive

function TAutoUpdate.GetActive: Boolean;
begin
  Result := Ftmr.Enabled;
end; // TAutoUpdate.GetActive

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods
procedure TAutoUpdate.Init;
var
  dtsResult: TADODataSet;
begin
  dtsResult := TADODataSet.Create(Nil);
  dsDoQuery(Fcnn, dtsResult, 'exec AutoUpdateSelectLastId');
  with dtsResult do
    if RecordCount = 1 then
      FnLastId := FieldValues['id'];
  dtsResult.Close;
  dtsResult.Free;
end; // TAutoUpdate.Init

procedure TAutoUpdate.ImmediatelyUpdate;
var
  dtsResult: TADODataSet;
  item: TAutoUpdateItem;
  nIdTable: Integer;
begin
  dtsResult := TADODataSet.Create(Nil);
  dsDoQuery(Fcnn, dtsResult, 'exec AutoUpdateSelect ' + IntToStr(FnLastId));
  with dtsResult do
    while not Eof do begin
      FnLastId := FieldValues['id'];
      nIdTable := FieldValues['idTable'];
      item := FCollection.GetItemByIdTable(nIdTable);
      if item <> Nil then
        item.Update(FieldValues['idAction'], FieldValues['idRecord']);
      //Изврат для таблицы аккаунтс
      if (nIdTable = 1) then begin
        item := FCollection.GetItemByIdTable(0);
        if item <> Nil then
          item.Update(FieldValues['idAction'], FieldValues['idRecord']);
      end;
       Next;
    end;
  dtsResult.Close;
  dtsResult.Free;
end; // TAutoUpdate.ImmediatelyUpdate

function TAutoUpdate.Add(
    AGCDataSet: TGCDataSet;
    AstrTableName: String;
    AnTableId: Integer): Boolean;
begin
  Result := FCollection.Add(AGCDataSet, AstrTableName, AnTableId);
  FCollection.GetItemByIdTable(AnTableId).SelectAll;
end; // TAutoUpdate.Add

end.
