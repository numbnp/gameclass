unit uAccounts;

interface

uses
  uAutoUpdate,
  uAccountsDataSet,
  uAccountsRecord;

type
  TAccounts = class(TAccountsDataSet)
  private
    FAccountsRecord: TAccountsRecord;
    function GetItem(AnId: Integer): TAccountsRecord;

  public
    constructor Create(AAutoUpdate: TAutoUpdate);
    constructor CreateCopy(AAutoUpdate: TAutoUpdate);
    destructor Destroy; override;

    property Current: TAccountsRecord
        read FAccountsRecord write FAccountsRecord;

    property Items[AnId: Integer]: TAccountsRecord
        read GetItem; default;

    function CheckFreeName(AstrName: String): Boolean;
    function CheckLogon(const AstrNameOrId, AstrPassword, AstrCode: String;
        const AnCodeIndex: Integer; var AnId: Integer): Boolean;
  end;

var
  GAccountsCopy: TAccounts;


implementation

uses
  Types,
  SysUtils,
  DateUtils,
  uVirtualTime,
  uGCDataSet,
  uAccountSystem;

constructor TAccounts.Create(AAutoUpdate: TAutoUpdate);
begin
  inherited Create(Nil, AAutoUpdate.Connection);
  AAutoUpdate.Add(Self,'Accounts',1);
  FAccountsRecord := TAccountsRecord.Create(Self);
end;

constructor TAccounts.CreateCopy(AAutoUpdate: TAutoUpdate);
begin
  inherited Create(Nil, AAutoUpdate.Connection);
  AAutoUpdate.Add(Self,'Accounts',0); //Изврат
  FAccountsRecord := TAccountsRecord.Create(Self);
end;

destructor TAccounts.Destroy;
begin
  FreeAndNil(FAccountsRecord);
  inherited Destroy;
end;

function TAccounts.CheckFreeName(AstrName: String): Boolean;
var
  bookmark: Pointer;
begin
  Result := True;
  exit;
  FbInAutoUpdate := True;
  bookmark := GetBookmark;
//  Result := not Locate('name', AstrName, [loCaseInsensitive]);
  try
    GotoBookmark(bookmark);
  except
  end;
  FreeBookmark(bookmark);
  FbInAutoUpdate := False;
end;

function TAccounts.GetItem(AnId: Integer): TAccountsRecord;
var
  bookmark: Pointer;
begin
  Result := Nil;
  if (AnId = 0) then exit;
  LocateById(AnId);
  Result := FAccountsRecord;
end;

function TAccounts.CheckLogon(const AstrNameOrId, AstrPassword, AstrCode: String;
    const AnCodeIndex: Integer; var AnId: Integer): Boolean;
var
  bookmark: Pointer;
begin
  Result := False;
  FbInAutoUpdate := True;
  bookmark := GetBookmark;
  if LocateById(StrToIntDef(AstrNameOrId, -1))
      or LocateByName(AstrNameOrId) then begin
    if FAccountsRecord.Enabled {and not FAccountsRecord.SecurityBlocked}
        and (FAccountsRecord.Password = AstrPassword)
        and (not FAccountsRecord.PeriodOfValidity
        or (CompareDateTime(GetVirtualTime, FAccountsRecord.ExpirationDate)
        = GreaterThanValue))
        and ((not GAccountSystem.UseSecurityCodes)
        or (GAccountSystem.UseSecurityCodes
        and (FAccountsRecord.SecCodes[AnCodeIndex] = AstrCode))) then begin
      AnId := FAccountsRecord.Id;
      Result := not FAccountsRecord.SecurityBlocked;
    end;
  end;
  try
    GotoBookmark(bookmark);
  except
  end;
  FreeBookmark(bookmark);
  FbInAutoUpdate := False;
end;

end.
