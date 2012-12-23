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

uses
  ufrmMain;


// Функция логона клиента  
procedure ClientLogon(sLogin,sPassword,sSecCode:string);
begin
  frmMain.lblWrongNameOrPassword.Visible := False; 
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
