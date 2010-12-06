unit uRegistryScripts;

interface

uses
  Classes,
  uRegistryRecord,
  uRegistryDataSet;

type

  TRegistryScripts = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    function LocateOnSession: Boolean;
    function GetOnSession: Boolean;
    procedure SetOnSession(AValue: Boolean);
    function LocateOnSessionPath: Boolean;
    function GetOnSessionPath: String;
    procedure SetOnSessionPath(AValue: String);
    function LocateOnSessionHideWindow: Boolean;
    function GetOnSessionHideWindow: Boolean;
    procedure SetOnSessionHideWindow(AValue: Boolean);
    function LocateOnServer: Boolean;
    function GetOnServer: Boolean;
    procedure SetOnServer(AValue: Boolean);
    function LocateOnServerPath: Boolean;
    function GetOnServerPath: String;
    procedure SetOnServerPath(AValue: String);
    function LocateOnServerHideWindow: Boolean;
    function GetOnServerHideWindow: Boolean;
    procedure SetOnServerHideWindow(AValue: Boolean);
    function LocateOnClient: Boolean;
    function GetOnClient: Boolean;
    procedure SetOnClient(AValue: Boolean);
    function LocateOnClientPath: Boolean;
    function GetOnClientPath: String;
    procedure SetOnClientPath(AValue: String);
    function LocateOnClientHideWindow: Boolean;
    function GetOnClientHideWindow: Boolean;
    procedure SetOnClientHideWindow(AValue: Boolean);
    function LocateOnClientSynchronizeFile: Boolean;
    function GetOnClientSynchronizeFile: Boolean;
    procedure SetOnClientSynchronizeFile(AValue: Boolean);

  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property OnSession: Boolean
        read GetOnSession write SetOnSession;
    property OnSessionPath: String
        read GetOnSessionPath write SetOnSessionPath;
    property OnSessionHideWindow: Boolean
        read GetOnSessionHideWindow write SetOnSessionHideWindow;
    property OnServer: Boolean
        read GetOnServer write SetOnServer;
    property OnServerPath: String
        read GetOnServerPath write SetOnServerPath;
    property OnServerHideWindow: Boolean
        read GetOnServerHideWindow write SetOnServerHideWindow;
    property OnClient: Boolean
        read GetOnClient write SetOnClient;
    property OnClientPath: String
        read GetOnClientPath write SetOnClientPath;
    property OnClientHideWindow: Boolean
        read GetOnClientHideWindow write SetOnClientHideWindow;
    property OnClientSynchronizeFile: Boolean
        read GetOnClientSynchronizeFile write SetOnClientSynchronizeFile;
  end;

implementation

uses
  SysUtils,
  DB,
  uGCDataSet,
  gcconst;

{*******************************************************************************
                      class  TRegistryScripts
*******************************************************************************}
constructor TRegistryScripts.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryScripts.Destroy;
begin
  inherited Destroy;
end;

function TRegistryScripts.LocateOnSession: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('SessionScript', '0');
end;

function TRegistryScripts.GetOnSession: Boolean;
begin
  LocateOnSession;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryScripts.SetOnSession(AValue: Boolean);
begin
  LocateOnSession;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryScripts.LocateOnSessionPath: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('SessionScriptPath',
      ExtractFilePath(ParamStr(0)) + DEF_SCRIPTS_DIRECTORY + '\'
      + DEF_SESSION_SCRIPT_FILENAME);
end;

function TRegistryScripts.GetOnSessionPath: String;
begin
  LocateOnSessionPath;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryScripts.SetOnSessionPath(AValue: String);
begin
  LocateOnSessionPath;
  FRegistryRecord.Value := AValue;
end;

function TRegistryScripts.LocateOnSessionHideWindow: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('SessionScriptHideWindow', '0');
end;

function TRegistryScripts.GetOnSessionHideWindow: Boolean;
begin
  LocateOnSessionHideWindow;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryScripts.SetOnSessionHideWindow(AValue: Boolean);
begin
  LocateOnSessionHideWindow;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryScripts.LocateOnServer: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ServerScript', '0');
end;

function TRegistryScripts.GetOnServer: Boolean;
begin
  LocateOnServer;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryScripts.SetOnServer(AValue: Boolean);
begin
  LocateOnServer;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryScripts.LocateOnServerPath: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ServerScriptPath',
      ExtractFilePath(ParamStr(0)) + DEF_SCRIPTS_DIRECTORY + '\'
      + DEF_SERVER_SCRIPT_FILENAME);
end;

function TRegistryScripts.GetOnServerPath: String;
begin
  LocateOnServerPath;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryScripts.SetOnServerPath(AValue: String);
begin
  LocateOnServerPath;
  FRegistryRecord.Value := AValue;
end;

function TRegistryScripts.LocateOnServerHideWindow: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ServerScriptHideWindow', '0');
end;

function TRegistryScripts.GetOnServerHideWindow: Boolean;
begin
  LocateOnServerHideWindow;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryScripts.SetOnServerHideWindow(AValue: Boolean);
begin
  LocateOnServerHideWindow;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryScripts.LocateOnClient: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ClientScript', '0');
end;

function TRegistryScripts.GetOnClient: Boolean;
begin
  LocateOnClient;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryScripts.SetOnClient(AValue: Boolean);
begin
  LocateOnClient;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryScripts.LocateOnClientPath: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ClientScriptPath',
      ExtractFilePath(ParamStr(0)) + DEF_SCRIPTS_DIRECTORY + '\'
      + DEF_CLIENT_SCRIPT_FILENAME);
end;

function TRegistryScripts.GetOnClientPath: String;
begin
  LocateOnClientPath;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryScripts.SetOnClientPath(AValue: String);
begin
  LocateOnClientPath;
  FRegistryRecord.Value := AValue;
end;

function TRegistryScripts.LocateOnClientHideWindow: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ClientScriptHideWindow', '0');
end;

function TRegistryScripts.GetOnClientHideWindow: Boolean;
begin
  LocateOnClientHideWindow;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryScripts.SetOnClientHideWindow(AValue: Boolean);
begin
  LocateOnClientHideWindow;
  FRegistryRecord.ValueAsBoolean := AValue;
end;


function TRegistryScripts.LocateOnClientSynchronizeFile: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ClientScriptSynchronizeFile', '0');
end;

function TRegistryScripts.GetOnClientSynchronizeFile: Boolean;
begin
  LocateOnClientSynchronizeFile;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryScripts.SetOnClientSynchronizeFile(AValue: Boolean);
begin
  LocateOnClientSynchronizeFile;
  FRegistryRecord.ValueAsBoolean := AValue;
end;



end.
