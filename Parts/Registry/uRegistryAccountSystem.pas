unit uRegistryAccountSystem;

interface

uses
  uRegistryRecord,
  uRegistryDataSet;

type

  TRegistryAccountSystem = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    function LocateEnable: Boolean;
    function GetEnable: Boolean;
    procedure SetEnable(AValue: Boolean);
    function LocateUseSecurityCodes: Boolean;
    function GetUseSecurityCodes: Boolean;
    procedure SetUseSecurityCodes(AValue: Boolean);
    function LocateBlockIfLogonFailed3Times: Boolean;
    function GetBlockIfLogonFailed3Times: Boolean;
    procedure SetBlockIfLogonFailed3Times(AValue: Boolean);
    function LocateAlwaysAllowAuthentication: Boolean;
    function GetAlwaysAllowAuthentication: Boolean;
    procedure SetAlwaysAllowAuthentication(AValue: Boolean);
    function LocateMinAddedSumma: Boolean;
    function GetMinAddedSumma: Double;
    procedure SetMinAddedSumma(AValue: Double);
    function LocateWarningAddedSumma: Boolean;
    function GetWarningAddedSumma: Double;
    procedure SetWarningAddedSumma(AValue: Double);
    function LocateDiscountAfterLimitDisabled: Boolean;
    function GetDiscountAfterLimitDisabled: Boolean;
    procedure SetDiscountAfterLimitDisabled(AValue: Boolean);
    function LocateDiscountForPacketsEnabled: Boolean;
    function GetDiscountForPacketsEnabled: Boolean;
    procedure SetDiscountForPacketsEnabled(AValue: Boolean);
    function LocateRefersSystemEnabled: Boolean;
    function GetRefersSystemEnabled: Boolean;
    procedure SetRefersSystemEnabled(AValue: Boolean);
    function LocateUseCheckAccounts: Boolean;
    function GetUseCheckAccounts: Boolean;
    procedure SetUseCheckAccounts(AValue: Boolean);
    function LocateUsePeriodOfValidity: Boolean;
    function GetUsePeriodOfValidity: Boolean;
    procedure SetUsePeriodOfValidity(AValue: Boolean);
    function LocatePeriodOfValidityInDays: Boolean;
    function GetPeriodOfValidityInDays: Integer;
    procedure SetPeriodOfValidityInDays(AValue: Integer);
  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property Enable: Boolean
      read GetEnable write SetEnable;
    property UseSecurityCodes: Boolean
      read GetUseSecurityCodes write SetUseSecurityCodes;
    property BlockIfLogonFailed3Times: Boolean
      read GetBlockIfLogonFailed3Times write SetBlockIfLogonFailed3Times;
    property AlwaysAllowAuthentication: Boolean
      read GetAlwaysAllowAuthentication write SetAlwaysAllowAuthentication;
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

implementation

uses
  SysUtils,
  DB, uGCDataSet;

{*******************************************************************************
                      class  TRegistryAccountSystem
*******************************************************************************}
constructor TRegistryAccountSystem.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryAccountSystem.Destroy;
begin
  inherited Destroy;
end;

function TRegistryAccountSystem.LocateEnable: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AccountSystem\bEnabled', '0');
end;

function TRegistryAccountSystem.GetEnable: Boolean;
begin
  try
    LocateEnable;
    Result := FRegistryRecord.ValueAsBoolean;
  except
    Result := False;
  end;
end;

procedure TRegistryAccountSystem.SetEnable(AValue: Boolean);
begin
  LocateEnable;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryAccountSystem.LocateUseSecurityCodes: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AccountSystem\bUseSecurityCodes',
      '0');
end;

function TRegistryAccountSystem.GetUseSecurityCodes: Boolean;
begin
  LocateUseSecurityCodes;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryAccountSystem.SetUseSecurityCodes(AValue: Boolean);
begin
  LocateUseSecurityCodes;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryAccountSystem.LocateBlockIfLogonFailed3Times: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey(
      'AccountSystem\bBlockIfLogonFailed3times', '1');
end;

