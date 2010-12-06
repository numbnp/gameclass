unit uAccountsDiscounts;

interface

uses
  uAutoUpdate,
  uAccountsDiscountsDataSet,
  uAccountsDiscountsRecord;

type
  TAccountsDiscounts = class(TAccountsDiscountsDataSet)
  private
    FAccountsDiscountsRecord: TAccountsDiscountsRecord;
  public
    constructor Create(AAutoUpdate: TAutoUpdate);
    destructor Destroy; override;

    function Discount(AfSummary: Double): Integer;

    property Current: TAccountsDiscountsRecord
        read FAccountsDiscountsRecord write FAccountsDiscountsRecord;

  end;

{var
  GAccountsDiscounts: TAccountsDiscounts;
}

implementation

uses SysUtils;

constructor TAccountsDiscounts.Create(AAutoUpdate: TAutoUpdate);
begin
  inherited Create(Nil, AAutoUpdate.Connection);
  AAutoUpdate.Add(Self,'AccountsDiscounts',2);
  FAccountsDiscountsRecord := TAccountsDiscountsRecord.Create(Self);
end;

destructor TAccountsDiscounts.Destroy;
begin
  FreeAndNil(FAccountsDiscountsRecord);
  inherited Destroy;
end;

function TAccountsDiscounts.Discount(AfSummary: Double): Integer;
begin
  Result := 0;
  if LocateBySummary(AfSummary) then
    Result := FAccountsDiscountsRecord.Discount;
end;

end.
