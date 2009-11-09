//////////////////////////////////////////////////////////////////////////////
//
// TLocalResendRemoteCommand
// Класс поступающих от управляющего сервера команд, которые требуют
// пересылки визуальной части клиента.
//
//
//////////////////////////////////////////////////////////////////////////////

unit uLocalResendRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TLocalResendRemoteCommand
  //

  TLocalResendRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrSendData: String;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrSendData: String); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property SendData: String read FstrSendData write FstrSendData;

  end; // TLocalResendRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
  uY2KCommon,
  uDebugLog,
  uLocalCommandSender;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TLocalResendRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TResendRemoteCommand.Create need AstrHostForResend parameter');
end; // TLocalResendRemoteCommand.Create

constructor TLocalResendRemoteCommand.Create(const AstrSendData: String);
begin
  inherited Create();

  FstrSendData := AstrSendData;

end; // TLocalResendRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TLocalResendRemoteCommand.Execute();
var
  bSendOk: Boolean;
begin
  bSendOk := LocalSendDataTo(SendData);
  if not bSendOk then begin
    Debug.Trace5('TLocalResendRemoteCommand.Execute error!');
  end;

end; // TLocalResendRemoteCommand.Execute


end.
