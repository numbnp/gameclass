//////////////////////////////////////////////////////////////////////////////
//
// TAnswerRemoteCommand
// Команда ответа управляющему серверу со стороны клиента.
//
// Карамани Юрий - 05.2005
//
//////////////////////////////////////////////////////////////////////////////

unit uAnswerRemoteCommand;

interface

uses
  // project units
  uCommandSender,
  uRemoteCommand;

type

  //
  // TAnswerRemoteCommand
  //

  TAnswerRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrHostForAnswer : string;
    FstrSendData      : string;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrHostForAnswer: string); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property HostForAnswer: string
        read FstrHostForAnswer write FstrHostForAnswer;
    property SendData: string read FstrSendData write FstrSendData;

  end; // TAnswerRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
  uDebugLog,
  uY2KCommon;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TAnswerRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TAnswerRemoteCommand.Create need AstrHostForAnswer parameter');
end; // TAnswerRemoteCommand.Create

constructor TAnswerRemoteCommand.Create(const AstrHostForAnswer: string);
begin
  inherited Create();

  FstrHostForAnswer := AstrHostForAnswer;

end; // TAnswerRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TAnswerRemoteCommand.Execute();
begin
  SendDataTo(HostForAnswer, SendData);
end; // TAnswerRemoteCommand.Execute


end. ////////////////////////// end of file //////////////////////////////////
