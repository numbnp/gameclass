unit uRegistryControlCommands;

interface

uses
  uRegistryRecord,
  uRegistryDataSet;

type

  TRegistryControlCommands = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;

    function LocateWindowsShutdownCommand: Boolean;
    function GetWindowsShutdownCommand: String;
    procedure SetWindowsShutdownCommand(AValue: String);

    function LocateWindowsRebootCommand: Boolean;
    function GetWindowsRebootCommand: String;
    procedure SetWindowsRebootCommand(AValue: String);

    function LocateWindowsLogoffCommand: Boolean;
    function GetWindowsLogoffCommand: String;
    procedure SetWindowsLogoffCommand(AValue: String);


  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property WindowsShutdownCommand : String
        read GetWindowsShutdownCommand write SetWindowsShutdownCommand;
    property WindowsRebootCommand : String
        read GetWindowsRebootCommand write SetWindowsRebootCommand;
        
    property WindowsLogoffCommand : String
        read GetWindowsLogoffCommand write SetWindowsLogoffCommand;
  end;

implementation

uses
  SysUtils,
  DB, uGCDataSet;

{*******************************************************************************
                      class  TRegistryControlCommands
*******************************************************************************}
constructor TRegistryControlCommands.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryControlCommands.Destroy;
begin
  inherited Destroy;
end;

// --------------------------------Shutdown-----------------------------------

function TRegistryControlCommands.LocateWindowsShutdownCommand: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ControlCommands\Windows\Shutdown', 'shutdown -s -f -t 0');
end;

function TRegistryControlCommands.GetWindowsShutdownCommand: String;
begin
  LocateWindowsShutdownCommand;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryControlCommands.SetWindowsShutdownCommand(AValue: String);
begin
  LocateWindowsShutdownCommand;
  FRegistryRecord.Value := AValue;
end;

// --------------------------------Reboot-----------------------------------

function TRegistryControlCommands.LocateWindowsRebootCommand: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ControlCommands\Windows\Reboot', 'shutdown -r -f -t 0');
end;

function TRegistryControlCommands.GetWindowsRebootCommand: String;
begin
  LocateWindowsRebootCommand;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryControlCommands.SetWindowsRebootCommand(AValue: String);
begin
  LocateWindowsRebootCommand;
  FRegistryRecord.Value := AValue;
end;

// --------------------------------LogOff-----------------------------------

function TRegistryControlCommands.LocateWindowsLogoffCommand: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ControlCommands\Windows\Logoff', 'Logoff');
end;

function TRegistryControlCommands.GetWindowsLogoffCommand: String;
begin
  LocateWindowsLogoffCommand;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryControlCommands.SetWindowsLogoffCommand(AValue: String);
begin
  LocateWindowsLogoffCommand;
  FRegistryRecord.Value := AValue;
end;


end.