function TRegistryAccountSystem.GetBlockIfLogonFailed3Times: Boolean;
begin
  LocateBlockIfLogonFailed3Times;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryAccountSystem.SetBlockIfLogonFailed3Times(AValue: Boolean);
begin
  LocateBlockIfLogonFailed3Times;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryAccountSystem.LocateAlwaysAllowAuthentication: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey(
      'AccountSystem\bAlwaysAllowAuthentication', '1');
end;

function TRegistryAccountSystem.GetAlwaysAllowAuthentication: Boolean;
begin
  LocateAlwaysAllowAuthentication;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryAccountSystem.SetAlwaysAllowAuthentication(AValue: Boolean);
begin
  LocateAlwaysAllowAuthentication;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryAccountSystem.LocateMinAddedSumma: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AccountSystem\minAddedSumma','10');
end;

function TRegistryAccountSystem.GetMinAddedSumma: Double;
begin
  LocateMinAddedSumma;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryAccountSystem.SetMinAddedSumma(AValue: Double);
begin
  LocateMinAddedSumma;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryAccountSystem.LocateWarningAddedSumma: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AccountSystem\warningAddedSumma',
      '100');
end;

function TRegistryAccountSystem.GetWarningAddedSumma: Double;
begin
  LocateWarningAddedSumma;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryAccountSystem.SetWarningAddedSumma(AValue: Double);
begin
  LocateWarningAddedSumma;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryAccountSystem.LocateDiscountAfterLimitDisabled: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey(
      'AccountSystem\DiscountAfterLimitDisabled', '1');
end;

function TRegistryAccountSystem.GetDiscountAfterLimitDisabled: Boolean;
begin
  LocateDiscountAfterLimitDisabled;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryAccountSystem.SetDiscountAfterLimitDisabled(AValue: Boolean);
begin
  LocateDiscountAfterLimitDisabled;
  FRegistryRecord.ValueAsBoolean := AValue;
end;


function TRegistryAccountSystem.LocateDiscountForPacketsEnabled: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey(
      'AccountSystem\DiscountForPacketsEnabled', '0');
end;

function TRegistryAccountSystem.GetDiscountForPacketsEnabled: Boolean;
begin
  LocateDiscountForPacketsEnabled;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryAccountSystem.SetDiscountForPacketsEnabled(AValue: Boolean);
begin
  LocateDiscountForPacketsEnabled;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryAccountSystem.LocateRefersSystemEnabled: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey(
      'AccountSystem\RefersSystemEnabled', '0');
end;

function TRegistryAccountSystem.GetRefersSystemEnabled: Boolean;
begin
  LocateRefersSystemEnabled;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryAccountSystem.SetRefersSystemEnabled(AValue: Boolean);
begin
  LocateRefersSystemEnabled;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryAccountSystem.LocateUseCheckAccounts: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey(
      'AccountSystem\UseCheckAccounts', '1');
end;

function TRegistryAccountSystem.GetUseCheckAccounts: Boolean;
begin
  try
    LocateUseCheckAccounts;
    Result := FRegistryRecord.ValueAsBoolean;
    Result := Result and GetEnable;
  except
    Result := False;
  end;
end;

procedure TRegistryAccountSystem.SetUseCheckAccounts(AValue: Boolean);
begin
  LocateUseCheckAccounts;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryAccountSystem.LocateUsePeriodOfValidity: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey(
      'AccountSystem\UsePeriodOfValidity', '1');
end;

function TRegistryAccountSystem.GetUsePeriodOfValidity: Boolean;
begin
  LocateUsePeriodOfValidity;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryAccountSystem.SetUsePeriodOfValidity(AValue: Boolean);
begin
  LocateUsePeriodOfValidity;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryAccountSystem.LocatePeriodOfValidityInDays: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey(
      'AccountSystem\PeriodOfValidityInDays', '30');
end;

function TRegistryAccountSystem.GetPeriodOfValidityInDays: Integer;
begin
  LocatePeriodOfValidityInDays;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryAccountSystem.SetPeriodOfValidityInDays(AValue: Integer);
begin
  LocatePeriodOfValidityInDays;
  FRegistryRecord.ValueAsInteger := AValue;
end;


end.
