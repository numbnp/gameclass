//////////////////////////////////////////////////////////////////////////////
//
// TServiceRemoteCommandFactory
// Фабрика классов-наследников TRemoteCommand.
//
//////////////////////////////////////////////////////////////////////////////

unit uServiceRemoteCommandFactory;

interface

uses
  // project units
  uRemoteCommand,
  uRemoteCommandFactory,
  uNullRemoteCommand;


type

  //
  // TServiceRemoteCommandFactory
  //

  TServiceRemoteCommandFactory = class(TRemoteCommandFactory)
  private
    // felds
    FbIsFirstPing: Boolean;

    // private helper methods
    procedure _ClearFirstPingCommand();
    function _IsFirstPingCommand(): Boolean;

  public
    // constructor / destructor
    constructor Create();

    // public methods
    function CreateCommandFromServer(const AstrCommand: String;
        const AstrFromHost: String): TRemoteCommand;
    function CreateCommandFromClient(const AstrCommand: String;
        const AstrFromHost: String): TRemoteCommand;

  end; // TServiceRemoteCommandFactory


implementation

uses
  // system units
  SysUtils,
  // project units
  uY2KCommon,
  uY2KString,
  uProtocol,
  uCompositeRemoteCommand,
  uAnswerRemoteCommand,
  uSetTimeRemoteCommand,
  uPlaySoundRemoteCommand,
  uKillTaskRemoteCommand,
  uRestartRemoteCommand,
  uShutdownRemoteCommand,
  uGetTasksListRemoteCommand,
  uUninstallRemoteCommand,
  uOptionSetRemoteCommand,
  uOptionGetRemoteCommand,
  uResendRemoteCommand,
  uLocalResendRemoteCommand,
  uSetVolumeRemoteCommand,
  uCloseClientRemoteCommand,
  uDebugLog,
  uClientInfoGetRemoteCommand,
  uClientInfoSetRemoteCommand,
  uClientInfoConstrainedCommand,
  uClientInfo,
  uClientOptions,
  uClientOptionsConst,
  uLogoffRemoteCommand,
  uPingRemoteCommand,
  uGetExtendedInfoRemoteCommand,
  uExecuteCommandRemoteCommand,
{$IFDEF LINUX}
  udmMain,
{$ENDIF}
  usrvGCCL,
  uGetHardwareRemoteCommand;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TServiceRemoteCommandFactory.Create();
begin
  inherited Create();

  FbIsFirstPing := TRUE;

end; // TServiceRemoteCommandFactory.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TServiceRemoteCommandFactory.CreateCommandFromClient(
    const AstrCommand: String; const AstrFromHost: String): TRemoteCommand;
var
  strCommand: String;
  strParameters: String;
begin
  Debug.Trace1('C>S>> ' + AstrCommand);
  _ParseCommandString(AstrCommand, {out}strCommand, {out}strParameters);

  if _IsResendedToServerCommand(strCommand) then begin
{$IFDEF MSWINDOWS}
    Result := TResendRemoteCommand.Create(AstrFromHost, AstrCommand);
{$ENDIF}

  end else if CompareText(strCommand, STR_CMD_OPTION_GET) = 0 then begin
    Result := TOptionGetRemoteCommand.Create(
        GetParamFromString(strParameters,0))

  end else if CompareText(strCommand, STR_CMD_CLIENT_INFO_GET) = 0 then begin
    Result := TClientInfoGetRemoteCommand.Create(
        GetParamFromString(strParameters,0))

  // пока что может прийти только Blocked
  end else if CompareText(strCommand, STR_CMD_CLIENT_INFO_SET) = 0 then begin
    Result := TClientInfoSetRemoteCommand.Create(
        GetParamFromString(strParameters,0),
        GetParamFromString(strParameters,1));

