unit uClientFunctions;

interface

uses
  uLocalCommandSender,
  uProtocol,
  uClientOptions,
  uClientOptionsConst,
  uSafeStorage;


procedure ClientLogon(sLogin,sPassword,sSecCode:string);

implementation

procedure ClientLogon(sLogin,sPassword,sSecCode:string);
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYSTATE_2 + '=' + sLogin
      + '/' + sPassword + '/' + sSecCode, False);
{$IFDEF MSWINDOWS}
  if (GClientOptions.ShellMode = ShellMode_Runpad) then begin
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
        Integer(RunPadAction_VipLogon), sLogin + '/'
        + sPassword);
  end;
{$ENDIF}

end;

end.
