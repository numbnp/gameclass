program tstHook;

uses
  Forms,
  ufrmMain in 'ufrmMain.pas' ,
  uwinhkg in '..\..\uwinhkg.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
