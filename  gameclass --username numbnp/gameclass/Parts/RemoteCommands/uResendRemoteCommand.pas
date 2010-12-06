//////////////////////////////////////////////////////////////////////////////
//
// TResendRemoteCommand
// Класс поступающих от управляющего сервера команд, которые требуют
// пересылки другому исполнителю.
//
//
//////////////////////////////////////////////////////////////////////////////

unit uResendRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TResendRemoteCommand
  //

  TResendRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrSendData: String;
    FstrHostForResend: String;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrHostForResend: String;
        const AstrSendData: String); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property SendData: String read FstrSendData write FstrSendData;
    property HostForResend: String
        read FstrHostForResend write FstrHostForResend;

  end; // TResendRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
  uY2KCommon,
  uDebugLog,
  uCommandSender;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TResendRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TResendRemoteCommand.Create need AstrHostForResend parameter');
end; // TResendRemoteCommand.Create

constructor TResendRemoteCommand.Create(const AstrHostForResend: String;
    const AstrSendData: String);
begin
  inherited Create();

  FstrHostForResend := AstrHostForResend;
  FstrSendData := AstrSendData;

end; // TResendRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TResendRemoteCommand.Execute();
var
  CommandSender: TCommandSender;
begin
  try
    CommandSender := TCommandSender.Create();
    try
      CommandSender.Host := HostForResend;
      CommandSender.SendCommand(SendData);
    finally
      FreeAndNilWithAssert(CommandSender);
    end;
  except
    on e: Exception do begin
      Debug.Trace0('TResendRemoteCommand.Execute error! ' + e.Message);
    end;
  end;
end; // TResendRemoteCommand.Execute


end.