{  end else if CompareText(strCommand, STR_CMD_RESTART) = 0 then begin
    if (Length(strParameters) > 0)
        and not StrToBool(GetParamFromString(strParameters,0)) then begin
          Result := TLogoffRemoteCommand.Create()
        end else begin
          Result := TRestartRemoteCommand.Create()
        end;

  end else if CompareText(strCommand, STR_CMD_PING) = 0 then begin
    Result := TCompositeRemoteCommand.Create();
    cmd := TAnswerRemoteCommand.Create(AstrFromHost);
   (cmd as TAnswerRemoteCommand).SendData := STR_CMD_RET_PINGANSWER;
   (Result as TCompositeRemoteCommand).Commands.Add(cmd);
    if _IsFirstPingCommand() then begin
      srvGCCL.NeedRescanProcess;
      cmd := TAnswerRemoteCommand.Create(AstrFromHost);
      (cmd as TAnswerRemoteCommand).SendData := STR_CMD_RET_RESTARTING;
      (Result as TCompositeRemoteCommand).Commands.Add(cmd);
      _ClearFirstPingCommand();
    end;
    if _IsFirstPingCommand() or GClientInfo.IsDisconnected then
      srvGCCL.NeedRescanProcess;

 }
  end else begin
    Result := TNullRemoteCommand.Create();
  end;

end; // TServiceRemoteCommandFactory.CreateCommand

function TServiceRemoteCommandFactory.CreateCommandFromServer(
    const AstrCommand: String; const AstrFromHost: String): TRemoteCommand;
var
  strCommand: String;
  strParameters: String;
  cmd: TRemoteCommand;
begin
  Debug.Trace1('G>S>> ' + AstrCommand);

  _ParseCommandString(AstrCommand, {out}strCommand, {out}strParameters);

  if _IsResendedToClientCommand(strCommand) then begin
    Result := TCompositeRemoteCommand.Create();
{$IFDEF MSWINDOWS}
    cmd :=  TLocalResendRemoteCommand.Create(AstrCommand);
    (Result as TCompositeRemoteCommand).Commands.Add(cmd);
{$ENDIF}
{$IFDEF LINUX}
    dmMain.LocalCommandDataReceived(AstrCommand);
{$ENDIF}
    if _IsClientInfoConstrainedCommand(strCommand) then begin
      cmd := TClientInfoConstrainedCommand.Create(strCommand, strParameters);
      (Result as TCompositeRemoteCommand).Commands.Add(cmd);
    end;
    if CompareText(strCommand, STR_CMD_CLIENT_INFO_SET) = 0 then begin
       cmd :=  TClientInfoSetRemoteCommand.Create(
           GetParamFromString(strParameters,0),
           GetParamFromString(strParameters,1));
      (Result as TCompositeRemoteCommand).Commands.Add(cmd);
    end;
  {end else if _IsSetOptionsCommand(strCommand) then begin
    Result := TSetOptionsRemoteCommand.Create(strCommand, strParameters);
 }
  end else if CompareText(strCommand, STR_CMD_OPTION_SET) = 0 then begin
    Result := TCompositeRemoteCommand.Create();
    cmd :=  TOptionSetRemoteCommand.Create(GetParamFromString(strParameters,0),
        GetParamFromString(strParameters,1));
    (Result as TCompositeRemoteCommand).Commands.Add(cmd);
//TODODO Попробуем так    
{$IFDEF MSWINDOWS}
    cmd :=  TLocalResendRemoteCommand.Create(AstrCommand);
    (Result as TCompositeRemoteCommand).Commands.Add(cmd);
{$ENDIF}

  end else if CompareText(strCommand, STR_CMD_SETVOLUME) = 0 then begin
    Result := TSetVolumeRemoteCommand.Create(strParameters)

  end else if CompareText(strCommand, STR_CMD_SETTIME) = 0 then begin
    Result := TSetTimeRemoteCommand.Create(strParameters)

  end else if _IsPlaySoundCommand(strCommand) then begin
    Result := TPlaySoundRemoteCommand.Create(strParameters)

  end else if CompareText(strCommand, STR_CMD_KILLTASK) = 0 then begin
    GClientInfo.AfterStopActionNeeded := False;
    GClientInfo.SaveIfNeeded;
    if (GClientOptions.ShellMode = ShellMode_Unknown)
        or (Length(strParameters) > 0) then
      Result := TKillTaskRemoteCommand.Create(strParameters)
    else
      Result := TLocalResendRemoteCommand.Create(AstrCommand);

  end else if CompareText(strCommand, STR_CMD_CLOSECLIENT) = 0 then begin
    Result := TCloseClientRemoteCommand.Create()
  // Запускаем процесс указанный сервером
  end else if CompareText(strCommand, STR_CMD_EXECUTE_COMMAND_SRV) = 0 then begin
    Result := TExecuteCommandRemoteCommand.Create(strParameters)

  end else if CompareText(strCommand, STR_CMD_RESTART) = 0 then begin
    GClientInfo.AfterStopActionNeeded := False;
    GClientInfo.SaveIfNeeded;
    if (Length(strParameters) > 0)
        and not StrToBool(GetParamFromString(strParameters,0)) then begin
