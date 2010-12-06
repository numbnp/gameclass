program GCLanguage;

uses
  Forms,
  frmMain in 'frmMain.pas' {formMain},
  GCLangUtils in 'gclangutils.pas',
  gcconst in '..\..\Server\gcconst.pas',
  uSystemRegistryTools in '..\Registry\uSystemRegistryTools.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
