unit uAccountSystem;

interface

uses
  uAutoUpdate,
  uAccounts,
  uAccountsDiscounts;

  type
  TAccountSystem = class(TObject)
  private
    FAccounts: TAccounts;
    FAccountsDiscounts: TAccountsDiscounts;
    function GetEnabled: Boolean;
    procedure SetEnabled(AValue: Boolean);
    function GetUseSecurityCodes: Boolean;
    procedure SetUseSecurityCodes(AValue: Boolean);
    function GetBlockIfLogonFailed3Times: Boolean;
    procedure SetBlockIfLogonFailed3Times(AValue: Boolean);
    function GetAlwaysAllowAuthentication: Boolean;
    procedure SetAlwaysAllowAuthentication(AValue: Boolean);
    function GetAuthenticationIfReserved: Boolean;
    procedure SetAuthenticationIfReserved(AValue: Boolean);
    function GetMinAddedSumma: Double;
    procedure SetMinAddedSumma(AValue: Double);
    function GetWarningAddedSumma: Double;
    procedure SetWarningAddedSumma(AValue: Double);
    function GetDiscountAfterLimitDisabled: Boolean;
    procedure SetDiscountAfterLimitDisabled(AValue: Boolean);
    function GetDiscountForPacketsEnabled: Boolean;
    procedure SetDiscountForPacketsEnabled(AValue: Boolean);
    function GetRefersSystemEnabled: Boolean;
    procedure SetRefersSystemEnabled(AValue: Boolean);
    function GetUseCheckAccounts: Boolean;
    procedure SetUseCheckAccounts(AValue: Boolean);
    function GetUsePeriodOfValidity: Boolean;
    procedure SetUsePeriodOfValidity(AValue: Boolean);
    function GetPeriodOfValidityInDays: Integer;
    procedure SetPeriodOfValidityInDays(AValue: Integer);

  public
    constructor Create(AAutoUpdate: TAutoUpdate);
    destructor Destroy; override;

    property Accounts: TAccounts
        read FAccounts;
    property AccountsDiscounts: TAccountsDiscounts
        read FAccountsDiscounts;
    property Enabled: Boolean
        read GetEnabled write SetEnabled;
    property UseSecurityCodes: Boolean
        read GetUseSecurityCodes write SetUseSecurityCodes;
    property BlockIfLogonFailed3Times: Boolean
        read GetBlockIfLogonFailed3Times write SetBlockIfLogonFailed3Times;
    property AlwaysAllowAuthentication: Boolean
        read GetAlwaysAllowAuthentication write SetAlwaysAllowAuthentication;
    property AuthenticationIfReserved: Boolean
        read GetAuthenticationIfReserved write SetAuthenticationIfReserved;
    property MinAddedSumma: Double
        read GetMinAddedSumma write SetMinAddedSumma;
    property WarningAddedSumma: Double
        read GetWarningAddedSumma write SetWarningAddedSumma;
    property DiscountAfterLimitDisabled: Boolean
        read GetDiscountAfterLimitDisabled write SetDiscountAfterLimitDisabled;
    property DiscountForPacketsEnabled: Boolean
        read GetDiscountForPacketsEnabled write SetDiscountForPacketsEnabled;
    property RefersSystemEnabled: Boolean
        read GetRefersSystemEnabled write SetRefersSystemEnabled;
    property UseCheckAccounts: Boolean
        read GetUseCheckAccounts write SetUseCheckAccounts;
    property UsePeriodOfValidity: Boolean
        read GetUsePeriodOfValidity write SetUsePeriodOfValidity;
    property PeriodOfValidityInDays: Integer
        read GetPeriodOfValidityInDays write SetPeriodOfValidityInDays;
  end;

var
  GAccountSystem: TAccountSystem; // система учетных записей

implementation

uses
  SysUtils,
  uRegistry, uRegistryAccountSystem;

constructor TAccountSystem.Create(AAutoUpdate: TAutoUpdate);
begin
  inherited Create;
  FAccounts := TAccounts.Create(AAutoUpdate);
  FAccountsDiscounts := TAccountsDiscounts.Create(AAutoUpdate);
end;

destructor TAccountSystem.Destroy;
begin
  FreeAndNil(FAccountsDiscounts);
  FreeAndNil(FAccounts);
  inherited Destroy;
end;

