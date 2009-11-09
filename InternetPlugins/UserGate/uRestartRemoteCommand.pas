//////////////////////////////////////////////////////////////////////////////
//
// TRestartRemoteCommand
// Команда выключения системы, поступающая от управляющего сервера.
//
//////////////////////////////////////////////////////////////////////////////

unit uRestartRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TRestartRemoteCommand
  //

  TRestartRemoteCommand = class(TRemoteCommand)
  public
    // public methods
    procedure Execute(); override;

  end; // TRestartRemoteCommand

implementation

uses
  // system units
  Windows,
  // project units
  uY2KCommon,
  uDebugLog;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TRestartRemoteCommand.Execute();
begin
  Debug.Trace1('EWX_REBOOT or EWX_FORCE');
  RebootSystem(EWX_REBOOT or EWX_FORCE);
end; // TRestartRemoteCommand.Execute


end. ////////////////////////// end of file //////////////////////////////////
