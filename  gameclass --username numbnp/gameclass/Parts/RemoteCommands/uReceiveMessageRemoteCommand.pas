//////////////////////////////////////////////////////////////////////////////
//
// TReceiveMessageRemoteCommand
// Обработка сообщения, поступивщего на клиент.
//
//////////////////////////////////////////////////////////////////////////////
unit uReceiveMessageRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TReceiveMessageRemoteCommand
  //

  TReceiveMessageRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrParameters: String;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrParameters: String); overload;

    // public methods
    procedure Execute(); override;

  end; // TReceiveMessageRemoteCommand


implementation

uses
  SysUtils,
  uY2KString,
  uSafeStorage,
  uClientConst;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TReceiveMessageRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TReceiveMessageRemoteCommand.Create need AstrExeFileName parameter');
end; // TReceiveMessageRemoteCommand.Create


constructor TReceiveMessageRemoteCommand.Create(const AstrParameters: String);
begin
  inherited Create();
  FstrParameters := AstrParameters;
end; // TReceiveMessageRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TReceiveMessageRemoteCommand.Execute();
begin
  TSafeStorage.Instance().Push(ThreadSafeOperation_ReceiveMessage, 0, FstrParameters);
end; // TReceiveMessageRemoteCommand.Execute


end.