function TAccountSystem.GetEnabled: Boolean;
begin
  Result := False;
  try
    if Assigned(GRegistry) then
      Result := GRegistry.AccountSystem.Enable;
  except
    Result := False;
  end;
end;

procedure TAccountSystem.SetEnabled(AValue: Boolean);
begin
  GRegistry.AccountSystem.Enable := AValue;
end;

function TAccountSystem.GetUseSecurityCodes: Boolean;
begin
  Result := GRegistry.AccountSystem.UseSecurityCodes;
end;

procedure TAccountSystem.SetUseSecurityCodes(AValue: Boolean);
begin
  GRegistry.AccountSystem.UseSecurityCodes := AValue;
end;

function TAccountSystem.GetBlockIfLogonFailed3Times: Boolean;
begin
  Result := GRegistry.AccountSystem.BlockIfLogonFailed3Times;
end;

procedure TAccountSystem.SetBlockIfLogonFailed3Times(AValue: Boolean);
begin
  GRegistry.AccountSystem.BlockIfLogonFailed3Times := AValue;
end;

function TAccountSystem.GetAlwaysAllowAuthentication: Boolean;
begin
  Result := GRegistry.AccountSystem.AlwaysAllowAuthentication;
end;

procedure TAccountSystem.SetAlwaysAllowAuthentication(AValue: Boolean);
begin
  GRegistry.AccountSystem.AlwaysAllowAuthentication := AValue;
end;

function TAccountSystem.GetAuthenticationIfReserved: Boolean;
begin
  Result := GRegistry.AccountSystem.AuthenticationIfReserved;
end;

procedure TAccountSystem.SetAuthenticationIfReserved(AValue: Boolean);
begin
  GRegistry.AccountSystem.AuthenticationIfReserved := AValue;
end;

function TAccountSystem.GetMinAddedSumma: Double;
begin
  Result := GRegistry.AccountSystem.MinAddedSumma;
end;

procedure TAccountSystem.SetMinAddedSumma(AValue: Double);
begin
  GRegistry.AccountSystem.MinAddedSumma := AValue;
end;

function TAccountSystem.GetWarningAddedSumma: Double;
begin
  Result := GRegistry.AccountSystem.WarningAddedSumma;
end;

procedure TAccountSystem.SetWarningAddedSumma(AValue: Double);
begin
  GRegistry.AccountSystem.WarningAddedSumma := AValue;
end;

function TAccountSystem.GetDiscountAfterLimitDisabled: Boolean;
begin
  Result := GRegistry.AccountSystem.DiscountAfterLimitDisabled;
end;

procedure TAccountSystem.SetDiscountAfterLimitDisabled(AValue: Boolean);
begin
  GRegistry.AccountSystem.DiscountAfterLimitDisabled := AValue;
end;

function TAccountSystem.GetDiscountForPacketsEnabled: Boolean;
begin
  Result := GRegistry.AccountSystem.DiscountForPacketsEnabled;
end;

procedure TAccountSystem.SetDiscountForPacketsEnabled(AValue: Boolean);
begin
  GRegistry.AccountSystem.DiscountForPacketsEnabled := AValue;
end;

function TAccountSystem.GetRefersSystemEnabled: Boolean;
begin
  Result := GRegistry.AccountSystem.RefersSystemEnabled;
end;

procedure TAccountSystem.SetRefersSystemEnabled(AValue: Boolean);
begin
  GRegistry.AccountSystem.RefersSystemEnabled := AValue;
end;

function TAccountSystem.GetUseCheckAccounts: Boolean;
begin
  Result := GRegistry.AccountSystem.UseCheckAccounts;
end;

procedure TAccountSystem.SetUseCheckAccounts(AValue: Boolean);
begin
  GRegistry.AccountSystem.UseCheckAccounts := AValue;
end;

function TAccountSystem.GetUsePeriodOfValidity: Boolean;
begin
  Result := GRegistry.AccountSystem.UsePeriodOfValidity;
end;

procedure TAccountSystem.SetUsePeriodOfValidity(AValue: Boolean);
begin
  GRegistry.AccountSystem.UsePeriodOfValidity := AValue;
end;

function TAccountSystem.GetPeriodOfValidityInDays: Integer;
begin
  Result := GRegistry.AccountSystem.PeriodOfValidityInDays;
end;

procedure TAccountSystem.SetPeriodOfValidityInDays(AValue: Integer);
begin
  GRegistry.AccountSystem.PeriodOfValidityInDays := AValue;
end;



end.