// Если винда то при наличии RunPad делаем логоф через его финкции
{$IFDEF MSWINDOWS}
          if GClientOptions.ShellMode = ShellMode_Unknown then
            Result := TLogoffRemoteCommand.Create()
          else
            Result := TLocalResendRemoteCommand.Create(AstrCommand);
{$ENDIF}
// Если линукс то производим логоф через средства системы
{$IFDEF LINUX}
            Result := TLogoffRemoteCommand.Create()
{$ENDIF}
        end else begin
          Result := TRestartRemoteCommand.Create()
        end;

  end else if CompareText(strCommand, STR_CMD_SHUTDOWN) = 0 then begin
    GClientInfo.AfterStopActionNeeded := False;
    GClientInfo.SaveIfNeeded;
    Result := TShutdownRemoteCommand.Create()

  end else if CompareText(strCommand, STR_CMD_GETTASKSLIST) = 0 then begin
    Result := TGetTasksListRemoteCommand.Create(AstrFromHost)

  end else if CompareText(strCommand, STR_CMD_UNINSTALL) = 0 then begin
    Result := TUninstallRemoteCommand.Create(
        StrToBool(GetParamFromString(strParameters,0)))

  end else if CompareText(strCommand, STR_CMD_PING) = 0 then begin
//    GClientInfo.LastPingTime := Now;
    GClientInfo.LastPingTime := GClientInfo.NowTime;
    if GClientInfo.IsSession and (GClientInfo.NowTime <= GClientInfo.Stop) then
      GClientInfo.AfterStopActionNeeded := True;

    Result := TCompositeRemoteCommand.Create();
    cmd := TPingRemoteCommand.Create(strParameters);
    (Result as TCompositeRemoteCommand).Commands.Add(cmd);
//    if not GClientInfo.GCCLNotStarted then
    begin
      cmd := TAnswerRemoteCommand.Create(AstrFromHost);
      (cmd as TAnswerRemoteCommand).SendData := STR_CMD_RET_PINGANSWER;
      (Result as TCompositeRemoteCommand).Commands.Add(cmd);
    end;
    if _IsFirstPingCommand() then begin
      cmd := TAnswerRemoteCommand.Create(AstrFromHost);
      (cmd as TAnswerRemoteCommand).SendData := STR_CMD_RET_RESTARTING;
      (Result as TCompositeRemoteCommand).Commands.Add(cmd);
      _ClearFirstPingCommand();
    end;

  end else if CompareText(strCommand, STR_CMD_GETEXTENDEDINFO) = 0 then begin
    Result := TGetExtendedInfoRemoteCommand.Create(AstrFromHost)

  end else if CompareText(strCommand, STR_CMD_GETHARDWARE) = 0 then begin
    Result := TGetHardwareRemoteCommand.Create(AstrFromHost);

  end else begin
    Result := TNullRemoteCommand.Create();
  end;

end; // TServiceRemoteCommandFactory.CreateCommand

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TServiceRemoteCommandFactory._IsFirstPingCommand(): Boolean;
begin
  Result := FbIsFirstPing;
end; // TServiceRemoteCommandFactory._IsFirstPingCommand


procedure TServiceRemoteCommandFactory._ClearFirstPingCommand();
begin
  FbIsFirstPing := FALSE;
end; // TServiceRemoteCommandFactory._ClearFirstPingCommand

end.
