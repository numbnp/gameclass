//////////////////////////////////////////////////////////////////////////////
//
// TGetTasksListRemoteCommand
//
//////////////////////////////////////////////////////////////////////////////

unit uGetTasksListRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TGetTasksListRemoteCommand
  //

  TGetTasksListRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrHostForSend: String;

    // private helper methods
    function _GetTasksList(): string;

  public
    // constructor / destructror
    constructor Create(const AstrHostForSend: String);

    // public methods
    procedure Execute(); override;

    // properties
    property HostForSend: String read FstrHostForSend write FstrHostForSend;

  end; // TGetTasksListRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
  uDebugLog,
  uProtocol,
{$IFDEF GCCLSRV}
  {$IFDEF MSWINDOWS}
  uProcessSupervisor,
  {$ELSE}
  uTaskKill,
  {$ENDIF}
{$ELSE}
  uTaskKill,
{$ENDIF}
  uCommandSender;


const
  MAX_EXCLUSIONS_PROCESSES = 16;
  ExclusionsProcesses: array[0..MAX_EXCLUSIONS_PROCESSES - 1] of string = (
      '', '[system process]', 'system', 'smss.exe', 'csrss.exe',
      'winlogon.exe', 'services.exe', 'lsass.exe', 'svchost.exe',
      'spoolsv.exe', 'inetinfo.exe', 'ctfmon.exe', 'gccl.exe',
      'gcclsrv.exe', 'gc3shell.exe', 'rshell.exe');


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TGetTasksListRemoteCommand.Create(const AstrHostForSend: String);
begin
  inherited Create();

  FstrHostForSend := AstrHostForSend;
  
end; // TGetTasksListRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TGetTasksListRemoteCommand.Execute();
var
  strTasksList: String;
  strSendData: String;
begin
  strTasksList := _GetTasksList();

  strSendData := STR_CMD_RET_TASKSLIST + '=' + strTasksList;
  Debug.Trace5('RET_TASKSLIST'+strSendData);
  SendDataTo(HostForSend, strSendData);

end; // TGetTasksListRemoteCommand.Execute


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TGetTasksListRemoteCommand._GetTasksList(): string;
begin
  Result := GetTasksList(ExclusionsProcesses);
end; // TGetTasksListRemoteCommand._GetTasksList


end. 
