//////////////////////////////////////////////////////////////////////////////
//
//
//
//////////////////////////////////////////////////////////////////////////////

unit uCloseClientRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;


type

  //
  // TShutdownRemoteCommand
  //

  TCloseClientRemoteCommand = class(TRemoteCommand)
  private
    // private helper methods
{$IFDEF MSWINDOWS}
    procedure _StopGCSrv();
{$ENDIF}

  public
    // public methods
    procedure Execute(); override;

  end; // TCloseClientRemoteCommand


implementation

uses
  // system units
  Types,
{$IFDEF MSWINDOWS}
  WinSvc,
  uServiceManager,
{$ENDIF}
{$IFDEF GCCLSRV}
  {$IFDEF MSWINDOWS}
  uProcessSupervisor,
  {$ELSE}
  uTaskKill,
  {$ENDIF}
{$ELSE}
  uTaskKill,
{$ENDIF}
  SysUtils,
  // project units
  uCrossPlatformFunctions,
  uDebugLog;


const
  GCCL_TASK = 'gccl.exe';
  GCCL_SERVICE = 'srvGCCL';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TCloseClientRemoteCommand.Execute();
begin
  KillTask(GCCL_TASK);
{$IFDEF MSWINDOWS}
  _StopGCSrv();
{$ENDIF}
end; // TCloseClientRemoteCommand.Execute


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

{$IFDEF MSWINDOWS}
procedure TCloseClientRemoteCommand._StopGCSrv();
var
  nRes: Integer;
begin
  with TServiceManager.Create() do begin
    try
      nRes := StopService(GCCL_SERVICE);
      if nRes <> 0 then begin
        Debug.Trace0('StopService error: ' + IntToStr(nRes));
      end;
    finally
      Free();
    end;
  end;
end; // TCloseClientRemoteCommand._StopGCSrv
{$ENDIF}



end.
