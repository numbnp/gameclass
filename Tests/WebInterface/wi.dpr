program wi;

uses
  Vcl.Forms,
  Windows,
  ceflib,
  sysutils,
  frmWI in 'frmWI.pas' {Form1},
  uClientWebInterface in '..\..\Parts\WebInterface\uClientWebInterface.pas',
  uMyWebBrowser in '..\..\Parts\WebInterface\uMyWebBrowser.pas',
  uWebServer in '..\..\Parts\WebInterface\uWebServer.pas';

//  uWebExec in '..\..\Parts\WebInterface\uWebExec.pas',
//  uWebServer in '..\..\Parts\WebInterface\uWebServer.pas';

var
  hMutex: THandle;

{$R *.res}



begin
  hMutex := CreateMutex(nil, False, Pchar(ExtractFileName(Application.ExeName)));

  if (GetLastError = ERROR_ALREADY_EXISTS) or (hMutex = 0) then
  begin
    if not CefLoadLibDefault then Exit;
  end else begin
    CefSingleProcess := False;

    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TForm1, Form1);
  Application.Run;
  end;
end.
