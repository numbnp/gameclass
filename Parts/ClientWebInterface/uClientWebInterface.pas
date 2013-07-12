unit uClientWebInterface;

interface

uses Classes,cefvcl,ceflib, uWebServer, Forms;

type


  TGCClientWebInterface = class(TObject)
    private
      _Brouser :TChromium;
      _MainFrame :ICefFrame;

    public
      Loaded:Boolean;
      constructor Create(Brouser:TChromium);

      procedure SetInterfaceData(str:string);

      procedure ReloadSkin();
      procedure SetState(state:integer);
      procedure ShowUnblock();
      procedure HideUnblock();
      procedure ShowMessages(str:string);
    end;

Var
  GCClientWebInterface :TGCClientWebInterface;


implementation

uses
  SysUtils;
{ TGCClientWebInterface }

procedure TGCClientWebInterface.SetState(state: integer);
begin
  _MainFrame.ExecuteJavaScript('gcclient_set_state(' + inttostr(state) + ');','', 0);

end;

procedure TGCClientWebInterface.ReloadSkin;
begin
  Loaded:= False;
  _MainFrame.LoadUrl('http://127.0.0.1:5060/main.html');

  while Not Loaded do
    Application.ProcessMessages;

end;

constructor TGCClientWebInterface.Create(Brouser:TChromium);
begin
  inherited Create();
  _Brouser := Brouser;

  if Assigned (_Brouser.Browser) then
    _MainFrame := _Brouser.Browser.GetMainFrame;
end;

procedure TGCClientWebInterface.ShowUnblock;
begin
  _MainFrame.ExecuteJavaScript('show_unblock_window();','', 0);
end;

procedure TGCClientWebInterface.SetInterfaceData(str: string);
var
  buffer :string;
begin
  buffer := ReplaceStr(str,#$D#$A,'<br>');
  _MainFrame.ExecuteJavaScript('update_info(' + buffer + ');','http://127.0.0.1:5060/main.html',0);

end;

procedure TGCClientWebInterface.ShowMessages(str: string);
begin
  _MainFrame.ExecuteJavaScript('show_messages("'+str+'");','', 0);
end;

procedure TGCClientWebInterface.HideUnblock;
begin
  _MainFrame.ExecuteJavaScript('hide_unblock_window();','', 0);
end;

end.
