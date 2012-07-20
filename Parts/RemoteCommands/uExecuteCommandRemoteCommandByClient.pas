//////////////////////////////////////////////////////////////////////////////
//
// TExecuteCommandRemoteCommand
// Команда выполняющая произвольную команду, поступающая от управляющего сервера.
//
//////////////////////////////////////////////////////////////////////////////

unit uExecuteCommandRemoteCommandByClient;

interface

uses
  // project units


  uRemoteCommand;

type

  //
  // TExecuteCommandRemoteCommandByClient
  //

  TExecuteCommandRemoteCommandByClient = class(TRemoteCommand)
  private
    ExeCommandLine: string;
{$IFDEF MSWINDOWS}
    procedure _ExecuteApp(const AstrExeFile: String);
    function _GetProcessHandle(const AstrProcessName: String): THandle;
{$ENDIF}
  public
    // constructor / destructor
    constructor Create(CmdLine: String);
    // public methods
    procedure Execute; override;

  end; // TExecuteCommandRemoteCommand


implementation

uses
  // system units
 // Windows,
  // project units
  {$IFDEF MSWINDOWS}
  Windows,
  uProcessesDescriptions,
  uY2KRunAs,
  uProcUtils,
  StrUtils,
  {$ENDIF}
  uCrossPlatformFunctions;


{$IFDEF MSWINDOWS}
function TExecuteCommandRemoteCommandByClient._GetProcessHandle(
    const AstrProcessName: String): THandle;
begin
  Result := GProcUtils.GetProcessHandle(AstrProcessName);
end; // TProcessSupervisor._GetProcessHandle

procedure TExecuteCommandRemoteCommandByClient._ExecuteApp(const AstrExeFile: String);
var
  hProcess: THandle;
  hToken: THandle;
  hNewToken: THandle;
begin
  hProcess := _GetProcessHandle('explorer.exe');
  if hProcess = 0 then
    hProcess := _GetProcessHandle('rshell.exe');
  if hProcess = 0 then exit;
  if hProcess <> 0 then begin
    if OpenProcessToken(hProcess,
        TOKEN_QUERY or TOKEN_DUPLICATE or TOKEN_IMPERSONATE,
        hToken) then begin
      if DuplicateTokenEx(hToken, MAXIMUM_ALLOWED, nil,
          SecurityImpersonation, TokenPrimary, hNewToken) then begin
        if hToken <> INVALID_HANDLE_VALUE then begin
          if 0 <> StartInteractiveClientProcess(hNewToken, AstrExeFile, TRUE) then begin

          end;
          CloseHandle(hToken);
        end;
      end else begin

      end;
    end;
  end;

end; // TExecuteCommandRemoteCommandByClient._ExecuteApp
{$ENDIF}
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TClientInfoGetRemoteCommand.Create

constructor TExecuteCommandRemoteCommandByClient.Create(CmdLine: String);
begin
  inherited Create();
  ExeCommandLine := CmdLine;
end; // TExecuteCommandRemoteCommand.Create

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TExecuteCommandRemoteCommandByClient.Execute;
begin
{$IFDEF MSWINDOWS}
  _ExecuteApp(ExeCommandLine);
{$ENDIF}
{$IFDEF LINUX}
  ExecuteCommandLine(ExeCommandLine);
{$ENDIF}
end; // TExecuteCommandRemoteCommand.Execute


end.
