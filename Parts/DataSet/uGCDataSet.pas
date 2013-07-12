//////////////////////////////////////////////////////////////////////////////
//
// TPMDataSet - класс-рекордсет ...
//
//////////////////////////////////////////////////////////////////////////////

unit uGCDataSet;

interface

uses
  // system units
  Classes,
  ADODB;
  // project units
//  uDatetimeInterval;

type

  //
  // TGCDataSet
  //
  TUpdateQueryEvent = procedure(const Sender: TObject; const Id: Integer;
    var CanUpdate: Boolean) of object;
  TAfterInsertEvent = procedure(const Sender: TObject;
    const Id: Integer) of object;

  TGCDataSet = class(TADODataSet)
  private
    FOnUpdateQuery: TUpdateQueryEvent;
    FOnAfterInsert: TAfterInsertEvent;
  protected
    FbEnableInheritedInternalMethods: Boolean;
    FbInAutoUpdate: Boolean;
    // protected methods
//    procedure BuildSQLQueryWithDTI(
//        Adti: TDatetimeInterval); virtual; abstract;
//    procedure DoSelectAll; virtual; abstract;
    function DoSelectAll (
        var AdtsResult: TADODataSet): Boolean; virtual; abstract;
    function DoSelect (const AnId: Integer;
        var AdtsResult: TADODataSet): Boolean; virtual; abstract;
    function DoUpdate(const AnId: Integer): Boolean; virtual; abstract;
    function DoDelete(const AnId: Integer): Boolean; virtual; abstract;
    function DoInsert(var AdtsResult: TADODataSet): Boolean; virtual; abstract;

    procedure InternalDelete; override;
    procedure DoOnNewRecord; override;
    procedure Post; override;

    procedure EnableInheritedInternalMethodsForOneOperation;
    function DoUpdateQuery(const AnId: Integer): Boolean;
    function DoAfterInsert(const AnId: Integer): Boolean;

  public
    // constructor / destructohr
    constructor Create(AOwner: TComponent); reintroduce; overload;
    constructor Create(AOwner: TComponent;
        Acnn: TADOConnection); reintroduce; overload;
    destructor Destroy(); override;

    // public methods
    procedure SelectAll;
    function Select (AnId: Integer): Boolean;
    function Update (AnId: Integer): Boolean;
    function Delete(const AnId: Integer; AbLocal: Boolean = False): Boolean;
    function Insert(var AnId: Integer): Boolean; //без чтени€ записи в dst
//    function Append: Boolean;
    procedure PostLocal;

    function LocateById(AnId: Integer): Boolean;
    property OnUpdateQuery: TUpdateQueryEvent
        read FOnUpdateQuery write FOnUpdateQuery;
    property OnAfterInsert: TAfterInsertEvent
        read FOnAfterInsert write FOnAfterInsert;
    property InAutoUpdate: Boolean
        read FbInAutoUpdate write FbInAutoUpdate;
    function IsEmpty: Boolean;
  end; // TGCDataSet


implementation

uses
  // system utils
  SysUtils, DB, ADOInt;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TGCDataSet.Create(AOwner: TComponent);
begin
  raise Exception.Create('TGCDataSet.Create: overload error!');
end; // TGCDataSet.Create

constructor TGCDataSet.Create(AOwner: TComponent; Acnn: TADOConnection);
begin
  inherited Create(AOwner);
  Connection := Acnn;
  Prepared   := FALSE;
  FbEnableInheritedInternalMethods := False;
  FbInAutoUpdate := False;
end; // TGCDataSet.Create

destructor TGCDataSet.Destroy();
begin
  inherited Destroy();
end; // TGCDataSet.Destroy

procedure TGCDataSet.EnableInheritedInternalMethodsForOneOperation;
begin
  FbEnableInheritedInternalMethods := True;
end; // TGCDataSet.EnableInheritedInternalInsert

procedure TGCDataSet.InternalDelete;
var
  nId: Integer;
begin
  if FbEnableInheritedInternalMethods then
    inherited InternalDelete
  else
    try
      nId := FieldValues['id'];
      if DoDelete(nId) then
        inherited InternalDelete;
    except
    end;
  FbEnableInheritedInternalMethods := False;
end;

procedure TGCDataSet.Post;
var
  nId: Integer;
begin
  nId := -1;
  if FbEnableInheritedInternalMethods then
    inherited Post
  else begin
    try
      nId := FieldValues['id'];
    except
    end;
    if DoUpdateQuery(nId) then
      try
        if DoUpdate(nId) then begin
          inherited Post;
          Select(nId);
        end;
      except
      end
    else
      Cancel;
  end;
  FbEnableInheritedInternalMethods := False;
end;

procedure TGCDataSet.PostLocal;
begin
  inherited Post
end;


