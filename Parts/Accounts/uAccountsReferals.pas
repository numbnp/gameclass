unit uAccountsReferals;

interface

uses
  uAutoUpdate,
  uAccountsReferalsDataSet,
  uAccountsReferalsRecord;

type
  TAccountsReferals = class(TAccountsReferalsDataSet)
  private
    FAccountsReferalsRecord: TAccountsReferalsRecord;
  public
    constructor Create(AAutoUpdate: TAutoUpdate);
    destructor Destroy; override;

    function BonusByLevel(AfLevel: Integer): Integer;

    property Current: TAccountsReferalsRecord
        read FAccountsReferalsRecord write FAccountsReferalsRecord;

  end;

{var
  GAccountsDiscounts: TAccountsDiscounts;
}

implementation

uses SysUtils;

constructor TAccountsReferals.Create(AAutoUpdate: TAutoUpdate);
begin
  inherited Create(Nil, AAutoUpdate.Connection);
  AAutoUpdate.Add(Self,'AccountsReferals',6);
  FAccountsReferalsRecord := TAccountsReferalsRecord.Create(Self);
end;

destructor TAccountsReferals.Destroy;
begin
  FreeAndNil(FAccountsReferalsRecord);
  inherited Destroy;
end;

function TAccountsReferals.BonusByLevel(AfLevel: Integer): Integer;
begin
  Result := 0;
  if LocateByLevel(AfLevel) then
    Result := FAccountsReferalsRecord.Percent;
end;

end.
