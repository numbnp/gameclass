unit uClientFunctions;

interface

uses
  uLocalCommandSender,
  uProtocol,
  uClientOptions,
  uClientOptionsConst,
  uSafeStorage;


procedure ClientLogon(sLogin,sPassword,sSecCode:string);
procedure ClientLogoff();
procedure ClientSessionStart(Tariff,Summ:string);
procedure ClientSessionStop();

procedure QueryCostTime(sTariff,sSumm:string);
procedure QueryCostAddTime(sSumm:string);
procedure QueryCostTrafficAdd(sSumm:string);

procedure QueryTariffs;

procedure SessionAddMoney(sSumm:string);
procedure SessionAddTraffic(sSumm:string);

procedure AgreeEula();
procedure NotAgreeEula();

procedure ChangePassword(OldPassword,NewPassword:string);

function UnblockedByPassword(password:string):boolean;
function BlockedByPassword():boolean;

implementation

uses
  ufrmMain,
  uClientInfo,
  uClientInfoConst,
  SysUtils,
  uCoder,
  uDebugLog;


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

procedure ClientLogoff();
begin
   LocalSendDataTo(STR_CMD_AUTH_QUERYLOGOFF, False);
end;

procedure QueryCostTime(sTariff,sSumm:string);
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYCOSTTIME_2 + '=' + sTariff + '/'
        + sSumm + '/',False);
end;

procedure ClientSessionStart(Tariff,Summ:string);
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYSTATE_3 + '=' + Tariff + '/'
      + Summ ,False);
end;

procedure QueryCostAddTime(sSumm:string);
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYCOSTTIME_3 + '=' + sSumm
       + '/', False);
end;

procedure SessionAddMoney(sSumm:string);
begin
  LocalSendDataTo(STR_CMD_AUTH_ADDTIME_3 + '=' + sSumm,
       False);
end;

procedure ClientSessionStop();
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYSTOP_3, False);
end;

procedure AgreeEula();
begin
  case GClientInfo.ClientState of
    ClientState_Agreement: begin
      // принимаем соглашение - шлем ClientState_AgreementAccepted
      LocalSendDataTo(STR_CMD_CLIENT_INFO_SET +'=ClientState/'
          + IntToStr(Integer(ClientState_AgreementAccepted)),False);
      frmMain.Hide;
    end;
    ClientState_OperatorAgreement: begin
      // принимаем соглашение - шлем ClientState_OperatorAgreementAccepted
      LocalSendDataTo(STR_CMD_CLIENT_INFO_SET +'=ClientState/'
      + IntToStr(Integer(ClientState_OperatorAgreementAccepted)), False);
    end;
  end;
end;

procedure NotAgreeEula();
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYSTOP_3, False);
end;

procedure ChangePassword(OldPassword,NewPassword:string);
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYCHANGEPASS + '='
      + OldPassword+'/'+NewPassword,
      False);
end;

procedure QueryCostTrafficAdd(sSumm:string);
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYCOSTTRAFFIC_3 + '=' + sSumm + '/',False);
end;

procedure SessionAddTraffic(sSumm:string);
begin
  LocalSendDataTo(STR_CMD_AUTH_ADDTRAFFIC_3 + '=' + sSumm, False);
end;

function UnblockedByPassword(password:string):boolean;
var
  Fcoder : TCoder;
  bUnblockedByPassword: Boolean;
  strPassword: String;
begin
  bUnblockedByPassword := False;
  strPassword := password;
  if GClientOptions.UnblockPassword  then begin
    try
      Fcoder := TCoder.Create;
      bUnblockedByPassword := (GClientOptions.UnblockPasswordHash =
          FCoder.SimpleEncodeString(PChar(strPassword)));
      FCoder.Free;
    except
      on e: Exception do begin
        Debug.Trace0('2 error! ' + e.Message);
      end;
    end;
  end;
  if bUnblockedByPassword then begin
     GClientInfo.UnblockedByPassword := True;
  end else begin
     GClientInfo.UnblockedByPassword := False;
  end;
{$IFDEF MSWINDOWS}
      //надо поменять на SetUnblockedByPassword
  LocalSendDataTo(STR_CMD_CLIENT_INFO_SET+'=UnblockedByPassword/'
    + BoolToStr(GClientInfo.UnblockedByPassword), False);
{$ENDIF}
  result := bUnblockedByPassword;
end;

function BlockedByPassword():boolean;
begin
  GClientInfo.UnblockedByPassword := False;
{$IFDEF MSWINDOWS}
    //надо поменять на SetUnblockedByPassword
  LocalSendDataTo(STR_CMD_CLIENT_INFO_SET+'=UnblockedByPassword/'
      + BoolToStr(GClientInfo.UnblockedByPassword), False);
{$ENDIF}

end;

procedure QueryTariffs;
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYTARIFS_2,False);
end;

end.