procedure TGCDataSet.DoOnNewRecord;
var nId: Integer;
begin
  if FbEnableInheritedInternalMethods then
    inherited DoOnNewRecord
  else
  try
    if Insert(nId) then begin
      inherited DoOnNewRecord;
      FieldValues['id'] := nId;
      inherited Post;
      Select(nId);
    end;
  except
  end;
  FbEnableInheritedInternalMethods := False;
end;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TGCDataSet.SelectAll;
var
  dtsResult: TADODataSet;
  i: Integer;
begin
  dtsResult := TADODataSet.Create(Self);
  if DoSelectAll(dtsResult) then begin
    If Active then begin
      First;
      while not Eof do begin
        EnableInheritedInternalMethodsForOneOperation;
        inherited Delete;
      end;
    end else begin
      // поле ќЅя«ј“≈Ћ№Ќќ id
      FieldDefs := dtsResult.FieldDefs;
      FieldDefs.Find('id').Attributes := [faFixed];
      FieldDefs.Find('id').DataType := ftInteger;
      CreateDataSet;
    end;
    dtsResult.First;
    while not dtsResult.Eof do begin
      EnableInheritedInternalMethodsForOneOperation;
      inherited Append;
      for i:=0 to dtsResult.FieldCount-1 do
        Fields[i].Value := dtsResult.Fields[i].Value;
      EnableInheritedInternalMethodsForOneOperation;
      Post;
      dtsResult.Next;
    end;
  end;
end;

function TGCDataSet.Select(AnId: Integer): Boolean;
var
  dtsResult: TADODataSet;
  i: Integer;
  Buffer: PChar;
  bookmark: Pointer;
  bInsert: Boolean;
begin
  FbInAutoUpdate := True;
  Result := False;
  if not DoUpdateQuery(AnId) then begin
    FbInAutoUpdate := False;
    exit;
  end;
  bInsert := False;
  bookmark := GetBookmark;
  dtsResult := TADODataSet.Create(Self);
  if DoSelect(AnId, dtsResult) and (dtsResult.RecordCount = 1) then begin
    if Locate('id', AnId, [loCaseInsensitive]) then begin
      Edit;
    end else
    begin
      EnableInheritedInternalMethodsForOneOperation;
      inherited Append;
      bInsert := True;
    end;
    for i:=0 to dtsResult.FieldCount - 1 do
      Fields[i].Value := dtsResult.Fields[i].Value;
    EnableInheritedInternalMethodsForOneOperation;

    Post;
    Result := True;
    if bInsert then
      DoAfterInsert(Fields[0].Value);
  end;
  try
    GotoBookmark(bookmark);
  finally
    FreeBookmark(bookmark);
  end;
  dtsResult.Free;
  FbInAutoUpdate := False;
end;

function TGCDataSet.Update(AnId: Integer): Boolean;
var
  bookmark: Pointer;
begin
  FbInAutoUpdate := True;
  bookmark := GetBookmark;
  Result := DoUpdate(AnId);
  try
    GotoBookmark(bookmark);
  except
  end;
  FreeBookmark(bookmark);
  FbInAutoUpdate := False;
end;

function TGCDataSet.Delete(const AnId: Integer;
    AbLocal: Boolean = False): Boolean;
var
  bookmark: Pointer;
begin
  FbInAutoUpdate := True;
  bookmark := GetBookmark;
  if AbLocal then
    Result := True
  else
    Result := DoDelete(AnId);
  if Locate('id', AnId, []) then begin
    if AbLocal then
      EnableInheritedInternalMethodsForOneOperation;
    inherited Delete;
  end;
  try
    GotoBookmark(bookmark);
  except
  end;
  FreeBookmark(bookmark);
  FbInAutoUpdate := False;
end;

function TGCDataSet.Insert(var AnId: Integer): Boolean;
var
  dtsResult: TADODataSet;
  bookmark: Pointer;
begin
  FbInAutoUpdate := True;
  bookmark := GetBookmark;
  Result := False;
  dtsResult := TADODataSet.Create(Self);
  if DoInsert(dtsResult) and (dtsResult.RecordCount = 1) then
    try
      AnId := dtsResult.FieldValues['id'];
      Result := True;
    except
    end;
  try
    GotoBookmark(bookmark);
  except
  end;
  FreeBookmark(bookmark);
  FbInAutoUpdate := False;
end;

function TGCDataSet.LocateById(AnId: Integer): Boolean;
begin
  Result := Locate('id', AnId, [loCaseInsensitive]);
end;

{function TGCDataSet.Append: Boolean;
var
  nId: Integer;
begin
  Result := Insert(nId) and Select(nId) and LocateById(nId);
end;
}

function TGCDataSet.DoUpdateQuery(const AnId: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnUpdateQuery) then
    FOnUpdateQuery(Self, AnId, Result);
end;

function TGCDataSet.DoAfterInsert(const AnId: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnAfterInsert) then
    FOnAfterInsert(Self, AnId);
end;

function TGCDataSet.IsEmpty: Boolean;
begin
  Result := (RecordCount = 0);
end;

end. ////////////////////////// end of file //////////////////////////////////


