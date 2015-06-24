unit uClientWebInterface;

interface

uses
  Classes,
  cefvcl,
  ceflib,
  Forms,
  StrUtils,
  Vcl.Controls,
  System.Rtti,
  windows,
  uMyWebBrowser,
  uWebServer;

type
  TWebInterface = class
    private
      _MyWebBrowser :TMyWebBrowser;
      _MyWebServer:TMyWebServer;
      _Parent:TWinControl;
      Loaded:Boolean;
    public
      Port:Integer;
      IndexFile:string;

      constructor Create (Parent:TWinControl);
      procedure ShowDevTools;
      procedure ReloadSkin();
      procedure ShowUnblock();
      procedure Start;
    end;

implementation

uses
  SysUtils;
{ TWebInterface }

procedure TWebInterface.ReloadSkin;
begin
  _MyWebBrowser.Reload;
end;

constructor TWebInterface.Create(Parent: TWinControl);
begin
  inherited Create();
  _Parent := Parent;
  IndexFile := 'main.html';
  Port := 5068;

end;


procedure TWebInterface.ShowDevTools;
begin
  _MyWebBrowser.ShowDevTools;
end;

procedure TWebInterface.ShowUnblock;
begin
  _MyWebBrowser.ExecuteJavaScript('show_unblock_window();');
  _MyWebBrowser.ExecuteJavaScript('gcclient_set_state(2);');

end;


procedure TWebInterface.Start;
begin
  _MyWebServer := TMyWebServer.Create;
  _MyWebServer.RootFolder := InstallDirectory + '\Skins\new';
  _MyWebServer.Port := Port;
  _MyWebServer.ExecuteClient := @ExecuteClient;
  _MyWebServer.ParceAndReplaceLine := @ParceAndReplaceLine;
  _MyWebServer.start;
  _MyWebBrowser := TMyWebBrowser.Create(_Parent,'http://127.0.0.1:'
                                        + IntToStr(Port)
                                        + '/' + IndexFile );


{  MyWebServer := TMyWebServer.Create;
  MyWebServer.RootFolder := InstallDirectory + '\Skins\new';
  MyWebServer.Port := 5060;
  MyWebServer.ExecuteClient := @ExecuteClient;
  MyWebServer.ParceAndReplaceLine := @ParceAndReplaceLine;
  MyWebServer.start;
}
end;

end.
