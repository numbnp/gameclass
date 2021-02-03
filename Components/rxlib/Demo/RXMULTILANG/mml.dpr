program mml;

uses
  Vcl.Forms,
  multilang in 'multilang.pas' {ToolsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TToolsForm, ToolsForm);
  Application.Run;
end.
