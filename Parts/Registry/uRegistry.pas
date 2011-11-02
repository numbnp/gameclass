unit uRegistry;

interface

uses
  uAutoUpdate,
  uRegistryDataSet,
  uRegistryRecord,
  uRegistryVolume,
  uRegistryAccountSystem,
  uRegistryOptions,
  uRegistryInterface,
  uRegistryScripts,
  uRegistryModules,
  uRegistryTaskKill,
  uRegistryClient,
  uRegistryInfo,
  uRegistryReportStrings,
  uRegistryControlCommands;

type
  TRegistry = class(TRegistryDataSet)
  private
    FRegistryRecord: TRegistryRecord;
    FRegistryVolume: TRegistryVolume;
    FRegistryAccountSystem: TRegistryAccountSystem;
    FRegistryOptions: TRegistryOptions;
    FRegistryInterface: TRegistryInterface;
    FRegistryScripts: TRegistryScripts;
    FRegistryModules: TRegistryModules;
    FRegistryTaskKill: TRegistryTaskKill;
    FRegistryClient: TRegistryClient;
    FRegistryInfo: TRegistryInfo;
    FRegistryReportStrings: TRegistryReportStrings;
    FRegistryControlCommands: TRegistryControlCommands;

    function GetBaseVersion: String;
    function GetItem(AstrValue: String): TRegistryRecord;
    function LocateLastLogin: Boolean;
    function GetLastLogin: String;
    procedure SetLastLogin(AValue: String);

  public
    constructor Create(AAutoUpdate: TAutoUpdate);
    destructor Destroy; override;

    property Current: TRegistryRecord
        read FRegistryRecord write FRegistryRecord;
    property BaseVersion: String
       read GetBaseVersion;
    property Volume: TRegistryVolume
        read FRegistryVolume;
    property AccountSystem: TRegistryAccountSystem
        read FRegistryAccountSystem;
    property Options: TRegistryOptions
       read FRegistryOptions;
    property UserInterface: TRegistryInterface
        read FRegistryInterface;
    property Scripts: TRegistryScripts
        read FRegistryScripts;
    property Modules: TRegistryModules
       read FRegistryModules;
    property TaskKill: TRegistryTaskKill
        read FRegistryTaskKill;
    property Client: TRegistryClient
       read FRegistryClient;
    property Info: TRegistryInfo
       read FRegistryInfo;
    property Items[AstrKey: String]: TRegistryRecord
       read GetItem; default;
    property LastLogin: String
       read GetLastLogin write SetLastLogin;
    property ReportStrings: TRegistryReportStrings
        read FRegistryReportStrings;
    property ControlCommands: TRegistryControlCommands
        read FRegistryControlCommands;
  end;

var
  GRegistry: TRegistry;

implementation

uses
  SysUtils,
  DB, uGCDataSet;

constructor TRegistry.Create(AAutoUpdate: TAutoUpdate);
begin
  inherited Create(Nil, AAutoUpdate.Connection);
  AAutoUpdate.Add(Self,'Registry',3);
  FRegistryRecord := TRegistryRecord.Create(Self);
  FRegistryVolume := TRegistryVolume.Create(Self, FRegistryRecord);
  FRegistryAccountSystem := TRegistryAccountSystem.Create(Self,
      FRegistryRecord);
  FRegistryOptions := TRegistryOptions.Create(Self, FRegistryRecord);
  FRegistryInterface := TRegistryInterface.Create(Self, FRegistryRecord);
  FRegistryScripts := TRegistryScripts.Create(Self, FRegistryRecord);
  FRegistryModules := TRegistryModules.Create(Self, FRegistryRecord);
  FRegistryTaskKill := TRegistryTaskKill.Create(Self, FRegistryRecord);
  FRegistryClient := TRegistryClient.Create(Self, FRegistryRecord);
  FRegistryInfo := TRegistryInfo.Create(Self, FRegistryRecord);
  FRegistryReportStrings := TRegistryReportStrings.Create(Self,
      FRegistryRecord);
  FRegistryControlCommands := TRegistryControlCommands.Create(Self,
      FRegistryRecord);
end;

destructor TRegistry.Destroy;
begin
  FreeAndNil(FRegistryVolume);
  FreeAndNil(FRegistryRecord);
  FreeAndNil(FRegistryAccountSystem);
  FreeAndNil(FRegistryOptions);
  FreeAndNil(FRegistryInterface);
  FreeAndNil(FRegistryScripts);
  FreeAndNil(FRegistryModules);
  FreeAndNil(FRegistryTaskKill);
  FreeAndNil(FRegistryClient);
  FreeAndNil(FRegistryInfo);
  FreeAndNil(FRegistryReportStrings);
  FreeAndNil(FRegistryControlCommands);
  inherited Destroy;
end;

function TRegistry.GetBaseVersion: String;
begin
  LocateByKey('BaseVersion','');
  Result :=  FRegistryRecord.Value;
end;

function TRegistry.GetItem(AstrValue: String): TRegistryRecord;
begin
  LocateByKey(AstrValue,'');
  Result :=  FRegistryRecord;
end;

function TRegistry.LocateLastLogin: Boolean;
begin
  Result := LocateByKeyWithUserName('LastLogin', '');
end;

function TRegistry.GetLastLogin: String;
begin
  LocateLastLogin;
  Result := FRegistryRecord.Value;
end;

procedure TRegistry.SetLastLogin(AValue: String);
begin
  LocateLastLogin;
  FRegistryRecord.Value := AValue;
end;

initialization

  GRegistry := Nil;


end.
