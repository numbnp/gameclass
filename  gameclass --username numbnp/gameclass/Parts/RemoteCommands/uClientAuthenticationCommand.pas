//////////////////////////////////////////////////////////////////////////////
//
// TClientAuthorizationCommand
// Класс поступающих от управляющего сервера команд, которые
// связаны с авторизацией.
//
//
//////////////////////////////////////////////////////////////////////////////

unit uClientAuthenticationCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TClientAuthenticationCommand
  //

  TClientAuthenticationCommand = class(TRemoteCommand)
  private
    // fields
    FstrCommand: String;
    FstrParameters: String;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrCommand: String;
        const AstrParameters: String); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property Command: String read FstrCommand write FstrCommand;
    property Parameters: String read FstrParameters write FstrParameters;

  end; // TClientAuthenticationCommand


implementation

uses
  SysUtils,
  uProtocol,
  uSafeStorage,
  uClientConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TClientAuthenticationCommand.Create();
begin
  ASSERT(FALSE,
      'TClientAuthenticationCommand.Create need AstrHostForResend parameter');
end; // TClientAuthenticationCommand.Create

constructor TClientAuthenticationCommand.Create(const AstrCommand: String;
    const AstrParameters: String);
begin
  inherited Create();

  FstrCommand := AstrCommand;
  FstrParameters := AstrParameters;

end; // TClientAuthenticationCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TClientAuthenticationCommand.Execute();
var
  i : Integer;
  str: String;
begin
  if (CompareText(FstrCommand, STR_CMD_AUTH_GOSTATE_0) = 0) then begin

  end else if(CompareText(FstrCommand, STR_CMD_AUTH_GOSTATE_1) = 0) then begin

  end else if
      (CompareText(FstrCommand, STR_CMD_AUTH_FAILEDLOGGING_2) = 0) then begin
    TSafeStorage.Instance().Push(ThreadSafeOperation_WrongPasswordMessage, 0,
        FstrParameters);

  end else if(CompareText(FstrCommand, STR_CMD_AUTH_GOSTATE_2) = 0) then begin

  end else if(CompareText(FstrCommand, STR_CMD_AUTH_RETTARIFS_2) = 0) then begin
    TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateTarifs, 0, FstrParameters);

  end else if(CompareText(FstrCommand, STR_CMD_AUTH_RETCOSTTIME_2) = 0) then begin
    TSafeStorage.Instance().Push(ThreadSafeOperation_RecalcCostTime, 0,
        FstrParameters);

  end else if(CompareText(FstrCommand,
      STR_CMD_AUTH_RETCOSTTRAFFIC_3) = 0) then begin
    TSafeStorage.Instance().Push(ThreadSafeOperation_RecalcCostAddTraffic, 0,
        FstrParameters);

  end else if(CompareText(FstrCommand, STR_CMD_AUTH_RETCOSTTIME_3) = 0) then begin
    TSafeStorage.Instance().Push(ThreadSafeOperation_RecalcCostAddTime, 0,
        FstrParameters);

  end else if(CompareText(FstrCommand, STR_CMD_AUTH_GOSTATE_3) = 0) then begin
    

  end else if(CompareText(FstrCommand, STR_CMD_AUTH_STOPSTATE_3) = 0) then begin

  end else if(CompareText(FstrCommand, STR_CMD_AUTH_PASSCHANGED) = 0) then begin
  end;
end; // TClientAuthenticationCommand.Execute


end.
