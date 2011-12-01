//////////////////////////////////////////////////////////////////////////////
//
// TClientRemoteCommandFactory
// Фабрика классов-наследников TRemoteCommand для визуальной части клиента.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientRemoteCommandFactory;

interface

uses
  // project units
  uRemoteCommand,
  uRemoteCommandFactory;


type

  //
  // TRemoteCommandFactory
  //

  TClientRemoteCommandFactory = class(TRemoteCommandFactory)
  private
    // felds

  public
    // constructor / destructor
    constructor Create();

    // public methods
    function CreateCommand(const AstrCommand: String;
        const AstrFromHost: String): TRemoteCommand;

  end; // TRemoteCommandFactory


implementation

uses
  // system units
  SysUtils,
  // project units
  uY2KCommon,
  uY2KString,
  uProtocol,
  uSendMessageRemoteCommand,
  uReceiveMessageRemoteCommand,
  uCompositeRemoteCommand,
  uOptionSetRemoteCommand,
  uClientInfoSetRemoteCommand,
  uClientInfoConstrainedCommand,
  uClientAuthenticationCommand,
  uClientDoDesignCommand,
  uBlockRemoteCommand,
  uDebugLog,
  uClientConst,
  uSafeStorage,
  uKillTaskRemoteCommand,
  ufrmMain,
{$IFDEF MSWINDOWS}
  uShellModeRemoteCommand,
{$ENDIF}
  uSetVolumeRemoteCommand,
  uNullRemoteCommand,
  uLogoffRemoteCommand,
  uRestartRemoteCommand,
  uClientOptions,
  uClientOptionsConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TClientRemoteCommandFactory.Create();
begin
  inherited Create();
end; // TClientRemoteCommandFactory.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TClientRemoteCommandFactory.CreateCommand(
    const AstrCommand: String; const AstrFromHost: String): TRemoteCommand;
var
  strCommand: String;
  strParameters: String;
  cmd: TRemoteCommand;
begin
  Debug.Trace5('<< ' + AstrCommand);

  _ParseCommandString(AstrCommand, {out}strCommand, {out}strParameters);
 if _IsAuthenticationCommand(strCommand) or
      _IsClientInfoConstrainedCommand(strCommand) then begin
    Result := TCompositeRemoteCommand.Create();
    if _IsClientInfoConstrainedCommand(strCommand) then begin
      cmd := TClientInfoConstrainedCommand.Create(strCommand, strParameters);
      (Result as TCompositeRemoteCommand).Commands.Add(cmd);
    end;
    //это история баланса, инфо и инфофулл
    if _IsClientInfoConstrainedCommand(strCommand)
        and not _IsAuthenticationCommand(strCommand) then begin
      cmd := TClientDoDesignCommand.Create(False, True, False);
      (Result as TCompositeRemoteCommand).Commands.Add(cmd);
    end;
    if _IsAuthenticationCommand(strCommand) then begin
      cmd := TClientAuthenticationCommand.Create(strCommand, strParameters);
      (Result as TCompositeRemoteCommand).Commands.Add(cmd);
    end;
    if CompareText(strCommand, STR_CMD_BLOCKED) = 0 then begin
      cmd := TBlockRemoteCommand.Create(strParameters);
      (Result as TCompositeRemoteCommand).Commands.Add(cmd);
    end;

  end else if CompareText(strCommand, STR_CMD_OPTION_SET) = 0 then begin
    Result := TOptionSetRemoteCommand.Create(
        GetParamFromString(strParameters,0),
        GetParamFromString(strParameters,1));

  end else if CompareText(strCommand, STR_CMD_SETVOLUME) = 0 then begin
    Result := TNullRemoteCommand.Create();
    TSafeStorage.Instance().Push(ThreadSafeOperation_SetVolume,0,strParameters);

  end else if CompareText(strCommand, STR_CMD_CLIENT_INFO_SET) = 0 then begin
    Result := TClientInfoSetRemoteCommand.Create(
        GetParamFromString(strParameters,0),
        GetParamFromString(strParameters,1));

  end else if CompareText(strCommand, STR_CMD_SENDMESSAGE) = 0 then begin
    Result := TReceiveMessageRemoteCommand.Create(strParameters)

  end else if CompareText(strCommand, STR_CMD_SHELLMODE) = 0 then begin
{$IFDEF MSWINDOWS}
    Result := TShellModeRemoteCommand.Create(strParameters)
{$ENDIF}
{$IFDEF LINUX}
    Result := TNullRemoteCommand.Create();
{$ENDIF}
// для LA2 под RP

  end else if CompareText(strCommand, STR_CMD_KILLTASK) = 0 then begin
    if (GClientOptions.ShellMode = ShellMode_Runpad) then begin
      Result := TSendMessageRemoteCommand.Create(
          ThreadSafeOperation_RunPadAction,
          Integer(RunPadAction_KillTasks));
    end else
      Result := TKillTaskRemoteCommand.Create();

  end else if CompareText(strCommand, STR_CMD_RESTART) = 0 then begin
    if (GClientOptions.ShellMode = ShellMode_Runpad) then begin
      Result := TSendMessageRemoteCommand.Create(
          ThreadSafeOperation_RunPadAction,
          Integer(RunPadAction_Logoff));
    end else begin
      if (Length(strParameters) > 0)
          and not StrToBool(GetParamFromString(strParameters,0)) then begin
        Result := TRestartRemoteCommand.Create();
      end else
        Result := TLogoffRemoteCommand.Create();
      end
  end else begin
    Result := TNullRemoteCommand.Create();
  end;

end; // TClientRemoteCommandFactory.CreateCommand


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

end.
