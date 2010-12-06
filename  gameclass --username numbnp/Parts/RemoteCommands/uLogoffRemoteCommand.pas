//////////////////////////////////////////////////////////////////////////////
//
// TLogoffRemoteCommand
// Команда выключения системы, поступающая от управляющего сервера.
//
// Карамани Юрий - 05.2005
//
//////////////////////////////////////////////////////////////////////////////

unit uLogoffRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TLogoffRemoteCommand
  //

  TLogoffRemoteCommand = class(TRemoteCommand)
  public
    // public methods
    procedure Execute(); override;

  end; // TLogoffRemoteCommand

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

procedure TLogoffRemoteCommand.Execute();
begin
  Debug.Trace5('SystemLogoff');
  SystemLogoff;
end; // TLogoffRemoteCommand.Execute


end. ////////////////////////// end of file //////////////////////////////////
