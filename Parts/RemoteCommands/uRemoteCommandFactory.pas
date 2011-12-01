//////////////////////////////////////////////////////////////////////////////
//
// TRemoteCommandFactory (базовый)
// Фабрика классов-наследников TRemoteCommand.
//
//////////////////////////////////////////////////////////////////////////////

unit uRemoteCommandFactory;

interface

uses
  // project units
  uRemoteCommand,
  uNullRemoteCommand;


type

  //
  // TRemoteCommandFactory
  //

  TRemoteCommandFactory = class(TObject)
  protected

    // protected helper methods
    procedure _ParseCommandString(const AstrData: String;
        var AstrCommand: String;
        var AstrParameters: String);

    function _IsResendedToClientCommand(const AstrCommand: String): boolean;
//    function _IsSetOptionsCommand(const AstrCommand: String): boolean;
    function _IsPlaySoundCommand(const AstrCommand: String): boolean;
    function _IsResendedToServerCommand(const AstrCommand: String): Boolean;
    function _IsClientInfoConstrainedCommand(
        const AstrCommand: String): Boolean;
    function _IsAuthenticationCommand(const AstrCommand: String): boolean;

  public
    // constructor / destructor
    constructor Create();


  end; // TRemoteCommandFactory


implementation

uses
  // system units
  SysUtils,
  // project units
  uY2KCommon,
  uY2KString,
  uProtocol;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TRemoteCommandFactory.Create();
begin
  inherited Create();
end; // TRemoteCommandFactory.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TRemoteCommandFactory._ParseCommandString(
    const AstrData: string;
    var AstrCommand: string;
    var AstrParameters: string);
const
  STR_PARAMETER_DIVIDER = '=';
var
  strData: string;
  nPosParameter: integer;
  nParameterLength: integer;
begin
  strData := TrimLeft(AstrData);

  AstrCommand    := strData;
  AstrParameters := '';

  nPosParameter := Pos(STR_PARAMETER_DIVIDER, AstrData);
  if nPosParameter > 0 then begin
    AstrCommand := copy(AstrData, 1, nPosParameter - 1);
    nParameterLength := length(AstrData) - nPosParameter;
    AstrParameters := copy(AstrData, nPosParameter + 1, nParameterLength);
  end;
end; // TRemoteCommandFactory._ParseCommandString


function TRemoteCommandFactory._IsPlaySoundCommand(
    const AstrCommand: String): Boolean;
begin
//  Result := (CompareText(AstrCommand, WAVFILE_5MINSLEFT_RU) = 0)
//      or (CompareText(AstrCommand, WAVFILE_MAXPOSTPAY_RU) = 0)
//      or (CompareText(AstrCommand, WAVFILE_STOP_PREPAY_RU) = 0)
//      or (CompareText(AstrCommand, WAVFILE_MOVETOOTHERCOMP_RU) = 0)
//      or (CompareText(AstrCommand, WAVFILE_5MINSLEFT_ENG) = 0)
//      or (CompareText(AstrCommand, WAVFILE_MAXPOSTPAY_ENG) = 0)
//      or (CompareText(AstrCommand, WAVFILE_STOP_PREPAY_ENG) = 0)
//      or (CompareText(AstrCommand, WAVFILE_MOVETOOTHERCOMP_ENG) = 0);
  Result := (CompareText(AstrCommand, STR_CMD_PLAY_SOUND) = 0)
end; // TRemoteCommandFactory._IsPlaySoundCommand


function TRemoteCommandFactory._IsResendedToClientCommand(
    const AstrCommand: String): Boolean;
begin
  Result := (CompareText(AstrCommand, STR_CMD_INFO) = 0)
      or (CompareText(AstrCommand, STR_CMD_INFO_FULL) = 0)
      or (CompareText(AstrCommand, STR_CMD_BLOCKED) = 0)
      or (CompareText(AstrCommand, STR_CMD_SHELLMODE) = 0)
      // authentifications commands
      or (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_0) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_1) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_FAILEDLOGGING_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_RETTARIFS_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_RETCOSTTIME_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_RETCOSTTRAFFIC_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_RETCOSTTIME_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_STOPSTATE_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_SENDBALANCEHISTORY) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_PASSCHANGED) = 0)
      or (CompareText(AstrCommand, STR_CMD_SENDMESSAGE) = 0)
//      or (CompareText(AstrCommand, STR_CMD_GETHARDWARE) = 0)
      or (CompareText(AstrCommand, STR_CMD_CLIENT_INFO_SET) =0)
      or (CompareText(AstrCommand, STR_CMD_SETVOLUME) =0);

//      or (CompareText(AstrCommand, STR_CMD_RECEIVEMESSAGE) = 0);
end; // TRemoteCommandFactory._IsResendedCommand

{
function TRemoteCommandFactory._IsSetOptionsCommand(
    const AstrCommand: String): Boolean;
var
  strCommandPrefix: String;
begin
  // в соответсвии с принятым протоклом любая команда установки опций
  // должна начинаться с префикса STR_CMD_OPT
  Result := FALSE;

  if Length(AstrCommand) >= Length(STR_CMD_OPT) then begin
    strCommandPrefix := Copy(AstrCommand, 1, Length(STR_CMD_OPT));
    if Length(strCommandPrefix) > 0 then begin
      Result := (CompareText(strCommandPrefix, STR_CMD_OPT) = 0);
    end;
  end;

end; // TRemoteCommandFactory._IsSetOptionsCommand

}
function TRemoteCommandFactory._IsResendedToServerCommand(
    const AstrCommand: String): Boolean;
begin
  Result := (CompareText(AstrCommand, STR_CMD_AUTH_QUERYSTATE_1) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_QUERYSTATE_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_QUERYTARIFS_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_QUERYCOSTTIME_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_QUERYCOSTTRAFFIC_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_QUERYCOSTTIME_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_ADDTRAFFIC_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_ADDTIME_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_QUERYSTATE_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_QUERYSTOP_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_QUERYLOGOFF) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_QUERYCHANGEPASS) = 0)
      or (CompareText(AstrCommand, STR_CMD_SENDMESSAGE) = 0)
//      or (CompareText(AstrCommand, STR_CMD_RET_GETHARDWARE) = 0)
      or (CompareText(AstrCommand, STR_CMD_CLIENT_INFO_SET) =0)
      or (CompareText(AstrCommand, STR_CMD_GUESTSESSION) =0);

end; // TRemoteCommandFactory._IsQueryCommand

function TRemoteCommandFactory._IsAuthenticationCommand(
    const AstrCommand: String): Boolean;
begin
  Result := (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_0) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_1) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_FAILEDLOGGING_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_RETTARIFS_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_RETCOSTTIME_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_RETCOSTTRAFFIC_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_RETCOSTTIME_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_STOPSTATE_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_SENDBALANCEHISTORY) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_PASSCHANGED) = 0);
end; // TClientRemoteCommandFactory._IsResendedCommand

function TRemoteCommandFactory._IsClientInfoConstrainedCommand(
    const AstrCommand: String): Boolean;
begin
  Result := (CompareText(AstrCommand, STR_CMD_BLOCKED) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_0) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_1) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_2) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_GOSTATE_3) = 0)
      or (CompareText(AstrCommand, STR_CMD_AUTH_SENDBALANCEHISTORY) = 0)
      or (CompareText(AstrCommand, STR_CMD_INFO) = 0)
      or (CompareText(AstrCommand, STR_CMD_INFO_FULL) = 0);
end; // TClientRemoteCommandFactory._IsClientInfoConstrainedCommand

end.
