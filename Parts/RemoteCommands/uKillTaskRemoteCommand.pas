//////////////////////////////////////////////////////////////////////////////
//
// TKillTaskRemoteCommand
// Команда снятия задач, поступающая от управляющего сервера.
//
//////////////////////////////////////////////////////////////////////////////

unit uKillTaskRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TKillTaskRemoteCommand
  //

  TKillTaskRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrExeFileName: string;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrExeFileName: string); overload;

    // public methods
    procedure Execute(); override;

  end; // TKillTaskRemoteCommand


implementation

uses
  SysUtils,
  // project units
{$IFDEF GCCL}
  uSafeStorage,
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
  uTaskKillConst,
  uClientOptions,
  uClientOptionsConst,
  uClientScripting;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TKillTaskRemoteCommand.Create();
begin
  inherited Create();
  FstrExeFileName := '';
end; // TKillTaskRemoteCommand.Create


constructor TKillTaskRemoteCommand.Create(const AstrExeFileName: string);
begin
  inherited Create();

  FstrExeFileName := AstrExeFileName;

end; // TKillTaskRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TKillTaskRemoteCommand.Execute();
{var
  i: Integer;}
begin
  if Length(FstrExeFileName) > 0 then
    KillTask(FstrExeFileName)
  else begin
    case GClientOptions.TaskKillMode of
      Include: begin
        KillTask(GClientOptions.TaskList.Text, False);
      end;
      Exclude: begin
        KillTask(GClientOptions.TaskList.Text, True);
      end;
      RunPad: begin
{$IFDEF GCCL}
        TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
            Integer(RunPadAction_VipLogout));
{$ENDIF}
      end;
      Nothing: begin
      end;
    end;
    RunClientScript(caTaskKill);


//    менять
//      for i:=0 to GClientOptions.TaskList.Count -1 do
  end;
end; // TKillTaskRemoteCommand.Execute


end.
