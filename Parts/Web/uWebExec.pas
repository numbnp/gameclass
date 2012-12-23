unit uWebExec;

interface

uses uWebServer;

var
  MyWebServer:TMyWebServer;

procedure StartWebServer;
procedure StopWebServer;

function ExecuteClient(Request:HttpRequest):boolean;
procedure ParceAndReplaceLine(var Str:string);

implementation

uses
  uParseAndReplase,
  uClientFunctions,
  uClientInstallDirectory;

procedure StartWebServer;
begin
  MyWebServer := TMyWebServer.Create;
  MyWebServer.RootFolder := InstallDirectory + '\Skins\full';
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
begin
  if Request.Parametrs.Values['action'] = 'logon' then
  begin
    //lblWrongNameOrPassword.Visible := False;
    ClientLogon(Request.Parametrs.Values['login'],
                Request.Parametrs.Values['password'],
                Request.Parametrs.Values['seccode']);
  end;

  
  Result := True;
end;
end.

