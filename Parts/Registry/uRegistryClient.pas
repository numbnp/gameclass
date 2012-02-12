unit uRegistryClient;

interface

uses
  Classes,
  uRegistryRecord,
  uRegistryDataSet;

type

  TRegistryClient = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    function LocateAutoInstall: Boolean;
    function GetAutoInstall: Boolean;
    procedure SetAutoInstall(AValue: Boolean);
    function LocateGuestSession: Boolean;
    function GetGuestSession: Boolean;
    procedure SetGuestSession(AValue: Boolean);
    function LocateGuestSessionTarifName: Boolean;
    function GetGuestSessionTarifName: String;
    procedure SetGuestSessionTarifName(AValue: String);
    function LocateTaskKillBeforeStart: Boolean;
    function GetTaskKillBeforeStart: Boolean;
    procedure SetTaskKillBeforeStart(AValue: Boolean);
    function LocateUseWOL: Boolean;
    function GetUseWOL: Boolean;
    procedure SetUseWOL(AValue: Boolean);
    function LocateShowSumm: Boolean;
    function GetShowSumm: Boolean;
    procedure SetShowSumm(AValue: Boolean);

  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property AutoInstall: Boolean
        read GetAutoInstall write SetAutoInstall;
    property GuestSession: Boolean
        read GetGuestSession write SetGuestSession;
    property GuestSessionTarifName: String
        read GetGuestSessionTarifName write SetGuestSessionTarifName;
    property TaskKillBeforeStart: Boolean
        read GetTaskKillBeforeStart write SetTaskKillBeforeStart;
    property UseWOL: Boolean
        read GetUseWOL write SetUseWOL;
    property ShowSumm: Boolean
        read GetShowSumm write SetShowSumm;

  end;

implementation

uses
  SysUtils,
  DB, uGCDataSet;
  
{*******************************************************************************
                      class  TRegistryClient
*******************************************************************************}
constructor TRegistryClient.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryClient.Destroy;
begin
  inherited Destroy;
end;



function TRegistryClient.LocateAutoInstall: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('Client\AutoInstall', '0');
end;

function TRegistryClient.GetAutoInstall: Boolean;
begin
  LocateAutoInstall;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryClient.SetAutoInstall(AValue: Boolean);
begin
  LocateAutoInstall;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryClient.LocateGuestSessionTarifName: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('Client\GuestSessionTarifName', '');
end;

function TRegistryClient.GetGuestSessionTarifName: String;
begin
  LocateGuestSessionTarifName;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryClient.SetGuestSessionTarifName(AValue: String);
begin
  LocateGuestSessionTarifName;
  FRegistryRecord.Value := AValue;
end;

function TRegistryClient.LocateGuestSession: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('Client\GuestSession', '0');
end;

function TRegistryClient.GetGuestSession: Boolean;
begin
  LocateGuestSession;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryClient.SetGuestSession(AValue: Boolean);
begin
  LocateGuestSession;
  FRegistryRecord.ValueAsBoolean := AValue;
end;
function TRegistryClient.LocateTaskKillBeforeStart: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('Client\TaskKillBeforeStart', '0');
end;

function TRegistryClient.GetTaskKillBeforeStart: Boolean;
begin
  LocateTaskKillBeforeStart;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryClient.SetTaskKillBeforeStart(AValue: Boolean);
begin
  LocateTaskKillBeforeStart;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryClient.LocateUseWOL: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('Client\UseWOL', '0');
end;

function TRegistryClient.GetUseWOL: Boolean;
begin
  LocateUseWOL;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryClient.SetUseWOL(AValue: Boolean);
begin
  LocateUseWOL;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryClient.LocateShowSumm: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('Client\ShowSumm', '1');
end;

function TRegistryClient.GetShowSumm: Boolean;
begin
  LocateShowSumm;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryClient.SetShowSumm(AValue: Boolean);
begin
  LocateShowSumm;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

end.
