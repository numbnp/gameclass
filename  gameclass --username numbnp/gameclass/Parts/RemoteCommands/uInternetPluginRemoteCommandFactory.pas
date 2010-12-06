//////////////////////////////////////////////////////////////////////////////
//
// TInternetPluginRemoteCommandFactory
// Фабрика классов-наследников TRemoteCommand.
//
//////////////////////////////////////////////////////////////////////////////

unit uInternetPluginRemoteCommandFactory;

interface

uses
  // project units
  uRemoteCommand,
  uRemoteCommandFactory,
  uNullRemoteCommand;


type

  //
  // TInternetPluginRemoteCommandFactory
  //

  TInternetPluginRemoteCommandFactory = class(TRemoteCommandFactory)
  private
    // felds

  public
    // constructor / destructor
    constructor Create();

    // public methods
    function CreateCommand(const AstrCommand: String;
        const AstrFromHost: String): TRemoteCommand;

  end; // TInternetPluginRemoteCommandFactory


implementation

uses
  // system units
  SysUtils,
  // project units
  uY2KCommon,
  uY2KString,
  uProtocol,
  uCompositeRemoteCommand,
  uBlockRemoteCommand,
  uUnblockRemoteCommand,
  uSetSpeedRemoteCommand,
  uSetGroupRemoteCommand,
  uSetLimitRemoteCommand,
  uSendTrafficAnswerRemoteCommand,
  uDebugLog;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TInternetPluginRemoteCommandFactory.Create();
begin
  inherited Create();
end; // TInternetPluginRemoteCommandFactory.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TInternetPluginRemoteCommandFactory.CreateCommand(
    const AstrCommand: String; const AstrFromHost: String): TRemoteCommand;
var
  strCommand: String;
  strParameters: String;
begin
  _ParseCommandString(AstrCommand, {out}strCommand, {out}strParameters);
  if CompareText(strCommand, STR_CMD_INET_BLOCK) = 0 then begin
    Result := TBlockRemoteCommand.Create(
        GetParamFromString(strParameters,0),
        AstrFromHost);

  end else if CompareText(strCommand, STR_CMD_INET_UNBLOCK) = 0 then begin
    Result := TUnblockRemoteCommand.Create(
        GetParamFromString(strParameters,0),
        GetParamFromString(strParameters,1),
        AstrFromHost);

  end else if CompareText(strCommand, STR_CMD_INET_SETSPEEDFORIP) = 0 then begin
    Result := TSetSpeedRemoteCommand.Create(
        GetParamFromString(strParameters,0),
        StrToIntDef(GetParamFromString(strParameters,1), 0),
        AstrFromHost);

  end else if CompareText(strCommand, STR_CMD_INET_SETGROUP) = 0 then begin
    Result := TSetGroupRemoteCommand.Create(
        GetParamFromString(strParameters,0),
        GetParamFromString(strParameters,1),
        AstrFromHost);

  end else if CompareText(strCommand, STR_CMD_INET_SETLIMIT) = 0 then begin
    Result := TSetLimitRemoteCommand.Create(
        GetParamFromString(strParameters,0),
        StrToIntDef(GetParamFromString(strParameters,1), 0),
        AstrFromHost);

  end else if CompareText(strCommand, STR_CMD_INET_GETTRAFFICVALUE) = 0 then begin
    Result := TSendTrafficAnswerRemoteCommand.Create(AstrFromHost);

  end else begin
    Debug.Trace0('TNullRemote' + strCommand);
    Result := TNullRemoteCommand.Create();
  end;

end; // TInternetPluginRemoteCommandFactory.CreateCommand

end.
