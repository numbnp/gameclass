//////////////////////////////////////////////////////////////////////////////
//
// TShutdownRemoteCommand
// Команда выключения системы, поступающая от управляющего сервера.
//
//////////////////////////////////////////////////////////////////////////////

unit uShutdownRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TShutdownRemoteCommand
  //

  TShutdownRemoteCommand = class(TRemoteCommand)
  public
    // public methods
    procedure Execute(); override;

  end; // TShutdownRemoteCommand


implementation

uses
  // system units
 // Windows,
  // project units
  uCrossPlatformFunctions;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TShutdownRemoteCommand.Execute();
begin
  SystemShutdown;
end; // TShutdownRemoteCommand.Execute


end. 
