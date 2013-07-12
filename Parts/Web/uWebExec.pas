unit uWebExec;

interface

uses uWebServer;

var
  MyWebServer:TMyWebServer;

procedure StartWebServer;
procedure StopWebServer;

function ExecuteClient(Request:HttpRequest):boolean;  stdcall;
procedure ParceAndReplaceLine(var Str:string);  stdcall;

implementation

uses
  uParseAndReplase,
  uClientFunctions,
  uClientInstallDirectory,
  uClientWebInterface,
  uClientConst,
  uClientInfo, SysUtils;

procedure StartWebServer;
begin
  MyWebServer := TMyWebServer.Create;
  MyWebServer.RootFolder := InstallDirectory + '\Skins\new';
  MyWebServer.Port := 5060;
  MyWebServer.ExecuteClient := @ExecuteClient;
  MyWebServer.ParceAndReplaceLine := @ParceAndReplaceLine;
  MyWebServer.start;

end;

procedure StopWebServer;
begin
  MyWebServer.stop;
  MyWebServer.Destroy;
end;

procedure ParceAndReplaceLine(var Str:string);
begin
  Str := ParseAndReplase(Str);
end;

function ExecuteClient(Request:HttpRequest):boolean;
var
  str:string;
begin
  if Request.Parametrs.Values['action'] = 'logon' then
  begin
    //lblWrongNameOrPassword.Visible := False;
    ClientLogon(Request.Parametrs.Values['login'],
                Request.Parametrs.Values['password'],
                Request.Parametrs.Values['seccode']);
  end;
  if Request.Parametrs.Values['action'] = 'querytimecost' then
  begin
    QueryCostTime(Request.Parametrs.Values['tariff'],
                  Request.Parametrs.Values['money']);
    GClientInfo.BookingSum:= StrToIntDef(Request.Parametrs.Values['money'],0);
    GClientInfo.BookingTariff:= Request.Parametrs.Values['tariff']
  end;
  if Request.Parametrs.Values['action'] = 'changetariff' then
  begin
    GClientInfo.BookingTariff:= Request.Parametrs.Values['tariff']
  end;

  if Request.Parametrs.Values['action'] = 'start_session' then
  begin
    ClientSessionStart(Request.Parametrs.Values['tariff'],
                        Request.Parametrs.Values['money']);
  end;

  if Request.Parametrs.Values['action'] = 'queryaddtimecost' then
  begin
    QueryCostAddTime(inttostr(StrToIntDef(Request.Parametrs.Values['money'],0)));

    GClientInfo.BookingAddSum := StrToIntDef(Request.Parametrs.Values['money'],0);

  end;

  if Request.Parametrs.Values['action'] = 'addmoney' then
  begin
    SessionAddMoney(Request.Parametrs.Values['money']);
  end;

  if Request.Parametrs.Values['action'] = 'queryaddtrafficcost' then
  begin
    QueryCostTrafficAdd(Request.Parametrs.Values['money']);
  end;

  if Request.Parametrs.Values['action'] = 'addtraffic' then
  begin
    SessionAddTraffic(Request.Parametrs.Values['money']);
  end;

  if Request.Parametrs.Values['action'] = 'stop_session' then
  begin
    ClientSessionStop;
  end;

  if Request.Parametrs.Values['action'] = 'accept_eula' then
  begin
    AgreeEula;
  end;

  if Request.Parametrs.Values['action'] = 'no_accept_eula' then
  begin
    NotAgreeEula;
  end;

  if Request.Parametrs.Values['action'] = 'logoff' then
  begin
    ClientLogoff;
  end;

  if Request.Parametrs.Values['action'] = 'unblock' then
  begin
    //ClientLogoff;
    UnblockedByPassword (Request.Parametrs.Values['unblock_code']);
    if UnblockedByPassword (Request.Parametrs.Values['unblock_code']) then begin
      GCClientWebInterface.HideUnblock;
      GCClientWebInterface.ShowMessages(MSG_UNBLOCKED);
    end else begin
      GCClientWebInterface.ShowMessages(MSG_UNBLOCK_PASSWORD_NEEDED);
    end;
  end;


  if Request.Parametrs.Values['action'] = 'change_password' then
  begin
    //ClientLogoff;
    ChangePassword(Request.Parametrs.Values['old_password'],
                    Request.Parametrs.Values['new_password']);
  end;


  if Request.Parametrs.Values['action'] = 'get_tariffs' then
  begin
    QueryTariffs;
  end;





  Result := True;
end;
end.

