//////////////////////////////////////////////////////////////////////////////
//
// TClientInfoConstrainedCommand
// Класс поступающих от управляющего сервера команд, которые требуют
// пересылки другому исполнителю.
//
//
//////////////////////////////////////////////////////////////////////////////

unit uClientInfoConstrainedCommand;
{$IFDEF LINUX}
  {$DEFINE GCCL}
  {$DEFINE GCCLSRV}
{$ENDIF}

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TClientInfoConstrainedCommand
  //

  TClientInfoConstrainedCommand = class(TRemoteCommand)
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

  end; // TClientInfoConstrainedCommand


implementation

uses
  // system units
  SysUtils,
  // project units
{$IFDEF GCCL}
  ufrmMain,
  uSafeStorage,
  uClientConst,
{$ENDIF}
  uY2KCommon,
  uY2KString,
  uDebugLog,
  uClientInfo,
  uClientInfoConst,
  uProtocol,
  Types,
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
  uClientOptions;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TClientInfoConstrainedCommand.Create();
begin
  ASSERT(FALSE,
      'TClientInfoConstrainedCommand.Create need AstrHostForResend parameter');
end; // TClientInfoConstrainedCommand.Create

constructor TClientInfoConstrainedCommand.Create(const AstrCommand: String;
    const AstrParameters: String);
begin
  inherited Create();

  FstrCommand := AstrCommand;
  FstrParameters := AstrParameters;

end; // TClientInfoConstrainedCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TClientInfoConstrainedCommand.Execute();
begin
  if (CompareText(FstrCommand, STR_CMD_BLOCKED) = 0) then begin
    GClientInfo.Blocked := (Length(FstrParameters) <> 0);

  end else if (CompareText(FstrCommand, STR_CMD_AUTH_GOSTATE_0) = 0) then begin
    // если есть параметр и это False, то это сессия оператора
//    if (Length(FstrParameters) > 0)
//        and not StrToBool(GetParamFromString(FstrParameters,0)) then begin
//{$IFDEF GCCLSRV}
//      GClientInfo.ClientState := ClientState_OperatorSession;
//{$ENDIF}
//    end else begin
      GClientInfo.Clear(True);
//    end;

  end else if(CompareText(FstrCommand, STR_CMD_AUTH_GOSTATE_1) = 0) then begin
    GClientInfo.ClientState := ClientState_Authentication;
    GClientInfo.SecCode := StrToInt(GetParamFromString(FstrParameters,0));

  end else if(CompareText(FstrCommand, STR_CMD_AUTH_GOSTATE_2) = 0) then begin
    GClientInfo.ClientState := ClientState_Order;
    GClientInfo.Login := GetParamFromString(FstrParameters,0);
    GClientInfo.Balance := StrToFloatDefWithReplace(
        GetParamFromString(FstrParameters,1), 0);
    GClientInfo.BalanceLimit := StrToFloatDefWithReplace(
        GetParamFromString(FstrParameters,2), 0);
    GClientInfo.Spent := StrToFloatDefWithReplace(
        GetParamFromString(FstrParameters,3), 0);
{$IFDEF GCCL}
      TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateData, 0); //frmMain.UpdateData;
{$ENDIF}


  end else if(CompareText(FstrCommand, STR_CMD_AUTH_GOSTATE_3) = 0) then begin
    GClientInfo.TarifName := GetParamFromString(FstrParameters,0);
    GClientInfo.Start := StrToDateTimeDefWithReplace(
        GetParamFromString(FstrParameters,1));
    GClientInfo.Stop := StrToDateTimeDefWithReplace(
        GetParamFromString(FstrParameters,2));
    GClientInfo.Balance := StrToFloatDefWithReplace(
        GetParamFromString(FstrParameters,3), 0);
    GClientInfo.TrafficSeparatePayment := StrToBool(
        GetParamFromString(FstrParameters,4));
{$IFDEF GCCL}
    TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateData, 0); //frmMain.UpdateData;
{$ENDIF}
    // True - если GOSTATE_3 приходит первый раз, т.е. начало сессии
    //TODO Это убить
{$IFDEF GCCL}
{    if StrToBool(GetParamFromString(FstrParameters,5))
        and GClientOptions.Agreement then
      GClientInfo.ClientState := ClientState_Agreement
    else}
{$ENDIF}
    //TODO Это перенести только в сервис, по-моему так
//      GClientInfo.ClientState := ClientState_Session;

  end else if(CompareText(FstrCommand,
      STR_CMD_AUTH_SENDBALANCEHISTORY) = 0) then begin
      GClientInfo.BalanceHistory := FstrParameters;
{$IFDEF GCCL}
      TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateData, 0); //frmMain.UpdateData;
{$ENDIF}

  end else if(CompareText(FstrCommand, STR_CMD_INFO) = 0) then begin
      GClientInfo.Info := FstrParameters;
{$IFDEF GCCL}
      TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateData, 0); //frmMain.UpdateData;
{$ENDIF}

  end else if(CompareText(FstrCommand, STR_CMD_INFO_FULL) = 0) then begin
      GClientInfo.FullInfo := FstrParameters;
{$IFDEF GCCL}
      TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateData, 0); //frmMain.UpdateData;
{$ENDIF}
  end;
end; // TClientInfoConstrainedCommand.Execute


end.
