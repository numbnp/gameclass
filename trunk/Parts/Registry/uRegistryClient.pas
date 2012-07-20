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

    //by numb
    function LocateKey(Key,DefValue:string): Boolean;
    function GetKeyAsBoolean(Key:string;DefValue: Boolean):Boolean;
    procedure SetKeyAsBoolean(Key:string;AValue: Boolean);
    function GetKeyAsInteger(Key:string;DefValue: Integer):Integer;
    procedure SetKeyAsInteger(Key:string;AValue: Integer);
    function GetKeyAsString(Key:string;DefValue: String):String;
    procedure SetKeyAsString(Key:string;AValue: String);

    function GetShutdownButton: Boolean;
    procedure SetShutdownButton(AValue: Boolean);


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

    property ShutdownButton: Boolean
        read GetShutdownButton write SetShutdownButton;

  end;

implementation

uses
  SysUtils,
  DB, uGCDataSet;

const
  RegistryPart = 'Client';

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

function TRegistryClient.LocateKey(Key,DefValue:string): Boolean;
begin
  Result := FRegistryDataSet.LocateByKey(
      RegistryPart+'\'+Key, DefValue);
end;

function TRegistryClient.GetKeyAsBoolean(Key:string;DefValue:Boolean):Boolean;
begin
  if DefValue then
    LocateKey(Key,'1')
  else
    LocateKey(Key,'0');
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryClient.SetKeyAsBoolean(Key:string;AValue: Boolean);
begin
  LocateKey(Key,'0');
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryClient.GetKeyAsInteger(Key:string;DefValue:Integer):Integer;
begin
  LocateKey(Key,IntToStr(DefValue));
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryClient.SetKeyAsInteger(Key:string;AValue: Integer);
begin
  LocateKey(Key,'0');
  FRegistryRecord.ValueAsInteger := AValue;
end;

function TRegistryClient.GetKeyAsString(Key:string;DefValue:String):String;
begin
  LocateKey(Key,DefValue);
  Result := FRegistryRecord.Value;
end;

procedure TRegistryClient.SetKeyAsString(Key:string;AValue: String);
begin
  LocateKey(Key,'0');
  FRegistryRecord.Value := AValue;
end;





function TRegistryClient.GetShutdownButton: Boolean;
begin
  Result:=GetKeyAsBoolean('ShutdownButton', False);
end;

procedure TRegistryClient.SetShutdownButton(AValue: Boolean);
begin
  SetKeyAsBoolean('ShutdownButton', AValue);
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
