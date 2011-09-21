//////////////////////////////////////////////////////////////////////////////
//
// TExecuteCommandRemoteCommand
// Команда выполняющая произвольную команду, поступающая от управляющего сервера.
//
//////////////////////////////////////////////////////////////////////////////

unit uExecuteCommandRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TExecuteCommandRemoteCommand
  //

  TExecuteCommandRemoteCommand = class(TRemoteCommand)
  private
    ExeCommandLine: string;
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
  uCrossPlatformFunctions;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TClientInfoGetRemoteCommand.Create

constructor TExecuteCommandRemoteCommand.Create(CmdLine: String);
begin
  inherited Create();
  ExeCommandLine := CmdLine;
end; // TExecuteCommandRemoteCommand.Create

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TExecuteCommandRemoteCommand.Execute;
begin
  ExecuteCommandLine(ExeCommandLine);
end; // TExecuteCommandRemoteCommand.Execute


end.
