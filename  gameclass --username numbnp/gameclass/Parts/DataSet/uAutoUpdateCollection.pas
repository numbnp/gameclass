unit uAutoUpdateCollection;

interface

uses
  Classes,
  ExtCtrls,
  ADODB,
  uGCDataSet,
  uY2KCommon;

type

  TAutoUpdateItem = class(TCollectionItem)
  private
    FGCDataSet: TGCDataSet;
    FstrTableName: String;
    FnTableId: Integer;
  public
    // Constructor/destructor
    constructor Create(Collection: TCollection); overload;
    constructor Create(
        ACollection: TCollection;
        AGCDataSet: TGCDataSet;
        AstrTableName: String;
        AnTableId: Integer); overload;
    // Public methods
    procedure Update(AnAction: Integer; AnIdRecord: Integer);
    procedure  SelectAll;
    // Public property
    property GCDataSet: TGCDataSet read FGCDataSet;
    property TableName: String read FstrTableName;
    property TableId: Integer read FnTableId;
  end;

  TAutoUpdateCollection = class(TCollection)
  public
    // Constructor/destructor
    constructor Create;
    destructor Destroy; override;
    // Public methods
    function GetItemByIdTable(AnIdTable: Integer): TAutoUpdateItem;
    function Add( //добавить новый GCDataSet или не добавить если есть
        AGCDataSet: TGCDataSet;
        AstrTableName: String;
        AnTableId: Integer): Boolean;
  end;

implementation

uses
  SysUtils,
  uSQLTools,
  DB;

constructor TAutoUpdateItem.Create(Collection: TCollection);
begin
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));
end;

constructor TAutoUpdateItem.Create(ACollection: TCollection;
    AGCDataSet: TGCDataSet; AstrTableName: String; AnTableId: Integer);
begin
  inherited Create(ACollection);
  FGCDataSet := AGCDataSet;
  FstrTableName := AstrTableName;
  FnTableId := AnTableId;
end;

procedure TAutoUpdateItem.Update(AnAction: Integer; AnIdRecord: Integer);
begin
  case AnAction of
    1: FGCDataSet.Select(AnIdRecord); // Insert
    2: FGCDataSet.Delete(AnIdRecord, True); // Delete
    3: FGCDataSet.Select(AnIdRecord); // Update
  end;
end;

procedure  TAutoUpdateItem.SelectAll;
begin
  FGCDataSet.SelectAll;
end;
/////
//                   TAutoUpdateCollection
//////
constructor TAutoUpdateCollection.Create;
begin
   inherited Create(TAutoUpdateItem);
end;

destructor TAutoUpdateCollection.Destroy;
begin
   Clear;
   inherited Destroy;
end;

function TAutoUpdateCollection.GetItemByIdTable(
    AnIdTable: Integer): TAutoUpdateItem;
var
   i : Integer;
begin
   Result := Nil;
   for i := 0 to Count-1 do
      if TAutoUpdateItem(Items[i]).TableId = AnIdTable then
         Result := TAutoUpdateItem(Items[i]);
end;

function TAutoUpdateCollection.Add(
    AGCDataSet: TGCDataSet;
    AstrTableName: String;
    AnTableId: Integer): Boolean;
begin
  Result := False;
  if GetItemByIdTable(AnTableId) = Nil then
    if TAutoUpdateItem.Create(Self, AGCDataSet, AstrTableName,
        AnTableId) <> Nil then
      Result := True;
end;


end.
