//////////////////////////////////////////////////////////////////////////////
//
// TRestartRemoteCommand
// Команда выключения системы, поступающая от управляющего сервера.
//
// Карамани Юрий - 05.2005
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
  Types,
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
  // project units
  uCrossPlatformFunctions,
  uDebugLog;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TRestartRemoteCommand.Execute();
begin
  Debug.Trace5('SystemRestart');
  SystemRestart;
end; // TRestartRemoteCommand.Execute


end. ////////////////////////// end of file //////////////////////////////////
