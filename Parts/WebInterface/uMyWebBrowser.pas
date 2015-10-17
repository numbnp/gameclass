unit uMyWebBrowser;

interface

uses
  cefvcl,
  ceflib,
  Vcl.Controls,
  vcl.Forms,
//  Vcl.Controls,
//  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TMyWebBrowser = class(TObject)
    private
      _Brouser: TChromium;
      _MainFrame: ICefFrame;
      _Parent: TWinControl;
      Loaded:Boolean;
      procedure _Brouser_LoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
      procedure ParentResize(Sender: TObject);
    public
      constructor Create (Parent:TWinControl; DefaultUrl:string);
      procedure ShowDevTools;
      procedure Reload;
      procedure ExecuteJavaScript(code: ustring); overload;
      procedure ExecuteJavaScript(code, scriptUrl: ustring); overload;
  end;

  TCustomRenderProcessHandler = class(TCefRenderProcessHandlerOwn)
    protected
      procedure OnWebKitInitialized; override;
    end;


implementation

{ TMyWebBrowser }

constructor TMyWebBrowser.Create(Parent: TWinControl; DefaultUrl: string);
begin
  inherited Create();
  _Parent := Parent;
  TPanel(_Parent).OnResize := ParentResize;
  _Brouser := TChromium.Create(nil);
  _Brouser.Parent := _Parent;
  _Brouser.DefaultUrl := DefaultUrl;
  _Brouser.OnLoadEnd := _Brouser_LoadEnd;
  _Brouser.Load(DefaultUrl);

  _MainFrame :=_Brouser.Browser.MainFrame;
  ParentResize(nil);

end;

procedure TMyWebBrowser.ExecuteJavaScript(code: ustring);
begin
  _MainFrame.ExecuteJavaScript(code,'',0);
end;

procedure TMyWebBrowser.ExecuteJavaScript(code, scriptUrl: ustring);
begin
  _MainFrame.ExecuteJavaScript(code,scriptUrl,0);
end;

procedure TMyWebBrowser.ParentResize(Sender: TObject);
begin
  _Brouser.Left := 0;
  _Brouser.Top := 0;
  _Brouser.Width := _Parent.Width;
  _Brouser.Height := _Parent.Height;
end;

procedure TMyWebBrowser.Reload;
begin
  Loaded:= False;
  _Brouser.Browser.Reload;
  while Not Loaded do
    Application.ProcessMessages;
end;

procedure TMyWebBrowser.ShowDevTools;
begin
  _Brouser.ShowDevTools;
end;

procedure TMyWebBrowser._Brouser_LoadEnd(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
begin
  self.Loaded := True;
end;

{ TCustomRenderProcessHandler }

procedure TCustomRenderProcessHandler.OnWebKitInitialized;
begin
  inherited;
end;

//initialization
//  CefRemoteDebuggingPort := 9000;
//  CefRenderProcessHandler := TCustomRenderProcessHandler.Create;
//  CefBrowserProcessHandler := TCefBrowserProcessHandlerOwn.Create;
end.
