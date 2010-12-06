//////////////////////////////////////////////////////////////////////////////
//
// TSendMessageRemoteCommand
// Отправка SafeMessage
//
//////////////////////////////////////////////////////////////////////////////
unit uSendMessageRemoteCommand;

interface

uses
  // project units
  uSafeStorage,
  uRemoteCommand;

type

  //
  // TSendMessageRemoteCommand
  //

  TSendMessageRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FOperation: TThreadSafeOperation;
    FnExtendedInfo: Longint;
  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AOperation: TThreadSafeOperation;
        const AnExtendedInfo: Longint); overload;

    // public methods
    procedure Execute(); override;

  end; // TSendMessageRemoteCommand


implementation

uses
  uClientConst;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TSendMessageRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TSendMessageRemoteCommand.Create need AstrExeFileName parameter');
end; // TSendMessageRemoteCommand.Create


constructor TSendMessageRemoteCommand.Create(
    const AOperation: TThreadSafeOperation;
    const AnExtendedInfo: Longint);
begin
  inherited Create();
  FOperation := AOperation;
  FnExtendedInfo := AnExtendedInfo;
end; // TSendMessageRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TSendMessageRemoteCommand.Execute();
begin
  TSafeStorage.Instance().Push(FOperation, FnExtendedInfo);
end; // TSendMessageRemoteCommand.Execute


end.
