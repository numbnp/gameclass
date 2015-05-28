unit uClientWebInterface;

interface

uses Classes,cefvcl,ceflib, Forms,StrUtils,Vcl.Controls,System.Rtti,windows,uMyWebBrowser;

type
  TWebInterface = class
    private
      _MyWebBrowser :TMyWebBrowser;
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
end;


procedure TWebInterface.Start;
begin
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
