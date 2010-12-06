//////////////////////////////////////////////////////////////////////////////
//
// TSendTrafficAnswerRemoteCommand
// Класс поступающих от управляющего сервера команд, которые требуют
// пересылки визуальной части клиента.
//
//
//////////////////////////////////////////////////////////////////////////////

unit uSendTrafficAnswerRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TSendTrafficAnswerRemoteCommand
  //

  TSendTrafficAnswerRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrServerIP: String;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrServerIP: String); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property ServerIP: String
        read FstrServerIP write FstrServerIP;

  end; // TSendTrafficAnswerRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
  uY2KCommon,
  uDebugLog,
  uGCUGOptions,
  uUGConfig,
  uUGUtils,
  uCommandSender;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TSendTrafficAnswerRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TResendRemoteCommand.Create need AstrHostForResend parameter');
end; // TSendTrafficAnswerRemoteCommand.Create

constructor TSendTrafficAnswerRemoteCommand.Create(
    const AstrServerIP: String);
begin
  inherited Create();

  FstrServerIP := AstrServerIP;

end; // TSendTrafficAnswerRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TSendTrafficAnswerRemoteCommand.Execute();
var
  strValues: String;
  UG: TUGConfig;
begin
  UG := TUGConfig.Create(Options.Genaral.Path.Value,
      Options.Genaral.Name.Value,
      Options.Genaral.DecriptedPassword);
  if UG.Connected then begin
    strValues := UGGetTrafficValues(UG, FstrServerIP);
    SendDataTo(FstrServerIP, strValues);
    Debug.Trace5('Answer [' + FstrServerIP + ']:' + strValues);
      UG.Disconnect;
  end;
  FreeAndNil(UG);
end; // TSendTrafficAnswerRemoteCommand.Execute


end.
